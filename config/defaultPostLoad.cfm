<!--- CFC Locations --->
<!--- Not cfparaming, because I'm snot sure why I didn't below. ' --->


<cfif not StructKeyExists(config['cfc'],  "database")>
	<cfset config['cfc']['database'] = "cfc." & config['db']['type'] & ".database" />
</cfif>

<cfif not StructKeyExists(config['cfc'],  "sqlstoredproc")>
	<cfset config['cfc']['sqlstoredproc'] = "cfc." & config['db']['type'] & ".sqlstoredproc" />
</cfif>

<cfif not StructKeyExists(config['cfc'],  "sqlstoredprocactive")>
	<cfset config['cfc']['sqlstoredprocactive'] = "cfc." & config['db']['type'] & ".sqlstoredprocactive" />
</cfif>

<cfif not StructKeyExists(config['cfc'],  "constants")>
	<cfset config['cfc']['constants'] = "cfc." & config['db']['type'] & ".constants" />
</cfif>

<cfif not StructKeyExists(config['cfc'],  "table")>
	<cfset config['cfc']['table'] = "cfc." & config['db']['type'] & ".table" />
</cfif>

<cfif not StructKeyExists(config['cfc'],  "help")>
	<cfset config['cfc']['help'] = "cfc." & config['db']['type'] & ".help" />
</cfif>

<cfif not StructKeyExists(config['cfc'],  "fk")>
	<cfset config['cfc']['fk'] = "cfc." & config['db']['type'] & ".foreignKey" />
</cfif>

<!--- Filelocations --->
<!--- I wish I had commented why I wasn't cfparaming these --->
<cfif not StructKeyExists(config['fileLocations'],  "webroot")>
	<cfset config['fileLocations']['webroot'] = expandPath('/') />
</cfif>
<cfif not StructKeyExists(config['fileLocations'],  "logs")>
	<cfset config['fileLocations']['logs'] = config['fileLocations']['output'] & "/logs" />						<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'],  "cfc")>
	<cfset config['fileLocations']['cfc'] = config['fileLocations']['output'] & "/cfc" />						<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "dao")>
	<cfset config['fileLocations']['dao'] = config['fileLocations']['cfc'] & "/dao" />							<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "gateway")>
	<cfset config['fileLocations']['gateway'] = config['fileLocations']['cfc'] & "/gateway" />					<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "dynamicdao")>
	<cfset config['fileLocations']['dynamicdao'] = config['fileLocations']['dao'] & "/dynamic" />				<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "dynamicgateway")>
	<cfset config['fileLocations']['dynamicgateway'] = config['fileLocations']['gateway'] & "/dynamic" />		<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "customtags")>
	<cfset config['fileLocations']['customtags'] = config['fileLocations']['output'] & "/customtags" />			<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "customtagsdynamic")>
	<cfset config['fileLocations']['customtagsdynamic'] = config['fileLocations']['customtags'] & "/dynamic" />	<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "cfml")>
	<cfset config['fileLocations']['cfml'] = config['fileLocations']['output'] />								<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "css")>
	<cfset config['fileLocations']['css'] = config['fileLocations']['output'] & "/css" />								<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "sql")>
	<cfset config['fileLocations']['sql'] = config['fileLocations']['output'] & "/sql" />						<!--- I would prefer you don't touch this.  --->
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "business")>
	<cfset config['fileLocations']['business'] = config['fileLocations']['cfc'] & "/business" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "businessdynamic")>
	<cfset config['fileLocations']['businessdynamic'] = config['fileLocations']['business'] & "/dynamic" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "test")>
	<cfset config['fileLocations']['test'] = config['fileLocations']['output'] & "/test" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "testdao")>
	<cfset config['fileLocations']['testdao'] = config['fileLocations']['test'] & "/dao" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "testdynamicdao")>
	<cfset config['fileLocations']['testdynamicdao'] = config['fileLocations']['testdao'] & "/dynamic" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "testgateway")>
	<cfset config['fileLocations']['testgateway'] = config['fileLocations']['test'] & "/gateway" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "testdynamicgateway")>
	<cfset config['fileLocations']['testdynamicgateway'] = config['fileLocations']['testgateway'] & "/dynamic" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "testbusiness")>
	<cfset config['fileLocations']['testbusiness'] = config['fileLocations']['test'] & "/business" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "testinterface")>
	<cfset config['fileLocations']['testinterface'] = config['fileLocations']['test'] & "/interface" />
</cfif>
<cfif not StructKeyExists(config['fileLocations'], "docs")>
	<cfset config['fileLocations']['docs'] = config['fileLocations']['output'] & "/docs" />								<!--- I would prefer you don't touch this.  --->
</cfif>

<cfif not StructKeyExists(config['fileLocations'], "temp")>
	<cfset config['fileLocations']['temp'] = config['fileLocations']['output'] & "/temp" />								<!--- I would prefer you don't touch this.  --->
</cfif>

<cfif not StructKeyExists(config['fileLocations'], "images")>
	<cfset config['fileLocations']['images'] = config['fileLocations']['output'] & "/img" />								<!--- I would prefer you don't touch this.  --->
</cfif>

<cfif not StructKeyExists(config['fileLocations'], "config")>
	<cfset config['fileLocations']['config'] = config['fileLocations']['output'] & "/config" />								<!--- I would prefer you don't touch this.  --->
</cfif>



