<!--- Filelocations --->
<cfset config['fileLocations']['output'] = ExpandPath(".") & "\bin"/>

<cfset config['db']['type'] = "mssql" />

<cfset config['settings']['defaultFunctionAccess'] = "public" />
<cfset config['settings']['excludedTableList'] = "" />
<cfset config['settings']['dboprocs'] = "select,update,insert,delete" />
<cfset config['settings']['applicationTemplate'] = "default" />
<cfset config['settings']['generateSQLScript'] = FALSE />
<cfset config['settings']['generateStoredProcedureFiles'] = FALSE />
<cfset config['settings']['ignoreXMLCache'] = FALSE />

<cfset config['application']['cssPath'] = "css/" />
<cfset config['application']['imagePath'] = "img/" />

<!--- Configure the steps the application will take. --->
<cfset config['application']['steps'] = arrayNew(1) />
<cfset arrayAppend(config['application']['steps'], "buildDirectories") />
<cfset arrayAppend(config['application']['steps'], "sqlAnalyzeTables") />
<cfset arrayAppend(config['application']['steps'], "sqlWriteStoredProcs") />
<cfset arrayAppend(config['application']['steps'], "sqlAnalyzeProcs") />
<cfset arrayAppend(config['application']['steps'], "cfc_dao_gateway") />
<cfset arrayAppend(config['application']['steps'], "cfc_business") />
<cfset arrayAppend(config['application']['steps'], "customtags") />
<cfset arrayAppend(config['application']['steps'], "cfms") />
<cfset arrayAppend(config['application']['steps'], "ant") />
<cfset arrayAppend(config['application']['steps'], "refreshApplication") />

<!--- These are default values for different variables types. --->
<cfset config['defaults']['numeric'] = "-9999" />
<cfset config['defaults']['string'] = "" />
<cfset config['defaults']['boolean'] = "" />
<cfset config['defaults']['date'] = "#DateAdd('yyyy',100,now())#" />
<cfset config['defaults']['binary'] = "" />
<cfset config['defaults']['CF_SQL_TINYINT'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_INTEGER'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_VARCHAR'] = config['defaults']['string'] />
<cfset config['defaults']['CF_SQL_CHAR'] = config['defaults']['string'] />
<cfset config['defaults']['CF_SQL_TIMESTAMP'] = config['defaults']['date'] />
<cfset config['defaults']['CF_SQL_BINARY'] = config['defaults']['binary'] />
<cfset config['defaults']['CF_SQL_BLOB'] = config['defaults']['binary'] />
<cfset config['defaults']['CF_SQL_LONGVARBINARY'] = config['defaults']['binary'] />
<cfset config['defaults']['CF_SQL_LONGVARCHAR'] = config['defaults']['string'] />
<cfset config['defaults']['CF_SQL_CLOB'] = config['defaults']['string'] />
<cfset config['defaults']['CF_SQL_DECIMAL'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_FLOAT'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_BIT'] = 0 />
<cfset config['defaults']['CF_SQL_NUMERIC'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_BIGINT'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_REAL'] = config['defaults']['numeric'] />
<cfset config['defaults']['CF_SQL_IDSTAMP'] = createUUID() />

<!--- These are UI settings for chnaging the way the ui is rendered --->
<cfset config['ui']['RichTextAreas'] = TRUE />
<cfset config['ui']['RichTextAreasSkin'] = "default" />
<cfset config['ui']['RichTextAreasToolbar'] = "Basic" />

<cfset config['ui']['DateField'] = TRUE />

<cfset config['ui']['Images'] = TRUE />
<cfset config['ui']['ImageListWidth'] = 100 />
<cfset config['ui']['ImageReadWidth'] = 200 />

<!--- These options handle how particular column names will be treated.  --->
<cfset config['reservedwords']['createdOn'] = "createdOn" />	<!--- Will be set to CURRENT_TIMESTAMP by the database only on item creation  --->
<cfset config['reservedwords']['updatedOn'] = "updatedOn" />	<!--- Will be set to CURRENT_TIMESTAMP by the database on item creation and update  --->
<cfset config['reservedwords']['createdBy'] = "createdBy" />	<!--- Will be available to insert operations. --->
<cfset config['reservedwords']['updatedBy'] = "updatedBy" />	<!--- No Restrictions yet. --->
<cfset config['reservedwords']['active'] = "active" />			<!--- Will change the behavior of delete and list operations to deactivate instead of delete. --->
<cfset config['reservedwords']['excludedTablePrefix'] = "exclude_" />
<cfset config['reservedwords']['password'] = "password" />	<!--- Will be shown in the ui as a password input instead of a text input.   --->


<!--- CFC Locations --->
<cfset config['cfc']['cfc'] = "cfc.cfc" />
<cfset config['cfc']['cfstoredproc'] = "cfc.cfstoredproc" />
<cfset config['cfc']['customtag'] = "cfc.customtag" />
<cfset config['cfc']['function'] = "cfc.function" />
<cfset config['cfc']['functionHelper'] = "cfc.functionhelper" />
<cfset config['cfc']['cfUnitPath'] = "net.sourceforge.cfunit.framework" />

<!--- Email Details --->
<cfset config['notify']['to'] = "" />
<cfset config['notify']['from'] = "" />

<!--- Font Details --->
<cfif FindNoCase("windows", server.os.name)>
	<cfset config['ui']['logoBuild'] = TRUE />
	<cfset config['ui']['LogoFont'] = "Arial"/>
<cfelse>
	<cfset config['ui']['logoBuild'] = FALSE />
	<cfset config['ui']['LogoFont'] = "Helvetica"/>
</cfif>