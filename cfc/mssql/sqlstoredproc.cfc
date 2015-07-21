<!---   SQLstoredproc.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Handles all of the rules assoiciated with creating SQL stored procedures for MSSQL
--->

<cfcomponent extends="GangPlank2.cfc.base.SQLStoredProc">

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction name="init" output="false">
		<cfargument name="databaseObj" type="any" required="yes" />
		<cfargument name="schema" type="string" required="no" default="dbo" />
		<cfargument name="configObj" type="any" required="yes" />
		<cfargument name="tableObj" type="any" required="yes" />

		<cfset var i=0 />
		<cfset variables.tableObj = arguments.tableObj />
		<cfset variables.configObj = arguments.configObj />
		<cfset variables.databaseObj = arguments.databaseObj />

		<cfset variables.databaseuser = configObj.get('db', 'username')  />

		<cfset variables.tableName = variables.tableObj.getTableName() />
		<cfset variables.unspacedtableName = ReplaceNoCase(variables.tableName, " ", "", "ALL") />
		<cfset variables.tableType =  variables.tableObj.getType() />
		<cfset variables.identity =  variables.tableObj.getIdentity() />
		<cfset variables.foreignKeyLabel = variables.tableObj.getTableForeignKeyLabel()  />


		<cfset variables.tabledetails = variables.tableObj.getTable() />
		<cfset variables.columnArray = variables.tableObj.getColumnArray() />
		<cfset variables.columnInfo = variables.tabledetails['columnlist'] />


		<cfset variables.schema = arguments.schema />

		<cfset setActive(variables.tableObj.isActive()) />

		<!--- Remove timestamps from the application --->
		<cfloop index="i" from="#ArrayLen(variables.columnArray)#" to="1" step="-1">
			<cfif FindNoCase("timestamp", variables.columnInfo[variables.columnArray[i]]['type'])>
				<cfset ArrayDeleteAt(variables.columnArray, i) />
			</cfif>
		</cfloop>



		<cfreturn This />
	</cffunction>

	<!--- STORED PROC CREATE ROUTINES --->
	<!---***********************************************************--->
	<!---createProcedureList                     --->
	<!---Creates a stored proc for a table list.                     --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureList" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_list]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list" />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(ArrayToList(variables.columnArray)) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfif variables.active>
			<cfset procContents.append("WHERE"	& Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />
		</cfif>
		<cfif not FindNoCase("No identity column defined.", variables.tabledetails.orderBy)>
			<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureSelect                   --->
	<!---Creates a stored proc for a table select                    --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureSelect" output="false" returntype="struct" description="Creates a stored proc for a table select.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />
		<cfargument name="uniqueField" type="string" required="no" default="#variables.identity#" hint="Whether or not to set no count on." />
		<cfargument name="uniqueFieldType" type="string" required="no" default="int" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "" />
		<cfset var displayName = "" />

		<cfif compareNoCase(variables.identity, arguments.uniqueField) neq 0>
			<cfset procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_select_by_#arguments.uniqueField#]" />
			<cfset displayName = "usp_#variables.unspacedtableName#_select_by_#arguments.uniqueField#" />
		<cfelse>
			<cfset procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_select]" />
			<cfset displayName = "usp_#variables.unspacedtableName#_select" />
		</cfif>



		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Selects one record in table #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append(Chr(9) & "@#arguments.uniqueField# #arguments.uniqueFieldType#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(ArrayToList(variables.columnArray)) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10) )/>
		<cfset procContents.append("WHERE"	& Chr(9) & "[#arguments.uniqueField#] = @#arguments.uniqueField#" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureDelete                   --->
	<!---Creates a stored proc for a table delete.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureDelete" output="false" returntype="struct" description="Creates a stored proc for a table delete.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />


		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_delete]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_delete" />


		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Deletes one record in table #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append(Chr(9) & "@#variables.Identity# int" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />
		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>
		<cfset procContents.append("DELETE" & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE"	& Chr(9) & "[#variables.Identity#] = @#variables.Identity#" & Chr(13) & Chr(10)) />


		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureUpdate                   --->
	<!---Creates a stored proc for a table update.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureUpdate" output="false" returntype="struct" description="Creates a stored proc for a table update.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />


		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_update]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_update" />
		<cfset var params = "" />
		<cfset var setsList = "" />
		<cfset var columnType = "" />

		<cfset var i = 0 />
		<cfset var nullableString = "" />

		<!--- Loop through the table columns to create the input parameters. --->
		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">

			<!--- If column is Nullable, allow the procedure to be. --->
			<cfif arguments.columnInfo[variables.columnArray[i]]['nullable']>
				<cfset nullableString = " = NULL" />
			<cfelse>
				<cfset nullableString = "" />
			</cfif>


			<!--- Ensure that createdon, createdby and updated on are autogenerated. --->
			<cfif compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn')) and
					compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdBy')) and
						compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))>
				<!--- Handle Varchars --->
				<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#", ",") />
				<cfelseif FindNoCase("decimal", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfif #arguments.columnInfo[variables.columnArray[i]]['scale']# EQ '-1'>
                        <cfset#arguments.columnInfo[variables.columnArray[i]]['scale']# = 'MAX'>
					</cfif>
                    <cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['prec']#,#arguments.columnInfo[variables.columnArray[i]]['scale']#)#nullableString#", ",")  />
				<cfelse>
					<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#", ",") />
				</cfif>
			</cfif>


			<cfset columnType = "" />
			<cfif arguments.columnInfo[variables.columnArray[i]]['isIdentity']>
				<cfset columnType = "identity">
			</cfif>
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn'))>
				<cfset columnType = "createdOn">
			</cfif>
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))>
				<cfset columnType = "updatedOn">
			</cfif>
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdBy'))>
				<cfset columnType = "createdBy">
			</cfif>

			<!--- JOHMS (Justin Ohms) 2007-08-03 - computed column support --->
			<cfif structKeyExists(arguments.columnInfo[variables.columnArray[i]], 'computed') and
					lcase(arguments.columnInfo[variables.columnArray[i]]['computed']) eq 'yes'>
				<cfset columnType = "computed">
			</cfif>


			<cfswitch expression="#columnType#">
				<!--- JOHMS 2007-08-03 - computed column support --->
				<cfcase value="computed" />
				<!--- JOHMS 2007-08-03 END --->

				<cfcase value="identity,createdOn,createdBy" />
				<cfcase value="updatedOn">
					<cfset setsList = ListAppend(setsList, Chr(9) & "[" & variables.columnArray[i] & "]" & " = " & "CURRENT_TIMESTAMP", ",") />
				</cfcase>
				<cfdefaultcase>
					<cfset setsList = ListAppend(setsList, Chr(9) & "[" & variables.columnArray[i] & "]" & " = @" & variables.columnArray[i], ",") />
				</cfdefaultcase>
			</cfswitch>


		</cfloop>


		<cfset params = Replace(params, ",", "," & Chr(13) & Chr(10), "ALL") />
		<cfset setsList = Replace(setsList, ",", "," & Chr(13) & Chr(10), "ALL") />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Updates one record in table #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("#params#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset procContents.append("UPDATE" & Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("SET") />
		<cfset procContents.append(setsList & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE"	& Chr(9) & "[#variables.Identity#] = @#variables.Identity#" & Chr(13) & Chr(10)) />


		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureInsert                   --->
	<!---Creates a stored proc for a table insert.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureInsert" output="false" returntype="struct" description="Creates a stored proc for a table insert.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />


		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_insert]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_insert" />
		<cfset var params = "" />
		<cfset var nullableString = "" />
		<cfset var columnType = "" />
		<cfset var tempString = "" />

		<cfset var columnList ="" />
		<cfset var valuesList ="" />
		<cfset var columnArray = structKeyArray(arguments.columnInfo) />

		<!--- Loop through the table columns to create the input parameters. --->
		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">

			<!--- If column is Nullable, allow the procedure to be. --->
			<cfif arguments.columnInfo[variables.columnArray[i]]['nullable']>
				<cfset nullableString = " = NULL" />
			<cfelse>
				<cfset nullableString = "" />
			</cfif>

			<!--- Ensure that createdon, createdby and updated on are autogenerated. --->
			<cfif compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn')) and
					compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))>

				<cfif not compareNoCase(variables.columnArray[i], variables.Identity)>
					<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']# OUTPUT", ",") />
				<cfelse>
					<!--- Handle Varchars --->
					<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
						<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#", ",")  />
					<cfelseif FindNoCase("decimal", arguments.columnInfo[variables.columnArray[i]]['type'])>
						<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['prec']#,#arguments.columnInfo[variables.columnArray[i]]['scale']#)#nullableString#", ",")  />
					<cfelse>
						<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#", ",") />
					</cfif>
				</cfif>
			</cfif>


			<cfset columnType = "" />
			<cfif arguments.columnInfo[variables.columnArray[i]]['isIdentity']>
				<cfset columnType = "identity">
			</cfif>
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn'))>
				<cfset columnType = "createdOn">
			</cfif>
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))>
				<cfset columnType = "updatedOn">
			</cfif>
			<!--- JOHMS 2007-08-03 - computed column support --->
			<cfif structKeyExists(arguments.columnInfo[variables.columnArray[i]], 'computed') and
					lcase(arguments.columnInfo[variables.columnArray[i]]['computed']) eq 'yes'>
				<cfset columnType = "computed">
			</cfif>





			<cfswitch expression="#columnType#">
				<!--- JOHMS 2007-08-03 - computed column support --->
				<cfcase value="computed" />
				<!--- JOHMS 2007-08-03 END --->
				<cfcase value="identity" />
				<cfcase value="updatedOn,createdon">
					<cfset columnList = ListAppend(columnList,"[#variables.columnArray[i]#]") />
					<!--- Let these values be auto generated. --->
					<cfset valuesList = ListAppend(valuesList, "CURRENT_TIMESTAMP") />
				</cfcase>
				<cfdefaultcase>
					<cfset columnList = ListAppend(columnList,"[#variables.columnArray[i]#]") />
					<cfset valuesList = ListAppend(valuesList, "@#variables.columnArray[i]#") />
				</cfdefaultcase>
			</cfswitch>

		</cfloop>





		<cfset params = Replace(params, ",", "," & Chr(13) & Chr(10), "ALL") />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Inserts one record into table #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("#params#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10) )/>

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<!--- Create insert line --->
		<cfset procContents.append("INSERT INTO" & Chr(9) & "[#variables.schema#].[#variables.tableName#](#columnList#)" & Chr(13) & Chr(10)) />
		<!--- Create Values line.  --->
		<cfset procContents.append("VALUES (#valuesList#)" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		<!--- Create return value line --->
		<cfset procContents.append("SET @#variables.Identity# = SCOPE_IDENTITY()"  & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />





		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureSearch                   --->
	<!---Creates a stored proc for a table update.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureSearch" output="false" returntype="struct" description="Creates a stored proc for a table update.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_search]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_search" />
		<cfset var params = "" />
		<cfset var setsList = "" />
		<cfset var columnType = "" />
		<cfset var i = 0 />
		<cfset var nullableString = "" />
		<cfset var whereClause = "" />

		<!--- Loop through the table columns to create the input parameters. --->
		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">

			<!--- All of these will be NULLABLE . --->
			<cfset nullableString = " = NULL" />


			<!--- Ommit text and image fields from search proc --->
			<cfif not FindNoCase("text", arguments.columnInfo[variables.columnArray[i]]['type']) AND not FindNoCase("image", arguments.columnInfo[variables.columnArray[i]]['type'])>

				<cfif i neq 1>
					<cfset whereClause = whereClause.concat( "AND " ) />
				</cfif>


				<!--- Handle Varchars --->
				<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#", ",") />
				<cfelse>
					<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#", ",") />
				</cfif>


				<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset whereClause = whereClause.concat( Chr(9) & "([#variables.columnArray[i]#] Like '%' + @#variables.columnArray[i]# + '%' OR @#variables.columnArray[i]# IS NULL)" & Chr(13) & Chr(10) ) />
				<cfelse>
					<cfset whereClause = whereClause.concat( Chr(9) & "([#variables.columnArray[i]#] =  @#variables.columnArray[i]# OR @#variables.columnArray[i]# IS NULL)" & Chr(13) & Chr(10) ) />
				</cfif>

			</cfif>

		</cfloop>




		<cfset params = Replace(params, ",", "," & Chr(13) & Chr(10), "ALL") />
		<cfset setsList = Replace(setsList, ",", "," & Chr(13) & Chr(10), "ALL") />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Performs various searches on table:  #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("#params#" & Chr(13) & Chr(10) )/>
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(ArrayToList(variables.columnArray)) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE" & Chr(13) & Chr(10)) />
		<cfset procContents.append(whereClause) />




		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createListThroughJoinTable                     --->
	<!---Creates list for table through joined Table                --->
	<!---***********************************************************--->
	<cffunction access="public" name="createListThroughJoinTable" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />
		<cfargument name="otherTable" type="string" required="yes" hint="The other table to link to." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_list_by_#databaseObj.getIdentity(otherTable)#]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_by_#databaseObj.getIdentity(otherTable)#" />
		<cfset var joinTable = "" />
		<cfset var temp = 0>


		<cfset var tempColumnArray = variables.columnArray />
		<cfset var i = 0 />


		<cfset temp = ListFind(tableObj.getJoinTableList(),arguments.otherTable) />
		<cfset joinTable = ListGetAt(tableObj.getPassThroughTableList(),temp) />


		<cfloop index="i" from="1" to="#ArrayLen(tempColumnArray)#">
			<cfset tempColumnArray[i] = "[#variables.tableName#].[" & tempColumnArray[i] & "]"/>
		</cfloop>

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName# that are linked to record in #arguments.otherTable# through table #joinTable# ")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append(Chr(9) & "@#databaseObj.getIdentity(otherTable)# int" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />


		

		<cfset procContents.append("SELECT" & Chr(9) & ArrayToList(tempColumnArray) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"   & Chr(9) & "[#variables.tableName#]" & Chr(13) & Chr(10)) />

		<cfset procContents.append("INNER JOIN	#joinTable#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("ON	#tableName#.#identity# = #joinTable#.#identity#" & Chr(13) & Chr(10)) />

		<cfset procContents.append("INNER JOIN	#otherTable#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("ON	#joinTable#.#databaseObj.getIdentity(otherTable)# = #otherTable#.#databaseObj.getIdentity(otherTable)#" & Chr(13) & Chr(10)) />

		<cfset procContents.append("WHERE [#otherTable#].[#databaseObj.getIdentity(otherTable)#] = @#databaseObj.getIdentity(otherTable)#" & Chr(13) & Chr(10)) />



		

		<cfif variables.active>
			<cfset procContents.append("AND"	& Chr(9) & "[#variables.tableName#].[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />
		</cfif>
		<cfif not FindNoCase("No identity column defined.", variables.tabledetails.orderBy)>
			<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureListByForeignKey         --->
	<!---Creates a stored proc for a table list by a foreign key.    --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureListByForeignKey" output="false" returntype="struct" description="Creates a stored proc for a table list by a foreign key. ">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="foreignKey" type="string" required="yes" hint="The foreign key in this table." />



		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_list_by_#arguments.foreignKey#]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_by_#arguments.foreignKey#" />



		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName# by #arguments.foreignKey#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName# @#arguments.foreignKey# int" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(ArrayToList(variables.columnArray)) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE"	& Chr(9) & "[#variables.tableName#].[#arguments.foreignKey#] = @#arguments.foreignKey#" & Chr(13) & Chr(10)) />


		<cfif variables.active>
			<cfset procContents.append("AND"	& Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />
		</cfif>
		<cfif not FindNoCase("No identity column defined.", variables.tabledetails.orderBy)>
			<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureListwithForeignKeys                     --->
	<!---Creates a stored proc for a table list.                     --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureListwithForeignKeys" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_with_FK" />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_list_with_FK]" />
		<cfset var selectString = ""/>
		<cfset var innerjoinString = ""/>
		<cfset var innerjoinSubString = ""/>
		<cfset var linkedLabelField = ""/>
		<cfset var linkedTable = ""/>
		<cfset var linkedField = ""/>
		<cfset var i = 0/>
		<cfset var nullable = FALSE />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName# with columns replaced by their foreign key.")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>

		<cfset selectString = ""/>
		<cfset innerjoinString = ""/>

		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">
			<cfif len(variables.tabledetails.columnlist[variables.columnArray[i]]['linkedField']) gt 0>
				<cfset linkedTable = variables.tabledetails.columnlist[columnArray[i]]['linkedTable'] />
				<cfset linkedField = variables.tabledetails.columnlist[columnArray[i]]['linkedField'] />
				<cfset linkedLabelField = variables.databaseObj.getTableForeignKeyLabel(linkedTable) />
				<cfset linkedTableAlias = linkedTable & "for" & variables.columnArray[i] />
				<cfset nullable = variables.tabledetails.columnlist[columnArray[i]]['nullable'] />
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "#linkedTableAlias#.[#linkedLabelField#] AS #variables.columnArray[i]#") />

				<!--- tpryan 5/2007 made inner joins happen when fields are required. --->
				<cfif nullable>
					<cfset innerjoinSubString = "LEFT OUTER JOIN [#linkedTable#] as #linkedTableAlias#  ">
				<cfelse>
					<cfset innerjoinSubString = "INNER JOIN [#linkedTable#] as #linkedTableAlias#  ">
				</cfif>
				<cfset innerjoinSubString = innerjoinSubString & "ON #linkedTableAlias#.[#linkedField#] = [#variables.tableName#].[#variables.columnArray[i]#] " />

				<cfset innerjoinString = ListAppend(innerjoinString, innerjoinSubString, Chr(10))/>

			<cfelse>
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "[#variables.tableName#].[#variables.columnArray[i]#]" )>
			</cfif>
		</cfloop>




		<cfset procContents.append("SELECT" & Chr(9) & selectString & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append(innerjoinString & Chr(13) & Chr(10)) />

		<cfif variables.active>
			<cfset procContents.append("WHERE"	& Chr(9) & "[#variables.tableName#].[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />
		</cfif>

		<cfif not FindNoCase("No identity column defined.", variables.tabledetails.orderBy)>
			<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureSelectwithForeignKeys                     --->
	<!---Creates a stored proc for a table list.                     --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureSelectwithForeignKeys" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var displayName = "usp_#variables.unspacedtableName#_select_with_FK" />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_select_with_FK]" />
		<cfset var selectString = ""/>
		<cfset var innerjoinString = ""/>
		<cfset var innerjoinSubString = ""/>
		<cfset var linkedLabelField = ""/>
		<cfset var linkedTable = ""/>
		<cfset var linkedField = ""/>
		<cfset var i = 0/>
		<cfset var nullable = FALSE />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Selects one record in table #variables.tableName# with columns replaced by their foreign key.")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append(Chr(9) & "@#variables.identity# int" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset selectString = ""/>
		<cfset innerjoinString = ""/>

		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">
			<cfif len(variables.tabledetails.columnlist[variables.columnArray[i]]['linkedField']) gt 0>
				<cfset linkedTable = variables.tabledetails.columnlist[columnArray[i]]['linkedTable'] />
				<cfset linkedField = variables.tabledetails.columnlist[columnArray[i]]['linkedField'] />
				<cfset linkedLabelField = variables.databaseObj.getTableForeignKeyLabel(linkedTable) />
				<cfset linkedTableAlias = linkedTable & "for" & variables.columnArray[i] />
				<cfset nullable = variables.tabledetails.columnlist[columnArray[i]]['nullable'] />
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "#linkedTableAlias#.[#linkedLabelField#] AS #variables.columnArray[i]#" )>

				<!--- tpryan 5/2007 made inner joins happen when fields are required. --->
				<cfif nullable>
					<cfset innerjoinSubString = "LEFT OUTER JOIN [#linkedTable#] as #linkedTableAlias#  ">
				<cfelse>
					<cfset innerjoinSubString = "INNER JOIN [#linkedTable#] as #linkedTableAlias#  ">
				</cfif>
				<cfset innerjoinSubString = innerjoinSubString & "ON #linkedTableAlias#.[#linkedField#] = [#variables.tableName#].[#variables.columnArray[i]#] " />

				<cfset innerjoinString = ListAppend(innerjoinString, innerjoinSubString, Chr(10))/>

			<cfelse>
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "[#variables.tableName#].[#variables.columnArray[i]#]" )>
			</cfif>
		</cfloop>




		<cfset procContents.append("SELECT" & Chr(9) & selectString & Chr(13) & Chr(10) )/>
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append(innerjoinString & Chr(13) & Chr(10)) />

		<cfset procContents.append("WHERE"	& Chr(9) & "[#variables.tableName#].[#variables.identity#] = @#variables.identity#" & Chr(13) & Chr(10)) />

		<cfif not FindNoCase("No identity column defined.", variables.tabledetails.orderBy)>
			<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---createProcedureListForeignKeyLabels                     --->
	<!---Creates a stored proc for a table list.                     --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureListForeignKeyLabels" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_foreign_key_labels" />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_list_foreign_key_labels]" />


		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Lists the id and foriegn key label for table: #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents.append("SELECT [#variables.identity#] as foreignKeyID, [#variables.foreignKeyLabel#] as foreignKeyLabel"  & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />

		<cfif variables.active>
			<cfset procContents.append("WHERE"	& Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.foreignKeyLabel#" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>


	<!---***********************************************************--->
	<!---createProcedureJoinTableUnique                     --->
	<!---Creates a stored proc for a table to read in unique join table records. --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureJoinTableUnique" output="false" returntype="struct" description="Creates a stored proc for a table to read in unique join table records.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />
		<cfargument name="uniqueColumnList" type="string" required="yes" hint="The columns to read uniqueness off of." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var displayName = "usp_#variables.unspacedtableName#_select_by_unique_join" />
		<cfset var procName = "[#variables.schema#].[#displayName#]" />
		<cfset var uniqueColumn = "" />
		<cfset var uniqueColumnVariables = ArrayNew(1) />
		<cfset var uniqueColumnWhere = ArrayNew(1) />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Reads one record in table #variables.tableName# by its join columns")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfloop list="#arguments.uniqueColumnList#" index="uniqueColumn">
			<cfset ArrayAppend(uniqueColumnVariables, "@#uniqueColumn# int")>
			<cfset ArrayAppend(uniqueColumnWhere, "[#uniqueColumn#] = @#uniqueColumn#")>
		</cfloop>
		<cfset procContents.append(ArrayToList(uniqueColumnVariables) & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(ArrayToList(variables.columnArray)) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[#variables.schema#].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE"	& Chr(9) & Replace(ArrayToList(uniqueColumnWhere), ",", " AND ", "ALL") & Chr(13) & Chr(10)) />
		<cfif variables.active>
			<cfset procContents.append("AND"	& Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />
		</cfif>
		<cfif not variables.tableObj.isProperTable()>
			<cfset procContents.append("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>




	<!---***********************************************************--->
	<!---StoredProcExists                        --->
	<!---Determines if a stored proc exists in a given database.     --->
	<!---***********************************************************--->
	<cffunction access="private" name="StoredProcExists" output="false" returntype="boolean" description="Determines if a stored proc exists in a given database.">
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">

		<cfset var exists = QueryNew('') />

		<!--- Adjust for fact that you may not have a database username and password. --->
		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfquery name="exists" datasource="#configObj.get('db', 'datasource')#" username="#configObj.get('db', 'username')#" password="#configObj.get('db', 'password')#">
				SELECT *
				FROM dbo.sysobjects
				WHERE id = OBJECT_ID('#arguments.name#')
			</cfquery>
		<cfelse>
			<cfquery name="exists" datasource="#configObj.get('db', 'datasource')#">
				SELECT *
				FROM dbo.sysobjects
				WHERE id = OBJECT_ID('#arguments.name#')
			</cfquery>
		</cfif>


		<cfif exists.recordCount gt 0>
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
	</cffunction>

	<!---***********************************************************--->
	<!---GrantExecStoredProc                     --->
	<!---Grants Exec Permissions on given database user.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="GrantExecStoredProc" output="false" returntype="boolean" description="Grants Exec Permissions on given database user.">
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">

		<cfset var grant = "" />

		<cftry>
		<!--- Adjust for fact that you may not have a database username and password. --->
		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfquery name="grant" datasource="#configObj.get('db', 'datasource')#" username="#configObj.get('db', 'username')#" password="#configObj.get('db', 'password')#">
				GRANT EXEC on #arguments.name# to #variables.databaseuser#
			</cfquery>
		<cfelse>
			<cfquery name="grant" datasource="#configObj.get('db', 'datasource')#">
				GRANT EXEC on #arguments.name# to #variables.databaseuser#
			</cfquery>
		</cfif>

		<!--- Why a catch that does nothing? Because I couldn't figure out how to make these stop throwing errors.'--->
		<!--- It's intermitent and testing doesn't reveal any problems.' ' --->
		<cfcatch type="any">
			<cfrethrow />
		</cfcatch>
		</cftry>


		<cfreturn TRUE />
	</cffunction>

	<!---***********************************************************--->
	<!---wrapProc                                --->
	<!---Wraps the proc in the script code.                          --->
	<!---***********************************************************--->
	<cffunction access="public" name="wrapProc" output="false" returntype="string" description="Wraps the proc in the script code." >
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">
		<cfargument name="creationCode" type="string" required="yes" hint="Code to Create stored Proc.">

		<cfset var generatedScript = CreateObject("java","java.lang.StringBuilder").Init() />

		<cfset generatedScript.append("IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('#arguments.name#') AND OBJECTPROPERTY(id, 'IsProcedure') = 1)") />
		<cfset generatedScript.append("DROP PROCEDURE #arguments.name# ") />

		<cfset generatedScript.append(chr(10) & chr(13) &"GO" & chr(10) & chr(13) & chr(10) & chr(13)) />

		<cfset generatedScript.append(arguments.creationCode) />
		<cfset generatedScript.append(chr(10) & chr(13) & "GO" & chr(10) & chr(13) & chr(10) & chr(13)) />

		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfset generatedScript.append("GRANT EXEC on #arguments.name# to #variables.databaseuser#") />
			<cfset generatedScript.append(chr(10) & chr(13) & "GO" & chr(10) & chr(13) & chr(10) & chr(13)) />
		</cfif>

		<cfreturn generatedScript.ToString() />
	</cffunction>

	<!---***********************************************************--->
	<!---ListQualifySeparate                                --->
	<!---Qualifies a list with separate characters for begining and end.                        --->
	<!---***********************************************************--->
	<cffunction access="private" name="ListQualifySeparate" output="false" returntype="string" description="Qualifies a list with separate characters for begining and end. Good for wrapping list elements in say a parenthesis block." >
		<cfargument name="list" type="string" required="yes" hint="The list to manipulate." />
		<cfargument name="startString" type="string" required="no" default="[" hint="The string that comes at the begining of the list item." />
		<cfargument name="endString" type="string" required="no" default="]" hint="The string that comes at the end of the list item." />
		<cfargument name="delimiter" type="string" required="no" default="," hint="The list delimiter." />

		<cfset var results = "" />
		<cfset var member = "" />

		<cfloop list="#arguments.list#" index="member">
			<cfset results = ListAppend(results, "#arguments.startString##member##arguments.endString#", arguments.delimiter)>
		</cfloop>

		<cfreturn results />
	</cffunction>

</cfcomponent>