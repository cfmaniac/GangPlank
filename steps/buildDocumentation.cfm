<!---    buildDocumentation.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:34:40 AM
DESCRIPTION			: A quick and dirty documenter example of a step. It builds cfexplorer docs for all of your cfc's.
---->

<cftimer label="Building Documentation" type="inline">
<p class="alert alert-success">Building Documentation</p>

<cfset cfcExplorerObj = createObject("component", "CFIDE.componentutils.cfcexplorer") />

<cfdirectory action="list" recurse="true" directory="#configObj.get('filelocations','cfc')#" name="cfcList" type="file" filter="*.cfc" />

<cfsavecontent variable="indexContents">
<h2>CFC Documentation</h2>
<ul>
</cfsavecontent>

<cffile action="write" file="#configObj.get('filelocations','docs')#\index.cfm" output="#indexContents#" />

<cfloop query="cfcList">
	<cfset filePath =  cfcList.directory & "\" & cfcList.name />
	<cfset path = "\" & ReplaceNoCase(filePath, configObj.get('filelocations','webroot'), "", "ONCE") />

	<cfset CFCPath = cfcList.directory & "\" & ListFirst(cfcList.name, '.') />
	<cfset CFCPath = ReplaceNoCase(CFCPath, configObj.get('filelocations','webroot'), "", "ONCE") />
	<cfset CFCPath = Replace(CFCPath, "\", ".", "ALL") />

	<cfsavecontent variable="docContents">
		<cfset cfcExplorerObj.getcfcinhtml(NAME=CFCPath, PATH=path) />
	</cfsavecontent>

	<cffile action="write" file="#configObj.get('filelocations','docs')#\#CFCPath#.html" output="#docContents#" />

	<cfoutput>
	<cfsavecontent variable="indexContents">
	<li><a href="#CFCPath#.html">#CFCPath#</a></li>
	</cfsavecontent>
	</cfoutput>

	<cffile action="append" file="#configObj.get('filelocations','docs')#\index.cfm" output="#indexContents#" />

</cfloop>

<cfsavecontent variable="indexContents">
</ul>
</cfsavecontent>

<cffile action="append" file="#configObj.get('filelocations','docs')#\index.cfm" output="#indexContents#" />

</cftimer>