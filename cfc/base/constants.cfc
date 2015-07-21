<cfcomponent output="false">

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
		<cfargument name="configObj" type="any" required="yes" hint="A GangPlank config object. " />
		<cfset variables.configObj = arguments.configObj />
		<cfreturn This />
	</cffunction>


	<cffunction access="public" name="getInfo" output="false" returntype="struct" description="Retrieves information for handling different datatypes." >
		<cfargument name="datatype" type="string" required="yes" hint="A sql datatype to analyze." />

		<cfset var result = structNew() />

		<cfset result.cfsqltype = "" />
		<cfset result.argumenttype = "" />
		<cfset result.defaultvalue = "" />

		<cfswitch expression="#arguments.datatype#">
			<cfcase value="text,ntext">
				<cfset result.cfsqltype = "CF_SQL_LONGVARCHAR" />
				<cfset result.argumenttype = "string" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','string') />
			</cfcase>
			<cfcase value="clob,nclob">
				<cfset result.cfsqltype = "CF_SQL_CLOB" />
				<cfset result.argumenttype = "string" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','string') />
			</cfcase>
			<cfcase value="int,smallint">
				<cfset result.cfsqltype = "CF_SQL_INTEGER" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="numeric">
				<cfset result.cfsqltype = "CF_SQL_NUMERIC" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="tinyint">
				<cfset result.cfsqltype = "CF_SQL_TINYINT" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="float,number">
				<cfset result.cfsqltype = "CF_SQL_FLOAT" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="money,decimal,smallmoney">
				<cfset result.cfsqltype = "CF_SQL_DECIMAL" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="datetime,smalldatetime">
				<cfset result.cfsqltype = "CF_SQL_TIMESTAMP" />
				<cfset result.argumenttype = "date" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','date') />
			</cfcase>
			<cfcase value="binary,varbinary">
				<cfset result.cfsqltype = "CF_SQL_BINARY" />
				<cfset result.argumenttype = "any" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','binary') />
			</cfcase>
			<cfcase value="image">
				<cfset result.cfsqltype = "CF_SQL_BLOB" />
				<cfset result.argumenttype = "any" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','binary') />
			</cfcase>
			<cfcase value="blob">
				<cfset result.cfsqltype = "CF_SQL_BLOB" />
				<cfset result.argumenttype = "any" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','binary') />
			</cfcase>
			<cfcase value="char,nchar">
				<cfset result.cfsqltype = "CF_SQL_CHAR" />
				<cfset result.argumenttype = "string" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','string') />
			</cfcase>
			<cfcase value="bit">
				<cfset result.cfsqltype = "CF_SQL_BIT" />
				<cfset result.argumenttype = "any" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','boolean') />
			</cfcase>
			<cfcase value="bigint">
				<cfset result.cfsqltype = "CF_SQL_BIGINT" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="real">
				<cfset result.cfsqltype = "CF_SQL_REAL" />
				<cfset result.argumenttype = "numeric" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','numeric') />
			</cfcase>
			<cfcase value="sql_variant">
				<cfset result.cfsqltype = "CF_SQL_VARCHAR" />
				<cfset result.argumenttype = "string" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','string') />
			</cfcase>
			<cfcase value="uniqueidentifier">
				<cfset result.cfsqltype = "CF_SQL_IDSTAMP" />
				<cfset result.argumenttype = "string" />
				<cfset result.defaultvalue = variables.configObj.get('defaults','string') />
			</cfcase>
			<cfdefaultcase>
				<cfif findNoCase("varchar", arguments.datatype)>
					<cfset result.cfsqltype = "CF_SQL_VARCHAR" />
					<cfset result.argumenttype = "string" />
					<cfset result.defaultvalue = "" />
				</cfif>
			</cfdefaultcase>
		</cfswitch>


		<cfreturn result />
	</cffunction>




</cfcomponent>