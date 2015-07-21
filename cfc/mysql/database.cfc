<cfcomponent extends="GangPlank2.cfc.base.database">

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
			<cfinvokeargument name="database" value="#configObj.get('db', 'database')#" />
			<cfinvokeargument name="configObj" value="#variables.configObj#" />
		</cfinvoke>


		<cfobjectcache action = "clear" />
		<cfset inspectTables() />

		<cfreturn This />
	</cffunction>





	<!---***********************************************************--->
	<!---inspectProceduresFromDB                 --->
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
			<cfset spTextStruct = helpObj.getProcTextStruct(name) />
			<cfset tempProcStruct['queryCount'] = countOutputQueries(spTextStruct.body)>


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



</cfcomponent>