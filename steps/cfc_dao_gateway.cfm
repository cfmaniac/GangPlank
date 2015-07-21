<!---    cfc_dao_gateway.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:40:52 AM
DESCRIPTION			: Builds all of the gateway and DAO cfc's.
---->
<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceCFCRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forceCFCRefresh = TRUE />
</cfif>

<!--- tpryan 6/2007 HelperCFC added to encapsulate bulky pieces. --->
<cfset functionHelperObj = CreateObject("component",configObj.get('cfc','functionHelper')).init() />

<!--- tpryan 6/2007 Reduced number of times this object is created.. --->
<cfset constantsObj = CreateObject("component",configObj.get('cfc','constants')).init(configObj) />

<cfset CFCArray = ArrayNew(1) />

<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>


<cftimer label="Writing Functions and CFC for DAOs and Gateways" type="inline">
<p class="alert alert-success">Writing Functions and CFC for DAOs and Gateways</p>




<p>Create Base Objects
<cfif not FileExists(configObj.get('fileLocations','dynamicdao') & "/baseDAO.cfc") or url.forceCFCRefresh>
	<cffile action="copy" source="#expandPath('.')#/templates/baseCFCs/#configObj.get('settings','applicationTemplate')#/baseDAO.cfc" destination="#configObj.get('fileLocations','dynamicdao')#/baseDAO.cfc" />
</cfif>

<cfif not FileExists(configObj.get('fileLocations','dynamicgateway') & "/baseGateway.cfc") or url.forceCFCRefresh>
	<cffile action="copy" source="#expandPath('.')#/templates/baseCFCs/#configObj.get('settings','applicationTemplate')#/baseGateway.cfc" destination="#configObj.get('fileLocations','dynamicgateway')#/baseGateway.cfc" />
</cfif>
-Done </p>



<!--- Initialize an array of all of the outputs. --->
<cfset operationArray = ArrayNew(1) />

<cftimer type="inline" label="Create CFstoredProcs and Functions">
<p>Create CFstoredProcs and Functions</p>
<ul>
<cfloop index="i" from="1" to="#ArrayLen(procedureArray)#">


	<cfoutput><li>Creating &lt;cfprocedure&gt; and &lt;cffunction&gt; for #procedureArray[i]#</cfoutput>



	<cfsilent>
	<!--- Get from the database details of the storedProc --->
	<cfset procedureDetails = databaseObj.getProcedure(procedureArray[i]) />

	<cfset parametersArray = databaseObj.getParamterArray(procedureArray[i]) />

	<!--- Record Details about the code --->
	<cfset operationStruct = StructNew() />
	<cfset operationStruct['table'] = procedureDetails['table'] />

	<cfif CompareNoCase(configObj.get('db','type'), "oracle") eq 0>
		<cfset operationStruct['operationName'] = ReplaceNoCAse(procedureArray[i], operationStruct['table'] & "pkg.", "", "ALL")  />
		<cfset operationStruct['operationName'] = ReplaceList(operationStruct['operationName'], "NEW,EDIT,LWFK,SWFK,LFKL,LB_", "create,update,list_with_FK,read_with_FK,list_foreign_key_labels,list_by_")>
		<cfset operationStruct['operationName'] = LCase(operationStruct['operationName']) />
	<cfelse>
		<cfset operationStruct['operationName'] = Replace(procedureArray[i], "usp_" & operationStruct['table'] & "_", "", "ALL")  />
	</cfif>



	<!--- Turns out, it's better if I just get the identity --->
	<!--- added to prevent sp's without proper naming conventions from ruining process. --->
	<cfif ListFind(ArrayToList(tableArray), operationStruct['table'])>
		<cfset operationStruct['identity'] = databaseObj.GetTable(operationStruct['table']).identity />
	<cfelse>
		<cfset operationStruct['identity'] = "unknown" />
	</cfif>
	<!--- Any operation is by default a gateway operation --->
	<cfset operationStruct['ObjectType'] = "gateway" />

	<cfloop list="#configObj.get('settings','dboprocs')#" index="dboOperation">
		<!--- Unless they are a dbo operation --->
		<!--- 2007-10-10 tpryan make sure that list functions don't end up in here.' --->
		<cfif FindNoCase(dboOperation, operationStruct['operationName']) and CompareNoCase(left(operationStruct['operationName'], 4), "list") neq 0>
			<cfset operationStruct['ObjectType'] = "dbo" />
			<cfbreak />
		</cfif>
	</cfloop>

	<!--- Set a few configurations here for things about the functions that will be created.  --->
	<cfset functionSetting = functionHelperObj.getFunctionDefaults(operationStruct['operationName'], operationStruct['table']) />
	<cfset operationStruct['functionName'] = functionSetting['name'] />
	<cfset operationStruct['functionHint'] = functionSetting['hint'] />

	<cfif procedureDetails['queryCount'] gt 1 or (StructKeyExists(procedureDetails,"outputVariableCount") and procedureDetails['outputVariableCount'] gt 1)>
		<cfset operationStruct['functionReturn'] = "struct" />
	<cfelse>
		<cfset operationStruct['functionReturn'] = functionSetting['return'] />
	</cfif>

	<!--- This gets a little confusing but it reduced code repetition and increased performance --->
	<!--- Basically, I am creating the Cfstoredproc code and the function that calls it in tandem.  --->

	<!--- *********************************************** --->
	<!--- Create the cfstoredproc code                    --->
	<!--- *********************************************** --->
	<cfinvoke component="#configObj.get('cfc','cfstoredproc')#" method="init" returnvariable="cfStoredProcObj" />

	<!--- Create the storedProc Wrapper --->
	<cfinvoke component="#cfstoredProcObj#" method="create">
		<cfinvokeargument name="procedure" value ="#procedureArray[i]#" />
		<cfinvokeargument name="datasource" value ="##variables.datasource##" />
		<!--- TODO: Make these variables set in the config. --->
		<cfif len(configObj.get('db','username')) gt 0 AND len(configObj.get('db','password'))>
			<cfinvokeargument name="username" value ="##variables.dbusername##" />
			<cfinvokeargument name="password" value ="##variables.dbpassword##" />
		</cfif>
	</cfinvoke>

	<!--- *********************************************** --->
	<!--- Create a new function                           --->
	<!--- *********************************************** --->
	<cfset functionObj = CreateObject("component", configObj.get('cfc','function')) />
	<!--- Create the function wrapper --->
	<cfset functionObj.create(name=operationStruct['functionName'],returntype=operationStruct['functionReturn'],hint=operationStruct['functionHint'], access=configObj.get('settings','defaultFunctionAccess')) />

	<cfset outputVariableName = "" />


	<!--- Create the params  --->
	<cfloop index="j" from="1" to="#ArrayLen(parametersArray)#">

		<!--- Encapsulated to allows for more database types. --->
		<cfset getInfoResults=constantsObj.getInfo(procedureDetails['parameterList'][parametersArray[j]]['type']) />

		<!--- Determine if we can skip variable. --->
		<cfif structkeyExists(procedureDetails['parameterList'][parametersArray[j]], "default") AND
				Len(procedureDetails['parameterList'][parametersArray[j]]['default']) gt 0>
			<cfset argumentRequired = FALSE />
		<cfelse>
			<cfset argumentRequired = TRUE />
		</cfif>

		<!--- Get a clean version of the name --->
		<!--- CfstoredProc Specific --->

		<cfif CompareNoCase(configObj.get('db','type'), "oracle") eq 0>
			<cfset propervariableName = Right(parametersArray[j], len(parametersArray[j])-2) />
		<cfelseif CompareNoCase(configObj.get('db','type'), "mysql") eq 0>
			<cfset propervariableName = Right(parametersArray[j], len(parametersArray[j])-1) />
		<cfelse>
			<cfset propervariableName = Replace(parametersArray[j],'@','','ALL') />
		</cfif>


		<!--- Add cfstored proc params for each loop.  --->

		<cfif StructKeyExists(procedureDetails['parameterList'][parametersArray[j]], "isImage") AND
				procedureDetails['parameterList'][parametersArray[j]]['IsImage']>

			<cfinvoke component="#cfstoredProcObj#" method="addImageParam">
				<cfinvokeargument name="type" value ="#procedureDetails['parameterList'][parametersArray[j]]['inout']#" />
				<cfinvokeargument name="cfsqltype" value ="#getInfoResults.cfsqltype#" />
				<cfinvokeargument name="variable" value ="#propervariableName#" />
				<cfinvokeargument name="dbvarname" value ="#parametersArray[j]#" />
				<cfinvokeargument name="value" value ="arguments.#propervariableName#" />
				<cfinvokeargument name="maxlength" value ="#procedureDetails['parameterList'][parametersArray[j]]['length']#" />
				<cfif isNumeric(procedureDetails['parameterList'][parametersArray[j]]['scale'])>
					<cfinvokeargument name="scale" value ="#procedureDetails['parameterList'][parametersArray[j]]['scale']#" />
				<cfelseif FindNoCase("decimal",procedureDetails['parameterList'][parametersArray[j]]['type']) >
					<cfinvokeargument name="scale" value ="#procedureDetails['parameterList'][parametersArray[j]]['scale']#" />
				</cfif>
				<cfinvokeargument name="default" value="#configObj.get('defaults', getInfoResults.cfsqltype)#" >
				<!--- added to prevent sp's without proper naming conventions from ruining process. --->
				<cfif structkeyExists(procedureDetails['parameterList'][parametersArray[j]], "nullable")>
					<cfinvokeargument name="nullable" value="#procedureDetails['parameterList'][parametersArray[j]]['nullable']#" >
				<cfelse>
					<cfinvokeargument name="nullable" value="NO" />
				</cfif>
				<cfinvokeargument name="required" value="#argumentRequired#" />
				<!--- Added to aid in image updating. --->
				<cfinvokeargument name="vartype" value="#procedureDetails['parameterList'][parametersArray[j]]['type']#" />
			</cfinvoke>

		<cfelse>

			<cfinvoke component="#cfstoredProcObj#" method="addParam">
				<cfinvokeargument name="type" value ="#procedureDetails['parameterList'][parametersArray[j]]['inout']#" />
				<cfinvokeargument name="cfsqltype" value ="#getInfoResults.cfsqltype#" />
				<cfinvokeargument name="variable" value ="#propervariableName#" />
				<cfinvokeargument name="dbvarname" value ="#parametersArray[j]#" />
				<cfinvokeargument name="value" value ="arguments.#propervariableName#" />
				<cfinvokeargument name="maxlength" value ="#procedureDetails['parameterList'][parametersArray[j]]['length']#" />
				<cfif isNumeric(procedureDetails['parameterList'][parametersArray[j]]['scale'])>
					<cfinvokeargument name="scale" value ="#procedureDetails['parameterList'][parametersArray[j]]['scale']#" />
				<cfelseif FindNoCase("decimal",procedureDetails['parameterList'][parametersArray[j]]['type']) >
					<cfinvokeargument name="scale" value ="#procedureDetails['parameterList'][parametersArray[j]]['scale']#" />
				</cfif>
				<cfinvokeargument name="default" value="#configObj.get('defaults', getInfoResults.cfsqltype)#" >
				<!--- added to prevent sp's without proper naming conventions from ruining process. --->
				<cfif structkeyExists(procedureDetails['parameterList'][parametersArray[j]], "nullable")>
					<cfinvokeargument name="nullable" value="#procedureDetails['parameterList'][parametersArray[j]]['nullable']#" >
				<cfelse>
					<cfinvokeargument name="nullable" value="NO" />
				</cfif>
				<cfinvokeargument name="required" value="#argumentRequired#" />


			</cfinvoke>

		</cfif>
		<!--- END CfstoredProc Specific --->


		<!--- Cffunction Specific --->
		<cfif FindNoCase("OUT", procedureDetails['parameterList'][parametersArray[j]]['inout']) >
			<cfset outputVariableName = ListAppend(outputVariableName, propervariableName) />
		</cfif>


		<!--- Add the function argument. Exclusing identity on insert  --->
		<!--- TODO: Figure Out a better way of doing this. --->
		<cfif not FindNoCase("OUT", procedureDetails['parameterList'][parametersArray[j]]['inout']) >
			<cfset functionObj.AddArgument(name=propervariableName, type=getInfoResults.argumenttype, required=argumentRequired, defaultvalue=configObj.get('defaults', getInfoResults.cfsqltype)) />
		</cfif>
		<!--- END Cffunction Specific --->


	</cfloop>


	<!--- create the result set --->
	<cfif operationStruct['functionReturn'] neq "void">
		<cfif procedureDetails['queryCount'] gt 1>
			<cfloop index="k" from="1" to="#procedureDetails['queryCount']#">
				<cfset cfstoredProcObj.addresult(name="results.query#k#",resultset=k) />
			</cfloop>
		<cfelse>
			<cfset cfstoredProcObj.addresult(name="results") />
		</cfif>
	</cfif>

	<!--- Get the stored Proc code and  Add the stored proc to the cfc --->
	<cfset functionObj.addoperation(cfstoredProcObj.getProc()) />


	<!--- If there is an output param add it to the return set  --->
	<cfif len(outputVariableName) gt 0>

		<!--- Handle multiple output variables from the same proc --->
		<cfif listLen(outputVariableName) gt 1>
			<cfloop list="#outputVariableName#" index="singleoutputvariable">
				<cfset functionObj.addoperation(chr(9) & chr(9) & "<cfset results['#singleoutputvariable#'] = #singleoutputvariable# />" & chr(13)) />
				<cfset functionObj.addLocalVariable(singleoutputvariable) />
			</cfloop>
		<cfelse>
			<cfset functionObj.addoperation(chr(9) & chr(9) & "<cfset results = #outputVariableName# />" & chr(13)) />
			<cfset functionObj.addLocalVariable(outputVariableName) />
		</cfif>

	</cfif>


	<!--- If the operation returns a query make sure that you return the results. --->
	<cfif CompareNoCase(operationStruct['functionReturn'], "void")>
		<cfinvoke component="#functionObj#" method="addLocalVariable">
			<cfinvokeargument name="LocalVariable" value="results"/>
			<cfif listLen(outputVariableName) gt 1 or procedureDetails['queryCount'] gt 1>
				<cfinvokeargument name="type" value="struct"/>
			</cfif>
		</cfinvoke>

		<cfset functionObj.addReturnResult("results") />
	</cfif>


	<cfset operationStruct['functionCode'] = functionObj.getFunction() />
	</cfsilent>
	- Done</li>
	<!--- Set the whole thing to the array. --->
	<cfset ArrayAppend(operationArray, Duplicate(operationStruct)) />


</cfloop>
</ul>
</cftimer>


<cftimer type="inline" label="Writing CFC code">
<p>Writing CFC code</p>
<ul>
<!--- Create the init function --->
<cfset InitfunctionObj = CreateObject("component", configObj.get('cfc','function')) />
<cfset InitfunctionObj.create(name="init", returntype="any", hint="This is the pseudo constructor that allows us to play little object games.") />

<!--- Set the database information in the init function, and allow for this to be passed in, but not break existing apps. --->
<cfset InitfunctionObj.addArgument(name="datasource", type="string", required="FALSE", defaultvalue="##application.datasource##", hint="The datasource for database operations." ) />
<cfset InitfunctionObj.addoperation(chr(9) & chr(9) & "<cfset variables.datasource = arguments.datasource />") />

<cfif len(configObj.get('db','username')) gt 0 AND len(configObj.get('db','password'))>
	<cfset InitfunctionObj.addArgument(name="dbusername", type="string", required="FALSE", defaultvalue="##application.dbusername##", hint="The database username for database operations." ) />
	<cfset InitfunctionObj.addArgument(name="dbpassword", type="string", required="FALSE", defaultvalue="##application.dbpassword##", hint="The database password for database operations." ) />
	<cfset InitfunctionObj.addoperation(chr(9) & chr(9) & "<cfset variables.dbusername = arguments.dbusername />") />
	<cfset InitfunctionObj.addoperation(chr(9) & chr(9) & "<cfset variables.dbpassword = arguments.dbpassword />") />
</cfif>


<cfset InitfunctionObj.addoperation(chr(9) & chr(9) & "<cfreturn This />") />

<cfset functionObj = CreateObject("component", configObj.get('cfc','function')) />

<!--- Initialze Structs. --->
<cfset DAOStruct = StructNew() />
<cfset GatewayStruct = StructNew() />
<cfset CustomDAOStruct = StructNew() />
<cfset CustomGatewayStruct = StructNew() />

<cfset StaticCommentString = "<!--- This CFC extends a dynamic CFC.  You may customize it. It will not be overwritten.  --->" & chr(13)/>
<cfset DynamicCommentString = "<!--- This CFC is a dynamic CFC.  Don't customize it. It WILL be overwritten.  --->" & chr(13)/>
<cfloop index="i" from="1" to="#ArrayLen(operationArray)#" >

	<!--- Prevents views with Spaces from causing problems. --->
	<cfset CFversionofTableName = databaseObj.getCFversionofTableName(operationArray[i].table) />
	
	<cfif not structKeyExists(DAOStruct, "#operationArray[i].table#")>
		<cfoutput><li>Creating CFC for table #operationArray[i].table#</cfoutput>
		<cfsilent>
		<!--- Added customizable DAO and gateway objects. Bu they shouldn't be altered if they exist. --->
		<cfif not FileExists("#configObj.get('fileLocations','dao')#\#CFversionofTableName#.cfc")>
			<cfset tempDAO = CreateObject("component", configObj.get('cfc','cfc')) />
			<cfset tempDAO.Create('#configObj.get('application','cfcPathCFCStyle')#.dao.dynamic.#CFversionofTableName#') />
			<cfset tempDAO.addConstructor(StaticCommentString) />
			<cfset CustomDAOStruct[operationArray[i].table] = tempDAO />
		</cfif>

		<cfif not FileExists("#configObj.get('fileLocations','gateway')#\#CFversionofTableName#.cfc")>
			<cfset tempGateway = CreateObject("component", configObj.get('cfc','cfc')) />
			<cfset tempGateway.Create('#configObj.get('application','cfcPathCFCStyle')#.gateway.dynamic.#CFversionofTableName#') />
			<cfset tempGateway.addConstructor(StaticCommentString) />
			<cfset CustomGatewayStruct[operationArray[i].table] = tempGateway />
		</cfif>

		<cfset tempDAO = CreateObject("component", configObj.get('cfc','cfc')) />
		<cfset tempGateway = CreateObject("component", configObj.get('cfc','cfc')) />
		<cfset tempDAO.Create('baseDAO') />
		<cfset tempGateway.Create('baseGateway') />

		<!--- Add init functions --->
		<cfset tempGateway.addFunction(InitfunctionObj.getFunction()) />
		<cfset tempDAO.addFunction(InitfunctionObj.getFunction()) />

		<!--- added to prevent sp's without proper naming conventions from ruining process. --->
		<cfif ListFind(ArrayToList(tableArray), operationArray[i].table)>
			<cfset tableData = databaseObj.getTable(operationArray[i].table) />
			<cfset parameterArray = databaseObj.getColumnArray(operationArray[i].table) />
		</cfif>

		<!--- Append the tablename to the array, so we'll be sure that we only try to create this whole thing once. --->
		<cfset ArrayAppend(cfcArray, "#operationArray[i].table#") />

		<!--- Create identity property for CFC and comment.  --->
		<cfset tempDAO.addConstructor(DynamicCommentString) />
		<cfset tempDAO.addConstructor("<cfset This.identity = """ & operationArray[i].identity & """ />" & chr(13)) />

		<!--- added to prevent sp's without proper naming conventions from ruining process. --->
		<!--- Basically, if you name your sp's independent of a table, then you cannot describe or sample them.  --->
		<cfif ListFind(ArrayToList(tableArray), operationArray[i].table)>

			<!--- Create the describe function --->
			<cfset operationData = chr(9) & chr(9) & "<cfset var description = queryNew(""name,type,length"") />" & chr(13) />

			<cfloop index="j" from="1" to="#arrayLen(parameterArray)#" >
				<cfset operationData = operationData.concat(chr(9) & chr(9) & '<cfset queryAddRow(description) />' & chr(13)) />
				<cfset operationData = operationData.concat(chr(9) & chr(9) & '<cfset querySetCell(description, "name", "' & parameterArray[j] & '") />' & chr(13)) />
				<cfset operationData = operationData.concat(chr(9) & chr(9) & '<cfset querySetCell(description, "type", "' & tableData['columnlist'][parameterArray[j]]['type'] & '") />' & chr(13)) />
				<cfset operationData = operationData.concat(chr(9) & chr(9) & '<cfset querySetCell(description, "length", "' & tableData['columnlist'][parameterArray[j]]['length'] & '") />' & chr(13)) />
			</cfloop>


			<cfset functionObj.create(name="describe",returntype="query",hint="This function will describe the data in the table this cfc represents.", access=configObj.get('settings','defaultFunctionAccess')) />
			<cfset functionObj.AddOperation(operationData) />
			<cfset functionObj.addReturnResult("description") />
			<cfset tempDAO.addFunction(functionObj.getFunction()) />
			<!--- END Create the describe function --->


			<!--- Create the sample function --->
			<cfset operationData = "" />
			<cfset operationData = chr(9) & chr(9) & "<cfset var sample = queryNew(""" & ArrayToList(parameterArray) & """) />" & chr(13) />


			<cfset functionObj.create(name="sample",returntype="query",hint="This function will create a sample blank record from the database.") />
			<cfset functionObj.AddOperation(operationData) />
			<cfset functionObj.addReturnResult("sample") />
			<cfset tempDAO.addFunction(functionObj.getFunction()) />
			<!--- END Create the sample function --->


			<!--- tpryan 6/2007 added readDisplay to deal with issues around not creating extraneous foreign key queries. --->
			<!--- Create the readDisplay function --->
			<cfif databaseObj.isProperTable(operationArray[i].table)>
				<cfset operationData = "" />
				<cfif databaseObj.hasForeignKeys(operationArray[i].table)>
					<cfset operationData = chr(9) & chr(9) & '<cfinvoke method="read_with_fk" argumentcollection="##arguments##" returnvariable="results" />' & chr(13) />
				<cfelse>
					<cfset operationData = chr(9) & chr(9) & '<cfinvoke method="read" argumentcollection="##arguments##" returnvariable="results" />' & chr(13) />
				</cfif>


				<cfset functionObj.create(name="readDisplay",returntype="query",hint="This function will handle returning the correct information to deal with foreign keys.") />
				<cfset functionObj.AddLocalVariable("results") />
				<cfset functionObj.AddArgument(name=operationArray[i].identity,type="numeric",required=TRUE) />
				<cfset functionObj.AddOperation(operationData) />
				<cfset functionObj.addReturnResult("results") />

				<cfset tempDAO.addFunction(functionObj.getFunction()) />
			</cfif>
			<!--- END Create the readDisplay function --->

		</cfif>


		<!--- tpryan 7/2007 added listDisplay to deal with issues around not creating extraneous foreign key queries. --->
		<!--- Create the readDisplay function --->
		<cfset operationData = "" />
		<cfif databaseObj.hasForeignKeys(operationArray[i].table)>
			<cfset operationData = chr(9) & chr(9) & '<cfinvoke method="list_with_fk" returnvariable="results" />' & chr(13) />
		<cfelse>
			<cfset operationData = chr(9) & chr(9) & '<cfinvoke method="list" returnvariable="results" />' & chr(13) />
		</cfif>

		<cfset functionObj.create(name="listDisplay",returntype="query",hint="This function will handle returning the correct information to deal with foreign keys.") />
		<cfset functionObj.AddLocalVariable("results") />
		<cfset functionObj.AddOperation(operationData) />
		<cfset functionObj.addReturnResult("results") />
		<cfset tempGateway.addFunction(functionObj.getFunction()) />
		<!--- END Create the readDisplay function --->

		<!--- Okay before we were doing all this with evaluate. And that was bad.  This way is a little better.  --->
		<cfset DAOStruct[operationArray[i].table] = tempDAO />
		<cfset GatewayStruct[operationArray[i].table] = tempGateway />

		</cfsilent>
		- Done</li>

	</cfif>

	<!--- Now add function we wanted to add to the cfc. --->
	<cfif CompareNoCase(operationArray[i]['ObjectType'] , "gateway") >
		<cfset DAOStruct[operationArray[i].table].addFunction(operationArray[i]['functionCode']) />
	<cfelse>
		<cfset GatewayStruct[operationArray[i].table].addFunction(operationArray[i]['functionCode']) />
	</cfif>




</cfloop>



</ul>
</cftimer>

<p>Writing CFC's to Disk</p>
<ul>
<cfoutput>
<cfloop index="i" from="1" to="#ArrayLen(cfcArray)#">


	<!--- Prevents views with Spaces from causing problems. --->
	<cfset CFversionofTableName = databaseObj.getCFversionofTableName(cfcArray[i]) />
	

	<cfset temp=DAOStruct[cfcArray[i]].GetCFC() />
	<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','dynamicdao')#/#CFversionofTableName#.cfc" output="#temp#" fixnewline="no" />
	<li>#configObj.get('fileLocations','dynamicdao')#/#CFversionofTableName#.cfc</li>

	<cfset temp=GatewayStruct[cfcArray[i]].GetCFC() />
	<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','dynamicgateway')#/#CFversionofTableName#.cfc" output="#temp#" fixnewline="no" />
	<li>#configObj.get('fileLocations','dynamicgateway')#/#CFversionofTableName#.cfc</li>

	<!--- Added customizable DAO and gateway objects. --->
	<cfif not FileExists("#configObj.get('fileLocations','dao')#\#CFversionofTableName#.cfc")>
		<cfset  temp= CustomDAOStruct[cfcArray[i]].GetCFC() />
		<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','dao')#/#CFversionofTableName#.cfc" output="#temp#" fixnewline="no" />
		<li>#configObj.get('fileLocations','dao')#/#CFversionofTableName#.cfc</li>
	</cfif>

	<cfif not FileExists("#configObj.get('fileLocations','gateway')#\#CFversionofTableName#.cfc")>
		<cfset  temp=CustomGatewayStruct[cfcArray[i]].GetCFC() />
		<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','gateway')#/#CFversionofTableName#.cfc" output="#temp#" fixnewline="no" />
		<li>#configObj.get('fileLocations','gateway')#/#CFversionofTableName#.cfc</li>
	</cfif>

</cfloop>
</cfoutput>
</ul>











</cftimer>