<!---    CFStoredProc.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Allows you to write the representation of cfstoredproc call code to an object, for writing cfstoredproc code sections's dynamically. .
---->
<cfcomponent output="false" >

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction name="init" output="false" hint="Psuedo constructor, and all around nice function." >
		<cfreturn This />
	</cffunction>

	<!---*****************************************************--->
	<!--- create                                              --->
	<!--- Begins the code of stored proc.                     --->
	<!---*****************************************************--->
	<cffunction name="create" access="public" output="false"  returntype="void" hint="Begins the code of stored proc.">
		<cfargument name="procedure" type="string" required="yes">
		<cfargument name="datasource" type="string" required="yes">
		<cfargument name="username" type="string" required="no" default="" />
		<cfargument name="password" type="string" required="no" default="" />

		<cfif len(arguments.username) gt 0 AND len(arguments.password) gt 0>
			<cfset variables.header = chr(9) & chr(9) & "<cfstoredproc procedure=""#arguments.procedure#"" datasource=""#arguments.datasource#"" username=""#arguments.username#"" password=""#arguments.password#"">" & chr(13) />
		<cfelse>
			<cfset variables.header = chr(9) & chr(9) & "<cfstoredproc procedure=""#arguments.procedure#"" datasource=""#arguments.datasource#"">" & chr(13) />
		</cfif>
		<cfset variables.params= ArrayNew(1) />
		<cfset variables.results="" />
		<cfset variables.footer = chr(9) & chr(9) & "</cfstoredproc>" & chr(13) />
	</cffunction>

	<!---*****************************************************--->
	<!--- addParam                                            --->
	<!--- Adds parameter to a storedProc.                     --->
	<!---*****************************************************--->
	<cffunction access="public" name="addParam" output="true" returntype="void" hint="Adds parameter to a storedProc.">
		<cfargument name="type" type="string" required="yes">
		<cfargument name="cfsqltype" type="string" required="yes">
		<cfargument name="variable" type="string" required="yes">
		<cfargument name="dbvarname" type="string" required="yes">
		<cfargument name="value" type="string" required="yes">
		<cfargument name="maxlength" type="string" required="no" default="">
		<cfargument name="scale" type="numeric" required="no" default="0">
		<cfargument name="null" type="string" required="no" default="NO">
		<cfargument name="default" type="string" required="yes">
		<cfargument name="nullable" type="boolean" required="no" default="FALSE">
		<cfargument name="required" type="boolean" required="yes" default="TRUE">

		<cfset var localparam =""/>
		<cfset var extraTab =""/>
		<cfset var nullString ="FALSE"/>

		<!--- Switched to using concat to try and speed it up.  --->

		<cfif not arguments['required'] AND CompareNoCase(arguments['type'], "OUT")>
			<cfif FindNoCase("BIT", arguments.cfsqltype) >

				<cfset nullString = "not IsBoolean(#arguments.value#)" />
			<cfelseif IsNumeric(arguments.default)>

				<cfset nullString = "#arguments.value# eq #arguments.default#" />
			<cfelseif IsDate(arguments.default)>

				<cfset nullString = "DateCompare(#arguments.value#,""#arguments.default#"") eq 0" />
			<cfelseif FindNoCase("BINARY", arguments.cfsqltype) >

				<cfset nullString = "not IsBinary(#arguments.value#)  and not IsImage(#arguments.value#)" />
			<cfelse>

				<cfset nullString = "#arguments.value# eq '#arguments.default#'" />
			</cfif>




		</cfif>

		<cfset localparam = localparam.concat(extraTab & chr(9) & chr(9) & chr(9) & "<cfprocparam type=""#arguments.type#"" cfsqltype=""#arguments.cfsqltype#"" ") />
		<cfset localparam = localparam.concat("variable=""#arguments.variable#"" dbvarname=""#arguments.dbvarname#"" ") />

		<cfif not compare(arguments.type, "IN") >
			<cfif FindNoCase("BLOB", arguments.cfsqltype)>
				<cfset localparam = localparam.concat("value=""##ImageGetBlob(#arguments.value#)##"" ") />
			<cfelse>
				<cfset localparam = localparam.concat("value=""###arguments.value###"" ") />
			</cfif>


		</cfif>

		<cfif len(arguments.maxlength) gt 0>
			<cfset localparam = localparam.concat("maxlength=""#arguments.maxlength#"" ") />
		</cfif>

		<cfif arguments.scale gt 0>
			<cfset localparam = localparam.concat("scale=""#arguments.scale#"" ") />
		</cfif>

		<cfif not arguments['required'] AND CompareNoCase(arguments['type'], "OUT")>
			<cfset localparam = localparam.concat("null=""###nullString###"" ") />
		</cfif>

		<cfset localparam = localparam.concat(" />" & chr(13)) />

		<cfset ArrayAppend(variables.params, localparam)/>

	</cffunction>

	<!---*****************************************************--->
	<!--- addImageParam                                            --->
	<!--- Adds Image parameter to a storedProc.                     --->
	<!---*****************************************************--->
	<cffunction access="public" name="addImageParam" output="true" returntype="void" hint="Adds parameter to a storedProc.">
		<cfargument name="type" type="string" required="yes">
		<cfargument name="cfsqltype" type="string" required="yes">
		<cfargument name="variable" type="string" required="yes">
		<cfargument name="dbvarname" type="string" required="yes">
		<cfargument name="value" type="string" required="yes">
		<cfargument name="maxlength" type="string" required="no" default="">
		<cfargument name="scale" type="numeric" required="no" default="0">
		<cfargument name="null" type="string" required="no" default="NO">
		<cfargument name="default" type="string" required="yes">
		<cfargument name="nullable" type="boolean" required="no" default="FALSE">
		<cfargument name="required" type="boolean" required="yes" default="TRUE">
		<cfargument name="vartype" type="string" required="yes">

		<cfset var localparam =""/>
		<cfset var extraTab  = chr(9) />



		<!--- If we're removing the image' --->
		<cfset localparam = localparam.concat(chr(9) & chr(9) & chr(9) & '<cfif IsSimpleValue(#arguments.value#) and #arguments.value# eq ''''>' & chr(13)) />
		<cfset localparam = localparam.concat(chr(9) & chr(9) & chr(9) & chr(9) & "<cfprocparam type=""#arguments.type#"" cfsqltype=""#arguments.cfsqltype#"" ") />
		<cfset localparam = localparam.concat("variable=""#arguments.variable#"" dbvarname=""#arguments.dbvarname#"" ")/>
		<cfset localparam = localparam.concat("null=""YES"" /> " & chr(13) )/>


		<!--- If we are just resetting the same image. --->
		<cfset localparam = localparam.concat(chr(9) & chr(9) & chr(9) & '<cfelseif IsImage(#arguments.value#)>' & chr(13)) />
				<cfset localparam = localparam.concat(extraTab & chr(9) & chr(9) & chr(9) & "<cfprocparam type=""#arguments.type#"" cfsqltype=""#arguments.cfsqltype#"" ") />
		<cfset localparam = localparam.concat("variable=""#arguments.variable#"" dbvarname=""#arguments.dbvarname#"" ") />
		<cfset localparam = localparam.concat("value=""##ImageGetBlob(#arguments.value#)##"" ") />
		<cfset localparam = localparam.concat("null=""NO"" /> " & chr(13)) />


		<cfset localparam = localparam.concat(chr(9) & chr(9) & chr(9) & '<cfelse>' & chr(13)) />

		<!--- If we are resetting inserting a new image. --->
		<cfset localparam = localparam.concat(extraTab & chr(9) & chr(9) & chr(9) & "<cfprocparam type=""#arguments.type#"" cfsqltype=""#arguments.cfsqltype#"" ") />
		<cfset localparam = localparam.concat("variable=""#arguments.variable#"" dbvarname=""#arguments.dbvarname#"" ") />
		<cfset localparam = localparam.concat("value=""###arguments.value###"" ") />
		<cfset localparam = localparam.concat("null=""NO"" /> " & chr(13)) />

		<cfset localparam = localparam.concat(chr(9) & chr(9) & chr(9) & '</cfif>' & chr(13)) />

		<cfset ArrayAppend(variables.params, localparam)/>

	</cffunction>

	<!---*****************************************************--->
	<!--- addresult                                           --->
	<!--- Adds result section to a storedProc.                --->
	<!---*****************************************************--->
	<cffunction access="public" name="addresult" output="false" returntype="void" hint="Adds result section to a storedProc.">
		<cfargument name="name" type="string" required="yes">
		<cfargument name="resultset" type="string" required="no" default="">
		<cfargument name="maxrows" type="string" required="no" default="">


		<cfset variables.results= variables.results.concat( chr(9) & chr(9) & chr(9) & "<cfprocresult name=""#arguments.name#"" ") />

		<cfif len(arguments.resultset) gt 0>
			<cfset variables.results = variables.results.concat( "resultset=""#arguments.resultset#"" ") />
		</cfif>
		<cfif len(arguments.maxrows) gt 0>
			<cfset variables.results = variables.results.concat(  "maxrows=""#arguments.maxrows#"" ") />
		</cfif>

		<cfset variables.results= variables.results.concat(" />" & chr(13)) />
	</cffunction>

	<!---*****************************************************--->
	<!--- getProc                                             --->
	<!--- Returns the actual cf proc code.                    --->
	<!---*****************************************************--->
	<cffunction access="public" name="getProc" output="false" returntype="string" hint="Returns the actual cf proc code.">
		<cfset var i=0 />
		<cfset var results="" />

		<!--- Add the header to the rss feed. --->
		<cfset results = results.concat(variables.header) />

		<cfset results = results.concat(ArrayToList(variables.params, " ") & chr(13))  />
		<cfset results = results.concat(variables.results) />
		<!--- Add the footer to the rss feed. --->
		<cfset results = results.concat(variables.footer) />

		<cfreturn results />
	</cffunction>

</cfcomponent>