<!---   database.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Pulls in MSSQL database structure, and makes it accessible.
--->
<cfcomponent output="FALSE">

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction access="public" name="init" output="FALSE" >
		<cfargument name="configObj" type="any" required="no" default="" hint="The configuration of the application." />

		<cfset variables.overrideList ="displayName,orderBy,ForeignKeyLabel,IsImage,label" />
		<cfset variables.configObj = arguments.configObj />
		<cfset variables.databaseStruct = StructNew() />
		<cfset variables.tableArray = ArrayNew(1) />

		<cfinvoke component="#configObj.get('cfc','help')#" method="init" returnvariable="variables.helpObj">
			<cfinvokeargument name="datasource" value="#configObj.get('db', 'datasource')#" />
			<cfinvokeargument name="username" value="#configObj.get('db', 'username')#" />
			<cfinvokeargument name="password" value="#configObj.get('db', 'password')#" />
			<cfinvokeargument name="configObj" value="#variables.configObj#" />
		</cfinvoke>

		<cfobjectcache action = "clear" />
		<cfset inspectTables() />

		<cfreturn This />
	</cffunction>

	<!---***********************************************************--->
	<!---inspectTables                           --->
	<!---Grabs SQL Data from the correct location.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="inspectTables" output="FALSE" returntype="void" description="Grabs SQL Data from the correct location." >

		<cfset var file = variables.configObj.get('filelocations','sql') & "/tables.xml" />

		<cfset inspectTablesFromDB() />

		<cfif not variables.configObj.get('settings','ignoreXMLCache')>
			<cfif fileExists(file)>
				<cfset inspectTablesFromXML(file) />
				<cfset CompareTableValuesFromXML() />
			</cfif>
			<cffile action="write" file="#file#" output="#getTableInfoAsXML()#" />

		</cfif>

	</cffunction>

	<!---***********************************************************--->
	<!---CompareTableValuesFromXML                           --->
	<!---Replaces the table details with info from XML file                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="CompareTableValuesFromXML" output="FALSE" returntype="void" description="Replaces the table details with info from XML file." >

		<cfset var overrideTerm = "" />
		<cfset var overRideArray = ArrayNew(1) />
		<cfset var i = 0 />
		<cfset var pointer = 0 />

		<cfloop list="#variables.overrideList#" index="overrideTerm">
			<cfset overRideArray = StructFindKey(variables.databaseStructXML,overrideTerm, "all") />




			<!--- Cannot override for tables with spaces.  --->
			<!--- Using convertStructFindKeyNotation below might work in the future, but it throws an error, even though it shouldn't' --->
			<!--- TODO: File bug report with Adobe. --->
			<cfloop index="i" from="1" to="#arrayLen(overRideArray)#">
				<cfif not FindNoCase(" ", overRideArray[i].path ) >
					<cfset "variables.databaseStruct#overRideArray[i].path#" = overRideArray[i].value />
					<cfset databaseStruct[GetToken(overRideArray[i].path, 1, '.')]['checksum'] = computeCheckSum(GetToken(overRideArray[i].path, 1, '.')) />
				</cfif>
			</cfloop>


		</cfloop>


		<!--- Checksum test will now help help speed up process --->
		<cfloop index="i" from="1" to="#ArrayLen(variables.tableArray)#">
			<cfif not StructKeyExists(variables.databaseStructXML,variables.tableArray[i]) OR
					not StructKeyExists(variables.databaseStructXML[variables.tableArray[i]],'checksum') OR
						CompareNoCase(variables.databaseStruct[variables.tableArray[i]]['checksum'], variables.databaseStructXML[variables.tableArray[i]]['checksum']) neq 0>
				<cfset variables.databaseStruct[variables.tableArray[i]]['hasChanged'] = TRUE />
			<cfelse>
				<cfset variables.databaseStruct[variables.tableArray[i]]['hasChanged'] = FALSE />
			</cfif>


		</cfloop>




	</cffunction>





	<!---***********************************************************--->
	<!---inspectProcedures                       --->
	<!---Grabs SQL Data from the correct location.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="inspectProcedures" output="false" returntype="void" description="Grabs SQL Data from the correct location." >

		<cfset var file = variables.configObj.get('filelocations','sql') & "\procs.xml" />

		<cfinvoke method="inspectProceduresFromDB" />

		<cfset file = variables.configObj.get('filelocations','sql') & "/procs.xml" />

		<cffile action="write" file="#file#" output="#getProcedureInfoAsXML()#" />



	</cffunction>

	<!---***********************************************************--->
	<!---inspectTablesFromDB                           --->
	<!---Organizes all of the sp_help output for tables              --->
	<!--- into a usable form.                                         --->
	<!---***********************************************************--->
	<cffunction access="public" name="inspectTablesFromDB" output="FALSE" returntype="void" description="Organizes all of the sp_help output for tables into a usable form." >

		<cfset var tableInfo = "" />
		<cfset var dbColumnInfo = "" />
		<cfset var identityQuery = "" />
		<cfset var dbtables = "" />
		<cfset var removeArray = ArrayNew(1) />
		<cfset var tempList = "" />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var keyInfo = "" />
		<cfset var foreignKeyObj = "" />
		<cfset var columnKeyData = StructNew() />
		<cfset var referenceData = "" />
		<cfset var spHelpAttributes = StructNew() />
		<cfset var spHelpresults = StructNew() />
		<cfset var uniqueQuery = "" />

		<cfset variables.databaseStruct = StructNew() />
		<cfset variables.tableArray = ArrayNew(1) />

		<!--- 9/22/2007 tpryan replaced all sp help with function calls to make this more extenisible --->
		<!--- Sp_help to get the tables from the database --->
		<cfset dbtables = helpObj.getTables() />




		<cfset tableArray = ListToArray(ValueList(dbtables.table_name))/>

		<!--- Loop through tables and place info about them in struct --->
		<cfloop query="dbtables">

			<cfset referenceData = QueryNew('') />

			<cfset spHelpAttributes = helpObj.getTable(dbtables.table_name[dbtables.currentRow]) />
			<cfset tableInfo = spHelpAttributes.tableInfo />
			<cfset dbColumnInfo = spHelpAttributes.dbColumnInfo />
			<cfset identityQuery = spHelpAttributes.identityQuery />
			<cfset keyInfo = spHelpAttributes.keyInfo />
			<cfset referenceData = spHelpAttributes.referenceData />



			<!--- tpryan 5/2005 -  added to allow for foreign key analysis  --->
			<cfinvoke component="#configObj.get('cfc', 'fk')#" method="init" returnvariable="foreignKeyObj">
				<cfif isQuery(keyInfo)>
					<cfinvokeargument name="columnInfo" value="#keyInfo#">
				<cfelse>
					<cfinvokeargument name="columnInfo" value="#QueryNew('')#">
				</cfif>
			</cfinvoke>



			<cfset databaseStruct[table_name]['name'] = table_name />
			<cfset databaseStruct[table_name]['label'] = table_name />
			<cfset databaseStruct[table_name]['type'] = ReplaceNoCase(table_type, "user ", "", "ALL") />
			<cfset databaseStruct[table_name]['identity'] = identityQuery.Identity />
			<cfif CompareNoCase(configObj.get('db','type'), "mysql")eq 0>
				<cfset databaseStruct[table_name]['orderBy'] = "`#table_name#`.`#identityQuery.Identity#`"  />
			<cfelseif CompareNoCase(configObj.get('db','type'), "oracle")eq 0>
				<cfset databaseStruct[table_name]['orderBy'] = "#table_name#.#identityQuery.Identity#"  />
			<cfelse>
				<cfset databaseStruct[table_name]['orderBy'] = "[#table_name#].[#identityQuery.Identity#]"  />
			</cfif>





			<cfset databaseStruct[table_name]['columnlist'] =StructNew() />
			<cfset databaseStruct[table_name]['foreignKeyLabel'] = dbColumnInfo.column_name[2] />
			<cfset databaseStruct[table_name]['hasForeignKeys'] = foreignKeyObj.hasForeignKeys() />
			<cfset databaseStruct[table_name]['hasJoinTable'] = FALSE />
			<cfset databaseStruct[table_name]['JoinTableList'] = "" />
			<cfset databaseStruct[table_name]['PassThroughTableList'] = "" />
			<cfset databaseStruct[table_name]['uniqueList'] = "" />

			<cfif len(databaseStruct[table_name]['identity']) lt 1>
				<cfset databaseStruct[table_name]['identity'] ="No identity column defined" />
			</cfif>


			<cfif FindNoCase("No identity column defined", databaseStruct[table_name]['identity']) OR
					FindNoCase("view", tableInfo.type)>
				<cfset databaseStruct[table_name]['isProperTable'] = FALSE />
			<cfelse>
				<cfset databaseStruct[table_name]['isProperTable'] = TRUE />
			</cfif>

			<cfif referenceData.recordCount gt 0>
				<cfset databaseStruct[table_name]['isReferencedAsFK'] = TRUE />
				<!--- Added to make cross joining easier. --->
				<cfloop index="j" from="1" to="#ArrayLen(tableArray)#">

					<cfif tableExists("#table_name#to#tableArray[j]#")>
						<cfset databaseStruct[table_name]['hasJoinTable'] = TRUE />
						<cfset databaseStruct["#table_name#to#tableArray[j]#"]['isJoinTable'] = TRUE />
						<cfset databaseStruct[table_name]['JoinTableList'] = listAppend(databaseStruct[table_name]['JoinTableList'], tableArray[j] )>
						<cfset databaseStruct[table_name]['PassThroughTableList'] = listAppend(databaseStruct[table_name]['PassThroughTableList'], "#table_name#to#tableArray[j]#")>
					<cfelseif tableExists("#tableArray[j]#to#table_name#")>
						<cfset databaseStruct[table_name]['hasJoinTable'] = TRUE />
						<cfset databaseStruct["#tableArray[j]#to#table_name#"]['isJoinTable'] = TRUE />
						<cfset databaseStruct[table_name]['JoinTableList'] = listAppend(databaseStruct[table_name]['JoinTableList'], tableArray[j] )>
						<cfset databaseStruct[table_name]['PassThroughTableList'] = listAppend(databaseStruct[table_name]['PassThroughTableList'], "#tableArray[j]#to#table_name#")>
					</cfif>
				</cfloop>
			<cfelse>
				<cfset databaseStruct[table_name]['isReferencedAsFK'] = FALSE />
			</cfif>


			<!--- Testing for Unique Columns. --->
			<cfif keyInfo.RecordCount gt 0>
				<cfquery name="uniqueQuery" dbtype="query">
					SELECT 	*
					FROM	keyInfo
					WHERE	constraint_type like '%UNIQUE%'
				</cfquery>

				<cfloop query="uniqueQuery">
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['uniqueList'] = ListAppend(databaseStruct[dbtables.table_name[dbtables.currentRow]]['uniqueList'], constraint_keys) />
				</cfloop>
			</cfif>




			<!--- This is all the data I regularly need about the database. In the future I may need to add more data here.   --->
			<cfloop query="dbColumnInfo">
				<!--- tpryan 3/23/2007 - timestamps shouldn't bubble back up to the surface' --->
				<!--- tpryan 10/29/2007 - unless we're in oracle.' --->
				<cfif dbColumnInfo.type[dbColumnInfo.currentRow] eq "timestamp" and CompareNoCase(configObj.get('db', 'type'), "oracle") neq 0>
					<cfset arrayAppend(removeArray, dbColumnInfo.column_name[dbColumnInfo.currentRow]) />
				<cfelse>
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['name'] = dbColumnInfo.column_name[dbColumnInfo.currentRow] />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['displayName'] = dbColumnInfo.column_name[dbColumnInfo.currentRow] />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['type'] = dbColumnInfo.type[dbColumnInfo.currentRow] />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['nullable'] = dbColumnInfo.nullable[dbColumnInfo.currentRow] />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['scale'] = Trim(dbColumnInfo.scale[dbColumnInfo.currentRow]) />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['prec'] = Trim(dbColumnInfo.prec[dbColumnInfo.currentRow]) />

					<!--- JOHMS (Justin Ohms) 2007-08-03 - computed column support --->
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['computed'] = dbColumnInfo.computed[dbColumnInfo.currentRow] />
					<!--- JOHMS 2007-08-03 end --->

					<!--- tpryan 2007-10-07 Added to allow images to be configured in MYSQL --->
					<cfif FindNoCase("image", databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['type'])>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['isImage'] = TRUE />
					<cfelse>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['isImage'] = FALSE />
					</cfif>
					<!--- tpryan 2007-10-07 Added to allow images to be configured in MYSQL --->

					<cfif not CompareNoCase(dbColumnInfo.type[dbColumnInfo.currentRow], "uniqueidentifier")>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['length'] = 36 />
					<cfelseif not CompareNoCase(dbColumnInfo.type[dbColumnInfo.currentRow], "text")>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['length'] = 0 />
					<!--- 4/4/2007 tpryan Fixes an issue where nvarchars and nchars are reported as double their length, because on disk they really are.  --->
					<cfelseif not CompareNoCase(dbColumnInfo.type[dbColumnInfo.currentRow], "nchar") or not CompareNoCase(dbColumnInfo.type[dbColumnInfo.currentRow], "nvarchar")>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['length'] = dbColumnInfo.length[dbColumnInfo.currentRow] / 2 />
					<cfelse>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['length'] = dbColumnInfo.length[dbColumnInfo.currentRow] />
					</cfif>

					<cfif not CompareNoCase(databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['name'], identityQuery.Identity)>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['isIdentity'] = TRUE />
					<cfelse>
						<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['isIdentity'] = FALSE />
					</cfif>

					<cfset columnKeyData = foreignKeyObj.getForeignKeyInfoForColumn(column_name) />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['linkedTable'] = columnKeyData['linkedTable'] />
					<cfset databaseStruct[dbtables.table_name[dbtables.currentRow]]['columnlist'][column_name]['linkedField'] = columnKeyData['linkedField'] />

				</cfif>

			</cfloop>



			<cfset tempList = ValueList(dbColumnInfo.column_name) >

			<!--- tpryan 3/23/2007 - timestamps shouldn't bubble back up to the surface' --->
			<cfif arrayLen(removeArray) gt 0>
				<cfloop index="i" from="1" to="#ArrayLen(removeArray)#">
					<cfset tempList = ReplaceNoCase(tempList,removeArray[i], "", "ONCE") />
				</cfloop>
			</cfif>

			<cfset databaseStruct[table_name]['columnArray'] = ListToArray(tempList) />
			<!--- 2007-10-19 tpryan added checksuming to skip tables that haven't changed.' --->
			<cfset databaseStruct[table_name]['checksum'] = computeCheckSum(table_name) />
		</cfloop>


	</cffunction>

	<!---***********************************************************--->
	<!---inspectTablesFromXML                           --->
	<!---Grabs the same data as InspectTables, but does so through   --->
	<!--- an XML file cache                                           --->
	<!---***********************************************************--->
	<cffunction access="public" name="inspectTablesFromXML" output="FALSE" returntype="void" description="Grabs the table specs from a file instead of the database." >
		<cfargument name="file" type="string" required="yes" hint="The file location to retreive the XML from. " />

		<cfset var tables = "" />
		<cfset var columnStruct = StructNew() />
		<cfset var columnsPLURALStruct = StructNew() />
		<cfset var tableStruct = StructNew() />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var k = 0 />
		<cfset var l = 0 />
		<cfset var tableAttrbArray = ArrayNew(1) />
		<cfset var columnAttrArray = ArrayNew(1) />
		<cfset var results = structNew() />
		<cfset var columnXML = structNew() />
		<cfset var tableXML = structNew() />


		<cffile action="read" file="#arguments.file#" variable="tables" />
		<cfset tables = XMLParse(tables) />

		<cfloop index="i" from="1" to="#ArrayLen(tables.tables.table)#">
			<cfset tableStruct= structNew() />
			<cfset tableXML = tables.tables.table[i] />
			<cfset tableAttrbArray = StructKeyArray(tableXML)>

				<cfloop index="j" from="1" to="#Arraylen(tableAttrbArray)#">
					<cfif CompareNoCase(tableAttrbArray[j], "columns") eq 0>
						<cfset columnsPLURALStruct = StructNew() />

						<cfloop index="k" from="1" to="#ArrayLen(tableXML['columns']['column'])#">
							<cfset columnXML = tableXML['columns']['column'][k] />
							<cfset columnAttrArray = StructKeyArray(columnXML)>
							<cfset columnStruct = StructNew() />

							<cfloop index="l" from="1" to="#arrayLen(columnAttrArray)#">
								<cfset columnStruct[columnAttrArray[l]] = columnXML[columnAttrArray[l]]['XMLText'] />
							</cfloop>
							<cfset columnsPLURALStruct[columnXML['name']['XMLText']] = columnStruct />
						</cfloop>

						<cfset tableStruct['columnlist'] = columnsPLURALStruct />
					<cfelse>
						<cfset tableStruct[tableAttrbArray[j]]= tableXML[tableAttrbArray[j]]['xmltext']/>
					</cfif>
				</cfloop>

			<cfset results[tableXML['name']['XMLText']]= tableStruct />
		</cfloop>

		<cfset variables.databaseStructXML = results />
		<cfset variables.tableArrayXML = StructKeyArray(results) />


	</cffunction>

	<!---***********************************************************--->
	<!---inspectProceduresFromDB                       --->
	<!---Organizes all of the sp_help output for procedures          --->
	<!--- into a usable form.                                         --->
	<!---***********************************************************--->
	<cffunction access="public" name="inspectProceduresFromDB" output="FALSE" returntype="void" description="Organizes all of the sp_help output for procedures into a usable form." >

		<cfset var dbprocedures = "" />
		<cfset var procedure = QueryNew('') />
		<cfset var parameters = QueryNew('') />
		<cfset var procedureContent = QueryNew('') />
		<cfset var IdentityDiscovered = FALSE />
		<cfset var columnData = "" />
		<cfset var i = 0 />
		<cfset var tempTableArray= ArrayNew(1) />
		<cfset var tempTableName= "" />
		<cfset var spTextStruct = StructNew() />
		<cfset var spContents = "" />
		<cfset var cfstoredProc =  StructNew() />
		<cfset var tempProcStruct = StructNew() />
		<cfset var sphelpresults = StructNew() />

		<cfset variables.proceduresStruct = StructNew() />
		<cfset variables.proceduresArray = ArrayNew(1) />

		<cfset dbprocedures =  helpObj.getProcs() />

		<cfset variables.proceduresArray = ListToArray(ValueList(dbprocedures.name))/>

		<cfloop query="dbprocedures">

			<cfset tempProcStruct = StructNew() />

			<cfset tempProcStruct['name'] =name />

			<cfset tempTableArray= ArrayNew(1) />

			<!--- Added to allow for tables with underscores --->
			<cfset tempProcStruct['table'] = "" />
			<cfloop index="i" from="1" to="#ArrayLen(variables.tableArray)#">
				<cfif FindNoCase("usp_#variables.tableArray[i]#_", name)>
					<!--- TPRYAN 2/26/2007 Fixing an issue where if a table name with underscores
						contained the name of another table stuff was being screwed up.  --->
					<cfset ArrayAppend(tempTableArray, variables.tableArray[i]) />

				</cfif>
			</cfloop>


			<cfif CompareNoCase(variables.configObj.get('db','type'), "oracle") eq 0>
				<cfset tempProcStruct['table'] = Left(GetToken(name, 1, "."), len(GetToken(name, 1, ".")) - 3) />


			<cfelse>
				<cfif ArrayLen(tempTableArray) gt 1>
					<cfset tempTableName = "" />
					<!--- TPRYAN 2/26/2007 The idea here is that the longest tablename is the table
						that this stored proc refers to --->
					<cfloop index="i" from="1" to="#ArrayLen(tempTableArray)#" >
						<cfif len(tempTableArray[i]) gt len(tempTableName)>
							<cfset tempTableName = tempTableArray[i] />
						</cfif>
					</cfloop>

					<cfset tempProcStruct['table'] = tempTableName />
				<!--- TPRYAN 3/21/2007 changed else to an else if because sometimes array can be empty.  --->
				<cfelseif ArrayLen(tempTableArray) eq 1>
					<cfset tempProcStruct['table'] = tempTableArray[1] />
				</cfif>

				<!--- TPRYAN 6/21/2007 Get rid of the tempTable --->
				<cfset tempTableArray= ArrayNew(1) />

				<cfif len(tempProcStruct['table']) lt 1>
					<cfset tempProcStruct['table'] = GetToken(name, 2, "_") />
				</cfif>
			</cfif>



			<cfset IdentityDiscovered = FALSE />

			<cfset procedure = QueryNew('') />
			<cfset parameters = QueryNew('') />
			<cfset spContents = QueryNew('') />

			<!--- 9/22/2007 tpryan replaced all sp help with function calls to make this more extenisible --->
			<!--- Get from the database details of the storedProc --->
			<cfset sphelpresults =  helpObj.getProc(name) />
			<cfset procedure = sphelpresults['procedure'] />
			<cfset parameters = sphelpresults['parameters'] />

			<!--- 3/26/2007 tpryan Update to retrieve and handle sp text to do deep analysis of stored proc's  --->
			<cfset spContents = helpObj.getProcText(name) />


			<!--- 3/26/2007 tpryan Update to retrieve and handle sp text to do deep analysis of stored proc's  --->
			<cfset spTextStruct = StructNew() />
			<cfset spTextStruct = analyzeProcText(spContents) />

			<cfset tempProcStruct['queryCount'] = countOutputQueries(spTextStruct.body)>
			
			
			
			<cfset tempProcStruct['outputVariableCount'] = countOutputVariables(spTextStruct) />


			<cfif parameters.recordCount gt 0>
				<cfset tempProcStruct['parameterArray'] =ListToArray(ValueList(parameters.parameter_name)) />

				<cfloop query="parameters">
					<cfset tempProcStruct['parameterList'][parameter_name]['name'] = parameter_name />
					<cfset tempProcStruct['parameterList'][parameter_name]['type'] = type />

					<!--- 4/4/2007 tpryan Fixes an issue where nvarchars and nchars are reported as double their length, because on disk they really are.  --->
					<cfif not CompareNoCase(type, "nchar") or not CompareNoCase(type, "nvarchar")>
						<cfset tempProcStruct['parameterList'][parameter_name]['length'] = length / 2 />
					<cfelse>
						<cfset tempProcStruct['parameterList'][parameter_name]['length'] = length />
					</cfif>

					<cfset tempProcStruct['parameterList'][parameter_name]['prec'] = prec />
					<cfset tempProcStruct['parameterList'][parameter_name]['scale'] = scale />
					<cfset tempProcStruct['parameterList'][parameter_name]['isIdentity'] = FALSE />
					<cfset tempProcStruct['parameterList'][parameter_name]['default'] = spTextStruct['params'][parameters.currentRow]['default'] />
					<cfset tempProcStruct['parameterList'][parameter_name]['inout'] = spTextStruct['params'][parameters.currentRow]['inout'] />


					<cfset columnData = getColumn(tempProcStruct['table'], ReplaceNoCase(parameter_name, "@", "", "ALL")) />
					<!--- Performance Enhancement. Hopefully it works. --->
					<cfif structKeyExists(columnData, "nullable")>
						<cfset tempProcStruct['parameterList'][parameter_name]['nullable'] = columnData.nullable />
					<cfelse>
						<cfset tempProcStruct['parameterList'][parameter_name]['nullable'] = "NO" />
					</cfif>


					<!--- Determine if parameter correponds to the identity of the the table that this sp interacts with.  --->
					<cfif not IdentityDiscovered and structKeyExists(columnData, "isIdentity")>
						<cfif columnData.isIdentity>
							<cfset tempProcStruct['parameterList'][parameter_name]['isIdentity'] = TRUE />
							<cfset IdentityDiscovered = TRUE />
						</cfif>
					</cfif>

					<!--- tpryan 2007-10-07 Added to help mysql get image CRUD --->
					<cfif structKeyExists(columnData, "isImage") and columnData.IsImage>
						<cfset tempProcStruct['parameterList'][parameter_name]['isImage'] = TRUE />
					</cfif>
					<!--- tpryan 2007-10-07 Added to help mysql get image CRUD --->


				</cfloop>


			<cfelse>
				<cfset tempProcStruct['parameterArray'] = ArrayNew(1) />
				<cfset tempProcStruct['parameterList'] =StructNew() />
			</cfif>



			<cfset variables.proceduresStruct[name] = tempProcStruct />

		</cfloop>



	</cffunction>

	<!---***********************************************************--->
	<!---inspectProceduresFromXML                           --->
	<!---Grabs the same data as InspectTables, but does so through   --->
	<!--- an XML file cache                                           --->
	<!---***********************************************************--->
	<cffunction access="public" name="InspectProceduresFromXML" output="false" returntype="void" hint="Grabs the same data as Inspectprocedures, but does so through an XML file." >
		<cfargument name="file" type="string" required="yes" default="" hint="The xml file to parse." />

		<cfset var tables = "" />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var k = 0 />
		<cfset var l = 0 />
		<cfset var procedureAttrbArray = ArrayNew(1) />
		<cfset var paramAttrArray = ArrayNew(1) />
		<cfset var results = structNew() />
		<cfset variables.proceduresStruct = StructNew() />
		<cfset variables.proceduresArray = ArrayNew(1) />

		<cffile action="read" file="#arguments.file#" variable="procedures" />
		<cfset procedures = XMLParse(procedures) />

		<cfloop index="i" from="1" to="#ArrayLen(procedures.procedures.procedure)#">
			<cfset results[procedures.procedures.procedure[i]['name']['XMLText']]= structNew() />
			<cfset procedureAttrbArray = StructKeyArray(procedures.procedures.procedure[i])>

			<cfloop index="j" from="1" to="#Arraylen(procedureAttrbArray)#">
				<cfif procedureAttrbArray[j] eq "parameters">
					<cfset results[procedures.procedures.procedure[i]['name']['XMLText']]['parameterArray'] = ArrayNew(1) />



					<cfif StructKeyExists(procedures.procedures.procedure[i]['parameters'], "parameter")>

						<cfloop index="k" from="1" to="#ArrayLen(procedures.procedures.procedure[i]['parameters']['parameter'])#">

							<cfset results[procedures.procedures.procedure[i]['name']['XMLText']]['parameterList'][procedures.procedures.procedure[i]['parameters']['parameter'][k]['name']['XMLText']] = StructNew() />
							<cfset paramAttrArray = StructKeyArray(procedures.procedures.procedure[i]['parameters']['parameter'][k])>



							<cfloop index="l" from="1" to="#arrayLen(paramAttrArray)#">
								<cfset results[procedures.procedures.procedure[i]['name']['XMLText']]['parameterList'][procedures.procedures.procedure[i]['parameters']['parameter'][k]['name']['XMLText']][paramAttrArray[l]] = procedures.procedures.procedure[i]['parameters']['parameter'][k][paramAttrArray[l]]['xmlText'] />
							</cfloop>

							<cfset ArrayAppend(results[procedures.procedures.procedure[i]['name']['XMLText']]['parameterArray'], procedures.procedures.procedure[i]['parameters']['parameter'][k]['name']['XMLText'] ) />

						</cfloop>


					</cfif>
				<cfelse>
					<cfset results[procedures.procedures.procedure[i]['name']['XMLText']][procedureAttrbArray[j]]= procedures.procedures.procedure[i][procedureAttrbArray[j]]['xmltext']/>
				</cfif>
			</cfloop>

		</cfloop>

		<cfset variables.proceduresStructXML = duplicate(results) />
		<cfset variables.proceduresArrayXML = StructKeyArray(results) />

	</cffunction>


	<!---***********************************************************--->
	<!---getTableArray                           --->
	<!---Returns the table array for easier looping.                 --->
	<!---***********************************************************--->
	<cffunction access="public" name="getTableArray" output="false" returntype="array" description="Returns the table array for easier looping." >
		<cfreturn variables.tableArray />
	</cffunction>

	<!---***********************************************************--->
	<!---getTableInfo                            --->
	<!--- Returns all table information.                              --->
	<!---***********************************************************--->
	<cffunction access="public" name="getTableInfo" output="false" returntype="struct" description="Returns all table information." >
		<cfreturn variables.databaseStruct />
	</cffunction>

	<!---***********************************************************--->
	<!---getTableInfoXML                            --->
	<!--- Returns all table information.                              --->
	<!---***********************************************************--->
	<cffunction access="public" name="getTableInfoXML" output="false" returntype="struct" description="Returns all table information." >
		<cfreturn variables.databaseStructXML />
	</cffunction>

	<!---***********************************************************--->
	<!---getProcedureInfoXML                          --->
	<!---Returns all procedures information.                         --->
	<!---***********************************************************--->
	<cffunction access="public" name="getProcedureInfoXML" output="false" returntype="struct" description="Returns all procedures information." >
		<cfreturn variables.proceduresStructXML />
	</cffunction>

	<!---***********************************************************--->
	<!---getTableInfoAsXML                       --->
	<!---Creates XML representation of database tables.      --->
	<!---***********************************************************--->
	<cffunction access="public" name="getTableInfoAsXML" output="false" returntype="string" description="Creates XML representation of database tables." >

		<cfset var xmloutput ="" />
		<cfset var column ="" />
		<cfset var table ="" />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var k = 0 />
		<cfset var columnArray = ArrayNew(1) />
		<cfset var attributeArray = ArrayNew(1) />

		<cfset xmloutput = '<?xml version="1.0" encoding="iso-8859-1"?>' & chr(13) />
		<cfset xmloutput = xmloutput.concat('<tables>' & chr(13)) />
			<cfloop index="i" from="1" to="#arrayLen(variables.tableArray)#">
				<cfset columnArray = variables.databaseStruct[variables.tableArray[i]]['columnArray'] />
				<cfset table = '	<table>' & chr(13) />
					<cfset table = table.concat('		<name>#variables.tableArray[i]#</name>' & chr(13)) />
					<cfset table = table.concat('		<label>#variables.databaseStruct[variables.tableArray[i]]['label']#</label>' & chr(13)) />
					<cfset table = table.concat('		<identity>#variables.databaseStruct[variables.tableArray[i]]['identity']#</identity>' & chr(13)) />
					<cfset table = table.concat('		<type>#variables.databaseStruct[variables.tableArray[i]]['type']#</type>' & chr(13)) />
					<cfset table = table.concat('		<orderBy>#variables.databaseStruct[variables.tableArray[i]]['orderBy']#</orderBy>' & chr(13)) />
					<cfset table = table.concat('		<foreignKeyLabel>#variables.databaseStruct[variables.tableArray[i]]['foreignKeyLabel']#</foreignKeyLabel>' & chr(13)) />
					<cfset table = table.concat('		<hasForeignKeys>#variables.databaseStruct[variables.tableArray[i]]['hasForeignKeys']#</hasForeignKeys>' & chr(13)) />
					<cfset table = table.concat('		<isReferencedAsFK>#variables.databaseStruct[variables.tableArray[i]]['isReferencedAsFK']#</isReferencedAsFK>' & chr(13)) />
					<cfset table = table.concat('		<hasJoinTable>#variables.databaseStruct[variables.tableArray[i]]['hasJoinTable']#</hasJoinTable>' & chr(13)) />
					<cfset table = table.concat('		<uniqueList>#variables.databaseStruct[variables.tableArray[i]]['uniqueList']#</uniqueList>' & chr(13)) />
					<cfset table = table.concat('		<checksum>#variables.databaseStruct[variables.tableArray[i]]['checksum']#</checksum>' & chr(13)) />

					<cfif structKeyExists(variables.databaseStruct[variables.tableArray[i]], "isJoinTable")>
						<cfset table = table.concat('		<isJoinTable>#variables.databaseStruct[variables.tableArray[i]]['isJoinTable']#</isJoinTable>' & chr(13)) />
					<cfelse>
						<cfset table = table.concat('		<isJoinTable>FALSE</isJoinTable>' & chr(13)) />
					</cfif>

					<cfset table = table.concat('		<JoinTableList>#variables.databaseStruct[variables.tableArray[i]]['JoinTableList']#</JoinTableList>' & chr(13)) />
					<cfset table = table.concat('		<PassThroughTableList>#variables.databaseStruct[variables.tableArray[i]]['PassThroughTableList']#</PassThroughTableList>' & chr(13)) />

					<cfset table = table.concat('		<columns>' & chr(13)) />

					<cfloop index="j" from="1" to="#arrayLen(columnArray)#">
						<cfset attributeArray = StructKeyArray(variables.databaseStruct[variables.tableArray[i]]['columnlist'][columnArray[j]]) />
						<cfset column = '			<column>' & chr(13) />
							<!--- Loop trhough and reveal the columnlist attributes --->
							<cfloop index="k" from="1" to="#ArrayLen(attributeArray)#">
								<cfset column = column.concat('				<' & attributeArray[k] &'>') />
								<cfset column = column & variables.databaseStruct[variables.tableArray[i]]['columnlist'][columnArray[j]][attributeArray[k]] />
								<cfset column = column.concat('</' & attributeArray[k] &'>' & chr(13)) />
							</cfloop>

						<cfset column = column.concat('			</column>' & chr(13)) />
						<cfset table = table.concat(column) />
					</cfloop>

					<cfset table = table.concat('		</columns>' & chr(13)) />
			<cfset table = table.concat('	</table>' & chr(13)) />
			<cfset xmloutput = xmloutput.concat(table) />
			</cfloop>
		<cfset xmloutput = xmloutput.concat('</tables>' & chr(13)) />

		<cfreturn xmloutput />
	</cffunction>

	<!---***********************************************************--->
	<!---getProcedureInfoAsXML                       --->
	<!---Creates XML representation of database procedures.      --->
	<!---***********************************************************--->
	<cffunction access="public" name="getProcedureInfoAsXML" output="false" returntype="string" description="Creates XML representation of database procedures." >

		<cfset var xmloutput ="" />
		<cfset var parameters ="" />
		<cfset var procedure ="" />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var k = 0 />
		<cfset var l = 0 />
		<cfset var columnArray = ArrayNew(1) />
		<cfset var attributeArray = ArrayNew(1) />
		<cfset var parameterArray = ArrayNew(1) />
		<cfset var parameterAttrArray = ArrayNew(1) />


		<cfset xmloutput = '<?xml version="1.0" encoding="iso-8859-1"?>' & chr(13) />
		<cfset xmloutput = xmloutput.concat('<procedures>' & chr(13)) />
			<cfloop index="i" from="1" to="#arrayLen(variables.proceduresArray)#">
				<cfset attributeArray = StructKeyArray(variables.proceduresStruct[variables.proceduresArray[i]] ) />

				<cfset procedure = '	<procedure>' & chr(13) />
					<cfloop index="j" from="1" to="#Arraylen(attributeArray)#">
						<cfif IsSimpleValue(variables.proceduresStruct[variables.proceduresArray[i]][attributeArray[j]])>
							<cfset procedure = procedure.concat('		<' & attributeArray[j] & '>') />
							<cfset procedure = procedure & variables.proceduresStruct[variables.proceduresArray[i]][attributeArray[j]] />
							<cfset procedure = procedure.concat('</' & attributeArray[j] & '>' & chr(13)) />
						</cfif>

					</cfloop>


					<cfloop index="j" from="1" to="#Arraylen(attributeArray)#">
						<cfif attributeArray[j] eq "parameterList">
							<cfset parameters = '		<parameters>' & chr(13) />


									<cfset parameterArray = StructKeyArray(variables.proceduresStruct[variables.proceduresArray[i]][attributeArray[j]] ) />

									<cfloop index="k" from="1" to="#Arraylen(parameterArray)#">
										<cfset parameterAttrArray = StructKeyArray(variables.proceduresStruct[variables.proceduresArray[i]][attributeArray[j]][parameterArray[k]] ) />

										<cfset parameters = parameters.concat('			<parameter>' & chr(13)) />
											<cfloop index="l" from="1" to="#Arraylen(parameterAttrArray)#">
												<cfset parameters = parameters.concat('				<' & parameterAttrArray[l] & '>') />
												<cfset parameters = parameters.concat(Javacast("string",variables.proceduresStruct[variables.proceduresArray[i]][attributeArray[j]][parameterArray[k]][parameterAttrArray[l]])) />
												<cfset parameters = parameters.concat('</' & parameterAttrArray[l] & '>' & chr(13)) />
											</cfloop>

										<cfset parameters = parameters.concat('			</parameter>' & chr(13)) />
									</cfloop>

									<cfset parameters = parameters.concat('		</parameters>' & chr(13)) />

							<cfif ArrayLen(parameterArray) gt 0>
								<cfset procedure = procedure.concat(parameters) />
							</cfif>


						</cfif>

					</cfloop>




				<cfset procedure = procedure.concat('	</procedure>' & chr(13)) />
				<cfset xmloutput = xmloutput.concat(procedure) />
			</cfloop>
		<cfset xmloutput = xmloutput.concat('</procedures>' & chr(13)) />

		<cfreturn xmloutput />
	</cffunction>

	<!---***********************************************************--->
	<!---getParamterArray                        --->
	<!---Returns the parameter array for easier looping.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getParamterArray" output="false" returntype="array" description="Returns the column array for easier looping." >
		<cfargument name="procedureName" type="string" required="yes" hint="The name of the procedure for which to return data." />

		<cfreturn variables.proceduresStruct[arguments.procedureName]['parameterArray'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getProcedure                            --->
	<!---Returns the information about 1 procedure.                  --->
	<!---***********************************************************--->
	<cffunction access="public" name="getProcedure" output="false" returntype="struct" description="Returns the information about 1 table." >
		<cfargument name="procedureName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfreturn variables.proceduresStruct[arguments.procedureName] />
	</cffunction>

	<!---***********************************************************--->
	<!---getParameter                            --->
	<!---Returns the information about 1 paramter in 1 procedure.    --->
	<!---***********************************************************--->
	<cffunction access="public" name="getParameter" output="false" returntype="struct" description="Returns the information about 1 paramter in 1 procedure." >
		<cfargument name="procedureName" type="string" required="yes" hint="The name of the procedure for which to return data." />
		<cfargument name="parameterName" type="string" required="yes" hint="The name of the parameter for which to return data." />

		<cfreturn variables.proceduresStruct[arguments.procedureName]['paramterlist'][arguments.parameterName] />
	</cffunction>

	<!---***********************************************************--->
	<!---getProcedureArray                       --->
	<!---Returns the procedure array for easier looping.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getProcedureArray" output="false" returntype="array" description="Returns the procedure array for easier looping." >
		<cfreturn variables.proceduresArray />
	</cffunction>

	<!--- TABLE FUNCTIONS --->

	<!---***********************************************************--->
	<!---getCFversionofTableName                       --->
	<!---Returns the getCFversionofTableName field of the table.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getCFversionofTableName" output="false" returntype="string" description="Returns the getCFversionofTableName field of the table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		
		<cfif StructKeyExists(variables.databaseStruct, arguments.tableName) AND
				StructKeyExists(variables.databaseStruct[arguments.tableName], "label") AND
					compareNoCase(arguments.tableName, variables.databaseStruct[arguments.tableName]['label']) neq 0>
			<cfreturn variables.databaseStruct[arguments.tableName]['label'] />
		<cfelse>
			<cfreturn Replace(arguments.tableName, " ", "", "ALL") />
		</cfif>
		
		
	</cffunction>

	<!---***********************************************************--->
	<!---getColumn                               --->
	<!---Returns the information about 1 column in 1 table.          --->
	<!---***********************************************************--->
	<cffunction access="public" name="getColumn" output="false" returntype="struct" description="Returns the information about 1 column in 1 table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfargument name="columnName" type="string" required="yes" hint="The name of the column for which to return data." />

		<cfif StructKeyExists(variables.databaseStruct, arguments.tableName) AND
				StructKeyExists(variables.databaseStruct[arguments.tableName], "columnlist") AND
					StructKeyExists(variables.databaseStruct[arguments.tableName]['columnlist'], arguments.columnName)>
			<cfreturn variables.databaseStruct[arguments.tableName]['columnlist'][arguments.columnName] />
		<cfelse>
			<cfreturn structNew() />
		</cfif>
	</cffunction>

	<!---***********************************************************--->
	<!---getColumnArray                          --->
	<!---Returns the column array for easier looping.                --->
	<!---***********************************************************--->
	<cffunction access="public" name="getColumnArray" output="false" returntype="array" description="Returns the column array for easier looping." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfreturn variables.databaseStruct[arguments.tableName]['columnArray'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getColumnType                               --->
	<!---Returns the type of 1 column in 1 table.          --->
	<!---***********************************************************--->
	<cffunction access="public" name="getColumnType" output="false" returntype="string" description="Returns the type of 1 column in 1 table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfargument name="columnName" type="string" required="yes" hint="The name of the column for which to return data." />

		<cfreturn variables.databaseStruct[arguments.tableName]['columnlist'][arguments.columnName]['type'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getColumnTypeAndLen                               --->
	<!---Returns the type and len of 1 column in 1 table.          --->
	<!---***********************************************************--->
	<cffunction access="public" name="getColumnTypeAndLen" output="false" returntype="string" description="Returns the type and len of 1 column in 1 table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfargument name="columnName" type="string" required="yes" hint="The name of the column for which to return data." />

		<cfif FindNoCase("char", variables.databaseStruct[arguments.tableName]['columnlist'][arguments.columnName]['type'])>
			<cfreturn "#variables.databaseStruct[arguments.tableName]['columnlist'][arguments.columnName]['type']#(#variables.databaseStruct[arguments.tableName]['columnlist'][arguments.columnName]['length']#)" />
		<cfelse>
			<cfreturn variables.databaseStruct[arguments.tableName]['columnlist'][arguments.columnName]['type'] />
		</cfif>
	</cffunction>

	<!---***********************************************************--->
	<!---getEditElligibleColumnList                       --->
	<!---Returns the Edit Elligible ColumnList of the table.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getEditElligibleColumnList" output="false" returntype="string" description="Returns the Edit Elligible ColumnList of the table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfset var DAOSamplecolumnList = ArrayToList(getColumnArray(arguments.tableName)) />
		<cfset var EditElligibleDAOSamplecolumnList = REReplaceNoCase(DAOSamplecolumnList, "\b#variables.configObj.get('reservedwords','createdOn')#\b", "", "ALL") />
		<cfset EditElligibleDAOSamplecolumnList = REReplaceNoCase(EditElligibleDAOSamplecolumnList, "\b#variables.configObj.get('reservedwords','updatedOn')#\b", "", "ALL") />
		<!--- 3/29/2007 tpryan updated to allow for active inactive delete instead of actual deleting of records. --->
		<cfset EditElligibleDAOSamplecolumnList = REReplaceNoCase(EditElligibleDAOSamplecolumnList, "\b#variables.configObj.get('reservedwords','active')#\b", "", "ALL") />

		<cfreturn EditElligibleDAOSamplecolumnList />
	</cffunction>

	<!---***********************************************************--->
	<!---getForeignKeyReferences                 --->
	<!---Gets information about all of the times where input         --->
	<!--- table is referenced as a foreignKey.                        --->
	<!---***********************************************************--->
	<cffunction access="public" name="getForeignKeyReferences" output="false" returntype="any" hint="Gets information about all of the times where input table is referenced as a foreignKey. " >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfset var result = ArrayNew(1) />
		<cfset var tempStruct = StructNew() />
		<cfset var referencesArray = StructFindValue(variables.databaseStruct, arguments.tableName, "ALL") />
		<cfset var i = 0 />

		<cfloop index ="i" from="1" to="#arrayLen(referencesArray)#">
			<cfif compareNoCase(referencesArray[i]['key'],"linkedTable") eq 0>
				<cfset tempStruct = StructNew() />
				<cfset tempStruct['table'] = getToken(referencesArray[i]['path'], 1, ".") />
				<cfset tempStruct['field'] = referencesArray[i]['owner']['name'] />
				<cfset arrayAppend(result,tempStruct)>
			</cfif>

		</cfloop>



		<cfreturn result>
	</cffunction>

	<!---***********************************************************--->
	<!---getIdentity                                --->
	<!---Determines if the table has a proper identity.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="getIdentity" output="false" returntype="string" description="Determines if the table has a proper identity." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfreturn variables.databaseStruct[arguments.tableName]['identity'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getJoinTableList                       --->
	<!---Returns the Read Elligible ColumnList of the table.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getJoinTableList" output="false" returntype="string" description="Returns the Join Table List." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfreturn variables.databaseStruct[arguments.tableName]['JoinTableList'] />
	</cffunction>


	<!---***********************************************************--->
	<!---getPassThroughTableLinkedFields                       --->
	<!---Returns the Read Elligible ColumnList of the table.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getPassThroughTableLinkedFields" output="false" returntype="string" description="Returns the Join Table List." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfset var results = ArrayNew(1) />
		<cfset var columnArray = getColumnArray(arguments.tableName) />
		<cfset var i = 0 />

		<cfif structKeyExists(variables.databaseStruct[arguments.tableName], 'isJoinTable') and
				variables.databaseStruct[arguments.tableName]['isJoinTable']>
			<cfloop index="i" from="1" to="#arrayLen(columnArray)#">
				<cfif len(variables.databaseStruct[arguments.tableName]['columnlist'][columnArray[i]]['linkedField']) gt 0 AND
						compareNoCase(variables.databaseStruct[arguments.tableName]['columnlist'][columnArray[i]]['linkedField'],
						variables.databaseStruct[arguments.tableName]['columnlist'][columnArray[i]]['name']) eq 0>
					<cfset ArrayAppend(results, variables.databaseStruct[arguments.tableName]['columnlist'][columnArray[i]]['name']) />
				</cfif>
				<!--- Prevents other foreign keys from coming in here, and improves performance, since it stops looking after two.  --->
				<cfif ArrayLen(results) gte 2>
					<cfbreak />
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn ArrayToList(results) />
	</cffunction>

	<!---***********************************************************--->
	<!---getPassThroughTableList                       --->
	<!---Returns the Read Elligible ColumnList of the table.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getPassThroughTableList" output="false" returntype="string" description="Returns the Join Table List." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfreturn variables.databaseStruct[arguments.tableName]['PassThroughTableList'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getReadElligibleColumnList                       --->
	<!---Returns the Read Elligible ColumnList of the table.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getReadElligibleColumnList" output="false" returntype="string" description="Returns the Read Elligible ColumnList of the table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfset var DAOSamplecolumnList = ArrayToList(getColumnArray(arguments.tableName)) />
		<cfreturn REReplaceNoCase(DAOSamplecolumnList, "\b#variables.configObj.get('reservedwords','active')#\b", "", "ALL") />
	</cffunction>

	<!---***********************************************************--->
	<!---getTable                                --->
	<!---Returns the information about 1 table.                      --->
	<!---***********************************************************--->
	<cffunction access="public" name="getTable" output="false" returntype="struct" description="Returns the information about 1 table." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfreturn variables.databaseStruct[arguments.tableName] />
	</cffunction>


	<!---***********************************************************--->
	<!---getTableForeignKeyLabel                       --->
	<!---Returns the ForeignKeyLabel for table.                      --->
	<!---***********************************************************--->
	<cffunction access="public" name="getTableForeignKeyLabel" output="false" returntype="string" description="Returns the ForeignKeyLabel for table. " >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfreturn variables.databaseStruct[arguments.tableName]['foreignKeyLabel'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getType                       --->
	<!---Returns the type of table: table or view                    --->
	<!---***********************************************************--->
	<cffunction access="public" name="getType" output="false" returntype="string" description="Whether or not the table uses the active/deactive model." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfreturn variables.databaseStruct[arguments.tableName]['type'] />
	</cffunction>

	<!---***********************************************************--->
	<!---getUniqueList                                --->
	<!---Determines if the table has a proper identity.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="getUniqueList" output="false" returntype="string" description="Determines if the table has a proper identity." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfreturn variables.databaseStruct[arguments.tableName]['UniqueList'] />
	</cffunction>

	<!---***********************************************************--->
	<!---hasChanged                                --->
	<!---Determines if the table has has changed.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="hasChanged" output="false" returntype="boolean" description="Determines if the table has has changed.   " >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfif StructKeyExists(variables.databaseStruct,arguments.tableName) and StructKeyExists(variables.databaseStruct[arguments.tableName], "hasChanged")>
			<cfreturn variables.databaseStruct[arguments.tableName]['hasChanged'] />
		<cfelse>
			<cfreturn TRUE />
		</cfif>
	</cffunction>

	<!---***********************************************************--->
	<!---hasForeignKeys                                --->
	<!---Determines if the table has any foriegn keys.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="hasForeignKeys" output="false" returntype="boolean" description="Determines if the table has any foriegn keys." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfif StructKeyExists(variables.databaseStruct,arguments.tableName)>
			<cfreturn variables.databaseStruct[arguments.tableName]['hasForeignKeys'] />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
	</cffunction>


	<!---***********************************************************--->
	<!---hasJoinTable                                --->
	<!---Determines if the table has any join tables.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="hasJoinTable" output="false" returntype="boolean" description="Determines if the table has any join tables." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfif not StructKeyExists(variables.databaseStruct[arguments.tableName], 'hasJoinTable')>
			<cfset variables.databaseStruct[arguments.tableName]['hasJoinTable'] = FALSE />
		</cfif>

		<cfreturn variables.databaseStruct[arguments.tableName]['hasJoinTable'] />
	</cffunction>

	<!---***********************************************************--->
	<!---isActive                       --->
	<!---Returns the ForeignKeyLabel for table.                      --->
	<!---***********************************************************--->
	<cffunction access="public" name="isActive" output="false" returntype="boolean" description="Whether or not the table uses the active/deactive model." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfif structKeyExists(variables.databaseStruct[arguments.tableName]['columnList'], configObj.get('reservedwords','active')) AND
			not CompareNoCase(variables.databaseStruct[arguments.tableName]['columnList'][configObj.get('reservedwords','active')]['type'], "bit")>

			<cfreturn TRUE />
		<cfelse>

			<cfreturn FALSE />
		</cfif>
	</cffunction>

	<!---***********************************************************--->
	<!---isJoinTable                                --->
	<!---Determines if the table has any foriegn keys.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="isJoinTable" output="false" returntype="boolean" description="Determines if the table has any foriegn keys." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />
		<cfif StructKeyExists(variables.databaseStruct,arguments.tableName) and StructKeyExists(variables.databaseStruct[arguments.tableName], "isJoinTable")>
			<cfreturn variables.databaseStruct[arguments.tableName]['isJoinTable'] />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
	</cffunction>



	<!---***********************************************************--->
	<!---isReferencedAsFK                                --->
	<!---Whether or not the table is ever referenced as a foreign key.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="isReferencedAsFK" output="false" returntype="boolean" description="Whether or not the table is ever referenced as a foreign key." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfif not StructKeyExists(variables.databaseStruct[arguments.tableName], 'isReferencedAsFK')>
			<cfset variables.databaseStruct[arguments.tableName]['isReferencedAsFK'] = FALSE />
		</cfif>

		<cfreturn variables.databaseStruct[arguments.tableName]['isReferencedAsFK'] />
	</cffunction>

	<!---***********************************************************--->
	<!---isProperTable                                --->
	<!---Determines if the table has a proper identity.               --->
	<!---***********************************************************--->
	<cffunction access="public" name="isProperTable" output="false" returntype="boolean" description="Determines if the table has a proper identity." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfif not StructKeyExists(variables.databaseStruct[arguments.tableName], 'isProperTable')>
			<cfset variables.databaseStruct[arguments.tableName]['isProperTable'] = FALSE />
		</cfif>

		<cfreturn variables.databaseStruct[arguments.tableName]['isProperTable'] />
	</cffunction>

	<!---***********************************************************--->
	<!---tableExists                                --->
	<!---Determines if the table exists               --->
	<!---***********************************************************--->
	<cffunction access="public" name="tableExists" output="false" returntype="boolean" description="Determines if the table exists" >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<!--- Changed tpryan 2007-10-10, altered to make tables search work, even during inspectTables --->
		<cfif listFindNoCase(arrayToList(tableArray), Trim(arguments.tableName)) gt 0>
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>

	</cffunction>

	<!---***********************************************************--->
	<!---computeCheckSum                               --->
	<!---Computes the checksum for a given table in the database.    --->
	<!---***********************************************************--->
	<cffunction access="public" name="computeCheckSum" output="false" returntype="string" hint="Computes the checksum for a given table in the database." >
		<cfargument name="tableName" type="string" required="yes" hint="The name of the table for which to return data." />

		<cfset var table=duplicate(getTable(arguments.tableName)) />
		<cfset var tableWDDX = "" />
		<cfset structDelete(table, "hasChanged") />
		<cfset structDelete(table, "checksum") />

		<cfwddx action="cfml2wddx" input="#table#" output="tableWDDX"/>


		<cfreturn hash(tableWDDX) />
	</cffunction>




	<!--- PRIVATE METHODS --->
	<!---***********************************************************--->
	<!---analyzeProcText                       --->
	<!---Analyzes the text of a storeProc in order to determine things about it.       --->
	<!---***********************************************************--->
	<cffunction access="public" name="analyzeProcText" output="false" returntype="struct" description="Analyzes the text of a storeProc in order to determine things about it. " >
		<cfargument name="procQuery" type="query" required="yes" default="" hint="The query of code that declares a proc. " />

		<cfset var spContentsText = valueList(arguments.procQuery.text, chr(13)) />
		<cfset var spStruct = structNew() />
		<cfset var stringStruct = structNew() />
		<cfset var i = 0 />

		<!--- Remove comments as sometimes crap in their can screw stuff up.  --->
		<cfset spContentsText = REReplaceNoCase(spContentsText, "/\*.*\*/", "", "ALL") />


		<cfset stringStruct['as']['start']= ReFindNoCase("[[:space:]]AS[[:space:]]", spContentsText) />
		<cfset stringStruct['firstVariable']['start']= ReFindNoCase("[[:space:]]@", spContentsText) >


		<cfif stringStruct['firstVariable']['start'] lt stringStruct['as']['start'] AND stringStruct['firstVariable']['start'] gt 0>
			<cfset spStruct['params'] = Mid(spContentsText, stringStruct['firstVariable']['start'], stringStruct['as']['start'] - stringStruct['firstVariable']['start'])>
		<cfelse>
			<cfset spStruct['params'] = "" />
		</cfif>

		<cfset spStruct['params'] = ListToArray(spStruct['params'], ",") />


		<cfloop index="i" from="1" to="#arrayLen(spStruct['params'])#">
			<cfset spStruct['params'][i] = analyzeProcParam(spStruct['params'][i]) />
		</cfloop>

		<cfset spStruct['body'] = Trim(Right(spContentsText, Len(spContentsText) - stringStruct['as']['start'] -2 )) />



		<cfreturn spStruct/>
	</cffunction>

	<!---***********************************************************--->
	<!---analyzeProcParam                       --->
	<!---Turns one line of a stored proc declaration into a structure that can be used for meta data.           --->
	<!---***********************************************************--->
	<cffunction access="private" name="analyzeProcParam" output="false" returntype="struct" description="Turns one line of a stored proc declaration into a structure that can be used for meta data. " >
		<cfargument name="paramString" type="string" required="yes" default="" hint="The line of code that declares a param. " />

		<cfset var tempString = arguments.paramString />
		<cfset var results = StructNew() />

		<cfset results['name'] = Trim(GetToken(tempString, 1)) />
		<cfset results['type'] = Trim(GetToken(tempString, 2)) />
		<cfset results['default'] = Replace(Trim(ReplaceNoCase(GetToken(tempString, 2, "="),"output", "" ,"ALL")), "'", "" , "ALL")/>

		<cfif findNocase("(", results['type'])>
			<cfset results['length'] = Trim(ReplaceNoCase(GetToken(results['type'], 2,"("),")", "", "ALL")) />
			<cfset results['type'] = Trim(GetToken(results['type'], 1,"(")) />
		</cfif>

		<!--- TODO: Figure out is there a way to support INOUT? --->
		<cfif findNoCase("output", tempString)>
			<cfset results['inout']="OUT" />
		<cfelse>
			<cfset results['inout']="IN" />
		</cfif>


		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---countOutputQueries                       --->
	<!---Counts the number of queries that will be exposed to a cfprocresult      --->
	<!---***********************************************************--->
	<cffunction access="private" name="countOutputQueries" output="false" returntype="numeric" description="Counts the number of queries that will be exposed to a cfprocresult." >
		<cfargument name="procBody" type="string" required="yes" hint="The code that declares the body of a proc. " />

		<cfset var queryCount = 0 />
		<cfset var selectLocation = 1 />
		<cfset var localprocBody = arguments.procBody>

		<!--- Removes SubSelects from query --->
		<cfset localprocBody = REReplaceNoCase(localprocBody, "\([[:space:]]*select", "invalid", "ALL") />
		<!--- Removes variable assignment from queries --->
		<cfset localprocBody = REReplaceNoCase(localprocBody, "select[[:space:]]*\@", "invalid", "ALL") />

		<!--- Removes variable assignment from procedure names --->
		<cfset localprocBody = REReplaceNoCase(localprocBody, "create.*proc.*select.*as", "invalid", "ALL") />
		<cfset localprocBody = REReplaceNoCase(localprocBody, "grant.*exec.*on.*select", "invalid", "ALL") />

		<!--- Removes variable assignment from comments --->
		<cfset localprocBody = REReplaceNoCase(localprocBody, "--[^#chr(13)##chr(10)#]select", "invalid", "ALL") />
		<cfset localprocBody = REReplaceNoCase(localprocBody, "/\*[.]*select[.]*\*/", "invalid", "ALL") />
		<cfset localprocBody = REReplaceNoCase(localprocBody, "/\*.*select.*\*/", "invalid", "ALL") />
		<cfset localprocBody = REReplaceNoCase(localprocBody, "/\*.*select.*\*/", "invalid", "ALL") />


		<!--- Count the number of selects  --->
		<cfloop condition="selectLocation gt 0">
			<cfset selectLocation =  FindNoCase("select", localprocBody, selectLocation) />

			<cfif selectLocation neq 0>
				<cfset queryCount = queryCount + 1 />
				<cfset selectLocation =  selectLocation +1  />
			</cfif>
		</cfloop>


	



		<cfreturn queryCount />
	</cffunction>

	<!---***********************************************************--->
	<!---replaceTableValuesFromXML               --->
	<!---Converts the output of a structKeyFind operation to the     --->
	<!--- non dot version. --->
	<!---***********************************************************--->
	<cffunction access="private" name="convertStructFindKeyNotation" output="false" returntype="string" hint="Converts the output of a structKeyFind operation to the non dot version." >
		<cfargument name="StructFindKeyResult" type="string" required="yes" default="" hint="The result to convert." />

		<cfset var str = ListQualify(arguments.StructFindKeyResult, "'", ".") />
		<cfset str = "[" & Replace(str, ".", "][", "ALL") & "]" />

		<cfreturn str>
	</cffunction>


	<cffunction access="private" name="countOutputVariables" output="false" returntype="numeric" hint="Counts the number of output variables in a procedure." >
		<cfargument name="spTextStruct" type="struct" required="yes" hint="The spTextStruct" />
		
		<cfreturn ArrayLen(StructFindValue(arguments.spTextStruct,'OUT','ALL')) />
	</cffunction>


</cfcomponent>