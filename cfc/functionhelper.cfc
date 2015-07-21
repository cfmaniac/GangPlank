<cfcomponent output="false">

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." > 
		<cfreturn This />
	</cffunction>


	<cffunction access="public" name="getFunctionDefaults" output="false" returntype="struct" hint="This will return return value type and comments for functions." >
		<cfargument name="operationName" type="string" required="yes" hint="The function name for which to create info." />
		<cfargument name="tableName" type="string" required="yes" hint="The table this function impacts" />
	
		<cfset var results = structNew() />
	
		<cfif FindNoCase("select_with_FK", arguments.operationName)>
			<cfset results['name'] = ReplaceNoCase(arguments.operationName, "select", "read", "all") />
			<cfset results['return'] = "query" />
			<cfset results['hint'] = "This function retrieves a single #arguments.tableName# record from the database with foreign key labels in place of foreign keyed columns." />
		<cfelseif FindNoCase("select", arguments.operationName)>
			<cfset results['name'] = ReplaceNoCase(arguments.operationName, "select", "read", "all") />
			<cfset results['return'] = "query" />
			<cfset results['hint'] = "This function retrieves a single #arguments.tableName# record from the database." />
		<cfelseif FindNoCase("insert", arguments.operationName)>
			<cfset results['name'] = ReplaceNoCase(arguments.operationName, "insert", "create", "all") />
			<cfset results['return'] = "numeric" />
			<cfset results['hint'] = "This function inserts a single #arguments.tableName# record into the database." />
		<cfelseif FindNoCase("update", arguments.operationName)>
			<cfset results['name'] = ReplaceNoCase(arguments.operationName, "update", "update", "all") />
			<cfset results['return'] = "void" />
			<cfset results['hint'] = "This function updates a single #arguments.tableName# record from the database." />
		<cfelseif FindNoCase("delete", arguments.operationName)>
			<cfset results['name'] = ReplaceNoCase(arguments.operationName, "delete", "destroy", "all") />
			<cfset results['return'] = "void" />
			<cfset results['hint'] = "This function deletes a single #arguments.tableName# record from the database." />
		<cfelseif FindNoCase("list_with_FK", arguments.operationName)>
			<cfset results['name'] = arguments.operationName />
			<cfset results['return'] = "query" />
			<cfset results['hint']  = "This function retrieves a list of #arguments.tableName#(s) from the database with foreign key labels in place of foreign keyed columns." />	
		<cfelseif FindNoCase("list_foreign_key_labels", arguments.operationName)>
			<cfset results['name'] = arguments.operationName />
			<cfset results['return'] = "query" />
			<cfset results['hint']  = "This function retrieves the primary key and foreign key label of #arguments.tableName#(s). Used in building select boxes. " />	
		<cfelseif FindNoCase("list", arguments.operationName)>
			<cfset results['name'] = arguments.operationName />
			<cfset results['return'] = "query" />
			<cfset results['hint']  = "This function retrieves a list of #arguments.tableName#(s) from the database." />
		<cfelseif FindNoCase("search", arguments.operationName)>
			<cfset results['name'] = arguments.operationName />
			<cfset results['return'] = "query" />
			<cfset results['hint']  = "This function performs a search for #arguments.tableName#(s) based on input parameters." />	
		<cfelse>
			<cfset results['name'] = arguments.operationName />
			<cfset results['return'] = "any" />
			<cfset results['hint'] = "This function performs an operation it likes to call '#arguments.operationName#'." />
		</cfif>
	
	
		<cfreturn results />
	</cffunction>	


</cfcomponent>