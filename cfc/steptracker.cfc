<cfcomponent output="false">

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
		<cfargument name="steps" type="array" required="yes" default="" hint="The step array from the application." />
		<cfset variables.stepsTaken = "" />
		<cfset variables.stepsPlanned = ArrayToList(arguments.steps) />
		<cfreturn This />
	</cffunction>

	<cffunction access="public" name="addStep" output="false" returntype="void" hint="Adds a step that was taken." >
		<cfargument name="step" type="string" required="yes" hint="The step to add." />
		<cfset variables.stepsTaken = ListAppend(variables.stepsTaken, arguments.step) />
	</cffunction>

	<cffunction access="public" name="require" output="false" returntype="void" hint="Determines if a particular step was taken." >
		<cfargument name="step" type="string" required="yes" hint="The step to add." />

		<cfif not ListFind(variables.stepsTaken, arguments.step)>
			<cfthrow type="Application" message="Required Step Skipped" detail="Step: #Ucase(arguments.step)# is required but was not taken." />
		</cfif>
	</cffunction>

	<cffunction access="public" name="exists" output="false" returntype="boolean" description="Determines if a particular step is planned at any point. " >
		<cfargument name="step" type="string" required="no" default="" hint="The step to test." />

		<cfif ListFind(variables.stepsPlanned,arguments.step)>
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
	</cffunction>

</cfcomponent>