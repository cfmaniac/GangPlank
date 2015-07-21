<!---    onRequestEndTemplate.cfm 

CREATED				: Terrence Ryan 
DESCRIPTION			: Template for the onRequestEnd.cfm file in the output CRUD application.
					 Did it as custom tag instead of a function because it was easier to edit. 
					 plus one template to output file ratio seems more understandable in my mind.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.result" type="string" default="result" />
<strong>with Default Template</strong>

<cfset cfmloutput = "" />
<cfset cfmloutput = cfmloutput & '</body>' & chr(13) />
<cfset cfmloutput = cfmloutput & '</html>' & chr(13) />

<cfset caller[attributes.result]  = cfmloutput />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />