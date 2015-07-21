<cfoutput>&lt;!--- These settings are particular to the application you are creating.  ---&gt;
&lt;cfset config['application']['appname'] = "#form.appName#" /&gt;
&lt;cfset config['application']['CFCpathCFCStyle'] = "#cfcPath#" /&gt;

&lt;!--- Filelocations ---&gt;
&lt;cfset config['fileLocations']['output'] = "#form.appdir#" /&gt;	&lt;!--- Definately set this.  ---&gt;
&lt;cfset config['application']['url'] = "#form.appurl#" /&gt;

&lt;!--- Database settings ---&gt;
&lt;cfset config['db']['datasource'] = "#form.datasource#" /&gt;		&lt;!--- Mandatory ---&gt;
&lt;cfset config['db']['username'] = "#form.username#" /&gt;			&lt;!--- optional ---&gt;
&lt;cfset config['db']['password'] = "#form.password#" /&gt;			&lt;!--- optional ---&gt;
&lt;cfset config['db']['database'] = "#form.database#" /&gt;			&lt;!--- optional ---&gt;
&lt;cfset config['db']['type'] = "#form.type#" /&gt;			&lt;!--- optional ---&gt;
&lt;cfset config['settings']['CFCpathCFCStyle'] = "#GangPlankpath#" /&gt;
</cfoutput>