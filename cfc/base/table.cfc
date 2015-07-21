<cfcomponent hint="Acts a bean for a table." output="false">

	<!---***********************************************************--->
	<!---init                   			              --->
	<!---Pseudo constructor.                                		  --->
	<!---***********************************************************--->
	<cffunction access="public" name="init" output="false" returntype="any" hint="Pseudo constructor" >
		<cfargument name="tableName" type="string" required="YES" />
		<cfargument name="databaseObj" type="any" required="yes" />

		<cfset variables.tableName = arguments.tableName />
		<cfset variables.databaseObj = arguments.databaseObj />

		<cfreturn This />
	</cffunction>

	<!---***********************************************************--->
	<!---onMissingMethod                   			  --->
	<!---The catches methods that don't exists.          		      --->
	<!--- This allowed me to get rid of tons of duplicate code between--->
	<!--- this cfc and database.cfc.                                  --->
	<!---***********************************************************--->
	<cffunction name="onMissingMethod">
		<cfargument name="missingMethodName" />
		<cfargument name="missingMethodArguments" />

		<cfset var results = "" />
		<cfset var functionDetails = GetMetaData(databaseObj[arguments.missingMethodName])>
		<cfset var i = 0 />
		<cfset var inputStruct = StructNew() />

		<!--- Ensures that if the underlying function call is not a table function that it isn't called.' --->
		<cfif compareNoCase(functionDetails.parameters[1].name, "tableName") neq 0>
			<cfthrow type="Application" detail="Ensure that the method is defined, and that it is spelled correctly."
					message="The method #arguments.missingMethodName# was not found in component.">
		</cfif>


		<cfloop index="i" from="2" to="#arrayLen(functionDetails.parameters)#">
			<cfset inputStruct[functionDetails.parameters[i].name] =  arguments.missingMethodArguments[i-1] />
		</cfloop>

		<cfset inputStruct['tableName'] = variables.tableName />


		<cfinvoke component="#variables.databaseObj#" method="#missingMethodName#" argumentcollection="#inputStruct#" returnvariable="results" />

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---getTableName                   			      --->
	<!---Returns the tableName field of the table.           		  --->
	<!---***********************************************************--->
	<cffunction access="public" name="gettableName" output="false" returntype="string" description="Returns the tableName field of the table." >
		<cfreturn variables.tableName />
	</cffunction>

</cfcomponent>