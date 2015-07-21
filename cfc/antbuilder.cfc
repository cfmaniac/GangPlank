<cfcomponent hint="Provides the capacity to build and edit Ant files programmatically." output="false">

	<cfproperty name="name" hint="The name of the Ant project" type="string" />
	<cfproperty name="rawFile" hint="The raw XML File contents" type="string" />
	<cfproperty name="antXML" hint="The XML of the Ant task" type="any" />

	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn name />
	</cffunction>

	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" />
		<cfset name = arguments.name />
		<cfreturn />
	</cffunction>

	<cffunction name="getRawFile" access="public" output="false" returntype="string">
		<cfreturn rawFile />
	</cffunction>

	<cffunction name="setRawFile" access="public" output="false" returntype="void">
		<cfargument name="rawFile" type="string" required="true" />
		<cfset rawFile = arguments.rawFile />
		<cfreturn />
	</cffunction>

	<cffunction name="getAntXML" access="public" output="false" returntype="any">
		<cfreturn antXML />
	</cffunction>

	<cffunction name="setAntXML" access="public" output="false" returntype="void">
		<cfargument name="antXML" type="any" required="true" />
		<cfset antXML = arguments.antXML />
		<cfreturn />
	</cffunction>
</cfcomponent>