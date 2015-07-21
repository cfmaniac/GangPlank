<h2>Installation</h2>
<ul>
<li>Unzip GangPlank.zip and place in web accessible location</li>
<li>Browse to Index.cfm.</li>
<li>Go to Add Application</li>
<li>Fill in relevant information and save</li>
<li>GangPlank is now ready to build your application</li>
<li>You may need to tweak your config file to get GangPlank to build the application the way you want. See <a href="config.cfm">config reference</a> for details.</li>
</ul>
<p>Note that you can configure multiple applications, with one config file per application.</p>
<p class="attention">Also note that appplication will delete and recreate any stored procedures named usp_[tablename]_[list|insert|select|update|delete|search|list_with_FK|list_FK]</p>

<h2>Database Particulars</h2>
<h3>MYSql</h3>
<p>Account used with GangPlank must have SELECT permission on the table <em>'proc'</em> in schema <em>'mysql'</em>. </p>