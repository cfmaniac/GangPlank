<!--- These settings are particular to the application you are creating.  --->
<cfset config['application']['appname'] = "sample" />
<cfset config['application']['CFCpathCFCStyle'] = "GangPlank2.apps.sample.cfc" />

<!--- Filelocations --->
<cfset config['fileLocations']['output'] = "w:\inetpub\wwwroot\sample" />	<!--- Definately set this.  --->
<cfset config['application']['url'] = "http://webhost.com/sample" />

<!--- Database settings --->
<cfset config['db']['datasource'] = "" />		<!--- Mandatory --->
<cfset config['db']['username'] = "" />			<!--- optional --->
<cfset config['db']['password'] = "" />			<!--- optional --->