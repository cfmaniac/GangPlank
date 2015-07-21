<cfcomponent output="false">

<!---*****************************************************--->
<!---init--->
<!---This is the pseudo constructor that allows us to play little object games.--->
<!---*****************************************************--->
<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
	<cfargument name="datasource" type="string" required="yes"  hint="The datasource to look at. " />
	<cfargument name="username" type="string" required="yes"  hint="The username to look with. " />
	<cfargument name="password" type="string" required="yes"  hint="The datasource to look with. " />
	<cfargument name="database" type="string" required="yes"  hint="The database to look at. " />
	<!--- <cfargument name="configObj" type="any" required="yes"  hint="The config object thingie" /> --->

	<cfset variables.datasource = arguments.datasource />
	<cfset variables.username = arguments.username />
	<cfset variables.password = arguments.password />
	<cfset variables.database = arguments.database />
	<!--- <cfset variables.configObj = arguments.configObj /> --->


	<cfreturn This />
</cffunction>


<cffunction access="public" name="getTables" output="false" returntype="any" hint="Retrieves all of the tables from a MySql database like sp_help in MSSQL" >

	<cfset var results = "" />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="results">
		SHOW FULL TABLES;
	</cfquery>

	<cfquery dbtype="query" name="results">
		SELECT 	tables_in_#database# as table_name, 'dbo' as owner, 'view' as table_type
		FROM	results
		WHERE	table_type = 'VIEW'
		UNION
		SELECT 	tables_in_#database# as name, 'dbo' as owner, 'user table' as table_type
		FROM	results
		WHERE	table_type = 'BASE TABLE'
	</cfquery>

	<cfreturn results />
</cffunction>

<cffunction access="public" name="getTable" output="false" returntype="struct" hint="Retrieves all of the info about a table from a MySql database like sp_help in MSSQL" >
	<cfargument name="table" type="string" required="yes" default="" hint="The table to retrieve information for. " />

	<cfset var results = structNew()/>
	<cfset var temp = "" />
	<cfset var temp2 = "" />

	<!--- FIRST RESULTSSET --->
	<cfset temp = getTables() />

	<cfquery dbtype="query" name="temp">
		SELECT  table_name, owner, table_type as type
		FROM	temp
		WHERE 	table_name = '#arguments.table#'
	</cfquery>
	<cfset results['tableInfo'] = temp />
	<!--- FIRST RESULTSSET --->

	<!--- SECOND RESULTSSET --->
	<cftry>
		<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
			DESCRIBE #arguments.table#;
		</cfquery>
		<!--- Added this catch here because Error is not that helpful at really telling you what is wrong.  --->
		<cfcatch type="any">
			<cfif FindNoCase("You have an error in your SQL syntax", cfcatch.detail)>
				<cfthrow type="GangPlank" message="MySQL didn't like your table name." detail="Table in question: #UCase(arguments.table)#" />
			<cfelse>
				<cfrethrow />
			</cfif>
		</cfcatch>
	</cftry>

		<!--- THIRD RESULTSSET --->
		<cfquery dbtype="query" name="temp2">
			SELECT 	field as [identity]
			FROM	temp
			WHERE	extra like 'auto_increment'
		</cfquery>
		<cfset results['identityQuery'] = temp2 />
		<!--- THIRD RESULTSSET --->

	<cfquery dbtype="query" name="temp">
		SELECT 	field as column_name, type, 'no' as computed, type as length, type as prec, type as scale, [null] as nullable
		FROM	temp
	</cfquery>

	<cfloop query="temp">
		<cfif FindNoCase("text", temp.length[currentRow])>
			<cfset temp.length[currentRow] = 16 />
		<cfelseif FindNoCase("datetime", temp.length[currentRow])>
			<cfset temp.length[currentRow] = 8 />
		<cfelseif FindNoCase("decimal", temp.length[currentRow])>
			<cfset temp.length[currentRow] = ReReplace(temp.length[currentRow], "[A-Za-z()]", "", "ALL") />
			<cfset temp.length[currentRow] = listFirst(temp.length[currentRow]) />
			<cfset temp.prec[currentRow] = temp.length[currentRow] />
			<cfset temp.scale[currentRow] = ReReplace(temp.scale[currentRow], "[A-Za-z()]", "", "ALL") />
			<cfset temp.scale[currentRow] = listLast(temp.scale[currentRow]) />
		<cfelseif FindNoCase("int", temp.length[currentRow])>
			<cfset temp.length[currentRow] = ReReplace(temp.length[currentRow], "[A-Za-z()]", "", "ALL") />
			<cfset temp.length[currentRow] = listFirst(temp.length[currentRow]) />
			<cfset temp.prec[currentRow] = temp.length[currentRow] />
			<cfset temp.scale[currentRow] = 0 />
		<cfelse>
			<cfset temp.length[currentRow] = ReReplace(temp.length[currentRow], "[A-Za-z()]", "", "ALL") />
		</cfif>
		<cfset temp.type[currentRow] = ReReplace(temp.type[currentRow], "[0-9(),]", "", "ALL") />
		<cfset temp.type[currentRow] = ReplaceNoCase(temp.type[currentRow], "unsigned", "", "ALL") />
	</cfloop>
	<cfset results['dbColumnInfo'] = temp />
	<!--- SECOND RESULTSSET --->

	<!--- SEVENTH RESULTSSET --->
	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SELECT kc.constraint_name, kc.table_name, kc.column_name, kc.referenced_table_name, kc.referenced_column_name, tc.constraint_type, column_name as contraint_keys
		FROM `information_schema`.`KEY_COLUMN_USAGE` kc
		INNER JOIN `information_schema`.`table_constraints` tc
		on kc.table_schema = tc.table_schema AND kc.table_name = tc.table_name AND kc.constraint_name= tc.constraint_name
		WHERE kc.TABLE_SCHEMA = '#variables.database#'
		AND   kc.TABLE_NAME = '#arguments.table#'
	</cfquery>

	<cfset temp2 = QueryNew('constraint_type,constraint_keys, table_name') />

	<cfloop query="temp">
		<cfif FindNoCase("PRIMARY", constraint_type)>
			<cfset QueryAddRow(temp2) />
			<cfset QuerySetCell(temp2, "constraint_type", "PRIMARY KEY") />
			<cfset QuerySetCell(temp2, "constraint_keys", column_name) />
			<cfset QuerySetCell(temp2, "table_name", table_name) />
		<cfelseif FindNoCase("UNIQUE", constraint_type)>
			<cfset QueryAddRow(temp2) />
			<cfset QuerySetCell(temp2, "constraint_type", "UNIQUE") />
			<cfset QuerySetCell(temp2, "constraint_keys", column_name) />
			<cfset QuerySetCell(temp2, "table_name", table_name) />
		<cfelse>
			<cfset QueryAddRow(temp2) />
			<cfset QuerySetCell(temp2, "constraint_type", "FOREIGN KEY") />
			<cfset QuerySetCell(temp2, "constraint_keys", column_name) />
			<cfset QuerySetCell(temp2, "table_name", table_name) />
			<cfset QueryAddRow(temp2) />
			<cfset QuerySetCell(temp2, "constraint_type", "") />
			<cfset QuerySetCell(temp2, "constraint_keys", "REFERENCE #table_name#.dbo.#referenced_table_name# (#referenced_column_name#)") />

		</cfif>

	</cfloop>

	<cfset results['keyInfo'] = temp2 />
	<!--- SEVENTH RESULTSSET --->

	<!--- EIGHTH RESULTSSET --->
	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
	SELECT Concat(table_schema, '.dbo.', table_name, ' :', constraint_name) as tableisreferencedasforeignkeys
	FROM `information_schema`.`KEY_COLUMN_USAGE`
	WHERE TABLE_SCHEMA = '#database#'
	AND   REFERENCED_TABLE_NAME = '#arguments.table#'
	</cfquery>

	<cfset results['referenceData'] = temp />
	<!--- EIGHTH RESULTSSET --->

	<cfreturn results />
</cffunction>

<cffunction access="public" name="getProcText" output="false" returntype="query" hint="query" >
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />

	<cfset var temp = "" />
	<cfset var result = QueryNew('text') />
	<cfset var tempString= "" />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SHOW CREATE PROCEDURE #arguments.proc#
	</cfquery>

	<cfset tempString = temp['create Procedure'] />

	<cfloop list="#tempString#" index="line" delimiters="#chr(13)##chr(10)#">
		<cfset QueryAddRow(result) />
		<cfset QuerySetCell(result, "text", line) />
	</cfloop>

	<cfreturn result />
</cffunction>

<cffunction access="public" name="getProcs" output="false" returntype="query" hint="Retrieves all of the procedures of a MYySQL database in the MSSQL sp_help style. " >

	<cfset var temp = "" />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SELECT  name, 'dbo' as owner, 'stored procedure' as object_type
		FROM    mysql.proc
		WHERE   db='#database#'
	</cfquery>

	<cfreturn temp />
</cffunction>

<cffunction access="public" name="getProc" output="false" returntype="struct" hint="Retrieves information about a proc in a mysql database in the same manner than sp_help does." >
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />

	<cfset var ProcQuery = getProcs() />
	<cfset var temp = "" />
	<cfset var temp2 = "" />
	<cfset var param = "" />
	<cfset var results = StructNew() />
	<cfset var paramString = "" />
	<cfset var paramQuery = QueryNew("parameter_name, type, length, prec, scale, inout") />
	<cfset var paramArray = ArrayNew(1) />

	<cfquery dbtype="query" name="ProcQuery">
		SELECT  *
		FROM	ProcQuery
		WHERE	name = '#arguments.proc#'
	</cfquery>

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SHOW CREATE PROCEDURE #arguments.proc#
	</cfquery>

	<cfset paramString = temp['create Procedure'] />

	<cfset paramString = ReplaceNoCase(paramString, "Procedure", "$", "Once") />
	<cfset paramString = ReplaceNoCase(paramString, "BEGIN", "$", "Once") />
	<cfset paramString = GetToken(Trim(paramString), 2, "$") />
	<cfset paramString = ReplaceNoCase(paramString, "(", "$", "Once") />
	<cfset paramString = Left(paramString, len(paramString)-2) />
	<cfset paramString = GetToken(paramString, 2 ,"$") />
	<cfset paramArray = ReMatch("\([0-9]*[\s]*\,[\s]*[0-9]*\)", paramstring)>


	<cfif ArrayLen(paramArray) gt 0>
		<cfloop array="#paramArray#" index="temp">
			<cfset paramString = ReplaceNoCase(paramString, temp, Replace(temp, ",", ";", "ALL")) />
		</cfloop>
	</cfif>



	<cfloop list="#paramString#" index="param">
		<cfset QueryAddRow(paramQuery) />

		<cfif CompareNoCase("INOUT", getToken(param, 1)) eq 0>
			<cfset QuerySetCell(paramQuery, "inout", "INOUT")>
			<cfset QuerySetCell(paramQuery, "parameter_name", getToken(param, 2))>
			<cfset QuerySetCell(paramQuery, "type", getToken(getToken(param, 3), 1, "(") ) />
			<cfset QuerySetCell(paramQuery, "scale", Trim(Replace(getToken(param, 2, ";"),  ")", "", "ALL")) ) />
			<cfset temp2 = Replace(getToken(getToken(param, 3), 2, "("), ")","", "ALL")>
			<cfset temp2 = Replace(temp2, ";", "", "ALL") />
			<cfset QuerySetCell(paramQuery, "length", temp2 ) />
			<cfset QuerySetCell(paramQuery, "prec", temp2 ) />
		<cfelseif CompareNoCase("OUT", getToken(param, 1)) eq 0>
			<cfset QuerySetCell(paramQuery, "inout", "OUT")>
			<cfset QuerySetCell(paramQuery, "parameter_name", getToken(param, 2))>
			<cfset QuerySetCell(paramQuery, "type", getToken(getToken(param, 3), 1, "(") ) />
			<cfset QuerySetCell(paramQuery, "scale", Trim(Replace(getToken(param, 2, ";"),  ")", "", "ALL")) ) />
			<cfset temp2 = Replace(getToken(getToken(param, 3), 2, "("), ")","", "ALL")>
			<cfset temp2 = Replace(temp2, ";", "", "ALL") />
			<cfset QuerySetCell(paramQuery, "length", temp2 ) />
			<cfset QuerySetCell(paramQuery, "prec", temp2 ) />
		<cfelseif CompareNoCase("IN", getToken(param, 1)) eq 0>
			<cfset QuerySetCell(paramQuery, "inout", "IN")>
			<cfset QuerySetCell(paramQuery, "parameter_name", getToken(param, 2))>
			<cfset QuerySetCell(paramQuery, "type", getToken(getToken(param, 3), 1, "(") ) />
			<cfset QuerySetCell(paramQuery, "scale", Trim(Replace(getToken(param, 2, ";"),  ")", "", "ALL")) ) />
			<cfset temp2 = Replace(getToken(getToken(param, 3), 2, "("), ")","", "ALL")>
			<cfset temp2 = Replace(temp2, ";", "", "ALL") />
			<cfset QuerySetCell(paramQuery, "length", temp2 ) />
			<cfset QuerySetCell(paramQuery, "prec", temp2 ) />
		<cfelse>
			<cfset QuerySetCell(paramQuery, "inout", "IN")>
			<cfset QuerySetCell(paramQuery, "parameter_name", getToken(param, 1))>
			<cfset QuerySetCell(paramQuery, "type", getToken(getToken(param, 2), 1, "(") ) />
			<cfset QuerySetCell(paramQuery, "scale", Trim(Replace(getToken(param, 2, ";"),  ")", "", "ALL")) ) />
			<cfset temp2 = Replace(getToken(getToken(param, 2), 2, "("), ")","", "ALL")>
			<cfset temp2 = Replace(temp2, ";", "", "ALL") />
			<cfset QuerySetCell(paramQuery, "length", temp2 ) />
			<cfset QuerySetCell(paramQuery, "prec", temp2 ) />
		</cfif>





	</cfloop>

	<cfset result.procedure = ProcQuery />
	<cfset result.parameters = paramQuery />

	<cfreturn result />
</cffunction>

<cffunction access="public" name="getProcTextStruct" output="false" returntype="struct" hint="Gets details about stored procedures">
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />

	<cfset var result = StructNew() />
	<cfset var temp = "" />
	<cfset var bodyString = "" />
	<cfset var procQueries = getProc(arguments.proc) />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SHOW CREATE PROCEDURE #arguments.proc#
	</cfquery>

	<cfset bodyString = temp['create Procedure'] />

	<cfset bodyString = ReplaceNoCase(bodyString, "BEGIN", "$", "Once") />
	<cfset bodyString = ReplaceNoCase(bodyString, "END", "$", "Once") />
	<cfset bodyString = GetToken(bodyString, 2, "$") />
	<cfset result.body = bodyString />

	<cfset result.params = ArrayNew(1) />
	<cfloop query="procQueries.parameters">
		<cfset result.params[currentRow] = StructNew() />
		<cfset result.params[currentRow]['default'] = "" />
		<cfset result.params[currentRow]['inout'] = inout />
		<cfset result.params[currentRow]['name'] = parameter_name />
		<cfset result.params[currentRow]['type'] = type />
	</cfloop>





	<cfreturn result />
</cffunction>


</cfcomponent>