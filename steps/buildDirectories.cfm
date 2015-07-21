<!---    buildDirectories.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:37:03 AM
DESCRIPTION			: Builds all of the directories that the generated application will use.
---->


<cftimer label="Building Directory Structure" type="inline">
<p class="alert alert-success">Building Directory Structure</p>

<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','output')) />
<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','cfml')) />
<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','images')) />
<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','css')) />
<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','sql')) />
<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','cfc')) />
<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','temp')) />


<cfif stepTrackerObj.Exists("customtags")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','logs')) />
</cfif>

<cfif stepTrackerObj.Exists("customtags")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','customtags')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','customtagsdynamic')) />
</cfif>

<cfif stepTrackerObj.Exists("cfc_dao_gateway")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','dao')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','gateway')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','dynamicgateway')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','dynamicdao')) />
</cfif>

<cfif stepTrackerObj.Exists("cfc_business")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','business')) />
</cfif>

<cfif stepTrackerObj.Exists("cfc_business_dynamic")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','business')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','businessdynamic')) />
</cfif>

<cfif stepTrackerObj.Exists("cfunit")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','test')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','testdao')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','testdynamicdao')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','testgateway')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','testdynamicgateway')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','testbusiness')) />
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','testinterface')) />
</cfif>



<cfif stepTrackerObj.Exists("buildDocumentation")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','docs')) />
</cfif>

<cfif stepTrackerObj.Exists("coldspringGenerateConfig")>
	<cfset application.utilityObj.conditionallyCreateDirectory(configObj.get('fileLocations','config')) />
</cfif>


</cftimer>