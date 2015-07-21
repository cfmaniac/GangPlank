<cfcomponent extends="GangPlank2.cfc.base.database">

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction access="public" name="init" output="FALSE" >
		<cfargument name="configObj" type="any" required="no" default="" hint="The configuration of the application." />

		<cfset variables.overrideList ="displayName,orderBy,ForeignKeyLabel,IsImage,label" />
		<cfset variables.configObj = arguments.configObj />
		<cfset variables.databaseStruct = StructNew() />
		<cfset variables.tableArray = ArrayNew(1) />

		<cfinvoke component="#configObj.get('cfc','help')#" method="init" returnvariable="variables.helpObj">
			<cfinvokeargument name="datasource" value="#configObj.get('db', 'datasource')#" />
			<cfinvokeargument name="username" value="#configObj.get('db', 'username')#" />
			<cfinvokeargument name="password" value="#configObj.get('db', 'password')#" />
			<cfinvokeargument name="configObj" value="#variables.configObj#" />
		</cfinvoke>


		<cfobjectcache action = "clear" />
		<cfset inspectTables() />

		<cfreturn This />
	</cffunction>

</cfcomponent>