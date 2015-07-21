<!---    function.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Allows you to write the representation of cffunction code to an object, for writing functions dynamically. .
---->
<cfcomponent output="false" >

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction name="init" output="false" hint="Psuedo constructor, and all around nice function." >
		<cfreturn This />
	</cffunction>

	<!---***********************************************************--->
	<!---create                                  --->
	<!---Kicks off the whole process here.                           --->
	<!---***********************************************************--->
	<cffunction access="public" name="create" output="FALSE" returntype="void" hint="Kicks off the whole process here.">
		<cfargument name="name" type="string" required="yes">
		<cfargument name="access" type="string" required="no" default="public">
		<cfargument name="returntype" type="string" required="yes">
		<cfargument name="output" type="string" required="no" default="FALSE">
		<cfargument name="hint" type="string" required="no" default="">

		<cfset variables.header = chr(9) & "<cffunction access=""#arguments.access#"" name=""#arguments.name#"" output=""#arguments.output#"" returntype=""#arguments.returntype#"" " />

		<cfif len(arguments.hint) gt 0 >
			<cfset variables.header = variables.header & "hint=""#arguments.hint#"" "  />
		</cfif>

		<cfset variables.header = variables.header & "> " & chr(13) />

		<cfset variables.documentation = "" />
		<cfset variables.arguments = ArrayNew(1) />
		<cfset variables.localvariables = "" />
		<cfset variables.operation = "" />
		<cfset variables.returnString = "" />
		<cfset variables.footer = chr(9) & "</cffunction>" & chr(13) />

		<cfinvoke method="AddDocumentation">
			<cfinvokeargument name="name" value="#arguments.name#"/>
			<cfinvokeargument name="hint" value="#arguments.hint#"/>
		</cfinvoke>


	</cffunction>

	<!---***********************************************************--->
	<!---addArgument                             --->
	<!--- Adds argument to a function.                                --->
	<!---***********************************************************--->
	<cffunction access="public" name="addArgument" output="false" returntype="void" description="Adds argument to a function. ">
		<cfargument name="name" type="string" required="yes" />
		<cfargument name="type" type="string" required="yes" />
		<cfargument name="required" type="string" required="no" default="no" />
		<cfargument name="defaultvalue" type="string" required="no" default="" />
		<cfargument name="hint" type="string" required="no" default="" />

		<cfset var temp = "" />

		<cfset temp = temp.concat(chr(9) & chr(9) & "<cfargument name=""#arguments.name#"" ") />

		<cfif len(arguments.type) gt 0>
			<cfset temp = temp.concat("type=""#arguments.type#"" ") />
		</cfif>
		<cfif len(arguments.required) gt 0>
			<cfset temp = temp.concat("required=""#arguments.required#"" ") />
		</cfif>
		<cfif len(arguments.defaultvalue) gt 0 and not arguments.required>
			<cfset temp = temp.concat("default=""#arguments.defaultvalue#"" ") />
		<cfelse>
				<cfif len(arguments.required) lt 1 OR not arguments.required>
					<cfset temp = temp.concat("default="""" ") />
				</cfif>
		</cfif>
		<cfif len(arguments.hint) gt 0>
			<cfset temp = temp.concat("hint=""#arguments.hint#"" ") />
		</cfif>


		<cfset temp = temp.concat("/>") />

		<cfset ArrayAppend(variables.arguments, temp) />


	</cffunction>

	<!---***********************************************************--->
	<!---AddLocalVariable                        --->
	<!---Adds var scope delclaration to a function.                  --->
	<!---***********************************************************--->
	<cffunction access="public" name="AddLocalVariable" output="false" returntype="void" description="Adds var scope delclaration to a function.">
		<cfargument name="LocalVariable" type="string" required="yes" />
		<cfargument name="type" type="string" required="no" default="string" />

		<cfset var temp = "" />

		<cfswitch expression="#arguments.type#">
			<cfcase value="struct">
				<cfset temp = chr(9) & chr(9) & "<cfset var #LocalVariable# = StructNew() />" & chr(13) />
			</cfcase>
			<cfdefaultcase>
				<cfset temp = chr(9) & chr(9) & "<cfset var #LocalVariable# = """" />" & chr(13) />
			</cfdefaultcase>
		</cfswitch>

		<cfset variables.localvariables = variables.localvariables.concat(temp) />
	</cffunction>

	<!---***********************************************************--->
	<!---AddOperation                            --->
	<!---Adds code section to the function.                          --->
	<!---***********************************************************--->
	<cffunction access="public" name="AddOperation" output="false" returntype="void" description="Adds code section to the function.">
		<cfargument name="Operation" type="string" required="yes" />

		<cfset variables.operation = variables.operation.concat(arguments.operation & chr(13)) />

	</cffunction>

	<!---***********************************************************--->
	<!---AddReturnResult                         --->
	<!---Adds return results to a function.                          --->
	<!---***********************************************************--->
	<cffunction access="public" name="AddReturnResult" output="false" returntype="void" description="Adds return results to a function. ">
		<cfargument name="ReturnResult" type="string" required="yes" />

		<cfset variables.returnString = chr(9) & chr(9) & "<cfreturn #arguments.ReturnResult# />" & chr(13) />

	</cffunction>

	<!---***********************************************************--->
	<!---AddDocumentation                        --->
	<!---Adds documentation to a function.                           --->
	<!---***********************************************************--->
	<cffunction access="public" name="AddDocumentation" output="false" returntype="void" description="Adds documentation to a function. ">
		<cfargument name="name" type="string" required="yes">
		<cfargument name="hint" type="string" required="no" default="">

		<cfset variables.documentation = variables.documentation.concat(chr(9) & "<!---*****************************************************--->" & chr(13)) />
		<cfset variables.documentation = variables.documentation.concat(chr(9) & "<!---" & arguments.name &  "--->" & chr(13)) />
		<cfif len(arguments.hint) gt 0>
			<cfset variables.documentation = variables.documentation.concat(chr(9) & "<!---" & arguments.hint &  "--->" & chr(13)) />
		</cfif>
		<cfset variables.documentation = variables.documentation.concat(chr(9) & "<!---*****************************************************--->" & chr(13)) />
	</cffunction>

	<!---***********************************************************--->
	<!---getFunction                             --->
	<!---Returns the actual cf function code                         --->
	<!---***********************************************************--->
	<cffunction access="public" name="getFunction" output="false" returntype="string" description="Returns the actual cf function code.">
		<cfset var i=0 />
		<cfset var results="" />

		<!--- Add the header to the rss feed. --->
		<cfset results = results.concat(variables.documentation)/>
		<cfset results = results.concat(variables.header) />

		<cfset results = results.concat(ArrayToList(variables.arguments, chr(13)) & chr(13) & chr(13)) />
		<cfset results = results.concat(variables.localvariables & chr(13)) />
		<cfset results = results.concat(variables.operation & chr(13)) />
		<cfif Len(variables.returnString) gt 0>
			<cfset results = results.concat(variables.returnString) />
		</cfif>
		<!--- Add the footer to the rss feed. --->
		<cfset results = results.concat(variables.footer) />

		<cfreturn results />
	</cffunction>
</cfcomponent>