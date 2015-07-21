<!---    cfunitTest.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:41:28 AM
DESCRIPTION			: Another example step that shows the running of the cfunit tests.

Requires that you follow the directions listsed here:
http://www.numtopia.com/terry/blog/archives/2007/09/cfunit_and_cfant.cfm
---->


<cfset stepTrackerObj.require("cfunit") />
<cfset stepTrackerObj.require("ant") />
<cfset stepTrackerObj.require("refreshApplication") />

<cftimer label="Running CFUnit Tests" type="inline">
<h2>Running CFUnit Tests</h2>
<cfset Antfile = "#configObj.get('filelocations','output')#/build.xml" />


<!--cfant buildFile="#Antfile#" messages="message" target="CFUnitTest"
		defaultDirectory="#configObj.get('filelocations','logs')#" anthome="#configObj.get('filelocations','logs')#"/--->

<pre>
<cfoutput>
#message#
</cfoutput>
</pre>


</cftimer>