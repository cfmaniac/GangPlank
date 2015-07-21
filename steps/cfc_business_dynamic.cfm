<!---    cfc_business.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:40:24 AM
DESCRIPTION			: Builds business objects.
---->


<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceBusinessRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forceBusinessRefresh = TRUE />
</cfif>

<cfset CFCArray = ArrayNew(1) />

<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>


<cftimer label="Writing Functions and CFC for Business Objects" type="inline">
<p class="alert alert-success">Writing Functions and CFC for Business Objects</p>

<p>Create Base Objects
<cfif not FileExists(configObj.get('fileLocations','businessdynamic') & "/baseBusiness.cfc") or url.forceBusinessRefresh>
	<cffile action="copy" source="#expandPath('.')#/templates/baseCFCs/#configObj.get('settings','applicationTemplate')#/baseBusiness.cfc" destination="#configObj.get('fileLocations','businessdynamic')#/baseBusiness.cfc" />
</cfif>


-Done </p>


<p>Creating business objects for items.</p>

<cfset commentString = "<!--- This CFC is static.  You may customize it. It will not be overwritten.  --->" & chr(13)/>
<cfset StaticCommentString = "<!--- This CFC extends a dynamic CFC.  You may customize it. It will not be overwritten.  --->" & chr(13)/>
<cfset DynamicCommentString = "<!--- This CFC is a dynamic CFC.  Don't customize it. It WILL be overwritten.  --->" & chr(13)/>

<ul>
<cfoutput>
<cfloop index="i" from="1" to="#arrayLen(tableArray)#">

		<cfset tableObj = createObject("component", "#configObj.get('cfc','table')#").init(tableArray[i], databaseObj, configObj) />

		<li>Creating dynamic businessCFC for table #tableArray[i]#

		<cfset CFversionofTableName = databaseObj.getCFversionofTableName(tableArray[i]) />

		<cfset AddedTablesGateway = StructNew() />
		<cfset AddedTablesDAO = StructNew() />

		<!--- Dynamic business objects. But they should be altered even if they exist. --->
		<cfobject name="tempBusiness" component="#configObj.get('cfc','cfc')#" />

		<cfset tempBusiness.Create('baseBusiness') />
		<cfset tempBusiness.addConstructor(DynamicCommentString) />
		<cfset tempBusiness.addConstructor("#chr(9)#<cfset this.name=""business.#CFversionofTableName#"" />") />

		<cfset functionObj = CreateObject("component", configObj.get('cfc','function')) />
		<!--- Create the function wrapper --->
		<cfset functionObj.create(name="getLinks",returntype="void",hint="Gets linked records in other tables", access=configObj.get('settings','defaultFunctionAccess')) />

		<cfset functionObj.AddLocalVariable("temp") />

		<!--- Get joined tables. --->
		<cfif tableObj.hasJoinTable()>
			<cfset joinTableArray= ListToArray(tableObj.getJoinTableList()) />
			<cfset PassThroughTableArray=  ListToArray(tableObj.getPassThroughTableList()) />

			<cfloop index="j" from="1" to="#ArrayLen(joinTableArray)#">
				<cfset AddedTablesGateway[joinTableArray[j]] = "" />
				<cfset AddedTablesDAO[joinTableArray[j]] = "" />
				<cfset AddedTablesDAO[PassThroughTableArray[j]] = "" />
				<cfset functionObj.AddOperation('#chr(9)##chr(9)#<cfset variables.InternalProperties["#joinTableArray[j]#"] = variables.gateways.#joinTableArray[j]#Obj.list_by_#tableObj.getIdentity()#(get("#tableObj.getIdentity()#")) />') />


				<!--- Add function to add across joined table.  --->
				<cfset AddfunctionObj = CreateObject("component", configObj.get('cfc','function')) />
				<cfset AddfunctionObj.create(name="add#joinTableArray[j]#",returntype="void",hint="Adds a #joinTableArray[j]# object to the database based on this object being the keyed value through a joining table.", access=configObj.get('settings','defaultFunctionAccess')) />
				<cfset AddfunctionObj.addArgument("FormValues", "struct", "TRUE") />
				<cfset AddfunctionObj.AddLocalVariable("#joinTableArray[j]#Obj") />
				<cfset AddfunctionObj.AddLocalVariable("#PassThroughTableArray[j]#Obj") />
				<cfset AddfunctionObj.AddLocalVariable("#PassThroughTableArray[j]#query") />

				<!--- Add function to remove across joined table.  --->
				<cfset RemoveFunctionObj = CreateObject("component", configObj.get('cfc','function')) />
				<cfset RemoveFunctionObj.create(name="remove#joinTableArray[j]#",returntype="void",hint="Adds a #joinTableArray[j]# object to the database based on this object being the keyed value through a joining table.", access=configObj.get('settings','defaultFunctionAccess')) />
				<cfset RemoveFunctionObj.addArgument("FormValues", "struct", "TRUE") />
				<cfset RemoveFunctionObj.AddLocalVariable("#PassThroughTableArray[j]#Query") />
				<cfset RemoveFunctionObj.AddLocalVariable("#PassThroughTableArray[j]#Obj") />

				<cfif len(databaseObj.getUniqueList(joinTableArray[j])) gt 0>

					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<!--- Try to instantiate based on a unique column --->') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cftry>') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvoke component="#configObj.get("application","CFCpathCFCStyle")#.business.#joinTableArray[j]#" method="init" returnvariable="#joinTableArray[j]#Obj">') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#<cfinvokeargument name="DAO" value="##variables.daos.#joinTableArray[j]#Obj##" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#<cfinvokeargument name="KeyValue" value="##arguments.FormValues.#databaseObj.getUniqueList(joinTableArray[j])###" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#<cfinvokeargument name="KeyField" value="#databaseObj.getUniqueList(joinTableArray[j])#" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#</cfinvoke>' & chr(13)) />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<!--- If it fails, it is because it does not exist, therefore create it. --->') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfcatch type="any">' & chr(13)) />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#<cfif FindNoCase("Object creation failure", cfcatch.message)>') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<cfinvoke component="#configObj.get("application","CFCpathCFCStyle")#.business.#joinTableArray[j]#" method="init" returnvariable="#joinTableArray[j]#Obj">') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<cfinvokeargument name="DAO" value="##variables.daos.#joinTableArray[j]#Obj##" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<cfinvokeargument name="FormValues" value="##arguments.FormValues##" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#</cfinvoke>') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<cfset #joinTableArray[j]#Obj.commit()>'& chr(13)) />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#<cfelse>') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<cfrethrow />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#</cfif>') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#</cfcatch>' & chr(13)) />



					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#</cftry>' & chr(13)) />

				<cfelse>

					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfinvoke component="#configObj.get("application","CFCpathCFCStyle")#.business.#joinTableArray[j]#" method="init" returnvariable="#joinTableArray[j]#Obj">') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="DAO" value="##variables.daos.#joinTableArray[j]#Obj##" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="FormValues" value="##arguments.FormValues##" />') />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#</cfinvoke>' & chr(13)) />
					<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfset #joinTableArray[j]#Obj.commit()>'& chr(13)) />


				</cfif>



				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<!--- Check to see if a record exists in the pass through join table. --->') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfinvoke component="##variables.daos.#PassThroughTableArray[j]#Obj##" method="read_by_unique_join" returnvariable="#PassThroughTableArray[j]#Query"> ') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="#databaseObj.getIdentity(joinTableArray[j])#" value="###joinTableArray[j]#Obj.get(''#databaseObj.getIdentity(joinTableArray[j])#'')##">') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="##This.keyField##" value="##get(This.keyField)##">') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#</cfinvoke>'& chr(13)) />

				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<!--- If a record does not exist create it.--->') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfif #PassThroughTableArray[j]#Query.recordCount eq 0>') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvoke component="#configObj.get("application","CFCpathCFCStyle")#.business.#PassThroughTableArray[j]#" method="init" returnvariable="#PassThroughTableArray[j]#Obj">') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)##chr(9)#<cfinvokeargument name="DAO" value="##variables.daos.#PassThroughTableArray[j]#Obj##" />') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#</cfinvoke>'& chr(13)) />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfset #PassThroughTableArray[j]#Obj.set(#joinTableArray[j]#Obj.keyField, #joinTableArray[j]#Obj.get(#joinTableArray[j]#Obj.KeyField))>') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfset #PassThroughTableArray[j]#Obj.set(This.keyField, get(This.KeyField))>') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfset #PassThroughTableArray[j]#Obj.commit()>') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#</cfif>'& chr(13)) />

				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#<!--- Find the relationship key based on the two primary keys.  --->') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#<cfinvoke component="##variables.daos.#PassThroughTableArray[j]#Obj##" method="read_by_unique_join" returnvariable="#PassThroughTableArray[j]#Query"> ') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="#databaseObj.getIdentity(joinTableArray[j])#" value="##arguments.formValues.#databaseObj.getIdentity(joinTableArray[j])###">') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="##This.keyField##" value="##get(This.keyField)##">') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#</cfinvoke>'& chr(13)) />

				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#<!--- Instantiate the relationship based on what we found.  --->') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#<cfinvoke component="#configObj.get("application","CFCpathCFCStyle")#.business.#PassThroughTableArray[j]#" method="init" returnvariable="#PassThroughTableArray[j]#Obj">') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="DAO" value="##variables.daos.#PassThroughTableArray[j]#Obj##" />') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="KeyValue" value="###PassThroughTableArray[j]#Query.#databaseObj.getIdentity(PassThroughTableArray[j])###" />') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#</cfinvoke>') />
				<cfset RemoveFunctionObj.AddOperation('#chr(9)##chr(9)#<cfset #PassThroughTableArray[j]#Obj.destroy() />'& chr(13)) />



				<cfset tempBusiness.addFunction(AddfunctionObj.getFunction()) />
				<cfset tempBusiness.addFunction(RemoveFunctionObj.getFunction()) />
			</cfloop>
		</cfif>



		<!--- Get foreign key tables. --->
		<cfset references = databaseObj.getForeignKeyReferences(tableArray[i]) />

		<cfif ArrayLen(references)>
			<cfloop index="j" from="1" to="#ArrayLen(references)#">
				<!--- Temp thing is done because some of the queries were commin back as null. --->
				<cfset AddedTablesGateway[references[j]['table']] = "" />
				<cfset AddedTablesDAO[references[j]['table']] = "" />
				<cfif not databaseObj.isJoinTable(references[j].table)>
					<cfset functionObj.AddOperation('#chr(9)##chr(9)#<cfset temp = variables.gateways.#references[j].table#Obj.list_by_#references[j].field#(get("#tableObj.getIdentity()#")) />') />
					<cfset functionObj.AddOperation('#chr(9)##chr(9)#<cfif not isDefined("temp")><cfset temp = QueryNew("") /></cfif>') />
					<cfset functionObj.AddOperation('#chr(9)##chr(9)#<cfset variables.InternalProperties["#references[j].table#_by_#references[j].field#"] = temp />') />
				</cfif>

				<!--- Create an add objectedb by this key function. --->
				<cfset AddfunctionObj = CreateObject("component", configObj.get('cfc','function')) />
				<cfset AddfunctionObj.create(name="add#references[j].table#by#references[j].field#",returntype="void",hint="Adds a #references[j].table# object to the database based on this objected being the keyed value in #references[j].field#.", access=configObj.get('settings','defaultFunctionAccess')) />
				<cfset AddfunctionObj.addArgument("FormValues", "struct", "TRUE") />
				<cfset AddfunctionObj.AddLocalVariable("alteredFormValues") />
				<cfset AddfunctionObj.AddLocalVariable("#references[j].table#") />
				<cfset AddfunctionObj.AddLocalVariable("#references[j].table#Obj") />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfset alteredFormValues = arguments.FormValues />') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfset alteredFormValues.#references[j].field# = get("#databaseObj.getIdentity(tableArray[i])#") />') />


				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfinvoke component="#configObj.get("application","CFCpathCFCStyle")#.business.#references[j].table#" method="init" returnvariable="#references[j].table#Obj">') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="DAO" value="##variables.daos.#references[j].table#Obj##" />') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)##chr(9)#<cfinvokeargument name="FormValues" value="##alteredFormValues##" />') />
				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#</cfinvoke>') />

				<cfset AddfunctionObj.AddOperation('#chr(9)##chr(9)#<cfset #references[j].table#Obj.commit()>') />


				<cfset tempBusiness.addFunction(AddfunctionObj.getFunction()) />
			</cfloop>
		</cfif>

		<!--- Swiing through and add all of the gateway objects for tables references in these queries. --->
		<cfif ArrayLen(StructKeyArray(AddedTablesGateway)) gt 0>
			<cfloop collection="#AddedTablesGateway#" item="joinTable">
				<cfset tempBusiness.addConstructor("#chr(9)#<cfset variables.gateways.#joinTable#Obj = application.gateway.#joinTable#Obj />") />
			</cfloop>
		</cfif>

		<!--- Swiing through and add all of the dao objects for tables references in these queries. --->
		<cfif ArrayLen(StructKeyArray(AddedTablesDAO)) gt 0>
			<cfloop collection="#AddedTablesDAO#" item="joinTable">
				<cfset tempBusiness.addConstructor("#chr(9)#<cfset variables.daos.#joinTable#Obj = application.dao.#joinTable#Obj />") />
			</cfloop>
		</cfif>

		<cfif ArrayLen(StructKeyArray(AddedTablesDAO)) gt 0 OR ArrayLen(StructKeyArray(AddedTablesDAO)) gt 0>
			<cfset tempBusiness.addFunction(functionObj.getFunction()) />
		</cfif>


		<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','businessdynamic')#/#CFversionofTableName#.cfc" output="#tempBusiness.GetCFC()#" fixnewline="no" />
		- Done</li>




		<!--- Customizeable business objects. But they shouldn't be altered if they exist. --->
		<cfif not FileExists("#configObj.get('fileLocations','business')#/#CFversionofTableName#.cfc")>
		<li>Creating customizable businessCFC for table #tableArray[i]#
			<cfset tempBusiness = CreateObject("component", configObj.get('cfc','cfc')) />
			<cfset tempBusiness.Create('#configObj.get('application','cfcPathCFCStyle')#.business.dynamic.#CFversionofTableName#') />
			<cfset tempBusiness.addConstructor(StaticCommentString) />

			<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','business')#/#CFversionofTableName#.cfc" output="#tempBusiness.GetCFC()#" fixnewline="no" />
		- Done</li>
		</cfif>

</cfloop>
</cfoutput>
</ul>



</cftimer>