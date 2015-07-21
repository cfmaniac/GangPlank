<!---    onRequestEndTemplate.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Template for the onRequestEnd.cfm file in the output CRUD application.
					 Did it as custom tag instead of a function because it was easier to edit.
					 plus one template to output file ratio seems more understandable in my mind.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.result" type="string" default="result" />
<cfparam name="attributes.leveldifference" type="numeric" default="0" />
<cfparam name="attributes.tableObj" type="any" />
<cfparam name="attributes.databaseObj" type="any" />
<cfparam name="attributes.displayCrud" type="boolean" default="#attributes.tableObj.isProperTable()#" />


<cfif attributes.tableObj.hasForeignKeys()>
	<cfset selectMethod =  "select_with_fk" />
	<cfset listMethod =  "list_with_fk" />
<cfelse>
	<cfset selectMethod =  "select" />
	<cfset listMethod =  "list" />
</cfif>

<!--- Get linked tables.  --->
<cfset linkedTables = attributes.tableObj.getForeignKeyReferences() />
<cfset pathThroughTables = attributes.tableObj.getPassThroughTableList() />
<cfset JoinTableTables = attributes.tableObj.getJoinTableList() />

<!--- Prevents views with Spaces from causing problems. --->
<cfset CFversionofTableName = attributes.tableObj.getCFversionofTableName() />

<strong>with BusinessDynamic Template</strong>

<!--- Need to make sure that cfimports in created files will be properly pathed if the CFML path is below the output path. --->
<cfset pathCorrection = "" />
<cfif attributes.leveldifference  gt 0>
	<cfloop index="i" from="1" to="#attributes.leveldifference#">
		<cfset pathCorrection = pathCorrection.concat("../") />
	</cfloop>
</cfif>
<cfset cfmloutput = "" />
<cfset cfmloutput = cfmloutput & '<!--- ' & attributes.tableObj.GetTableName() & '.cfm --->' & chr(13) />
<cfset cfmloutput = cfmloutput & '<cfparam name="url.message" type="string" default="" />' & chr(13) />
<cfif attributes.displayCRUD>
	<cfset cfmloutput = cfmloutput & '<cfparam name="url.' & attributes.tableObj.getIdentity() & '" type="numeric" default="0" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '<cfparam name="form.' & attributes.tableObj.getIdentity() & '" type="numeric" default="0" />' & chr(13) & chr(13)  />
</cfif>

<cfset cfmloutput = cfmloutput & '<cfif StructKeyExists(form, "SUBMIT") and FindNoCase("save", form.submit)>' & chr(13) />
<cfset cfmloutput = cfmloutput & '	<cfparam name="url.method" type="string" default="edit_process" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '</cfif>' & chr(13) & chr(13)/>
<cfset cfmloutput = cfmloutput & '<cfparam name="url.method" type="string" default="list" />' & chr(13) />

<cfset cfmloutput = cfmloutput & '<cfimport prefix="display" taglib="#pathCorrection#customtags"/>' & chr(13)/>
<cfset cfmloutput = cfmloutput & '<cfimport prefix="display" taglib="#pathCorrection#customtags/dynamic"/>' & chr(13) & chr(13)/>


<cfset cfmloutput = cfmloutput & '<cfswitch expression="##url.method##">' & chr(13) & chr(13) />

<cfset cfmloutput = cfmloutput & '	<cfcase value="list">' & chr(13) />
<cfset cfmloutput = cfmloutput & '		<cfinvoke component="##application.gateway.' & CFversionofTableName & 'Obj##" method="#listMethod#" returnvariable="listQuery" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '		<h2>' & attributes.tableObj.GetTableName() & '</h2>' & chr(13) />

<!--- Ensure that views don't screw anything up.  --->
<cfif attributes.displayCRUD>
	<cfset cfmloutput = cfmloutput & '		<cfoutput><p><a href="index.cfm">Main</a> / <a href="##cgi.script_name##?method=edit">Add</a></p></cfoutput>' & chr(13) />
<cfelse>
	<cfset cfmloutput = cfmloutput & '		<cfoutput><p><a href="index.cfm">Main</a></cfoutput>' & chr(13) />
</cfif>
<cfset cfmloutput = cfmloutput & '		<display:' & CFversionofTableName & 'List listQuery="##listQuery##" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />

<!--- Ensure that views don't screw anything up.  --->
<cfif attributes.displayCRUD>
	<cfset cfmloutput = cfmloutput & '	<cfcase value="read">' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#ReadObj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="WithLinks" value="TRUE" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<cfif StructKeyExists(#CFversionofTableName#ReadObj,"getLinks" )>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfset #CFversionofTableName#ReadObj.getLinks() />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfif>' & chr(13) & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<h2>' & attributes.tableObj.GetTableName() & '</h2>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfoutput><p><a href="index.cfm">Main</a> / <a href="##cgi.script_name##">List</a> / <a href="##cgi.script_name##?method=edit&amp;#attributes.tableObj.getIdentity()#=###attributes.tableObj.getIdentity()###">Edit</a> / <a href="##cgi.script_name##?method=edit">Add</a></p></cfoutput>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<display:' & CFversionofTableName & 'Read ' & attributes.tableObj.getIdentity() & '="##url.' & attributes.tableObj.getIdentity() & '##" ' & CFversionofTableName & 'Obj="##' & CFversionofTableName &'ReadObj##"/>' & chr(13) />
	<cfset cfmloutput = cfmloutput & chr(13) & chr(13) />


	<!--- Added all UI for linked tables --->
	<cfif Arraylen(linkedTables) gt 0>
		<cfloop index="i" from="1" to="#ArrayLen(linkedTables)#">
			<cfif not attributes.databaseObj.isJoinTable(linkedTables[i]['table'])>

				<cfset cfmloutput = cfmloutput & '		<cfif #CFversionofTableName#ReadObj.get("' & linkedTables[i]['table'] & "_by_" & linkedTables[i]['field'] &'").recordCount gt 0>' & chr(13) />
				<cfset cfmloutput = cfmloutput & '			<h3>' & linkedTables[i]['table'] & " by " & linkedTables[i]['field'] & '</h3>' & chr(13) />
				<cfset cfmloutput = cfmloutput & '			<display:' & linkedTables[i]['table'] & 'List listQuery="###CFversionofTableName#ReadObj.get("' & linkedTables[i]['table'] & "_by_" & linkedTables[i]['field'] &'")##" />' & chr(13) />
				<cfset cfmloutput = cfmloutput & '		</cfif>' & chr(13) & chr(13) />


				<cfset cfmloutput = cfmloutput & '		<h3>Add ' & linkedTables[i]['table'] & " by " & linkedTables[i]['field'] & '</h3>' & chr(13) />
				<cfset cfmloutput = cfmloutput & '		<cfinvoke component="' & attributes.configObj.get('application','CFCpathCFCStyle') & '.business.' & linkedTables[i]['table'] & '" method="init" returnvariable="' & linkedTables[i]['table'] & 'Obj">' & chr(13) />
				<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & linkedTables[i]['table'] & 'Obj##" />' & chr(13) />
				<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />

				<cfset cfmloutput = cfmloutput & '		<display:' & linkedTables[i]['table'] & 'Form ' & linkedTables[i]['table'] & 'Obj="##' & linkedTables[i]['table'] & 'Obj##" message="##url.message##" display' & linkedTables[i]['field'] & '="FALSE"  actionTarget="##cgi.script_name##?method=add' & linkedTables[i]['table'] & 'by' & linkedTables[i]['field'] & '&' & attributes.tableObj.getIdentity() & '=##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) & chr(13) & chr(13)/>
			</cfif>

		</cfloop>
	</cfif>

	<!--- Added all UI for pass through tables --->
	<cfif ListLen(JoinTableTables) gt 0>
		<cfloop list="#JoinTableTables#" index="joinedTable">
			<cfset cfmloutput = cfmloutput & '		<cfif #CFversionofTableName#ReadObj.get("' & joinedTable &'").recordCount gt 0>' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<h3>' & joinedTable & '</h3>' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<display:' & joinedTable & 'List listQuery="###CFversionofTableName#ReadObj.get("' & joinedTable &'")##" deleteTarget="##cgi.script_name##?method=remove' & joinedTable & '&' & attributes.tableObj.getIdentity() & '=##' & attributes.tableObj.getIdentity() & '##&amp;"  />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		</cfif>' & chr(13) & chr(13) />


			<cfset cfmloutput = cfmloutput & '		<h3>Add ' & joinedTable & '</h3>' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfinvoke component="' & attributes.configObj.get('application','CFCpathCFCStyle') & '.business.' & joinedTable & '" method="init" returnvariable="' & joinedTable & 'Obj">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & joinedTable & 'Obj##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />

			<cfset cfmloutput = cfmloutput & '		<display:' & joinedTable & 'Form ' & joinedTable & 'Obj="##' & joinedTable & 'Obj##" message="##url.message##" display' & attributes.databaseObj.getIdentity(joinedTable) & '="FALSE"  actionTarget="##cgi.script_name##?method=add' & joinedTable & '&' & attributes.tableObj.getIdentity() & '=##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) & chr(13) & chr(13)/>
		</cfloop>
	</cfif>


	<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />

	<cfset cfmloutput = cfmloutput & '	<cfcase value="edit">' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfif url.' & attributes.tableObj.getIdentity() & ' gt 0>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfinvokeargument name="KeyValue" value="##url.' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			</cfif>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<h2>' & attributes.tableObj.GetTableName() & '</h2>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfoutput><p><a href="index.cfm">Main</a> / <a href="##cgi.script_name##">List</a> <cfif url.' & attributes.tableObj.getIdentity() & ' gt 0>/ <a href="##cgi.script_name##?method=read&amp;#attributes.tableObj.getIdentity()#=###attributes.tableObj.getIdentity()###">Read</a> / <a href="##cgi.script_name##?method=edit">Add</a></cfif></p></cfoutput>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<display:' & CFversionofTableName & 'Form ' & CFversionofTableName & 'Obj="##' & CFversionofTableName &'Obj##" message="##url.message##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13)/>

	<cfset cfmloutput = cfmloutput & '	<cfcase value="edit_process">' & chr(13) & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfif form.' & attributes.tableObj.getIdentity() & ' gt 0>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfinvokeargument name="KeyValue" value="##form.' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			</cfif>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="FormValues" value="##form##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.commit()>' & chr(13) />

	<cfset cfmloutput = cfmloutput & '			<cfif form.' & attributes.tableObj.getIdentity() & ' gt 0>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfset message = "updated#CFversionofTableName#" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfelse>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfset message = "added#CFversionofTableName#" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			</cfif>' & chr(13) />




	<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=edit&' & attributes.tableObj.getIdentity() &'=###CFversionofTableName#Obj.Get("' & attributes.tableObj.getIdentity() & '")##&message=##message##" addtoken="FALSE" />' & chr(13) />

	<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13 )/>

	<cfset cfmloutput = cfmloutput & '	<cfcase value="delete_process">' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.destroy()>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=list" addtoken="FALSE" />' & chr(13) />

	<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />




	<cfif Arraylen(linkedTables) gt 0>
		<cfloop index="i" from="1" to="#ArrayLen(linkedTables)#">
			<cfset cfmloutput = cfmloutput & '	<cfcase value="add'& linkedTables[i]['table'] & 'by' & linkedTables[i]['field']  &'">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="WithLinks" value="FALSE" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.add'& linkedTables[i]['table'] & 'by' & linkedTables[i]['field']  &'(form) />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=read&' & attributes.tableObj.getIdentity() &'=###CFversionofTableName#Obj.Get("' & attributes.tableObj.getIdentity() & '")##&message=added#linkedTables[i]['table']#" addtoken="FALSE" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />
		</cfloop>
	</cfif>

	<!--- Added all UI for pass through tables --->
	<cfif ListLen(JoinTableTables) gt 0>
		<cfloop list="#JoinTableTables#" index="joinedTable">
			<cfset cfmloutput = cfmloutput & '	<cfcase value="add'& joinedTable  &'">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="WithLinks" value="FALSE" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.add'& joinedTable  &'(form) />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=read&' & attributes.tableObj.getIdentity() &'=###CFversionofTableName#Obj.Get("' & attributes.tableObj.getIdentity() & '")##&message=added#joinedTable#" addtoken="FALSE" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />

			<cfset cfmloutput = cfmloutput & '	<cfcase value="remove'& joinedTable  &'">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="WithLinks" value="FALSE" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.remove'& joinedTable  &'(url) />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=read&' & attributes.tableObj.getIdentity() &'=###CFversionofTableName#Obj.Get("' & attributes.tableObj.getIdentity() & '")##&message=removed#joinedTable#" addtoken="FALSE" />' & chr(13) />
			<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />


		</cfloop>
	</cfif>


</cfif>
<cfset cfmloutput = cfmloutput & '</cfswitch>' & chr(13) />

<cfset caller[attributes.result]  = cfmloutput />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />