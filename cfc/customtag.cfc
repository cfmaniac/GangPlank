<!---    customTag.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Allows you to write the representation of customtag code to an object, for writing customtags's dynamically. .
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
	<!---Kicks off the whole custom tag process.                     --->
	<!---***********************************************************--->
	<cffunction access="public" name="create" output="FALSE" returntype="void" hint="Kicks off the whole custom tag process.">
		<cfargument name="name" type="string" required="no" default="" hint="A name for the custom tag." />

		<cfset variables.header = "<!--- #arguments.name#.cfm --->" & chr(13) & '<cfprocessingdirective suppresswhitespace="yes">' & chr(13) />
		<cfset variables.attributes = "" />
		<cfset variables.body = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset variables.footer = "</cfprocessingdirective>" & chr(13) & '<cfexit method="exitTag" />' & chr(13)  />

	</cffunction>

	<!---***********************************************************--->
	<!---addAttribute                            --->
	<!---Adds a cfparam'ed attribute to the custom tag.              --->
	<!---***********************************************************--->
	<cffunction access="public" name="addAttribute" output="false" returntype="void" hint="Adds a cfparam'ed attribute to the custom tag. ">
		<cfargument name="name" type="string" required="yes" hint="A name for the attribute." />
		<cfargument name="type" type="string" required="no" default="" hint="The type of variable it is" />
		<cfargument name="defaultvalue" type="string" required="no" default="" hint="What to default the variable to. " />
		<cfargument name="required" type="boolean" required="no" default="FALSE" hint="Whether or not the variable is required." />

		<cfset var attributeString = '<cfparam name="attributes.' & arguments.name & '"' />

		<cfif len(arguments.type gt 1)>
			<cfset attributeString = attributeString & ' type="' & arguments.type & '"' />
		</cfif>

		<cfif not arguments.required AND len(arguments.defaultvalue gt 1)>
			<cfset attributeString = attributeString & ' default="' & arguments.defaultvalue & '"' />
		</cfif>

		<cfset attributeString = attributeString & " />" & chr(13) />


		<cfset variables.attributes = variables.attributes & attributeString />
	</cffunction>

	<!---***********************************************************--->
	<!---appendBody                              --->
	<!---Adds code content to the body of a custom tag.              --->
	<!---***********************************************************--->
	<cffunction access="public" name="appendBody" output="FALSE" returntype="void" hint="Adds code content to the body of a custom tag.">
		<cfargument name="bodyContent" type="string" required="yes" hint="Content to append to the body of the custom tag. " />

		<cfset variables.body.append(arguments.bodyContent) & chr(13)  />
	</cffunction>

	<!---***********************************************************--->
	<!---getCustomTag                            --->
	<!---Returns the actual cf code.                                 --->
	<!---***********************************************************--->
	<cffunction access="public" name="getCustomTag" output="false" returntype="string" hint="Returns the actual cf code.">
		<cfset var i=0 />
		<cfset var results = CreateObject("java","java.lang.StringBuilder").Init() />

		<!--- Add the header to the custom tag. --->
		<cfset results.append(variables.header) />
		<cfset results.append(variables.attributes) />
		<cfset results.append(variables.body) />

		<!--- Add the footer to the custom tag. --->
		<cfset results.append(variables.footer) />

		<cfreturn results />
	</cffunction>

</cfcomponent>