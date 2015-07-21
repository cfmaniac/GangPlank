<cfcomponent output="false">

<!---*****************************************************--->
<!---init--->
<!---This is the pseudo constructor that allows us to play little object games.--->
<!---*****************************************************--->
<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
	<cfargument name="datasource" type="string" required="yes"  hint="The datasource to look at. " />
	<cfargument name="username" type="string" required="yes"  hint="The username to look with. " />
	<cfargument name="password" type="string" required="yes"  hint="The datasource to look with. " />
	<!--- <cfargument name="database" type="string" required="yes"  hint="The database to look at. " /> --->
	<!--- <cfargument name="configObj" type="any" required="yes"  hint="The config object thingie" /> --->

	<cfset variables.datasource = arguments.datasource />
	<cfset variables.username = arguments.username />
	<cfset variables.password = arguments.password />
	<!--- <cfset variables.database = arguments.database /> --->
	<!--- <cfset variables.configObj = arguments.configObj /> --->


	<cfreturn This />
</cffunction>


<cffunction access="public" name="getTables" output="false" returntype="any" hint="Retrieves all of the tables from a MySql database like sp_help in MSSQL" >

	<cfset var results = "" />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="results">
		SELECT 	TABLE_NAME, 'dbo' as owner, 'user table' as table_type
		FROM 	TABS
		WHERE 	TABLE_NAME != 'HTMLDB_PLAN_TABLE'
		UNION
		SELECT 	VIEW_NAME as table_name, 'dbo' as owner, 'view' as table_type
		FROM 	USER_VIEWS
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
			SELECT column_name, data_type as type, 'no' as computed, data_length as length, DATA_PRECISION as prec, DATA_SCALE as scale, nullable
			FROM user_tab_columns
			WHERE table_name='#arguments.table#'
		</cfquery>

		<cfloop query="temp">
			<cfif FindNoCase("Y",nullable)>
				<cfset temp['nullable'][currentRow] = "yes" />
			<cfelse>
				<cfset temp['nullable'][currentRow] =  "no" />
			</cfif>
		</cfloop>

		<!--- Added this catch here because Error is not that helpful at really telling you what is wrong.  --->
		<cfcatch type="any">
			<cfif FindNoCase("You have an error in your SQL syntax", cfcatch.detail)>
				<cfthrow type="GangPlank" message="ORACLE didn't like your table name." detail="Table in question: #UCase(arguments.table)#" />
			<cfelse>
				<cfrethrow />
			</cfif>
		</cfcatch>
	</cftry>

	<cfloop query="temp">
		<cfif FindNoCase("text", temp.length[currentRow])>
			<cfset temp.length[currentRow] = 16 />
		<cfelseif FindNoCase("datetime", temp.length[currentRow])>
			<cfset temp.length[currentRow] = 8 />
		<cfelse>
			<cfset temp.length[currentRow] = ReReplace(temp.length[currentRow], "[A-Za-z()]", "", "ALL") />
		</cfif>
		<cfset temp.type[currentRow] = ReReplace(temp.type[currentRow], "[0-9()]", "", "ALL") />
		<cfset temp.type[currentRow] = ReplaceNoCase(temp.type[currentRow], "unsigned", "", "ALL") />
	</cfloop>
	<cfset results['dbColumnInfo'] = temp />
	<!--- SECOND RESULTSSET --->

	<!--- THIRD RESULTSSET --->
	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp2">
		SELECT column_name as identity
		FROM user_constraints co
		INNER JOIN USER_IND_COLUMNS cl on co.index_name = cl.index_name
		WHERE co.table_name = '#arguments.table#'
		AND co.constraint_type = 'P'
	</cfquery>
	<cfset results['identityQuery'] = temp2 />
	<!--- THIRD RESULTSSET --->

	<!--- SEVENTH RESULTSSET --->
	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SELECT 	alc.constraint_name, alc.table_name, cols.column_name,
				r_alc.table_name "referenced_table_name", r_cols.column_name "referenced_column_name",
				CASE alc.constraint_type WHEN 'P' THEN 'PRIMARY KEY' WHEN 'R' THEN 'FOREIGN KEY' WHEN 'U' THEN 'UNIQUE' WHEN 'C' THEN 'CHECK' END "constraint_type",
				cols.column_name "contraint_keys"
		FROM 	all_cons_columns cols
		LEFT JOIN all_constraints alc ON alc.constraint_name = cols.constraint_name AND alc.owner = cols.owner
		LEFT JOIN all_constraints r_alc ON alc.r_constraint_name = r_alc.constraint_name AND alc.r_owner = r_alc.owner
		LEFT JOIN all_cons_columns r_cols ON r_alc.constraint_name = r_cols.constraint_name AND r_alc.owner = r_cols.owner AND cols.position = r_cols.position
		WHERE 	alc.constraint_name = cols.constraint_name
		AND  	alc.table_name = '#arguments.table#'
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
	SELECT  alc.table_name||':'||alc.constraint_name as "tableisreferencedasforeignkeys"
	FROM all_cons_columns cols
	LEFT JOIN all_constraints alc ON alc.constraint_name = cols.constraint_name AND alc.owner = cols.owner
	LEFT JOIN all_constraints r_alc ON alc.r_constraint_name = r_alc.constraint_name AND alc.r_owner = r_alc.owner
	LEFT JOIN all_cons_columns r_cols ON r_alc.constraint_name = r_cols.constraint_name AND r_alc.owner = r_cols.owner AND cols.position = r_cols.position

	WHERE alc.constraint_name = cols.constraint_name
	AND alc.constraint_type = 'R'
	AND  r_alc.table_name = '#arguments.table#'
	</cfquery>

	<cfset results['referenceData'] = temp />
	<!--- EIGHTH RESULTSSET --->

	<cfreturn results />
</cffunction>



<cffunction access="public" name="getProcs" output="false" returntype="query" hint="Retrieves all of the procedures of a MYySQL database in the MSSQL sp_help style. " >

	<cfset var temp = "" />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="temp">
		SELECT  object_name|| '.' ||procedure_name "name", 'dbo' "owner", 'stored procedure' "object_type"
		FROM 	USER_PROCEDURES
	</cfquery>

	<cfreturn temp />
</cffunction>

<cffunction access="public" name="getProc" output="false" returntype="struct" hint="Retrieves information about a proc in a mysql database in the same manner than sp_help does." >
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />

	<cfset var ProcQuery = getProcs() />
	<cfset var temp = "" />
	<cfset var param = "" />
	<cfset var results = StructNew() />
	<cfset var paramString = "" />
	<cfset var paramQuery = QueryNew("parameter_name, type, length, prec, scale, inout") />

	<<cfset var packageName = GetToken(arguments.proc, 1, ".") />
	<cfset var procName = GetToken(arguments.proc, 2, ".") />

	<cfquery dbtype="query" name="result.procedure">
		SELECT  *
		FROM	ProcQuery
		WHERE	name = '#arguments.proc#'
	</cfquery>

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="result.parameters">
		SELECT IN_OUT "INOUT", argument_name "parameter_name", DATA_TYPE  "type", DATA_LENGTH "length", DATA_SCALE "scale", DATA_PRECISION "prec"
		FROM USER_ARGUMENTS
		WHERE object_name = '#procName#'
		AND	package_name = '#packageName#'
		AND DATA_LEVEL = 0
		AND DATA_TYPE != 'REF CURSOR'
		ORDER BY DATA_LEVEL, POSITION
	</cfquery>


	<cfreturn result />
</cffunction>

<cffunction access="public" name="getProcText" output="false" returntype="query" hint="query" >
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />


	<cfset var result = "" />
	<cfset var returnQuery = QueryNew('text') />
	<cfset var procText = "" />
	<cfset var i = 0 />
	<cfset var strStruct = StructNew() />
	<cfset var packageName = GetToken(arguments.proc, 1, ".") />
	<cfset var procName = GetToken(arguments.proc, 2, ".") />

	<cfquery datasource="#datasource#" username="#username#" password="#password#" name="result">
		SELECT TEXT
		FROM USER_SOURCE
		WHERE TYPE= 'PACKAGE BODY'
		AND NAME = '#packageName#'
		ORDER BY 	LINE
	</cfquery>

	<cfloop query="result">
		<cfif ReFindNoCase("PROCEDURE[\s]+#procName#",text)>
			<cfset strStruct.start = currentRow />
		</cfif>
		<cfif structKeyExists(strStruct, "start") AND len(strStruct.start) gt 0 AND FindNoCase("END;", text)>
			<cfset strStruct.end = currentRow />
			<cfbreak />
		</cfif>

	</cfloop>

	<cfloop index="i" from="#strStruct.start#" to="#strStruct.end#">
		<cfset QueryAddRow(returnQuery) />
		<cfset QuerySetCell(returnQuery, "text", result.text[i]) />
	</cfloop>





	<cfreturn returnQuery />
</cffunction>

</cfcomponent>