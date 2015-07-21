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
<cfparam name="attributes.displayCrud" type="boolean" default="#attributes.tableObj.isProperTable()#" />


<cfif attributes.tableObj.hasForeignKeys()>
	<cfset selectMethod =  "select_with_fk" />
	<cfset listMethod =  "list_with_fk" />
<cfelse>
	<cfset selectMethod =  "select" />
	<cfset listMethod =  "list" />
</cfif>


<!--- Prevents views with Spaces from causing problems. --->
<cfset CFversionofTableName = attributes.tableObj.getCFversionofTableName() />

<strong>with Default Template</strong>

<!--- Need to make sure that cfimports in created files will be properly pathed if the CFML path is below the output path. --->
<cfset pathCorrection = "" />
<cfif attributes.leveldifference  gt 0>
	<cfloop index="i" from="1" to="#attributes.leveldifference#">
		<cfset pathCorrection = pathCorrection.concat("../") />
	</cfloop>
</cfif>
<cfset cfmloutput = "" />
<cfset cfmloutput = cfmloutput & '<!--- ' & attributes.tableObj.GetTableName() & '.cfm --->' & chr(13) />
<cfset cfmloutput = cfmloutput & '<cfparam name="url.method" type="string" default="list" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '<cfparam name="url.message" type="string" default="" />' & chr(13) />
<cfif attributes.displayCRUD>
	<cfset cfmloutput = cfmloutput & '<cfparam name="url.' & attributes.tableObj.getIdentity() & '" type="numeric" default="0" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '<cfparam name="form.' & attributes.tableObj.getIdentity() & '" type="numeric" default="0" />' & chr(13) & chr(13)  />
</cfif>
<cfset cfmloutput = cfmloutput & '<cfimport prefix="display" taglib="#pathCorrection#customtags"/>' & chr(13)/>
<cfset cfmloutput = cfmloutput & '<cfimport prefix="display" taglib="#pathCorrection#customtags/dynamic"/>' & chr(13) & chr(13)/>
<cfset cfmloutput = cfmloutput & '<cfif StructKeyExists(form, "SUBMIT") and FindNoCase("save", form.submit)>' & chr(13) />
<cfset cfmloutput = cfmloutput & '	<cfset url.method = "edit_process" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '</cfif>' & chr(13) & chr(13)/>
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

	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="WithLinks" value="TRUE" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<h2>' & attributes.tableObj.GetTableName() & '</h2>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfoutput><p><a href="index.cfm">Main</a> / <a href="##cgi.script_name##">List</a> / <a href="##cgi.script_name##?method=edit&amp;#attributes.tableObj.getIdentity()#=###attributes.tableObj.getIdentity()###">Edit</a> / <a href="##cgi.script_name##?method=edit">Add</a></p></cfoutput>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<display:' & CFversionofTableName & 'Read ' & attributes.tableObj.getIdentity() & '="##url.' & attributes.tableObj.getIdentity() & '##" ' & CFversionofTableName & 'Obj="##' & CFversionofTableName &'Obj##"/>' & chr(13) />

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

	<cfset cfmloutput = cfmloutput & '	<cfcase value="edit_process">' & chr(13) />


	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfif form.' & attributes.tableObj.getIdentity() & ' gt 0>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfinvokeargument name="KeyValue" value="##form.' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			</cfif>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="FormValues" value="##form##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.commit()>' & chr(13) />

	<cfset cfmloutput = cfmloutput & '			<cfif form.' & attributes.tableObj.getIdentity() & ' gt 0>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfset message = "updated" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfelse>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '				<cfset message = "added" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			</cfif>' & chr(13) />




	<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=edit&' & attributes.tableObj.getIdentity() &'=###CFversionofTableName#Obj.Get("' & attributes.tableObj.getIdentity() & '")##&message=##message##" />' & chr(13) />

	<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13 )/>

	<cfset cfmloutput = cfmloutput & '	<cfcase value="delete_process">' & chr(13) />

	<cfset cfmloutput = cfmloutput & '		<cfinvoke component="#attributes.configObj.get('application','CFCpathCFCStyle')#.business.#CFversionofTableName#" method="init" returnvariable="#CFversionofTableName#Obj">' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="KeyValue" value="##' & attributes.tableObj.getIdentity() & '##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '			<cfinvokeargument name="DAO" value="##application.dao.' & CFversionofTableName & 'Obj##" />' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		</cfinvoke>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cfset #CFversionofTableName#Obj.destroy()>' & chr(13) />
	<cfset cfmloutput = cfmloutput & '		<cflocation url="##cgi.script_name##?method=list" />' & chr(13) />

	<cfset cfmloutput = cfmloutput & '	</cfcase>' & chr(13) & chr(13) />
</cfif>
<cfset cfmloutput = cfmloutput & '</cfswitch>' & chr(13) />

<cfset caller[attributes.result]  = cfmloutput />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />