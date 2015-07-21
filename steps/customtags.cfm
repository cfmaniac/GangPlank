<!---    customtags.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:46:25 AM
DESCRIPTION			: Writes the Custom Tag UI components.
---->
<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfimport prefix="template" taglib="../templates/customtagtemplates" />

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forcecustomtagsRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forcecustomtagsRefresh = TRUE />
</cfif>

<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>

<cftimer label="Writing UI Components" type="inline">
<p class="alert alert-success">Writing UI Components</p>


<p>Copying default custom tags
<cfdirectory action="list" directory="#ExpandPath('.')#/templates/basecustomtags" name="customTagDir" filter="*.cfm" />

<cfloop query="customTagDir">
	<cffile action="copy" source="#directory#/#name#" destination="#configObj.get('fileLocations','customtagsdynamic')#">
</cfloop>
- done</p>


<cfloop index="i" from="1" to="#ArrayLen(tableArray)#">
	<cfset tableObj = CreateObject("component", configObj.get('cfc','table')).init(tableName=tableArray[i], databaseObj=databaseObj, configObj=configObj) />

	<cfif tableObj.hasChanged() or url.forcecustomtagsRefresh>


	<ul>

		<li>Creating List Custom Tag for - <cfoutput>#tableObj.getCFversionofTableName()#</cfoutput>
		<template:listTemplate result="cfmlCode" generatorCFCpath="#configObj.get('cfc','customtag')#" tableObj="#tableObj#" configObj="#configObj#" />
		<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','customtagsdynamic')#/#tableObj.getCFversionofTableName()#List.cfm" output="#cfmlCode#" fixnewline="no" />
		-Done </li>

		<!--- More deailing with pesky view's --->
		<cfif tableObj.isProperTable()>
			<li>Creating Read Custom Tag for - <cfoutput>#tableObj.getCFversionofTableName()#</cfoutput>
			<template:readTemplate result="cfmlCode" generatorCFCpath="#configObj.get('cfc','customtag')#" tableObj="#tableObj#" configObj="#configObj#"  />
			<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','customtagsdynamic')#/#tableObj.getCFversionofTableName()#Read.cfm" output="#cfmlCode#" fixnewline="no" />
			-Done </li>

			<li>Creating Form Custom Tag for - <cfoutput>#tableObj.getCFversionofTableName()#</cfoutput>
			<template:formTemplate result="cfmlCode" generatorCFCpath="#configObj.get('cfc','customtag')#" tableObj="#tableObj#" configObj="#configObj#"   />
			<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','customtagsdynamic')#/#tableObj.getCFversionofTableName()#Form.cfm" output="#cfmlCode#" fixnewline="no" />
			-Done </li>
		</cfif>
	</ul>
	<cfelse>
	<ul>
		<li>Table has not changed - <cfoutput>#tableObj.getCFversionofTableName()#</cfoutput></li>
	</ul>

	</cfif>
</cfloop>



</cftimer>