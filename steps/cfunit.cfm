<!---    cfunit.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:47:29 AM
DESCRIPTION			: Writes CFUnit tests.
---->


<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forcecfunitRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forcecfunitRefresh = TRUE />
</cfif>

<cftimer label="Writing CFUnit Tests" type="inline">
<h2>Writing CFUnit Tests</h2>

<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>

<cfset tableData = databaseObj.getTableInfo() />

<cftimer type="inline" label="Create Unit Tests">
<p>Create CFUnit Tests</p>

<cfoutput>
	<cfloop index="i" from="1" to="#ArrayLen(tableArray)#">

		<cfset objectName = tableData[tableArray[i]]['name'] />
		<!--- Prevents views with Spaces from causing problems. --->
		<cfset CFversionofTableName = databaseObj.getCFversionofTableName(objectName) />
		

		<cfset identity = tableData[tableArray[i]]['identity'] />

		<!--- If a table doesn't have a identity it's not a proper table as far as this applicaiton is concerned. --->
		<cfset isProperTable = tableData[tableArray[i]]['isProperTable'] />

		<cfif isProperTable>

			<!--- Creating DAO test. --->
			<cfif not FileExists("#configObj.get('fileLocations','testDAO')#\#CFversionofTableName#Test.cfc")>
				<cfobject name="staticObject" component="#configObj.get('cfc','cfc')#" />
				<cfset staticObject.Create(configObj.get('cfc','cfUnitPath') & ".TestCase") />
				<cfset staticObject.addConstructor("<!--- This CFC is Static.  You may customize it. It will not be overwritten.  --->") />
				<cffile action="write" file="#configObj.get('fileLocations','testDAO')#/#CFversionofTableName#Test.cfc" output="#staticObject.GetCFC()#" />
			</cfif>

			<ul><li>#CFversionofTableName# DAO
			<ul>

			<!--- *********************************************** --->
			<!--- Create a new CFC                                --->
			<!--- *********************************************** --->
			<cfset daoTestObj = createObject("component", configObj.get('cfc','cfc')) />
			<cfset daoTestObj.Create(configObj.get('cfc','cfUnitPath')& ".TestCase") />
			<cfset daoTestObj.addConstructor("<!--- This CFC is a dynamic CFC.  Don't customize it. It WILL be overwritten.  --->") />

			<li>Create Setup Function for dao.#CFversionofTableName#Test.</li>

			<!--- *********************************************** --->
			<!--- Create the setup function.                        --->
			<!--- *********************************************** --->
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="setUp", returntype="void", hint="Creates the initial conditions for a unit test.", access="public" ) />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset VARIABLES.tempCFC = CreateObject("component", "#configObj.get('application','CFCpathCFCStyle')#.dao.#CFversionofTableName#").init() />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName# = StructNew() />') />

			<!--- Spin throught the inputs of this CFC --->
			<cfloop index="j" from="1" to="#ArrayLen(tableData[tableArray[i]]['columnArray'])#">

				<cfset columnName = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['name'] />
				<cfset isIdentity = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['isIdentity'] />
				<cfset type = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['type'] />
				<cfset linkedTable = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['linkedTable'] />
				<cfset length = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['length'] />

				<cfif columnName neq configObj.get('reservedWords','active') AND
						columnName neq configObj.get('reservedWords','createdOn') AND
							<!--- columnName neq configObj.get('reservedWords','createdBy') AND --->
								columnName neq configObj.get('reservedWords','updatedOn')>

					<cfif FindNoCase("text", type) OR  FindNoCase("clob", type) >
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = "Data for CFUnit testing for the column #tableData[tableArray[i]]['columnArray'][j]#" />') />
					<cfelseif FindNoCase("char", type) or findNoCase("variant", type)>
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = Left("Data for CFUnit testing for the column #tableData[tableArray[i]]['columnArray'][j]#", #length#) />') />
					<cfelseif len(linkedTable) gt 0>
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.#linkedTable#gatewayObj = CreateObject("component", "#configObj.get('application','CFCpathCFCStyle')#.gateway.#application.utilityObj.convertToCFVersion(linkedTable)#").init() />') />
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.#linkedTable#FKQuery = variables.#linkedTable#gatewayObj.list_foreign_key_labels() />') />
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = variables.#linkedTable#FKQuery.foreignkeyID />') />
					<cfelseif FindNoCase("datetime", type)>
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = Now() />') />
					<cfelseif FindNoCase("uniqueidentifier", type)>
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = "#Lcase(application.UtilityObj.CreateGuid())#" />') />
					<cfelseif FindNoCase("bit", type)>
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = 1 />') />
					<cfelseif FindNoCase("image", type) or FindNoCase('binary', type) >
						<!--- <cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = "##toBinary(toBase64("4"))##" />') /> --->
					<cfelseif FindNoCase("int", type) OR FindNoCase("float", type) OR
								FindNoCase("money", type) OR FindNoCase("decimal", type) OR
									FindNoCase("numeric", type) OR FindNoCase("real", type) OR
										FindNoCase("number", type)>
						<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.mock#CFversionofTableName#.#columnName# = 1 />') />
					</cfif>
				</cfif>
			</cfloop>

			<cfset daoTestObj.addFunction(functionObj.getFunction()) />

			<li>Create CRUDTest Function for dao.#CFversionofTableName#Test.</li>

			<!--- *********************************************** --->
			<!--- Create a new function                           --->
			<!--- *********************************************** --->
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="testCRUD", returntype="void", hint="Tests all CRUD operations at once.", access="public" ) />

			<!--- Grouped together for performance reasons. --->
			<cfset createAssertString = "" />
			<cfset updateAssertString = "" />
			<cfset updateStructString = "" />

			<!--- Creating several layers of code chucks to insert into the final test. --->
			<cfloop index="j" from="1" to="#ArrayLen(tableData[tableArray[i]]['columnArray'])#">

				<cfset columnName = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['name'] />
				<cfset isIdentity = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['isIdentity'] />
				<cfset type = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['type'] />
				<cfset linkedTable = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['linkedTable'] />
				<cfset length = tableData[tableArray[i]]['columnList'][tableData[tableArray[i]]['columnArray'][j]]['length'] />

				<cfif columnName neq configObj.get('reservedWords','active') AND
						columnName neq configObj.get('reservedWords','createdOn') AND
							columnName neq configObj.get('reservedWords','createdBy') AND
								columnName neq configObj.get('reservedWords','updatedOn')>

					<cfif isIdentity >
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=keyItemTest, actual=queryTest.#columnName#, message="Create #columnName#") />' & Chr(13)) />
					<cfelseif type eq "smalldatetime">
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset expectedMock#CFversionofTableName##columnName# = DateFormat(variables.mock#CFversionofTableName#.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(variables.mock#CFversionofTableName#.#columnName#, "HH") />' & Chr(13)) />
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset actual#columnName# = DateFormat(queryTest.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(queryTest.#columnName#, "HH") />' & Chr(13)) />
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=expectedMock#CFversionofTableName##columnName#, actual=actual#columnName#, message="Create #columnName#") />' & Chr(13)) />

					<cfelseif type eq "datetime">
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset expectedMock#CFversionofTableName##columnName# = DateFormat(variables.mock#CFversionofTableName#.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(variables.mock#CFversionofTableName#.#columnName#, "HH:mm:ss") />' & Chr(13)) />
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset actual#columnName# = DateFormat(queryTest.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(queryTest.#columnName#, "HH:mm:ss") />' & Chr(13)) />
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=expectedMock#CFversionofTableName##columnName#, actual=actual#columnName#, message="Create #columnName#") />' & Chr(13)) />
					<cfelseif FindNoCase("image", type) or FindNoCase('binary', type) or FindNoCase('uniqueidentifier', type)>

					<cfelse>
						<cfset createAssertString = createAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=variables.mock#CFversionofTableName#.#columnName#, actual=queryTest.#columnName#, message="Create #columnName#") />' & Chr(13)) />
					</cfif>

					<cfif isIdentity >
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = keyItemTest/>' & Chr(13)) />
					<cfelseif findNoCase("text", type) or findNoCase("CLOB", type)>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = mock#CFversionofTableName#.#columnName# & "For Update" />' & Chr(13)) />
					<cfelseif findNoCase("char", type) or findNoCase("variant", type)>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = Left(mock#CFversionofTableName#.#columnName# & "For Update", #length#) />' & Chr(13)) />

					<cfelseif len(linkedTable) gt 0>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = variables.#linkedTable#FKQuery.foreignkeyID />' & Chr(13)) />
					<cfelseif findNoCase("datetime", type)>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = DateAdd("m", 1, mock#CFversionofTableName#.#columnName#)  />' & Chr(13)) />
					<cfelseif findNoCase("uniqueidentifier", type)>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = "#Lcase(application.UtilityObj.CreateGuid())#"  />' & Chr(13)) />

					<cfelseif findNoCase("bit", type)>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = FALSE  />' & Chr(13)) />
					<cfelseif FindNoCase("int", type) OR FindNoCase("float", type) OR
								FindNoCase("money", type) OR FindNoCase("decimal", type) OR
									FindNoCase("numeric", type) OR FindNoCase("real", type) OR
										FindNoCase("number", type)>
						<cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = mock#CFversionofTableName#.#columnName# + 1 />' & Chr(13)) />
					<cfelseif FindNoCase("image", type) or FindNoCase('binary', type) >
						<!--- <cfset updateStructString = updateStructString.concat('#chr(9)##chr(9)##chr(9)#<cfset mock#CFversionofTableName#ForUpdate.#columnName# = "##toBinary(toBase64("3"))##" />' & Chr(13)) /> --->
					</cfif>

					<cfif type eq "datetime">
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset expectedMock#CFversionofTableName#ForUpdate#columnName# = DateFormat(mock#CFversionofTableName#ForUpdate.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(mock#CFversionofTableName#ForUpdate.#columnName#, "HH:mm:ss") />' & Chr(13)) />
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset actual#columnName# = DateFormat(queryTest.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(queryTest.#columnName#, "HH:mm:ss") />' & Chr(13)) />
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=expectedMock#CFversionofTableName#ForUpdate#columnName#, actual=actual#columnName#, message="Update #columnName#") />' & Chr(13)) />

					<cfelseif type eq "smalldatetime">
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset expectedMock#CFversionofTableName#ForUpdate#columnName# = DateFormat(mock#CFversionofTableName#ForUpdate.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(mock#CFversionofTableName#ForUpdate.#columnName#, "HH") />' & Chr(13)) />
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset actual#columnName# = DateFormat(queryTest.#columnName#, "mm/dd/yyyy") & " " & TimeFormat(queryTest.#columnName#, "HH") />' & Chr(13)) />
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=expectedMock#CFversionofTableName#ForUpdate#columnName#, actual=actual#columnName#, message="Update #columnName#") />' & Chr(13)) />
					<cfelseif type eq "bit">
						<!--- False which is the update value for bit's gets converted to null, not 0. So, have to do this manuevering.' --->
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=0, actual=queryTest.#columnName#, message="Update #columnName#") />' & Chr(13)) />
					<cfelseif FindNoCase("image", type) or FindNoCase('binary', type)>

					<cfelse>
						<cfset updateAssertString = updateAssertString.concat('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=mock#CFversionofTableName#ForUpdate.#columnName#, actual=queryTest.#columnName#, message="Update #columnName#") />' & Chr(13)) />
					</cfif>

				</cfif>
			</cfloop>

			<!--- Write all of this to the function code --->
			<cfset functionObj.AddLocalVariable("queryTest","string") />
			<cfset functionObj.AddLocalVariable("keyItemTest","string") />
			<cfset functionObj.AddLocalVariable("mock#CFversionofTableName#ForUpdate","struct") />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cftransaction action="begin" isolation="read_uncommitted">') />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Create --->') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfinvoke component="##variables.tempCFC##" method="create" argumentcollection="##variables.mock#CFversionofTableName###" returnvariable="keyItemTest" />') />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Read --->') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfset queryTest = variables.tempCFC.read(keyItemTest) />') />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Essentially Create and Read Test. --->') />
			<cfset functionObj.addOperation(createAssertString) />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Update --->') />
			<cfset functionObj.addOperation(updateStructString) />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfinvoke component="##variables.tempCFC##" method="update" argumentcollection="##mock#CFversionofTableName#ForUpdate##" />') />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Read --->') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfset queryTest = variables.tempCFC.read(keyItemTest) />') />
			<cfset functionObj.addOperation(updateAssertString) />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Delete --->') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfset variables.tempCFC.destroy(keyItemTest) />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfset queryTest = variables.tempCFC.read(keyItemTest) />') />
			<cfset functionObj.addOperation('#chr(13)##chr(9)##chr(9)##chr(9)#<!--- Delete Test --->') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cfset assertEquals(expected=0, actual=queryTest.recordCount) />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)##chr(9)#<cftransaction action="rollback" />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#</cftransaction>') />

			<!--- Write it to the CFC --->
			<cfset daoTestObj.addFunction(functionObj.getFunction()) />

			<li>Writing Test case to disk.
			<cffile action="write" file="#configObj.get('fileLocations','testdynamicDAO')#/#CFversionofTableName#Test.cfc" output="#daoTestObj.GetCFC()#" />
			- Done</li>

			</li>
			</ul>
			</ul>
		</cfif>


		<cfif isProperTable>
			<!--- Creating interface tests --->

			<ul><li>#CFversionofTableName# Interface
			<ul>


			<!--- *********************************************** --->
			<!--- Create a new CFC                                --->
			<!--- *********************************************** --->
			<cfset interfaceTemp = createObject("component", configObj.get('cfc','cfc')) />
			<cfset interfaceTemp.Create(configObj.get('cfc','cfUnitPath')& ".TestCase") />
			<cfset interfaceTemp.addConstructor("<!--- This CFC is a dynamic CFC.  Don't customize it. It WILL be overwritten.  --->") />



			<!--- *********************************************** --->
			<!--- Create the setup function.                      --->
			<!--- *********************************************** --->
			<li>Create Setup Function for interface.#CFversionofTableName#Test.</li>
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="setUp", returntype="void", hint="Creates the initial conditions for a unit test.", access="public" ) />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.targetUrl="#configObj.get('application','url')##LCase(CFversionofTableName)#.cfm" />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.GatewayObj = CreateObject("component", "#configObj.get('application','CFCpathCFCStyle')#.gateway.#CFversionofTableName#").init() />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset variables.List = variables.GatewayObj.list() />') />
			<cfset interfaceTemp.addFunction(functionObj.getFunction()) />

			<!--- *********************************************** --->
			<!--- Create the testList function.                      --->
			<!--- *********************************************** --->
			<li>Create testList Function for interface.#CFversionofTableName#Test.</li>
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="testList", returntype="void", hint="Tests that the list method for a page is working.", access="public" ) />
			<cfset functionObj.AddLocalVariable("callResult", "struct") />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfhttp url="##variables.targetUrl##?method=list" result="callResult" />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset assertEquals(expected=200, actual=callResult[''Responseheader''][''Status_Code''], message="#CFversionofTableName#.cfm list method [##variables.targetUrl##?method=list] could not fire correctly.") />') />
			<cfset interfaceTemp.addFunction(functionObj.getFunction()) />

			<!--- *********************************************** --->
			<!--- Create the testRead function.                      --->
			<!--- *********************************************** --->
			<li>Create testRead Function for interface.#CFversionofTableName#Test.</li>
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="testRead", returntype="void", hint="Tests that the read method for a page is working.", access="public" ) />
			<cfset functionObj.AddLocalVariable("callResult", "struct") />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfhttp url="##variables.targetUrl##?method=read&#identity#=##variables.list.#identity###" result="callResult" />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset assertEquals(expected=200, actual=callResult[''Responseheader''][''Status_Code''], message="#CFversionofTableName#.cfm read method [##variables.targetUrl##?method=read&#identity#=##variables.list.#identity###] could not fire correctly.") />') />
			<cfset interfaceTemp.addFunction(functionObj.getFunction()) />

			<!--- *********************************************** --->
			<!--- Create the testEditUpdate function.             --->
			<!--- *********************************************** --->
			<li>Create testEditUpdate Function for interface.#CFversionofTableName#Test.</li>
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="testEditUpdate", returntype="void", hint="Tests that the edit method for an existing item is working.", access="public" ) />
			<cfset functionObj.AddLocalVariable("callResult", "struct") />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfhttp url="##variables.targetUrl##?method=edit&#identity#=##variables.list.#identity###" result="callResult" />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset assertEquals(expected=200, actual=callResult[''Responseheader''][''Status_Code''], message="#CFversionofTableName#.cfm edit (for update) method [##variables.targetUrl##?method=edit&#identity#=##variables.list.#identity###]could not fire correctly.") />') />
			<cfset interfaceTemp.addFunction(functionObj.getFunction()) />

			<!--- *********************************************** --->
			<!--- Create the testEditCreate function.             --->
			<!--- *********************************************** --->
			<li>Create testEditCreate Function for interface.#CFversionofTableName#Test.</li>
			<cfset functionObj = createObject("component", configObj.get('cfc','function')) />
			<cfset functionObj.create(name="testEditCreate", returntype="void", hint="Tests that the edit method for an new item is working.", access="public" ) />
			<cfset functionObj.AddLocalVariable("callResult", "struct") />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfhttp url="##variables.targetUrl##?method=edit" result="callResult" />') />
			<cfset functionObj.addOperation('#chr(9)##chr(9)#<cfset assertEquals(expected=200, actual=callResult[''Responseheader''][''Status_Code''], message="#CFversionofTableName#.cfm edit (for create) method [##variables.targetUrl##?method=edit] could not fire correctly. ") />') />
			<cfset interfaceTemp.addFunction(functionObj.getFunction()) />



			<li>Writing Test case to disk.
			<cffile action="write" file="#configObj.get('fileLocations','testinterface')#/#CFversionofTableName#Test.cfc" output="#interfaceTemp.GetCFC()#" />
			- Done</li>

			</li>
			</ul>
			</ul>


		</cfif>

	</cfloop>
</cfoutput>

</cftimer>

<p>Create CFUnit Tester Page</p>

<cfdirectory action="list" directory="#configObj.get('fileLocations','test')#" recurse="true" filter="*.cfc" name="TestDirectory" />


<cfset CfUnitTestContents = "" />
<cfset CfUnitTestContents = CfUnitTestContents.concat("<h2>Unit Tests</h2>" & Chr(13)) />
<cfset CfUnitTestContents = CfUnitTestContents.concat("<p>Running all Unit Tests found in #configObj.get('fileLocations','test')#</p>" & Chr(13)) />
<cfset CfUnitTestContents = CfUnitTestContents.concat("<cfset testClasses = ArrayNew(1)>" & Chr(13)) />

<cfloop query="TestDirectory">
	<cfset CfUnitTestContents = CfUnitTestContents.concat('<cfset ArrayAppend(testClasses, "' & application.utilityObj.convertFilePathToCFCPath(configObj.get('fileLocations','webroot'), "#directory#\#name#") & '" )>' & Chr(13)) />
</cfloop>

<cfset CfUnitTestContents = CfUnitTestContents.concat("" & Chr(13)) />

<cfset CfUnitTestContents = CfUnitTestContents.concat('<cfset suite = CreateObject("component", "' & configObj.get('cfc','cfUnitPath') &'.TestSuite").init( testClasses )>' & Chr(13)) />
<cfset CfUnitTestContents = CfUnitTestContents.concat('<cfinvoke component="' & configObj.get('cfc','cfUnitPath') & '.TestRunner" method="run">' & Chr(13)) />
<cfset CfUnitTestContents = CfUnitTestContents.concat(Chr(9) & '<cfinvokeargument name="test" value="##suite##">' & Chr(13)) />
<cfset CfUnitTestContents = CfUnitTestContents.concat(Chr(9) & '<cfinvokeargument name="name" value="">' & Chr(13)) />
<cfset CfUnitTestContents = CfUnitTestContents.concat("</cfinvoke>" & Chr(13)) />


<cffile action="write" file="#configObj.get('fileLocations','test')#\index.cfm" output="#CfUnitTestContents#" />



</cftimer>