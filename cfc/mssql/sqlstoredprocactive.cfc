<!---   SQLstoredprocActive.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Handles all of the rules assoiciated with creating SQL stored procedures
--->
<!--- 3/29/2007 tpryan updated to allow for active inactive delete instead of actual deleting of records. --->
<cfcomponent output="FALSE" extends="sqlstoredproc">



	<!---***********************************************************--->
	<!---createProcedureList                   --->
	<!---Creates a stored proc for a table list                    --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureList" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procName = "[#variables.schema#].[usp_#variables.unspacedtableName#_list]" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list" />
		<cfset var columnList = ArrayToList(variables.columnArray) />

		<cfset columnList = ReplaceNoCase(columnList,"," & configObj.get('reservedWords', 'active'),"","ALL") />
		<cfset columnList = ReplaceNoCase(columnList,configObj.get('reservedWords', 'active') & "," ,"","ALL") />
		<cfset columnList = ReplaceNoCase(columnList,configObj.get('reservedWords', 'active'),"","ALL") />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName#")) />
		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(columnList) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[dbo].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE"	& Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />

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

		<cfset var columnList = ArrayToList(variables.columnArray) />

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



		<cfset columnList = ReplaceNoCase(columnList,"," & configObj.get('reservedWords', 'active'),"","ALL") />
		<cfset columnList = ReplaceNoCase(columnList,configObj.get('reservedWords', 'active') & "," ,"","ALL") />
		<cfset columnList = ReplaceNoCase(columnList,configObj.get('reservedWords', 'active'),"","ALL") />

		<cfset procContents.append(createComment(name=procName, author="GangPlank", description="Selects one record in table #variables.tableName#")) />

		<cfset procContents.append("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents.append(Chr(9) & "@#variables.identity# int" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(columnList) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[dbo].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE"	& Chr(9) & "[#variables.identity#] = @#variables.identity#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AND"	& Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />

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
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>
		<cfset procContents.append("UPDATE" & Chr(9) & "[dbo].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("SET" & Chr(9) & "#configObj.get('reservedWords', 'active')# = 0" & Chr(13) & Chr(10)) />


		<cfif ListFindNoCase(ArrayToList(variables.columnArray), configObj.get('reservedWords', 'updatedOn'))>
			<cfset procContents.append("," & Chr(9) & "#configObj.get('reservedWords', 'updatedOn')# = CURRENT_TIMESTAMP" & Chr(13) & Chr(10)) />
		</cfif>
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
						compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'active')) and
							compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))	>
				<!--- Handle Varchars --->
				<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset params = listAppend(params, Chr(9) & "@#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#", ",") />
				<cfelseif FindNoCase("decimal", arguments.columnInfo[variables.columnArray[i]]['type'])>
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
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'active'))>
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
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents.append("UPDATE" & Chr(9) & "[dbo].[#variables.tableName#]" & Chr(13) & Chr(10)) />
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
			<cfif compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn'))
					and compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))
					and compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'active'))	>

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
			<cfif not compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'active'))>
				<cfset columnType = "active">
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
				<cfcase value="active">
					<cfset columnList = ListAppend(columnList,"[#variables.columnArray[i]#]") />
					<!--- Let these values be auto generated. --->
					<cfset valuesList = ListAppend(valuesList, 1) />
				</cfcase>
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
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />
		</cfif>

		<!--- Create insert line --->
		<cfset procContents.append("INSERT INTO" & Chr(9) & "[dbo].[#variables.tableName#](#columnList#)" & Chr(13) & Chr(10) )/>
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

			<cfdump var="#arguments.columnInfo[variables.columnArray[i]]['type']#">

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
		<cfset procContents.append("#params#" & Chr(13) & Chr(10)) />
		<cfset procContents.append("AS" & Chr(13) & Chr(10)) />

		<cfif arguments.noCountOn>
			<cfset procContents.append("SET NOCOUNT ON" & Chr(13) & Chr(10) & Chr(13) & Chr(10))/>
		</cfif>

		<cfset procContents.append("SELECT" & Chr(9) & ListQualifySeparate(ArrayToList(variables.columnArray)) & Chr(13) & Chr(10)) />
		<cfset procContents.append("FROM"	& Chr(9) & "[dbo].[#variables.tableName#]" & Chr(13) & Chr(10)) />
		<cfset procContents.append("WHERE" & Chr(13) & Chr(10)) />
		<cfset procContents.append(whereClause) />
		<cfset procContents.append("AND"	& Chr(9) & Chr(9) & "[#configObj.get('reservedWords', 'active')#] = 1" & Chr(13) & Chr(10)) />



		<cfset results.contents = procContents.toString() />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />
		
		
		<cfreturn results />
	</cffunction>

</cfcomponent>