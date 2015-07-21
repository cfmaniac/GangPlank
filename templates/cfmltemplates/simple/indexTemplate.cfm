<!---    indexTemplate.cfm 

CREATED				: Terrence Ryan 
DESCRIPTION			: Template for the index.cfm file in the output CRUD application.
					 Did it as custom tag instead of a function because it was easier to edit. 
					 plus one template to output file ratio seems more understandable in my mind.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.result" type="string" default="result" />
<cfparam name="attributes.objectList" type="string" default="" />

<cfset cfmloutput = "" />

<cfif len(attributes.objectList) gt 0>

	<cfset cfmloutput = cfmloutput & '<h2>Scaffolds</h2>' & chr(13) />		
	<cfset cfmloutput = cfmloutput & '<ul>' & chr(13) />	
	<cfloop list="#attributes.objectList#" index="objectName">
		<cfset cfmloutput = cfmloutput & chr(9) & '<li><a href="#objectName#.cfm">#objectName#</a></li>' & chr(13) />	
	</cfloop>
	<cfset cfmloutput = cfmloutput & '</ul>' & chr(13) />	

</cfif>



<cfset caller[attributes.result]  = cfmloutput />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />