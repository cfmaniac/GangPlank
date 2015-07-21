<cfcomponent hint="Handles foreign Key analysis" output="false">

	<cffunction access="package" name="init" output="false" returntype="any" description="Psuedo Constructor and all around nice function." >
		<cfargument name="columnInfo" type="query" required="yes" default="" hint="The foreign key data query." />

		<cfset variables.foreignKeyData = extractForeignKeyInfoFromQuery(arguments.columnInfo) />

		<cfreturn This />
	</cffunction>

	<!---***********************************************************--->
	<!---getForeignKeyInfoForColumn              --->
	<!---Returns a struct of the key data of the column.             --->
	<!---***********************************************************--->
	<cffunction access="package" name="getForeignKeyInfoForColumn" output="false" returntype="struct" description="Returns a struct of the key data of the column.  " >
		<cfargument name="column" type="string" required="yes" default="" hint="Column for which to retreive key data." />

		<cfset var results = StructNew()>

		<cfif StructKeyExists(variables.foreignKeyData, arguments.column)>
			<cfset results = variables.foreignKeyData[arguments.column] />
		<cfelse>
			<cfset results['linkedTable'] = "" />
			<cfset results['linkedField'] = "" />
		</cfif>

		<cfreturn results />
	</cffunction>

	<!---***********************************************************     --->
	<!---extractForeignKeyInfoFromQuery               --->
	<!---Spins through the sp_help query and extracts foreign key data.   --->
	<!---***********************************************************     --->
	<cffunction access="private" name="extractForeignKeyInfoFromQuery" output="false" returntype="struct" description="Spins through the sp_help query and extracts foreign key data. " >
		<cfargument name="fieldInfo" type="query" required="yes" hint="The sp_help keys query. " />

		<cfset var results = StructNew()>

		<cfloop query="arguments.fieldInfo">
			<cfif FindNoCase("foreign key", CONSTRAINT_TYPE )>
				<cfset results[constraint_keys] = extractForeignKeyInfo(fieldInfo.constraint_keys[fieldInfo.currentRow + 1]) />
			</cfif>
		</cfloop>

		<cfreturn results />
	</cffunction>

	<!---***********************************************************     --->
	<!---extractForeignKeyInfo                        --->
	<!---Extracts Foreign key data from a sp_help routine.                --->
	<!---***********************************************************     --->
	<cffunction access="private" name="extractForeignKeyInfo" output="false" returntype="struct" description="Extracts Foreign key data from a sp_help routine." >
		<cfargument name="foreignTableString" type="string" required="yes" hint="The sp_help record to parse." />

		<cfset var results = StructNew()>

		<cfset results.linkedTable = ListLast(GetToken(arguments.foreignTableString, 2), ".") />
		<cfset results.linkedField = ReplaceList(GetToken(arguments.foreignTableString, 3), "(,)", ",") />

		<cfreturn results />
	</cffunction>

	<cffunction access="public" name="hasForeignKeys" output="false" returntype="boolean" hint="Reports whether or not this table has any foreign keys." >
		<cfif  StructISEmpty(variables.foreignKeyData)>
			<cfreturn FALSE />
		<cfelse>
			<cfreturn TRUE />
		</cfif>
	</cffunction>


</cfcomponent>