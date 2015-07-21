<!---    cfms.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:48:22 AM
DESCRIPTION			: Builds the weak controlers for the ui.
---->
<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceCFMLRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forceCFMLRefresh = TRUE />
</cfif>


<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>

<cftimer label="Writing UI Controllers" type="inline">
<p class="alert alert-success">Writing UI Controllers</p>

<!--- Need to make sure that cfimports in created files will be properly pathed if the CFML path is below the output path. --->
<cfif FindNoCase(configObj.get('filelocations','output'), configObj.get('filelocations','cfml')) AND
		len(configObj.get('filelocations','cfml')) gt len(configObj.get('filelocations','output'))>
	<cfset levelDifference =  ArrayLen(ListToArray(Replace(configObj.get('filelocations','cfml'), configObj.get('filelocations','output'), "", "ALL"), "/")) />
<cfelse>
	<cfset levelDifference = 0 />
</cfif>

<cfimport prefix="template" taglib="../templates/cfmltemplates" />

<p>Adding CSS templates
<cfdirectory action="list" directory="#ExpandPath('.')#/templates/csstemplates" name="cssDir" filter="*.css" />
<cfloop query="cssDir">
	<cffile action="copy" source="#directory#/#name#" destination="#configObj.get('fileLocations','css')#">
</cfloop>
-Done</p>

<p>Adding Logo File

<cfif configObj.get('ui','logoBuild') AND (not FileExists("#configObj.get('filelocations','images')#/logo.jpg") or url.forceCFMLRefresh) >

	<cfset fontStruct= StructNew() />
	<cfset fontStruct.font= configObj.get('ui','logoFont') />
	<cfset fontStruct.size= "30" />
	<cfset fontStruct.style= "bold" />
	<cfset fontStruct.strikethrough = "no" />
	<cfset fontStruct.underline = "no" />

	<cfset baseImage = application.utilityObj.writeWeb20Logo(text=configObj.get('application','appname'), height=50, fontstruct="#fontStruct#") />
	<cfimage  action = "write"  destination = "#configObj.get('filelocations','images')#/logo.jpg"  source = "#baseImage#" overwrite = "yes">

	<cfset baseImage = application.utilityObj.writeWeb20Logo(text=configObj.get('application','appname'), height=50, fontStruct="#fontStruct#") />
	<cfimage  action = "write"  destination = "#configObj.get('filelocations','images')#\logo.jpg"  source = "#baseImage#" overwrite = "yes">
</cfif>



-done</p>



<p>Creating Custom Pages for Items</p>
<ul>
<cfloop index="i" from="1" to="#ArrayLen(tableArray)#">
	
	
	<cfset tableObj = CreateObject("component", configObj.get('cfc','table')).init(tableName=tableArray[i], databaseObj=databaseObj, configObj=configObj) />
	<!--- Only create the object.cfm  files if it doesn't exist already, or the developer is forcing a refresh.  --->
	<cfif not FileExists("#configObj.get('filelocations','cfml')#/#tableArray[i]#.cfm") or url.forceCFMLRefresh>
		
		<li>Creating UI for - <cfoutput>#tableObj.getCFversionofTableName()#</cfoutput>
		<template:objectTemplate result="cfmlCode" levelDifference="#leveldifference#" tableObj="#tableObj#"  configObj="#configObj#" databaseObj="#databaseObj#" />
		<cffile action="write" addnewline="yes" file="#configObj.get('filelocations','cfml')#/#tableObj.getCFversionofTableName()#.cfm" output="#cfmlCode#" fixnewline="no" />
		- Done</li>
	<cfelse>
		<li>UI for - <cfoutput>#tableObj.getCFversionofTableName()#</cfoutput>- Already Exists</li>
	</cfif>

</cfloop>
</ul>

<!--- Only create the application.cfm if it doesn't exist, or the developer is forcing a refresh.  --->
<cfif not FileExists("#configObj.get('filelocations','cfml')#/application.cfm") or url.forceCFMLRefresh >
<p>Creating Application.cfm file
	<template:applicationTemplate result="cfmlCode" configObj="#configObj#"	/>
	<cffile action="write" addnewline="yes" file="#configObj.get('filelocations','cfml')#/Application.cfm" output="#cfmlCode#" fixnewline="no" />
- Done </p>
</cfif>

<!--- Only create the index.cfm if it doesn't exist, or the developer is forcing a refresh.  --->
<cfif not FileExists("#configObj.get('filelocations','cfml')#/index.cfm") or url.forceCFMLRefresh >

<p>Creating index.cfm file
	<cfset objectList=ArrayToList(tableArray) />
	<template:indexTemplate result="cfmlCode" objectList="#objectList#" configObj="#configObj#">
	<cffile action="write" addnewline="yes" file="#configObj.get('filelocations','cfml')#/index.cfm" output="#cfmlCode#" fixnewline="no" />
- Done </p>
</cfif>

<!--- Only create the onRequestEnd.cfm if it doesn't exist, or the developer is forcing a refresh.  --->
<cfif not FileExists("#configObj.get('filelocations','cfml')#/onRequestEnd.cfm") or url.forceCFMLRefresh >
<p>Creating onRequestEnd.cfm file
	<template:onRequestEndTemplate result="cfmlCode" configObj="#configObj#" />
	<cffile action="write" addnewline="yes" file="#configObj.get('filelocations','cfml')#/onRequestEnd.cfm" output="#cfmlCode#" fixnewline="no" />
- Done </p>
</cfif>



</cftimer>