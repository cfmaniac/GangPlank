
<h2>Configuration Reference</h2>





<dl>

	<dt>config['application']</dt>
	<dd>These configurations all refer to settings for the application GangPlank will create. </dd>

	
	
	<dl>
	
		
		<dt>config['application']['appname']</dt>
		<dd>The name of the application you are creating</dd>


		
		

		


		
	
		
		<dt>config['application']['CFCpathCFCStyle']</dt>
		<dd>The CFC path of the CFC's that will be created for te application.</dd>


		
		

		


		
	
		
		<dt>config['application']['cssPath']</dt>
		<dd>The path to the css file that will style the created application.</dd>


		
		

		


		
	
		
	
		
		<dt>config['application']['imagePath']</dt>
		<dd>The path to the image file that will be the logo for the created application.</dd>


		
		

		


		
	
		
		<dt>config['application']['steps']</dt>
		<dd>An ordered array of the steps that GangPlank will perform.</dd>


		
		

		


		
	
		
		<dt>config['application']['url']</dt>
		<dd>The url for the new application.</dd>


		
		

		


		
	
	</dl>



	<dt>config['cfc']</dt>
	<dd>These are CFC paths for GangPlank CFC's which perform specialized functions. </dd>

	
	
	<dl>
	
		
		<dt>config['cfc']['cfc']</dt>
		<dd>The CFC path of the CFC that builds cfc code.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['cfstoredproc']</dt>
		<dd>The CFC path of the CFC that builds cfstoredproc calls.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['cfUnitPath']</dt>
		<dd>The CFC style path to the CFunit framework on your system. Defaults to CFUnit default.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['constants']</dt>
		<dd>The CFC path of the CFC that holds certain database constants.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['customtag']</dt>
		<dd>The CFC path of the CFC that builds customtags.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['database']</dt>
		<dd>The CFC path of the CFC that inspects and presents the database structure.</dd>


		
		

		


		
	
		
	
		
		<dt>config['cfc']['fk']</dt>
		<dd>The CFC style path to the foreignkey cfc.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['function']</dt>
		<dd>The CFC path of the CFC that builds cffunction code.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['functionHelper']</dt>
		<dd>The CFC style path to the functionhelper cfc.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['help']</dt>
		<dd>The CFC style path to the help cfc.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['sqlstoredproc']</dt>
		<dd>The CFC path of the CFC that builds SQL storedprocedure calls in an active/delete table.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['sqlstoredprocactive']</dt>
		<dd>The CFC path of the CFC that builds SQL storedprocedure calls in an active/deactivate table.</dd>


		
		

		


		
	
		
		<dt>config['cfc']['table']</dt>
		<dd>The CFC style path to the table cfc.</dd>


		
		

		


		
	
	</dl>



	<dt>config['db']</dt>
	<dd>These configurations all refer to settings for the database on which the create application will be built.</dd>

	
	
	<dl>
	
		
		<dt>config['db']['datasource']</dt>
		<dd>The ColdFusion datasource to use. </dd>


		
		

		


		
	
		
	
		
		<dt>config['db']['password']</dt>
		<dd>The database password to use.</dd>


		
		

		


		
	
		
		<dt>config['db']['type']</dt>
		<dd>The Type of DBMS to use. [Currently only MSSQL is valid]</dd>


		
		

		


		
	
		
		<dt>config['db']['username']</dt>
		<dd>The database username to use.</dd>


		
		

		


		
	
	</dl>



	<dt>config['defaults']</dt>
	<dd>These are default values used for certain data types.</dd>

	
	
	<dl>
	
		
		<dt>config['defaults']['binary']</dt>
		<dd>Default for BINARY</dd>


		
		

		


		
	
		
		<dt>config['defaults']['boolean']</dt>
		<dd>Default for booleans.</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_BIGINT']</dt>
		<dd>Default for CF_SQL_BIGINT</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_BINARY']</dt>
		<dd>Default for CF_SQL_BINARY</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_BIT']</dt>
		<dd>Default for CF_SQL_BIT</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_BLOB']</dt>
		<dd>Default for blobs</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_CHAR']</dt>
		<dd>Default for CF_SQL_CHAR</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_CLOB']</dt>
		<dd>Default for CLOBS</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_DECIMAL']</dt>
		<dd>Default for CF_SQL_DECIMAL</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_FLOAT']</dt>
		<dd>Default for CF_SQL_FlOAT</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_IDSTAMP']</dt>
		<dd>Default for CF_SQL_IDSTAMP</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_INTEGER']</dt>
		<dd>Default for CF_SQL_INTEGER</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_LONGVARBINARY']</dt>
		<dd>Default for CF_SQL_LONGVARBINARY</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_LONGVARCHAR']</dt>
		<dd>Default for CF_SQL_LONGVARCHAR</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_NUMERIC']</dt>
		<dd>Default for CF_SQL_NUMERIC</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_REAL']</dt>
		<dd>Default for CF_SQL_REAL</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_TIMESTAMP']</dt>
		<dd>Default for CF_SQL_TIMESTAMP</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_TINYINT']</dt>
		<dd>Default for CF_SQL_TINYINT</dd>


		
		

		


		
	
		
		<dt>config['defaults']['CF_SQL_VARCHAR']</dt>
		<dd>Default for CF_SQL_VARCHAR</dd>


		
		

		


		
	
		
		<dt>config['defaults']['date']</dt>
		<dd>Default for dates</dd>


		
		

		


		
	
		
	
		
		<dt>config['defaults']['numeric']</dt>
		<dd>Default for numeric.</dd>


		
		

		


		
	
		
		<dt>config['defaults']['string']</dt>
		<dd>Default for string.</dd>


		
		

		


		
	
	</dl>



	<dt>config['fileLocations']</dt>
	<dd>A collection of paths where GangPlank will create certain files.</dd>

	
	
	<dl>
	
		
		<dt>config['fileLocations']['business']</dt>
		<dd>The path in which to store all of the business files.(These aren't overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['businessdynamic']</dt>
		<dd>Path where GangPlank will store dynamically generated business objects.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['cfc']</dt>
		<dd>The top level path of all of the CFC's cretaed by GangPlank.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['cfml']</dt>
		<dd>The path in which to store all of the CFML form handling logic.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['config']</dt>
		<dd>Path where GangPlank will store dynamically generated config files currently only for ColdSpring.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['css']</dt>
		<dd>The directory for CSS in the application that we are building.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['customtags']</dt>
		<dd>The path in which to store all of the static customtag files.(These aren't overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['customtagsdynamic']</dt>
		<dd>The path in which to store all of the dynamic customtag files.(These are overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['dao']</dt>
		<dd>The path in which to store all of the static dao files.(These aren't overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['docs']</dt>
		<dd>A location for storing documents produced by the buildDocumentation step. </dd>


		
		

		


		
	
		
	
		
		<dt>config['fileLocations']['dynamicdao']</dt>
		<dd>The path in which to store all of the dynamic dao files.(These are overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['dynamicgateway']</dt>
		<dd>The path in which to store all of the dynamic gateway files.(These are overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['gateway']</dt>
		<dd>The path in which to store all of the static gateway files.(These aren't overwritten by GangPlank)</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['images']</dt>
		<dd>A location for storing images that GangPlank generates.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['logs']</dt>
		<dd>A log directory for various purposes for the application.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['output']</dt>
		<dd>The top level path of your application. </dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['sql']</dt>
		<dd>The path in which to store all output SQL code, if you are not autocreating the stored procedures, or are using the disk cache..</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['temp']</dt>
		<dd>A location for storing temporary files produced by image manipulation.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['test']</dt>
		<dd>The root directory for CFUnit Tests to go in.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['testbusiness']</dt>
		<dd>The directory for user created CFUnit Tests related to business objects</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['testdao']</dt>
		<dd>The directory for user created CFUnit Tests related to dao's</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['testdynamicdao']</dt>
		<dd>The directory for dynamically created CFUnit Tests related to dao's</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['testdynamicgateway']</dt>
		<dd>The directory for dynamically created CFUnit Tests related to gateways.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['testgateway']</dt>
		<dd>The directory for user created CFUnit Tests related to gateways.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['testinterface']</dt>
		<dd>The directory for dynamically created CFUnit Tests related to user interfaces.</dd>


		
		

		


		
	
		
		<dt>config['fileLocations']['webroot']</dt>
		<dd>The webroot of your server.</dd>


		
		

		


		
	
	</dl>



	<dt>config['notify']</dt>
	<dd>Settings for use in the notify step. </dd>

	
	
	<dl>
	
		
	
		
		<dt>config['notify']['from']</dt>
		<dd>A setting for just the notify step. It's the address from which send notification emails.</dd>


		
		

		


		
	
		
		<dt>config['notify']['to']</dt>
		<dd>A setting for just the notify step. It's the address to which send notification emails.</dd>


		
		

		


		
	
	</dl>



	<dt>config['reservedwords']</dt>
	<dd>These are words and strings that when you use in the database, will have a specific effect on the way GangPlank works with it.</dd>

	
	
	<dl>
	
		
		<dt>config['reservedwords']['active']</dt>
		<dd>Bit fields with this name will cause GangPlank to write delete and list functions that treat deleted records as deactivated (active = false). A good choice if you have a
				lot of foreign key's in your database. </dd>


		
		

		


		
	
		
		<dt>config['reservedwords']['createdBy']</dt>
		<dd>Any field with this name will only be accessible on Insert operations.</dd>


		
		

		


		
	
		
		<dt>config['reservedwords']['createdOn']</dt>
		<dd>A datetime field with this reserved word will be automatically set by the code GangPlank creates, and only on insert operations.</dd>


		
		

		


		
	
		
	
		
		<dt>config['reservedwords']['excludedTablePrefix']</dt>
		<dd>Tables that start with this string will be ignore by GangPlank. </dd>


		
		

		


		
	
		
		<dt>config['reservedwords']['password']</dt>
		<dd>Text fields with this name will appear as ********* in read and list ui's and as a password input in the edit ui.</dd>


		
		

		


		
	
		
		<dt>config['reservedwords']['updatedBy']</dt>
		<dd>No restrictions.</dd>


		
		

		


		
	
		
		<dt>config['reservedwords']['updatedOn']</dt>
		<dd>A date field with this reserved word will be automatically set by the code GangPlank creates.</dd>


		
		

		


		
	
	</dl>



	<dt>config['settings']</dt>
	<dd>These are general settings that determines how GangPlank runs.</dd>

	
	
	<dl>
	
		
		<dt>config['settings']['applicationTemplate']</dt>
		<dd> The UI template to use. Currently there are only two default or simple. In the future there may be more. Alternately, you can create your own templates, and they won't be 
				overwrittne by updating.</dd>


		
		

		


		
	
		
		<dt>config['settings']['dboprocs']</dt>
		<dd>The verbs used in procedures that will be placed in DBO CFC's.</dd>


		
		

		


		
	
		
		<dt>config['settings']['defaultFunctionAccess']</dt>
		<dd>Default access to give to the functions created in your cfc's.</dd>


		
		

		


		
	
		
	
		
		<dt>config['settings']['excludedTableList']</dt>
		<dd>A comma separated list of excluded tables.</dd>


		
		

		


		
	
		
		<dt>config['settings']['generateSQLScript']</dt>
		<dd>Whether or not to create SQL scripts for creating the procedures instead of writing them directly to the database.</dd>


		
		

		


		
	
		
		<dt>config['settings']['generateStoredProcedureFiles']</dt>
		<dd>Whether or not to have GangPlank create SQL files for adding adding and dropping every stored procedure individually.</dd>


		
		

		


		
	
		
		<dt>config['settings']['ignoreXMLCache']</dt>
		<dd>Setting instructs GangPlank to ignore the XMLCache when inspecting the database. Will speed up process at cost of not overiding values from the XMLCache.</dd>


		
		

		


		
	
	</dl>



	<dt>config['ui']</dt>
	<dd>Various settings that deal with using ColdFusion 8 UI components</dd>

	
	
	<dl>
	
		
		<dt>config['ui']['DateField']</dt>
		<dd>Whether or not to use the cfinput type=datefield option for datetime columns.</dd>


		
		

		


		
	
		
	
		
		<dt>config['ui']['ImageListWidth']</dt>
		<dd>The width to resize images to in the list view. </dd>


		
		

		


		
	
		
		<dt>config['ui']['ImageReadWidth']</dt>
		<dd>The width to resize images to in the read view. </dd>


		
		

		


		
	
		
		<dt>config['ui']['Images']</dt>
		<dd>Whether or not to use cfimage to deal with images in the application.</dd>


		
		

		


		
	
		
		<dt>config['ui']['logoBuild']</dt>
		<dd>Whether or not to build a Web 2.0 logo. By default this is yes in Windows, no in Mac. The Mac had issues with Cfimage, and since it was such a little plus, I just 
				deactivated it. </dd>


		
		

		


		
	
		
		<dt>config['ui']['LogoFont']</dt>
		<dd>The default font to use with the Web 2.0 logo. Defaults to Arial on Windows, Helvetica on Mac (IF the issues with logoBuild get fixed.)</dd>


		
		

		


		
	
		
		<dt>config['ui']['RichTextAreas']</dt>
		<dd>Whether or not to use the cftextarea richtext option for text columns.</dd>


		
		

		


		
	
		
		<dt>config['ui']['RichTextAreasSkin']</dt>
		<dd>Which skin to use with the richtext option.</dd>


		
		

		


		
	
		
		<dt>config['ui']['RichTextAreasToolbar']</dt>
		<dd>Which toolbar to use with the richtext option.</dd>


		
		

		


		
	
	</dl>




</dl>

