<h2>FAQS</h2>

<dl>

<dt>What is GangPlank?</dt>
<dd>GangPlank is a ColdFusion application that creates scaffolds for a SQL database.  It creates them using stored procedures instead of inline SQL.
It also automatically creates ColdFusion code for user created stored procedures.</dd>

<dt>Why is it called GangPlank?</dt>
<dd>My wife told me to call it that. It comes from a fake band name I came up with a while back. I figure the SQ in GangPlank works for something with SQL.</dd>

<dt>What makes this different from other database scaffolders?</dt>
<dd>As far as I know, none of the other scaffolders use stored procedures. This both writes and reads stored procedures for the purposes of scaffolding.
Additionally, GangPlank introspects using foreign keys, making reference tables very easy to use.
</dd>

<dt>The config calls for database usernames and passwords, but my configuration includes them in the datasource.  What do I do?</dt>
<dd>Set the username and password to an empty string.</dd>

<dt>Why aren't you making an application.cfc in your generated application?</dt>
<dd>Because, an application.cfc is a little trickier to make dynamically than an application.cfm.
Also I assumed that I would just slap in an application.cfc when I wanted to customize the application.
Since an application.cfc overrules an applicaiton.cfm, no one would get hurt. </dd>

<dt>I don't like the way a particular piece comes out, can I configure them myself?</dt>
<dd>Sure, you just have to know where to look.
	<table>
		<thead><tr><th>Item to Change</th><th>Where to edit the code</th></tr></thead>
		<tbody>
			<tr><td>Stored Procedures</td><td>cfc/SQLStoredProc.cfc</td></tr>
			<tr><td>&lt;cfstoredproc&gt;</td><td>cfc/mssql/CFstoredProc.cfc</td></tr>
			<tr><td>Custom Tags</td><td>templates/cfmltemplates</td></tr>
			<tr><td>CFML</td><td>templates/customtagtemplates</td></tr>
		</tbody>
	</table>
</dd>

<dt>If my Database admins won't let me call direct SQL, why would they let me use this tool since it requires Create and Drop permissions?</dt>
<dd>Well, you could run it in scripting mode. This will output a SQL script will all of the SQL code to generate the default CRUD procedures.
You will have to run that script on the SQL server before you continue with the rest of the application.  To do this, set
<em>config['settings']['generateSQLScript']</em> to TRUE.  Just make sure that you set <em>config['db']['username']</em>, otherwise, neccessary grant commands will not be created.</dd>

<dt>How does GangPlank handle outputs?</dt>
<dd>If the stored procedure returns via a single output variable, then the CFC will return it as the CF variable type that matches the SQL variable type of the output variable.
If the store procedure returns via multiple output variables, then it returns a structure of those output variables.  </dd>

<dt>Oh Yeah? How does GangPlank handle multiple queries?</dt>
<dd>Dude, what's with the 'tude? It detects multiple queries and returns then as a structure of those queries.</dd>

<dt>I don't like to delete records from the database? So I won't use an auto-crud tool. </dt>
<dd>If you set <em>config['reservedwords']['active']</em> to a a value of your choice, then put that value as a bit value column name in a table of your choosing; then
GangPlank will build your CRUD stored procedures respecting deactivation versus deletion. (The list function will obey it too.)
</dd>

<dt>What's the XML Disk Cache? </dt>
<dd>It's an XML Representation of the database structure that GangPlank creates when it analyzes your database. Certain settings in this file override introspected database information.<br /><br />
	Currently there are 4 things that setting here will effect:
	<ol><li><em>DisplayName</em> on database columns that will show as labels on all UI components instead of the name. ("First Name" vs f_name).
</li><li><em>OrderBy</em> on tables which will alter the order of the default List elements
</li>
<li><em>ForeignKeyLabel</em> the column which will be substituted for the primary key, in all tables that link to this table via foreign keys.</li>
<li><em>IsImage</em> whether or not a column is an image.  Set to true for image columns in MSSql, must be mannually set for blobs that are images in MySQL.</li>
</ol>
</dd>
<dt>Does GangPlank support foreign keys?</dt>
<dd>Yes.</dd>
<dt>Care to elaborate on that?</dt>
<dd>
	<p><em>Form UI</em> - On forms that interact with tables with foreign keys, GangPlank will produce a select box of the aforementioned "foreign key labels."</p>
	<p><em>List and Read UI</em>- These components now call separate stored procedures that properly join the requisite tables to show the appropriate "foreign key label" in lieu of the actual value.</p>
	<p>If you use the application template <em>fkCrazy</em> GangPlank will build methods in all of your business objects that allow you to manipulate tables across foreign key linked tables.</p>
</dd>

<dt>How can I run a generated application on ColdFusion 7?</dt>
<dd><p>You have to deactivate the ColdFusion 8 specific ui components. To do so add the following lines to your config file:</p>
	<p>
		&lt;!--- These are UI settings for changing the way the ui is rendered ---&gt; <br />
		&lt;cfset config['ui']['RichTextAreas'] = FALSE /&gt; <br />
		&lt;cfset config['ui']['DateField'] = FALSE /&gt; <br />
		&lt;cfset config['ui']['Images'] = FALSE /&gt; <br />
	</p>

</dd>
</dl>