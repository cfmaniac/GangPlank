<!---    config.cfc

AUTHOR				: tpryan
CREATED				: 9/12/2007 4:42:56 PM
DESCRIPTION			: Persists all of the configuration options of the application.
---->


<cfcomponent output="FALSE">

	<cffunction access="public" name="init" output="true" returntype="any" description="Psuedo Constructor and all around nice function." >
		<cfargument name="configuration" type="struct" required="yes" hint="The configuration structure." />
		<cfargument name="version" type="string" required="yes"  hint="The current version of GangPlank." />

		<cfset var cfcStructKeyArray = ArrayNew(1) />
		<cfset var i = 0 />

		<cfset variables.config = duplicate(arguments.configuration) />

		<cfset config['settings']['GangPlankVersion'] = arguments.version />



		<cfset cfcStructKeyArray = StructKeyArray(config.cfc) />
		<cfloop index="i" from="1"  to="#ArrayLen(cfcStructKeyArray)#">
			<cfset variables.config.cfc[cfcStructKeyArray[i]] = Replace(variables.config.cfc[cfcStructKeyArray[i]], "cfc.", variables.config.settings.CFCpathCFCStyle & ".", "ONCE") />
		</cfloop>

		<cfif right(config['application']['url'], 1) neq "/">
			<cfset config['application']['url'] = config['application']['url'] & "/" />
		</cfif>

		<!--- Ensure backwards compatibility with CF7 --->
		<cfset removeScorpioSettings() />


		<cfreturn This />
	</cffunction>

	<cffunction access="public" name="get" output="false" returntype="any" description="Gets a setting from the configuration." >
		<cfargument name="FirstLevel" type="string" required="no" default="" hint="The first level of the config structure to return. " />
		<cfargument name="SecondLevel" type="string" required="no" default="" hint="The first level of the config structure to return. " />

		<cfif len(arguments.secondLevel) gt 1>
			<cftry>
				<cfreturn variables.config[arguments.firstLevel][arguments.secondLevel] />

				<cfcatch type="any">
					<cfif FindNoCase("is undefined in a CFML structure referenced as part of an expression", cfcatch.Message)>
						<cfthrow type="application" message="Requested setting does not exists in this configuration. Check your GangPlank configuration file for the correct setting."
								detail="Requested setting: [#Ucase(arguments.FirstLevel)#][#Ucase(arguments.SecondLevel)#] does not exist.">
					<cfelse>
						<cfrethrow />
					</cfif>

				</cfcatch>
			</cftry>

		<cfelse>
			<cftry>
				<cfreturn variables.config[arguments.firstLevel] />

				<cfcatch type="any">
					<cfif FindNoCase("is undefined in a CFML structure referenced as part of an expression", cfcatch.Message)>
						<cfthrow type="application" message="Requested setting does not exists in this configuration. Check your GangPlank configuration file for the correct setting."
								detail="Requested setting: [#Ucase(arguments.FirstLevel)#] does not exist.">
					<cfelse>
						<cfrethrow />
					</cfif>

				</cfcatch>
			</cftry>

		</cfif>



	</cffunction>

	<cffunction access="public" name="exists" output="false" returntype="boolean" description="Tests for configuration setting being set." >
		<cfargument name="FirstLevel" type="string" required="no" default="" hint="The first level of the config structure to return. " />
		<cfargument name="SecondLevel" type="string" required="no" default="" hint="The first level of the config structure to return. " />

		<cfif StructKeyExists(variables.config, FirstLevel) AND StructKeyExists(variables.config[FirstLevel], SecondLevel)>
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
	</cffunction>

	<cffunction access="public" name="getAll" output="false" returntype="struct" hint="A help function for dubugging, returns the entire config structure." >
		<cfreturn variables.config />
	</cffunction>

	<cffunction access="private" name="removeScorpioSettings" output="false" returntype="string" hint="Deactivates any scorpio settings if you are not running on CF8." >

		<cfif left(server.coldfusion.ProductVersion, 1) lt 8>
			<cfset config['ui']['RichTextAreas'] = FALSE />
			<cfset config['ui']['DateField'] = FALSE />
		</cfif>


	</cffunction>

</cfcomponent>