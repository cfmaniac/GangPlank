
			<!--- These settings are particular to the application you are creating.  --->
<cfset config['application']['appname'] = "PlantSearch" />
<cfset config['application']['CFCpathCFCStyle'] = "GangPlank.Applications.PlantSearch.cfc" />

<!--- Filelocations --->
<cfset config['fileLocations']['output'] = "C:\inetpub\wwwroot\Sites\localhost\GangPlank\Applications\PlantSearch" />	<!--- Definately set this.  --->
<cfset config['application']['url'] = "http://localhost.com/GangPlank/Applications/PlantSearch" />

<!--- Database settings --->
<cfset config['db']['datasource'] = "plantsearch" />		<!--- Mandatory --->
<cfset config['db']['username'] = "" />			<!--- optional --->
<cfset config['db']['password'] = "" />			<!--- optional --->
<cfset config['db']['database'] = "" />			<!--- optional --->
<cfset config['db']['type'] = "mssql" />			<!--- optional --->
<cfset config['settings']['CFCpathCFCStyle'] = "GangPlank.cfc" />

		
