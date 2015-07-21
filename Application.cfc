
<cfcomponent>



	<cfsetting showdebugoutput="no" />
	<cfset This.name= "GangPlank#ReplaceList(ExpandPath('.'),'\,/,:','_,_,')#" />
	<cfset This.customtagpaths = "#ExpandPath('.')#/customtags/"/>
	<cfset this.mappings["/GangPlank2"] = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfset this.mappings["/GangPlank"] = getDirectoryFromPath(getCurrentTemplatePath())>

	<cferror type="exception" template="error_exception.cfm" exception="any" />
	<cferror type="request" template="error_request.cfm" exception="any" />



	<!--- onApplicationStart --->
	<cffunction name="onApplicationStart" output="false">
		<cfinclude template="includes/buildNum.cfm" />

		<cfset application.version = "1.1.0" & NumberFormat(application.buildnum, "00000") />
		<cfset application.relativePath = findRelativeRoot() />

		<cfset application.utilityObj = createObject("component", "cfc.utility") />





	</cffunction>

	<!--- onRequestStart --->
	<cffunction name="onRequestStart">
		<cfparam name="url.rebuild" type="boolean" default="TRUE" />
		<cfif url.rebuild>
			<cfinvoke method="onApplicationStart" />
		</cfif>

	</cffunction>

	<cffunction access="public" name="findRelativeRoot" output="false" returntype="string" hint="Determines the relative root of a page. " >
		<cfreturn "/" & Replace(ReplaceNoCase(getDirectoryFromPath(getCurrentTemplatePath()), ExpandPath("/"), "", "ALL"), "\", "/", "ALL") />
	</cffunction>

</cfcomponent>