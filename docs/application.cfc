<cfcomponent>
	<cfset This.name= "GangPlank#ReplaceList(ExpandPath('..'),'\,/,:','_,_,')#" />


	<cfsetting showdebugoutput="no"/>

	<cffunction name="onRequestStart" returnType="boolean">
		<cfargument type="String" name="targetPage" required=true/>

		<cfif not StructKeyExists(application, "relativePath")>
			<cfhttp url="#getParentURL()#?resetApp=TRUE" timeout="1" />
		</cfif>

		<cfimport taglib="../customtags" prefix="pageElement" />
		<pageElement:header>
		<pageElement:navDoc />

		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestEnd" returnType="boolean">
		<cfargument type="String" name="targetPage" required=true/>

		<cfimport taglib="../customtags" prefix="pageElement" />
		<pageElement:footer>

		<cfreturn true>
	</cffunction>

	<cffunction access="public" name="getParentURL" output="false" returntype="string" hint="Gets the parent url of the current directory." >
		<cfset var script = cgi.script_name />
		<cfset var listCount = listLen(script, "/") />
		<cfset script = ListDeleteAt(script, listCount, "/") />
		<cfset script = ListDeleteAt(script, listCount -1, "/") />

		<cfreturn "http://" & cgi.server_name & script/>
	</cffunction>



</cfcomponent>