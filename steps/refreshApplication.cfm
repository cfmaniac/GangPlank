<!---    refreshApplication.cfm

AUTHOR				: tpryan
CREATED				: 9/21/2007 11:25:24 AM
DESCRIPTION			: Refreshes generated applications after they are built.
---->




<cfset stepTrackerObj.require("ant") />

<cftimer label="Refreshing #configObj.get('application','appname')#" type="inline">
<cfoutput><h2>Refreshing #configObj.get('application','appname')#</h2></cfoutput>
<cfset Antfile = "#configObj.get('filelocations','output')#/build.xml" />


<!---cfant buildFile="#Antfile#" messages="message" target="Refresh Application"
		defaultDirectory="#configObj.get('filelocations','logs')#" anthome="#configObj.get('filelocations','logs')#"/--->

<!---pre>
<cfoutput>
#message#
</cfoutput>
</pre--->


</cftimer>