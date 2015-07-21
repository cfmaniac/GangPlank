
<h2>Documentation</h2>

<h3>What does it do?</h3>

<ul>
<li>It introspects a Database</li>
<li>It analyzes the tables and views</li>
<li>It creates INSERT, SELECT, UPDATE, DELETE, SEARCH and LIST stored procedures for every TABLE.</li>
<li>It creates LIST and SEARCH stored procedure for every VIEW.</li>
<li>If there are foreign keys, it creates SELECT_WITH_FK, LIST_WITH_FK, and LIST_FORIEGNKEY_LABELS stored procedures.</li>
<li>It adds them to the database.</li>
<li>It assigns the proper GRANT permissions</li>
</ul>
<p>Then it does a second pass</p>
<ul>
<li>It introspects the database</li>
<li>It analyses all of the stored procedures not just the ones the process creates</li>
<li>It creates two sets of CFC's: GATEWAY and DAO</li>
<li>It creates a DAO for each TABLE and VIEW.</li>
<li>It creates the &lt;cfstoredProcedure&gt; calls for each stored procedure</li>
<li>It creates the &lt;cffunction&gt; to wrap the storedprocedure in.</li>
<li>It adds each &lt;cffunction&gt; &lt;cfstoredproc&gt; combo within the appropriate CFC per table.</li>
<li>It places any operation with SELECT, DELETE, UPDATE, AND INSERT in the title within the DAO CFC'S.</li>
<li>It places all other actions to the GATEWAY CFC's.</li>
<li>It writes the CFC's to disk. </li>
</ul>
<ul><li>It writes Custom Tag components to produce nuggets of Editing and Listing functions.</li></ul>
<ul><li>It strings all of these together to produce a simplistic CRUD application.</li></ul>
<p>Optionally it will do the following:</p>
<ul>
<li>Build Unit Tests.</li>
<li>Run Unit Tests</li>
<li>Build Ant Script</li>
<li>Build Documentation</li>
<li>Build Coldspring Configs</li>
</ul>

<h3>Requirements</h3>
<ul>
	<li>ColdFusion 8</li>
	<li>MySQL 5, Microsoft Sql Server 2000/2005, Oracle 10g</li>
	<li>Requires account with ability to create and drop objects </li>
	<li>All tables must have identity (MSSQL), auto increment (MySQL) or a sequence (Oracle).</li>

</ul>

<h3>Restrictions</h3>

<ul>
<li>GangPlank needs CF8 to run, but application can run on CF 7.</li>
<li><span style="text-decoration:line-through; color:#999999;">Preferably the id should be [table name]Id (Meaning I haven't found all the bugs)</span></li>
<li>Fields named "createdOn", "updatedOn"  will be automatically set (Can be changed in configuration)</li>
<li>Field named "createdBy" will only be set on create method</li>
<li>A bit field named 'active' will alter behvior of table. It will deactivate instead of delete records. (Can be changed in config) </li>
<li>All stored procedures should be named "usp_[tableName]_[action]"</li>
<li><span style="text-decoration:line-through; color:#999999;">Table names need to be one word, Camel case is okay</span> No longer true as of version 0.8.4</li>
<li>Action can contain underscore.</li>
</ul>

