<!---    foreignKeySelector.cfm

AUTHOR				: Terrence Ryan
CREATED				: 5/10/2007 7:29:43 PM
DESCRIPTION			: Displays the foreign key in a select box for input.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfparam name="attributes.gateway" type="any" />
<cfparam name="attributes.method" type="string" default="list_foreign_key_labels" />
<cfparam name="attributes.fieldName" type="string" />
<cfparam name="attributes.fieldValue" type="any" default="" />
<cfparam name="attributes.required" type="boolean" default="FALSE" />

<cfinvoke component="#attributes.gateway#" method="list_foreign_key_labels" returnvariable="foreignKeyQuery" />

<cfoutput>
<select name="#attributes.fieldName#">
	<cfif not attributes.required><option value="0"></option></cfif>
	<cfloop query="foreignKeyQuery">
	<option value="#foreignKeyID#"<cfif foreignKeyID eq attributes.fieldValue> selected="selected"</cfif>>#foreignKeyLabel#</option>
	</cfloop>
</select>
</cfoutput>
</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />