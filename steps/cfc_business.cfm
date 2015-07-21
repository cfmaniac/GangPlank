<!---    cfc_business.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:40:24 AM
DESCRIPTION			: Builds business objects.
---->


<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceBusinessRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forceBusinessRefresh = TRUE />
</cfif>

<cfset CFCArray = ArrayNew(1) />

<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>


<cftimer label="Writing Functions and CFC for Business Objects" type="inline">
<p class="alert alert-success">Writing Functions and CFC for Business Objects</p>

<p>Create Base Objects
<cfif not FileExists(configObj.get('fileLocations','business') & "/baseBusiness.cfc") or url.forceBusinessRefresh>
	<cffile action="copy" source="#expandPath('.')#/templates/baseCFCs/#configObj.get('settings','applicationTemplate')#/baseBusiness.cfc" destination="#configObj.get('fileLocations','business')#/baseBusiness.cfc" />
</cfif>
-Done </p>


<p>Creating business objects for items.</p>

<cfset commentString = "<!--- This CFC is static.  You may customize it. It will not be overwritten.  --->" & chr(13)/>
<ul>
<cfoutput>
<cfloop index="i" from="1" to="#arrayLen(tableArray)#">

		<cfset CFversionofTableName = databaseObj.getCFversionofTableName(tableArray[i]) />

		<li>Creating businessCFC for table #CFversionofTableName#

		

		<!--- Added business objects. But they shouldn't be altered if they exist. --->
		<cfif not FileExists("#configObj.get('fileLocations','business')#/#CFversionofTableName#.cfc")>
			<cfobject name="tempBusiness" component="#configObj.get('cfc','cfc')#" />

			<cfset tempBusiness.Create('baseBusiness') />
			<cfset tempBusiness.addConstructor(commentString) />
			<cfset tempBusiness.addConstructor("<cfset this.name=""business.#CFversionofTableName#"" />#chr(10)# #chr(10)#") />

			<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','business')#/#CFversionofTableName#.cfc" output="#tempBusiness.GetCFC()#" fixnewline="no" />

		</cfif>
		- Done</li>
</cfloop>
</cfoutput>
</ul>



</cftimer>