<cfparam name="url.method" type="string" default="" />


<cfimport taglib="customtags" prefix="pageElement" />




<cfswitch expression="#url.method#">
	<cfcase value="createConfig">


		<cfset cfcPath = form.appdir & "/cfc" />
		<cfset cfcPath = Replace(cfcPath, "//", "/", "ALL") />
		<cfset cfcPath = ReplaceNoCase(cfcPath, expandPath("/"), "", "ALL") />
		<cfset cfcPath = ReplaceNoCase(cfcPath, "/", ".", "ALL") />
		<cfset cfcPath = ReplaceNoCase(cfcPath, "\", ".", "ALL") />

		<cfset GangPlankpath = ExpandPath('.') & "/cfc" />
		<cfset GangPlankpath = Replace(GangPlankpath, "//", "/", "ALL") />
		<cfset GangPlankpath = ReplaceNoCase(GangPlankpath, expandPath("/"), "", "ALL") />
		<cfset GangPlankpath = ReplaceNoCase(GangPlankpath, "/", ".", "ALL") />
		<cfset GangPlankpath = ReplaceNoCase(GangPlankpath, "\", ".", "ALL") />


		<cfif FileExists("#expandPath('.')#/config/#form.appName#.cfm")>
			<pageElement:header>
				<h2>No You Don't!</h2>
				<p>That configuration file already exists. Don't go blaming me for overwriting your config. You'll have to delete that configuration file yourself.</p>
				<p><a href="ApplicationBuilder.cfm">Try Again</a></p>
			<pageElement:footer>
			<cfabort />
		</cfif>

		<cfsavecontent variable="configFileContents">
			<cfinclude template="includes/defaultConfig.cfm" />
		</cfsavecontent>


		<cfset configFileContents = Replace(configFileContents, "&lt;", "<", "ALL") />
		<cfset configFileContents = Replace(configFileContents, "&gt;", ">", "ALL") />

		<cffile action="write" file="#expandPath('.')#/config/#form.appName#.cfm" output="#configFileContents#" />

		<pageElement:header>
			<!---h2>Configuration Created</h2>
			<p>The configuration was created successfully.</p>
			<p><a href="index.cfm">Main Menu</a></p--->

            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title"><cfoutput>#form.appName#</cfoutput> Configuration Created</h3>
                </div>
                <div class="panel-body">
                    The configuration file was created successfully.
                    <a href="<cfoutput>#application.relativePath#</cfoutput>" class="btn btn-default pull-left">Return to Main</a> <a href="<cfoutput>#application.relativePath#?method=run&amp;appName=#form.appName#</cfoutput>" class="btn btn-info pull-right">Scaffold your Appication Now</a>
                </div>
            </div>

		<pageElement:footer>


	</cfcase>
	<cfdefaultcase>
		<cfset rootpath= ExpandPath('/') />
		<cfset urlPath= "http://" & cgi.server_name   />

		<cfoutput>
		<cfsavecontent variable="javascriptToInsert">
			<script type="text/javascript">

			function updatefields(){
			appname = document.getElementById('appname');
			appdir = document.getElementById('appdir');
			appurl = document.getElementById('appurl');


		appurl.value = "#urlPath#" + "/" + appname.value;
		appdir.value = "#Replace(rootpath, "\", "\\", "ALL")#" + appname.value;

			}

			</script>

		</cfsavecontent>
		</cfoutput>

		<cfhtmlhead text="#javascriptToInsert#" />

		<pageElement:header>
            <cfform action="#cgi.script_name#?method=createConfig" method="post">
         <div class="panel panel-primary">
            <div class="panel-heading">Application Information</div>
            <div class="panel-body">
                <div class="form-group">
                    <label for="exampleInputEmail1">Application Name</label>
                <cfinput id="appname" class="form-control" name="appname" type="text"  onchange="updatefields()" />
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">Application Scaffold Directory</label>
                <cfinput id="appdir" class="form-control" name="appdir" type="text" value="#rootpath#"  />
            </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">Application URL</label>
                    <cfinput id="appurl" class="form-control" name="appurl" type="text" value="#urlPath#"  />
            </div>
            </div>
         </div>

         <div class="panel panel-success">
             <div class="panel-heading">DataSource Information</div>
             <div class="panel-body">
            <div class="form-group">
                <label for="exampleInputEmail1">Database Type</label>
                <cfselect name="type" id="type" class="form-control">
                        <option value="mssql">Microsoft Sql Server 2000/2005</option>
                        <option value="mysql">MySql 5</option>
                </cfselect>
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">DataSource</label>
                <cfinput id="username" name="datasource" class="form-control" value=""  /><br />
            </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">DataSource Username</label>
                <cfinput id="username" name="username" class="form-control" value=""  /><br />
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Datasource Password</label>
                <cfinput id="password" name="password" type="password" value=""  class="form-control"/><br />
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Database</label>
                <cfinput id="database" name="database" type="text" value=""  class="form-control"/>
                    <span class="small">(only required if type=mysql)</span>
            </div>

            </div>
            </div>

            <div class="row">
                <cfinput class="btn btn-success pull-right" type="submit" name="create" value="Create Config" />
            </div>

            </cfform>


		<pageElement:footer>

	</cfdefaultcase>

</cfswitch>

