<!---    ant.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:36:36 AM
DESCRIPTION			: Builds Ant build files.
---->
<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceANTRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forceANTRefresh = TRUE />
</cfif>


<cfif stepTrackerObj.Exists("cfunit")>
	<cfdirectory action="list" directory="#configObj.get('fileLocations','test')#" recurse="true" filter="*.cfc" name="TestDirectory" />
</cfif>

<cftimer label="Writing Ant File" type="inline">
<h2>Writing Ant File</h2>



<cfif not FileExists("#configObj.get('filelocations','output')#/build.xml") or url.forceANTRefresh>
	<cfoutput>
	<cfxml variable="AntFileToWrite">
	<?xml version="1.0" encoding="iso-8859-1"?>
	<project name="#configObj.get('application','appname')#" default="Rebuild and Refresh">
		<property name="GangPlankURL" value="http://#cgi.server_name##cgi.script_name#" />
		<property name="appURL" value="#configObj.get('application','url')#" />
		<property name="logPath" value="#configObj.get('fileLocations','logs')#" />
		<property name="appName" value="#configObj.get('application','appname')#" />

		<cfif stepTrackerObj.Exists("cfunit")>
		<taskdef name="CFUnit" classname="net.sourceforge.cfunit.ant.CFUnit"/>
		</cfif>


		<target name="Run GangPlank">
				<echo message="Rebuild Via GangPlank"/>
				<get src="${GangPlankURL}?method=run&amp;appName=${appName}" dest="${logPath}\GangPlankRefresh.html"/>
		</target>

		<target name="Run GangPlank Full Refresh">
				<echo message="Rebuild Via GangPlank in Full Refresh Mode"/>
				<get src="${GangPlankURL}?method=run&amp;appName=${appName}&amp;forceRefresh=TRUE" dest="${logPath}\GangPlankFullRefresh.html"/>
		</target>

		<target name="Refresh Application">
			<echo message="Refresh Application"/>
			<get src="${appURL}?reset_app=true" dest="${logPath}\applicationRefresh.html"/>
		</target>

		<target name="Rebuild and Refresh" depends="Run GangPlank,Refresh Application" />

		<cfif stepTrackerObj.Exists("cfunit")>

		<target name="CFUnitTest">

		<cfloop query="TestDirectory">
			<cfset pathToTest = ReplaceNoCase("#directory#\#name#", ExpandPath('\'), "", "ALL") />
			<cfset pathToTest = ReplaceNoCase(pathToTest, "\", "/", "ALL") />
			#chr(9)##chr(9)##chr(60)#CFUnit testcase="http://#cgi.server_name#/#pathToTest#" verbose="true" /#chr(62)##Chr(13)#
		</cfloop>
		</target>

		</cfif>


	</project>
	</cfxml>
	</cfoutput>

	<cffile action="write" file="#configObj.get('fileLocations','output')#/build.xml" output="#AntFileToWrite#" />
	<p>Ant File written</p>
<cfelse>
	<p>Ant File Already Exists</p>

</cfif>

</cftimer>