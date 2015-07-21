<cfcomponent output="false">

<!---*****************************************************--->
<!---init--->
<!---This is the pseudo constructor that allows us to play little object games.--->
<!---*****************************************************--->
<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
	<cfargument name="datasource" type="string" required="yes"  hint="The datasource to look at. " />
	<cfargument name="username" type="string" required="yes"  hint="The username to look with. " />
	<cfargument name="password" type="string" required="yes"  hint="The datasource to look with. " />
	<cfargument name="database" type="string" default=""  hint="The database to look at. " />
	<cfargument name="configObj" type="any" required="yes"  hint="The config object thingie" />

	<cfset variables.datasource = arguments.datasource />
	<cfset variables.username = arguments.username />
	<cfset variables.password = arguments.password />
	<cfset variables.database = arguments.database />
	<cfset variables.configObj = arguments.configObj />


	<cfreturn This />
</cffunction>


<cffunction access="public" name="getTables" output="false" returntype="any" hint="Retrieves all of the tables from a MySql database like sp_help in MSSQL" >

	<cfset var dbtables = "" />

	<cfif len(username) gt 0 and len(password) gt 0>
		<cfset db.username = username />
		<cfset db.password = password />
	</cfif>
	<cfset db.datasource = datasource />
	<cfset db.procedure = "sp_help" />

	<cfstoredProc attributeCollection="#db#">
		<cfprocresult name="dbtables" resultset="1" />
	</cfstoredProc>

	<!--- You maybe be wondering why the odd transformation here.  I was using another method to get the db info... the cfdbinfo.  Either you get that or not. --->
	<cfquery name="dbtables" dbtype="query" debug="0">
		SELECT 	name AS table_name, object_type AS table_type
		FROM	dbtables
		WHERE	object_type IN ('user table','view')
		AND		name not like 'sys%'
		AND		name not like 'dtproperties%'
		AND		owner not like 'INFORMATION_SCHEMA'
		AND		owner not like 'sys'

		<cfif len(configObj.get('settings', 'excludedTableList')) gt 0>
		AND		name not in (<cfqueryparam value="#configObj.get('settings', 'excludedTableList')#" list="yes" CFSQLType="CF_SQL_VARCHAR" />)
		</cfif>

		<cfif len(configObj.get('reservedWords', 'excludedTablePrefix')) gt 0>
		AND		name not like '#configObj.get('reservedWords', 'excludedTablePrefix')#%'
		</cfif>

	</cfquery>

	<cfreturn dbtables />
</cffunction>

<cffunction access="public" name="getTable" output="false" returntype="struct" hint="Retrieves all of the info about a table from a MySql database like sp_help in MSSQL" >
	<cfargument name="table" type="string" required="yes" default="" hint="The table to retrieve information for. " />

	<cfset var db = StructNew() />
	<cfset var result = StructNew() />

	<cfif len(username) gt 0 and len(password) gt 0>
		<cfset db.username = username />
		<cfset db.password = password />
	</cfif>
	<cfset db.datasource = datasource />
	<cfset db.procedure = "sp_help" />

	<cfstoredProc attributeCollection="#db#">
		<cfprocparam type="In" cfsqltype="CF_SQL_CHAR" value="#arguments.table#" null="no" />
		<cfprocresult name="result.tableInfo" resultset="1" />
		<cfprocresult name="result.dbColumnInfo" resultset="2" />
		<cfprocresult name="result.identityQuery" resultset="3" />
		<cfprocresult name="result.keyInfo" resultset="7" />
		<cfprocresult name="result.referenceData" resultset="8" />
	</cfstoredProc>

	<cfif not structKeyExists(result,"keyInfo") >
		<cfset result.keyInfo = QueryNew("") />
	</cfif>

	<cfif not structKeyExists(result,"referenceData") >
		<cfset result.referenceData = QueryNew("") />
	</cfif>

	<cfreturn result />
</cffunction>

<cffunction access="public" name="getProcs" output="false" returntype="query" hint="Retrieves all of the procs from a MSSQL database like sp_help in MSSQL" >


	<cfset var dbprocedures = "" />

	<cfif len(username) gt 0 and len(password) gt 0>
		<cfset db.username = username />
		<cfset db.password = password />
	</cfif>
	<cfset db.datasource = datasource />
	<cfset db.procedure = "sp_help" />

	<cfstoredProc attributeCollection="#db#">
		<cfprocresult name="dbprocedures" resultset="1" />
	</cfstoredProc>

	<!--- Get only user created ones. --->
	<cfquery name="dbprocedures" dbtype="query" debug="0">
		SELECT 	*
		FROM	dbprocedures
		WHERE	NAME like 'usp_%'
		AND		OBJECT_TYPE= 'stored procedure'
		AND		NAME not like 'usp_dt%'
	</cfquery>



	<cfreturn dbprocedures />
</cffunction>



<cffunction access="public" name="getProc" output="false" returntype="struct" hint="query" >
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />

	<cfset var db = StructNew() />
	<cfset var result = StructNew() />

	<cfif len(username) gt 0 and len(password) gt 0>
		<cfset db.username = username />
		<cfset db.password = password />
	</cfif>
	<cfset db.datasource = datasource />
	<cfset db.procedure = "sp_help" />

	<cfstoredProc attributeCollection="#db#">
		<cfprocparam type="In" cfsqltype="CF_SQL_CHAR" value="#arguments.proc#" null="no" />
		<cfprocresult name="result.procedure" resultset="1" />
		<cfprocresult name="result.parameters" resultset="2" />
	</cfstoredProc>

	<cfif not structKeyExists(result,"parameters") >
		<cfset result.parameters = QueryNew("") />
	</cfif>


	<cfreturn result />
</cffunction>


<cffunction access="public" name="getProcText" output="false" returntype="query" hint="query" >
	<cfargument name="proc" type="string" required="yes" hint="The procedure to retrieve. " />

	<cfset var db = StructNew() />
	<cfset var result = "" />

	<cfif len(username) gt 0 and len(password) gt 0>
		<cfset db.username = username />
		<cfset db.password = password />
	</cfif>
	<cfset db.datasource = datasource />
	<cfset db.procedure = "sp_helptext" />

	<cfstoredProc attributeCollection="#db#">
		<cfprocparam type="In" cfsqltype="CF_SQL_CHAR" value="#arguments.proc#" null="no" />
		<cfprocresult name="result" resultset="1" />
	</cfstoredProc>


	<cfreturn result />
</cffunction>

</cfcomponent>