<cfprocessingdirective suppresswhitespace="yes">
<cfoutput><!---ul id="toolbar">
	<li><a href="#application.relativePath#">Main</a></li>



	<cfif FindNoCase("configbuilder", cgi.script_name)>
		<li>Add Application</li>
	<cfelse>
		<li><a href="#application.relativePath#/ApplicationBuilder.cfm" title="Add Application">Add Application</a></li>
	</cfif>

	<cfif FindNoCase("/docs/", cgi.script_name)>
		<li>Documentation</li>
	<cfelse>
		<li><a href="#application.relativePath#/docs/index.cfm" title="Documentation">Documentation</a></li>
	</cfif>

</ul--->
    <header class="navbar navbar-inverse navbar-fixed-top bs-docs-nav" role="banner">
        <div class="container">
            <div class="navbar-header">
                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="../" class="navbar-brand">GangPlank :: Scaffolding Engine</a>
            </div>
            <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
                <ul class="nav navbar-nav">
                  <li><a href="#application.relativePath#">Main</a></li>
                  <li><a href="#application.relativePath#/ApplicationBuilder.cfm" title="Add Application">Add Application</a></li>
                  <li><a href="#application.relativePath#/docs/index.cfm" title="Documentation">Documentation</a></li>
                </ul>
                <!---ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="http://www.jasny.net"><span class="hidden-sm">More by</span> Jasny</a>
                    </li>
                </ul--->
            </nav>
        </div>
    </header>
</cfoutput>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />