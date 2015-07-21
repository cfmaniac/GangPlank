<!---    navDoc.cfm

AUTHOR				: tpryan
CREATED				: 9/18/2007 11:15:30 AM
DESCRIPTION			: Encaspsulates documentation navigation.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfset navArray = ArrayNew(1) />
<cfset linkStruct = {title="Overview", link="#application.relativePath#/docs/index.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="Installation", link="#application.relativePath#/docs/installation.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="Config Reference", link="#application.relativePath#/docs/config.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="CFC Reference", link="#application.relativePath#/docs/cfc.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="Steps", link="#application.relativePath#/docs/steps.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="Release Notes", link="#application.relativePath#/docs/notes.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="FAQ's", link="#application.relativePath#/docs/faqs.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="Conventions", link="#application.relativePath#/docs/conventions.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>
<cfset linkStruct = {title="Database Features", link="#application.relativePath#/docs/databasefeatures.cfm"} />
<cfset ArrayAppend(navArray,linkStruct )>

<cfoutput>
<ul id="toolbarsecondary">
<cfloop array="#navArray#" index="linkStruct">
	<cfif FindNoCase(linkStruct.link, cgi.script_name)>
		<li>#linkStruct.title#</li>
	<cfelse>
		<li><a href="#linkStruct.link#" title="#linkStruct.title#">#linkStruct.title#</a></li>
	</cfif>

</cfloop>


</ul></cfoutput>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />