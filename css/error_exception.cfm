<cfimport taglib="customtags" prefix="pageElement" />

<pageElement:header displayHeader="FALSE" displayToolbar="FALSE">


<div class="error">
<h2>There has been an error</h2>



<cfif StructKeyExists(error, "RootCause") and StructKeyExists(error.RootCause, "type") and FindNoCase("GangPlank", error.RootCause.type)>
	<cfoutput>
	<p>#error.rootcause.message#</p>
	<p>#error.rootcause.detail#</p>
	</cfoutput>
<cfelseif isDefined("error.rootcause.rootcause.message") AND findNoCase("Login failed", error.rootcause.rootcause.message)>
	<p>The database settings supplied in the config file do not seem to work.  Please double check them. </p>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("Data source", error.Diagnostics) and findNoCase("could not be found.", error.Diagnostics)>
	<p>The datasource supplied in the config file could not be found.  Please double check it. </p>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("The required parameter config", error.Diagnostics)>
	<p>The config file seems to be misconfigured. Specifically: </p>
	<p><cfoutput>#error.message#</cfoutput>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("is undefined in a CFML structure referenced as part of an expression.", error.Diagnostics)>
	<p>One of the configuration settings are misset. Specifically: </p>
	<p><cfoutput>#error.message#</cfoutput>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("Invalid parameter type", error.Diagnostics)>
	<p>The config file seems to be misconfigured. Specifically: </p>
	<p><cfoutput>#error.detail#</cfoutput>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("Output Directory Defined Incorrectly", error.Diagnostics)>
	<p>Output Directory Defined Incorrectly</p>
	<p><cfoutput>#error.rootcause.detail#</cfoutput>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("GangPlank.cfc.customtag.", error.Diagnostics)>
	<p>Cannot find customtag.cfc. Make sure that config['settings']['CFCpathCFCStyle'] is set correctly.</p>
	<p><cfoutput>#error.rootcause.detail#</cfoutput>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("Required Step Skipped Step", error.Diagnostics)>
	<p>You've called a step that requires another step and can't find it.</p>
	<p><cfoutput>#error.diagnostics#</cfoutput>
<cfelseif isDefined("error.Diagnostics") AND findNoCase("There are no stored procedures", error.Diagnostics)>
	<p><cfoutput>#error.diagnostics#</cfoutput>
<cfelse>
	<p>Here are the details</p>
	<cfdump var="#error#" />

</cfif>

</div>

<pageElement:footer>
