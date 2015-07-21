<cfcomponent>

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
		<cfargument name="name" type="string" required="yes" hint="The name of the table for which to create package." />

		<cfset variables.packageHeader = "CREATE OR REPLACE PACKAGE #arguments.name#PKG #chr(10)# AS">
		<cfset variables.bodyHeader = "CREATE OR REPLACE PACKAGE BODY #arguments.name#PKG AS">

		<cfset variables.packageFooter = "END #arguments.name#PKG;">
		<cfset variables.bodyFooter = "END;">

		<cfset variables.packageProcArray = ArrayNew(1) />
		<cfset variables.bodyProcArray = ArrayNew(1) />

		<cfset variables.packageTypeArray = ArrayNEw(1) />

		<cfreturn This />
	</cffunction>

	<cffunction access="public" name="addProc" output="false" returntype="void" hint="Adds a procedure to the package." >
		<cfargument name="procedureCode" type="string" required="yes" default="" hint="The code of the procedure to add." />

		<cfset var aslocation = FindNoCase(")", arguments.procedureCode) />
		<cfset var header = left(arguments.procedureCode, aslocation) &  ";"/>

		<cfset arrayAppend(variables.packageProcArray, ReplaceList(header, "#chr(10)#,#chr(9)#", " , " )) />
		<cfset arrayAppend(variables.bodyProcArray, arguments.procedureCode) />

	</cffunction>

	<cffunction access="public" name="addType" output="false" returntype="void" hint="Adds a type to the package." >
		<cfargument name="typeCode" type="string" required="yes" hint="The code that creates the type." />

		<cfset arrayAppend(variables.packageTypeArray, arguments.typeCode) />
	</cffunction>

	<cffunction access="public" name="getPackage" output="false" returntype="struct" hint="Returns the creation code for the package." >

		<cfset var result = structNew() />
		<cfset result.package = "" />
		<cfset result.body = "" />

		<cfset result.package = result.package.concat(variables.packageHeader & chr(10)) />
		<cfset result.package = result.package.concat(arrayToList(variables.packageTypeArray, chr(10)) & chr(10)) />
		<cfset result.package = result.package.concat(arrayToList(variables.packageProcArray, chr(10)) & chr(10)) />
		<cfset result.package = result.package.concat(variables.packageFooter & chr(10)) />


		<cfset result.body = result.body.concat(variables.bodyHeader & chr(10)) />
		<cfset result.body = result.body.concat(arrayToList(variables.bodyProcArray, chr(10)) & chr(10)) />
		<cfset result.body = result.body.concat(variables.bodyFooter & chr(10)) />

		<cfreturn result />
	</cffunction>


</cfcomponent>