
<cfcomponent output="false" >

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction name="init" output="false" hint="Psuedo constructor, and all around nice function." >
		<cfreturn This />
	</cffunction>

	<!---***********************************************************--->
	<!---create                                   --->
	<!---Kicks off the whole CFC code.                               --->
	<!---***********************************************************--->
	<cffunction access="public" name="create" output="FALSE" returntype="void" hint="Kicks off the whole CFC code.">
		<cfargument name="extends" type="string" required="no" default="" hint="A CFC that this cfc extends." />
		<cfargument name="output" type="boolean" required="no" default="FALSE" hint="Whether or not this cfc pushes output." />

		<cfif len(arguments.extends) gt 0>
			<cfset variables.header = '<cfcomponent output="' & arguments.output & '" extends="' & arguments.extends & '"> ' & chr(13) />
		<cfelse>
			<cfset variables.header = '<cfcomponent output="' & arguments.output & '"> ' & chr(13) />
		</cfif>
		<cfset variables.constructor = "" />
		<cfset variables.body = "" />
		<cfset variables.functionArray = ArrayNew(1) />
		<cfset variables.footer = "</cfcomponent>" & chr(13) />

	</cffunction>

	<!---***********************************************************--->
	<!---addFunction                             --->
	<!---Adds the code of a function to the CFC.                     --->
	<!---***********************************************************--->
	<cffunction access="public" name="addFunction" output="FALSE" returntype="void" hint="Adds the code of a function to the CFC.">
		<cfargument name="function" type="string" required="no" hint="The function to add to the cfc." />
		<cfset ArrayAppend(variables.functionArray, arguments.function) />
	</cffunction>

	<!---***********************************************************--->
	<!---addConstructor                          --->
	<!---Adds code lines to the constructor area of the CFC.         --->
	<!---***********************************************************--->
	<cffunction access="public" name="addConstructor" output="FALSE" returntype="void" hint="Adds code lines to the constructor area of the CFC.">
		<cfargument name="content" type="string" required="no" hint="The code to add to the constructor." />
		<cfset variables.constructor = variables.constructor & arguments.content & chr(13)/>
	</cffunction>

	<!---***********************************************************--->
	<!---getCFC                                  --->
	<!---Returns the actual cf cfc code.                             --->
	<!---***********************************************************--->
	<cffunction access="public" name="getCFC" output="false" returntype="string" hint="Returns the actual cf cfc code.">
		<cfset var i=0 />
		<cfset var results="" />

		<!--- Add the header to the rss feed. --->
		<cfset results = results & variables.header />
		<cfset results = results & variables.constructor />

		<cfloop index="i" from="1" to="#arrayLen(variables.functionArray)#">
			<cfset variables.body = variables.body & chr(13) & variables.functionArray[i] & chr(13) />
		</cfloop>
		<cfset results = results & variables.body />

		<!--- Add the footer to the rss feed. --->
		<cfset results = results & variables.footer />

		<cfreturn results />
	</cffunction>

</cfcomponent>