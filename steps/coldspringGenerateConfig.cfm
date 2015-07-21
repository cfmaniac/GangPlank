<!---    coldspringGenerateConfig.cfm

AUTHOR				: tpryan
CREATED				: 11/3/2007 3:51:27 PM
DESCRIPTION			: Creates ColdSpring config file
---->

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceColdSpringRefresh" type="boolean" default="FALSE" />

<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfif url.forceRefresh>
	<cfset url.forceColdSpringRefresh = TRUE />
</cfif>

<cftimer label="Writing ColdSpring Config" type="inline">
	<h2>Writing ColdSpring Config</h2>

	<cfif not structKeyExists(variables, "tableArray")>
		<cfset tableArray = databaseObj.getTableArray() />
	</cfif>

	<cfset tableData = databaseObj.getTableInfo() />

	<cfset csXML = "" />
	<cfset csXML = csXML.concat('<?xml version="1.0" encoding="iso-8859-1"?>' & chr(13) & chr(10)) />
	<cfset csXML = csXML.concat(chr(9) & '<beans>' & chr(13) & chr(10)) />

	<cfset beanContents = "" />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '<constructor-arg name="datasource">' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & chr(9) & '<value>${datasource}</value>' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '</constructor-arg>' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '<constructor-arg name="dbusername">' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & chr(9) & '<value>${dbusername}</value>' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '</constructor-arg>' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '<constructor-arg name="dbpassword">' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & chr(9) & '<value>${dbpassword}</value>' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '</constructor-arg>' & chr(13) & chr(10)) />
	<cfset beanContents = beanContents.concat(chr(9) & chr(9) & chr(9) & '<singleton>TRUE</singleton>' & chr(13) & chr(10)) />

	<ul>
	<cfloop index="i" from="1" to="#ArrayLen(tableArray)#">
		<li>Generating bean config for <cfoutput>#tableArray[i]#</cfoutput>
		<cfset beanloop = "" />
		<cfset beanloop = beanloop.concat(chr(9) & chr(9) & '<bean id="dao.#tableArray[i]#" class="' & configObj.get('application','CFCpathCFCStyle') & '.dao.#tableArray[i]#">' & chr(13) & chr(10)) />
		<cfset beanloop = beanloop.concat(beanContents) />
		<cfset beanloop = beanloop.concat(chr(9) & chr(9) & '</bean>' & chr(13) & chr(10)) />

		<cfset beanloop = beanloop.concat(chr(9) & chr(9) & '<bean id="gateway.#tableArray[i]#" class="' & configObj.get('application','CFCpathCFCStyle') &  '.gateway.#tableArray[i]#">' & chr(13) & chr(10)) />
		<cfset beanloop = beanloop.concat(beanContents) />
		<cfset beanloop = beanloop.concat(chr(9) & chr(9) & '</bean>' & chr(13) & chr(10)) />
		<cfset csXML = csXML.concat(beanloop) />
		- done </p>
	</cfloop>
	</ul>

	<cfset csXML = csXML.concat(chr(9) & '</beans>' & chr(13) & chr(10)) />

	<cffile action="write" file="#configObj.get('fileLocations','config')#\csConfig.xml" output="#csXML#" />

</cftimer>
