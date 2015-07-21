<!---   SQLstoredproc.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Handles all of the rules assoiciated with creating SQL stored procedures for MYSSQL
--->

<cfcomponent extends="GangPlank2.cfc.base.SQLStoredProc">

	<!---*********************************************************** --->
	<!--- init                                                        --->
	<!--- Psuedo constructor, and all around nice function.           --->
	<!--- *********************************************************** --->
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

		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfset db.username = configObj.get('db', 'username') />
			<cfset db.password = configObj.get('db', 'password') />
		</cfif>

		<cfset db.datasource = configObj.get('db', 'datasource') />
		<cfset database = configObj.get('db', 'database') />

		<cfreturn This />
	</cffunction>

	<!--- STORED PROC CREATE ROUTINES --->
	<!--- *********************************************************** --->
	<!--- createProcedureList                                         --->
	<!--- Creates a stored proc for a table list.                     --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureList" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />



		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list" />
		<cfset var procName = "`#database#`.`#displayName#`" />



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName# ()" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName#")) />

		<cfset procContents = procContents.concat("SELECT" & Chr(9) & ListQualify(ArrayToList(variables.columnArray),"`") & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfif variables.active>
			<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#configObj.get('reservedWords', 'active')#` = 1" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#ReplaceList(variables.tabledetails.orderBy, '[,]', '`,`')#" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureSelect                                       --->
	<!--- Creates a stored proc for a table select                    --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureSelect" output="false" returntype="struct" description="Creates a stored proc for a table select.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />
		<cfargument name="uniqueField" type="string" required="no" default="#variables.identity#" hint="Whether or not to set no count on." />
		<cfargument name="uniqueFieldType" type="string" required="no" default="int" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "" />
		<cfset var procName = "" />

		<cfif compareNoCase(variables.identity, arguments.uniqueField) neq 0>
			<cfset displayName = "usp_#variables.unspacedtableName#_select_by_#arguments.uniqueField#" />
		<cfelse>
			<cfset displayName = "usp_#variables.unspacedtableName#_select" />
		</cfif>

		<cfset procName = "`#database#`.`#displayName#`" />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Selects one record in table #variables.tableName#")) />

		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(Chr(9) & "(_#arguments.uniqueField# #arguments.uniqueFieldType#)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat("SELECT" & Chr(9) & ArrayToList(variables.columnArray) & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10) )/>
		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#arguments.uniqueField#` = _#arguments.uniqueField#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureDelete                                       --->
	<!--- Creates a stored proc for a table delete.                   --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureDelete" output="false" returntype="struct" description="Creates a stored proc for a table delete.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_delete" />
		<cfset var procName = "`#database#`.`#displayName#`" />

		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(Chr(9) & "(_#variables.Identity# int)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Deletes one record in table #variables.tableName#")) />

		<cfset procContents = procContents.concat("DELETE" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#variables.Identity#` = _#variables.Identity#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureUpdate                                       --->
	<!--- Creates a stored proc for a table update.                   --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureUpdate" output="false" returntype="struct" description="Creates a stored proc for a table update.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_update" />
		<cfset var procName = "`#database#`.`#displayName#`" />
		<cfset var params = "" />
		<cfset var setsList = "" />
		<cfset var columnType = "" />
		<cfset var i = 0 />
		<cfset var nullableString = "" />

		<!--- Loop through the table columns to create the input parameters. --->
		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">

			<!--- If column is Nullable, allow the procedure to be. --->
			<!--- <cfif arguments.columnInfo[variables.columnArray[i]]['nullable']>
				<cfset nullableString = " = NULL" />
			<cfelse>
				<cfset nullableString = "" />
			</cfif> --->

			<cfset nullableString = "" />


			<!--- Ensure that createdon, createdby and updated on are autogenerated. --->
			<cfif compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn')) and
					compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdBy')) and
						compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))>
				<!--- Handle Varchars --->
				<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset params = listAppend(params, Chr(9) & "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#", ",") />
				<cfelseif arguments.columnInfo[variables.columnArray[i]]['isIdentity']>
					<cfset params = listAppend(params, Chr(9) & "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#", ",") />
				<cfelseif FindNoCase("decimal", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset params = listAppend(params, Chr(9) & "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['prec']#, #arguments.columnInfo[variables.columnArray[i]]['scale']#)#nullableString#", ",")  />
				<cfelse>
					<cfset params = listAppend(params, Chr(9) & "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#", ",") />
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
					<cfset setsList = ListAppend(setsList, Chr(9) & "`" & variables.columnArray[i] & "`" & " = " & "CURRENT_TIMESTAMP", ",") />
				</cfcase>
				<cfdefaultcase>
					<cfset setsList = ListAppend(setsList, Chr(9) & "`" & variables.columnArray[i] & "`" & " = " & variables.columnArray[i], ",") />
				</cfdefaultcase>
			</cfswitch>


		</cfloop>


		<cfset params = Replace(params, ",", "," & Chr(13) & Chr(10), "ALL") />
		<cfset setsList = Replace(setsList, ",", "," & Chr(13) & Chr(10), "ALL") />



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("(#params#)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Updates one record in table #variables.tableName#")) />

		<cfset procContents = procContents.concat("UPDATE" & Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("SET") />
		<cfset procContents = procContents.concat(setsList & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#variables.Identity#` = _#variables.Identity#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureSearch                                       --->
	<!--- Creates a stored proc for a table update.                   --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureSearch" output="false" returntype="struct" description="Creates a stored proc for a table update.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_search" />
		<cfset var procName = "`#database#`.`#displayName#`" />
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
					<cfset params = listAppend(params, Chr(9) & "#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#", ",") />
				<cfelse>
					<cfset params = listAppend(params, Chr(9) & "#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#", ",") />
				</cfif>


				<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
					<cfset whereClause = whereClause.concat( Chr(9) & "(#variables.columnArray[i]# Like '%' + #variables.columnArray[i]# + '%' OR #variables.columnArray[i]# IS NULL)" & Chr(13) & Chr(10) ) />
				<cfelse>
					<cfset whereClause = whereClause.concat( Chr(9) & "(#variables.columnArray[i]# =  #variables.columnArray[i]# OR #variables.columnArray[i]# IS NULL)" & Chr(13) & Chr(10) ) />
				</cfif>





			</cfif>

		</cfloop>




		<cfset params = Replace(params, ",", "," & Chr(13) & Chr(10), "ALL") />
		<cfset setsList = Replace(setsList, ",", "," & Chr(13) & Chr(10), "ALL") />



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("(#params#)" & Chr(13) & Chr(10) )/>
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Performs various searches on table:  #variables.tableName#")) />



		<cfset procContents = procContents.concat("SELECT" & Chr(9) & ArrayToList(variables.columnArray) & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("WHERE" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(whereClause) />
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureInsert                                       --->
	<!--- Creates a stored proc for a table insert.                   --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureInsert" output="false" returntype="struct" description="Creates a stored proc for a table insert.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_insert" />
		<cfset var procName = "`#database#`.`#displayName#`" />
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
			<!--- <cfif arguments.columnInfo[variables.columnArray[i]]['nullable']>
				<cfset nullableString = " = NULL" />
			<cfelse>
				<cfset nullableString = "" />
			</cfif> --->

			<cfset nullableString = "" />

			<!--- Ensure that createdon, createdby and updated on are autogenerated. --->
			<cfif compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'createdOn')) and
					compareNoCase(variables.columnArray[i], configObj.get('reservedWords', 'updatedOn'))>

				<cfif not compareNoCase(variables.columnArray[i], variables.Identity)>
					<cfset params = listAppend(params, Chr(9) & "OUT _#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#" & Chr(13) & Chr(10), ",") />
				<cfelse>
					<!--- Handle Varchars --->
					<cfif FindNoCase("char", arguments.columnInfo[variables.columnArray[i]]['type'])>
						<cfset params = listAppend(params, Chr(9) & "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['length']#)#nullableString#" & Chr(13) & Chr(10), ",")  />
					<cfelseif FindNoCase("decimal", arguments.columnInfo[variables.columnArray[i]]['type'])>
						<cfset tempstring = "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']#(#arguments.columnInfo[variables.columnArray[i]]['prec']#,#Trim(arguments.columnInfo[variables.columnArray[i]]['scale'])#)#nullableString#"  />

						<cfset params = listAppend(params, Chr(9) & tempString & Chr(13) & Chr(10), ",")  />
					<cfelse>
						<cfset params = listAppend(params, Chr(9) & "_#variables.columnArray[i]# #arguments.columnInfo[variables.columnArray[i]]['type']##nullableString#" & Chr(13) & Chr(10), ",") />
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
					<cfset columnList = ListAppend(columnList,"`#variables.columnArray[i]#`") />
					<!--- Let these values be auto generated. --->
					<cfset valuesList = ListAppend(valuesList, "CURRENT_TIMESTAMP") />
				</cfcase>
				<cfdefaultcase>
					<cfset columnList = ListAppend(columnList,"`#variables.columnArray[i]#`") />
					<cfset valuesList = ListAppend(valuesList, "_#variables.columnArray[i]#") />
				</cfdefaultcase>
			</cfswitch>

		</cfloop>





		<!--- <cfset params = Replace(params, ",", "," & Chr(13) & Chr(10), "ALL") /> --->



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("(#params#)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10) )/>

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Inserts one record into table #variables.tableName#")) />

		<!--- Create insert line --->
		<cfset procContents = procContents.concat("INSERT INTO" & Chr(9) & "`#database#`.`#variables.tableName#`(#columnList#)" & Chr(13) & Chr(10)) />
		<!--- Create Values line.  --->
		<cfset procContents = procContents.concat("VALUES (#valuesList#)" & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />

		<!--- Create return value line --->
		<cfset procContents = procContents.concat("select last_insert_id() into _#variables.Identity# "  & Chr(13) & Chr(10) & Chr(13) & Chr(10)) />


		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />




		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />



		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createListThroughJoinTable                                  --->
	<!--- Creates list for table through joined Table                --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createListThroughJoinTable" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />
		<cfargument name="otherTable" type="string" required="yes" hint="The other table to link to." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_by_#databaseObj.getIdentity(otherTable)#" />
		<cfset var procName = "`#database#`.`#displayName#`" />
		<cfset var joinTable = "" />
		<cfset var temp= 0 />
		<cfset var tempColumnArray = variables.columnArray />
		<cfset var i = 0 />


		<cfset temp = ListFind(tableObj.getJoinTableList(),arguments.otherTable) />
		<cfset joinTable = ListGetAt(tableObj.getPassThroughTableList(),temp) />

		<cfloop index="i" from="1" to="#ArrayLen(tempColumnArray)#">
			<cfset tempColumnArray[i] = "`#variables.tableName#`." & tempColumnArray[i] />
		</cfloop>


		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName# (_#databaseObj.getIdentity(otherTable)# int)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName# that are linked to record in #arguments.otherTable# through table #joinTable# ")) />

		<cfset procContents = procContents.concat("SELECT" & Chr(9) & ArrayToList(tempColumnArray) & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"   & Chr(9) & "`#variables.tableName#`" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat("INNER JOIN	#joinTable#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("ON	#tableName#.#identity# = #joinTable#.#identity#" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat("INNER JOIN	#otherTable#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("ON	#joinTable#.#databaseObj.getIdentity(otherTable)# = #otherTable#.#databaseObj.getIdentity(otherTable)#" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat("WHERE `#otherTable#`.#databaseObj.getIdentity(otherTable)# = _#databaseObj.getIdentity(otherTable)#" & Chr(13) & Chr(10)) />



		<cfif variables.active>
			<cfset procContents = procContents.concat("AND"	& Chr(9) & "`#variables.tableName#`.`#configObj.get('reservedWords', 'active')#` = 1" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#ReplaceList(variables.tabledetails.orderBy, '[,]', '`,`')#" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureListByForeignKey                             --->
	<!--- Creates a stored proc for a table list by a foreign key.    --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureListByForeignKey" output="false" returntype="struct" description="Creates a stored proc for a table list by a foreign key. ">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="foreignKey" type="string" required="yes" hint="The foreign key in this table." />



		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_by_#arguments.foreignKey#" />
		<cfset var procName = "`#database#`.`#displayName#`" />

		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName# (_#arguments.foreignKey# int)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName# by #arguments.foreignKey#")) />

		<cfset procContents = procContents.concat("SELECT" & Chr(9) & ArrayToList(variables.columnArray) & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#variables.tableName#`.`#arguments.foreignKey#` = _#arguments.foreignKey#" & Chr(13) & Chr(10)) />


		<cfif variables.active>
			<cfset procContents = procContents.concat("AND"	& Chr(9) & "`#configObj.get('reservedWords', 'active')#` = 1" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#ReplaceList(variables.tabledetails.orderBy, '[,]', '`,`')#" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureListwithForeignKeys                          --->
	<!--- Creates a stored proc for a table list.                     --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureListwithForeignKeys" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_with_FK" />
		<cfset var procName = "`#database#`.`#displayName#`" />

		<cfset var selectString = ""/>
		<cfset var innerjoinString = ""/>
		<cfset var innerjoinSubString = ""/>
		<cfset var linkedLabelField = ""/>
		<cfset var linkedTable = ""/>
		<cfset var linkedField = ""/>
		<cfset var i = 0/>
		<cfset var nullable = FALSE />



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName# ()" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Lists all records in table #variables.tableName# with columns replaced by their foreign key.")) />

		<cfset selectString = ""/>
		<cfset innerjoinString = ""/>

		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">
			<cfif len(variables.tabledetails.columnlist[variables.columnArray[i]]['linkedField']) gt 0>
				<cfset linkedTable = variables.tabledetails.columnlist[columnArray[i]]['linkedTable'] />
				<cfset linkedField = variables.tabledetails.columnlist[columnArray[i]]['linkedField'] />
				<cfset linkedLabelField = variables.databaseObj.getTableForeignKeyLabel(linkedTable) />
				<cfset linkedTableAlias = linkedTable & "for" & variables.columnArray[i] />
				<cfset nullable = variables.tabledetails.columnlist[columnArray[i]]['nullable'] />
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "#linkedTableAlias#.`#linkedLabelField#` AS #variables.columnArray[i]#") />

				<!--- tpryan 5/2007 made inner joins happen when fields are required. --->
				<cfif nullable>
					<cfset innerjoinSubString = "LEFT OUTER JOIN `#linkedTable#` as #linkedTableAlias#  ">
				<cfelse>
					<cfset innerjoinSubString = "INNER JOIN `#linkedTable#` as #linkedTableAlias#  ">
				</cfif>
				<cfset innerjoinSubString = innerjoinSubString & "ON #linkedTableAlias#.`#linkedField#` = `#variables.tableName#`.`#variables.columnArray[i]#` " />

				<cfset innerjoinString = ListAppend(innerjoinString, innerjoinSubString, Chr(10))/>

			<cfelse>
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "`#variables.tableName#`.`#variables.columnArray[i]#`" )>
			</cfif>
		</cfloop>




		<cfset procContents = procContents.concat("SELECT" & Chr(9) & selectString & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(innerjoinString & Chr(13) & Chr(10)) />

		<cfif variables.active>
			<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#variables.tableName#`.`#configObj.get('reservedWords', 'active')#` = 1" & Chr(13) & Chr(10)) />
		</cfif>


		<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#ReplaceList(variables.tabledetails.orderBy, '[,]', '`,`')#" & Chr(13) & Chr(10)) />


		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />


		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureSelectwithForeignKeys                          --->
	<!--- Creates a stored proc for a table list.                     --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureSelectwithForeignKeys" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_select_with_FK" />
		<cfset var procName = "`#database#`.`#displayName#`" />
		<cfset var selectString = ""/>
		<cfset var innerjoinString = ""/>
		<cfset var innerjoinSubString = ""/>
		<cfset var linkedLabelField = ""/>
		<cfset var linkedTable = ""/>
		<cfset var linkedField = ""/>
		<cfset var i = 0/>
		<cfset var nullable = FALSE />



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(Chr(9) & "(_#variables.identity# int)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Selects one record in table #variables.tableName# with columns replaced by their foreign key.")) />

	<cfset selectString = ""/>
		<cfset innerjoinString = ""/>

		<cfloop index="i" from="1" to="#ArrayLen(variables.columnArray)#">
			<cfif len(variables.tabledetails.columnlist[variables.columnArray[i]]['linkedField']) gt 0>
				<cfset linkedTable = variables.tabledetails.columnlist[columnArray[i]]['linkedTable'] />
				<cfset linkedField = variables.tabledetails.columnlist[columnArray[i]]['linkedField'] />
				<cfset linkedLabelField = variables.databaseObj.getTableForeignKeyLabel(linkedTable) />
				<cfset linkedTableAlias = linkedTable & "for" & variables.columnArray[i] />
				<cfset nullable = variables.tabledetails.columnlist[columnArray[i]]['nullable'] />
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "#linkedTableAlias#.`#linkedLabelField#` AS #variables.columnArray[i]#" )>

				<!--- tpryan 5/2007 made inner joins happen when fields are required. --->
				<cfif nullable>
					<cfset innerjoinSubString = "LEFT OUTER JOIN `#linkedTable#` as #linkedTableAlias#  ">
				<cfelse>
					<cfset innerjoinSubString = "INNER JOIN `#linkedTable#` as #linkedTableAlias#  ">
				</cfif>
				<cfset innerjoinSubString = innerjoinSubString & "ON #linkedTableAlias#.`#linkedField#` = `#variables.tableName#`.`#variables.columnArray[i]#` " />

				<cfset innerjoinString = ListAppend(innerjoinString, innerjoinSubString, Chr(10))/>

			<cfelse>
				<cfset selectString = ListAppend(selectString, Chr(13) & Chr(10) & chr(9) & "`#variables.tableName#`.`#variables.columnArray[i]#`" )>
			</cfif>
		</cfloop>




		<cfset procContents = procContents.concat("SELECT" & Chr(9) & selectString & Chr(13) & Chr(10) )/>
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(innerjoinString & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#variables.tableName#`.`#variables.identity#` = _#variables.identity#" & Chr(13) & Chr(10)) />


		<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#ReplaceList(variables.tabledetails.orderBy, '[,]', '`,`')#" & Chr(13) & Chr(10)) />


		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />


		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- createProcedureListForeignKeyLabels                         --->
	<!--- Creates a stored proc for a table list.                     --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureListForeignKeyLabels" output="false" returntype="struct" description="Creates a stored proc for a table list.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_list_foreign_key_labels" />
		<cfset var procName = "`#database#`.`#displayName#`" />



		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName# ()" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Lists the id and foriegn key label for table: #variables.tableName#")) />


		<cfset procContents = procContents.concat("SELECT `#variables.identity#` as foreignKeyID, `#variables.foreignKeyLabel#` as foreignKeyLabel"  & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />

		<cfif variables.active>
			<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "`#configObj.get('reservedWords', 'active')#` = 1" & Chr(13) & Chr(10)) />
		</cfif>

		<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#ReplaceList(variables.tabledetails.orderBy, '[,]', '`,`')#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />



		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>


	<!--- *********************************************************** --->
	<!--- createProcedureJoinTableUnique                              --->
	<!--- Creates a stored proc for a table to read in unique join table records. --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createProcedureJoinTableUnique" output="false" returntype="struct" description="Creates a stored proc for a table to read in unique join table records.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />
		<cfargument name="uniqueColumnList" type="string" required="yes" hint="The columns to read uniqueness off of." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "usp_#variables.unspacedtableName#_select_by_unique_join" />
		<cfset var procName = "`#database#`.`#displayName#`" />
		<cfset var uniqueColumn = "" />
		<cfset var uniqueColumnVariables = ArrayNew(1) />
		<cfset var uniqueColumnWhere = ArrayNew(1) />


		<cfset procContents = procContents.concat("CREATE PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfloop list="#arguments.uniqueColumnList#" index="uniqueColumn">
			<cfset ArrayAppend(uniqueColumnVariables, "_#uniqueColumn# int")>
			<cfset ArrayAppend(uniqueColumnWhere, "`#uniqueColumn#` = _#uniqueColumn#")>
		</cfloop>
		<cfset procContents = procContents.concat("(" & ArrayToList(uniqueColumnVariables) & ")" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("BEGIN" & Chr(13) & Chr(10)) />

		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Reads one record in table #variables.tableName# by its join columns")) />


		<cfset procContents = procContents.concat("SELECT" & Chr(9) & ListQualify(ArrayToList(variables.columnArray), "`") & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("FROM"	& Chr(9) & "`#database#`.`#variables.tableName#`" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & Replace(ArrayToList(uniqueColumnWhere), ",", " AND ", "ALL") & Chr(13) & Chr(10)) />
		<cfif variables.active>
			<cfset procContents = procContents.concat("AND"	& Chr(9) & "`#configObj.get('reservedWords', 'active')#` = 1" & Chr(13) & Chr(10)) />
		</cfif>
		<cfif not variables.tableObj.isProperTable()>
			<cfset procContents = procContents.concat("ORDER BY"	& Chr(9) & "#variables.tabledetails.orderBy#" & Chr(13) & Chr(10)) />
		</cfif>
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END" & Chr(13) & Chr(10)) />


		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>






	<!--- *********************************************************** --->
	<!--- StoredProcExists                                            --->
	<!--- Determines if a stored proc exists in a given database.     --->
	<!--- *********************************************************** --->
	<cffunction access="private" name="StoredProcExists" output="false" returntype="boolean" description="Determines if a stored proc exists in a given database.">
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">

		<cfset var exists = QueryNew('') />
		<cfset var localdb= duplicate(db) />

		<cfset var procName = Replace(getToken(arguments.name, 2, "."),  "`", "", "ALL") />

		<cfset localdb.name = "exists" />

		<cfquery attributeCollection="#localdb#">
			SELECT name
			FROM mysql.proc
			WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#procName#">
		</cfquery>

		<cfif exists.recordCount gt 0>
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
	</cffunction>

	<!--- *********************************************************** --->
	<!--- wrapProc                                                    --->
	<!--- Wraps the proc in the script code.                          --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="wrapProc" output="false" returntype="string" description="Wraps the proc in the script code." >
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">
		<cfargument name="creationCode" type="string" required="yes" hint="Code to Create stored Proc.">

		<cfset var generatedScript = "" />
		<cfset var procName = Replace(getToken(arguments.name, 2, "."),  "`", "", "ALL") />



		<cfset generatedScript = generatedScript.concat("DROP PROCEDURE IF EXISTS #procName#;") />

		<cfset generatedScript = generatedScript.concat(chr(10) & chr(13) &"DELIMITER $$" & chr(10) & chr(13) & chr(10) & chr(13)) />

		<cfset generatedScript = generatedScript.concat(arguments.creationCode) />
		<cfset generatedScript = generatedScript.concat(chr(10) & chr(13) & "$$" & chr(10) & chr(13) & chr(10) & chr(13)) />

		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfset generatedScript = generatedScript.concat("GRANT EXECUTE ON PROCEDURE #procName# to #variables.databaseuser#") />
			<cfset generatedScript = generatedScript.concat(chr(10) & chr(13) & "$$" & chr(10) & chr(13) & chr(10) & chr(13)) />
		</cfif>

		<cfset generatedScript = generatedScript.concat(chr(10) & chr(13) &"DELIMITER ;" & chr(10) & chr(13) & chr(10) & chr(13)) />
		<cfreturn generatedScript />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- GrantExecStoredProc                                         --->
	<!--- Grants Exec Permissions on given database user.             --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="GrantExecStoredProc" output="false" returntype="boolean" description="Grants Exec Permissions on given database user.">
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">

		<cfset var grant = "" />

		<cftry>
		<!--- Adjust for fact that you may not have a database username and password. --->
		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfquery name="grant" datasource="#configObj.get('db', 'datasource')#" username="#configObj.get('db', 'username')#" password="#configObj.get('db', 'password')#">
				GRANT EXECUTE on PROCEDURE #arguments.name# to #variables.databaseuser#
			</cfquery>
		<cfelse>
			<cfquery name="grant" datasource="#configObj.get('db', 'datasource')#">
				GRANT EXECUTE on PROCEDURE #arguments.name# to #variables.databaseuser#
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

</cfcomponent>