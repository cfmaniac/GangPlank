

	<h2>Release Notes</h2>
	
		<h3>Version 2.0.00695</h3>
		<p><strong>Wed, August 06, 2008 4:18:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/riaforge/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00694</h3>
		<p><strong>Wed, August 06, 2008 4:16:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/riaforge/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00692</h3>
		<p><strong>Wed, August 06, 2008 4:12:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00693</h3>
		<p><strong>Wed, August 06, 2008 4:12:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00691</h3>
		<p><strong>Wed, August 06, 2008 3:55:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00690</h3>
		<p><strong>Wed, August 06, 2008 3:14:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00689</h3>
		<p><strong>Wed, August 06, 2008 3:12:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:03:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:03:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:02:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:02:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:01:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:00:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00688</h3>
		<p><strong>Wed, August 06, 2008 3:00:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing issues with the build file. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/settings.properties (A)</li>
		
			
			
		
	
		<li>/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactoring for performance.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/customtag.cfc (M)</li>
		
			
			
		
	
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Template items and code creators were changed to ensure proper var scoping. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
			
			
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseDAO.cfc (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Making sure all references to object names flow through the CFversionofTableName method. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/default/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Implemented database label feature, which allows table to be named one thing in the database, but another thing in CFML code. 

Helps with issues like tables being named with over zealous hungarian notation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/listTemplate.cfm (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mssql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfms.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/customtags.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/mysql/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/cfc/base/database.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/readTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/fkCrazy/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/steps/cfc_business.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/listTemplate.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/templates/customtagtemplates/default/readTemplate.cfm (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a number of changes to make GangPlank example apps work on my new system. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused issues with search procedures being made for tables that were using active bit and had a text field as their last item. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/settings.properties (M)</li>
		
			
			
		
	
		<li>/trunk/GangPlank/tools/Application.cfc (A)</li>
		
	
		<li>/trunk/GangPlank/tools/application.cfc (D)</li>
		
	
		<li>/trunk/GangPlank/Application.cfc (M)</li>
		
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
	
		<li>/trunk/GangPlank/build.xml (M)</li>
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing more build issues.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug in test creation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>More work to get it to work with new workstation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/config/blogmac.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Caught a bug in cfunit test creation. Path was using Windows path separator. Boooooo!</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/steps/cfunit.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/refresh/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/documentationBuilder/index.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing build to work on new workstation. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/trunk/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (M)</li>
		
			
			
		
	
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00663</h3>
		<p><strong>Thu, April 17, 2008 3:25:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Removed cfdump/cfabort combo that was occasionally called.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/refresh/index.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fix bug: Simple applications were getting created with reference to "destory" insread of "destroy".</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fix Bug: default value not getting set right for non required fields</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00586</h3>
		<p><strong>Tue, March 11, 2008 3:42:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Improved messaging for linked objects. Now only the updated table will display a message instead of all of them because the message was too generic.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed Bug 25 : http://GangPlank.riaforge.org/index.cfm?event=page.issueedit&issueid=63B7DB81-F255-09CA-8F1035ED2FBECDFF.

Select arguments were not being qualified with brackets in certain MSSQL stored procs. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added documentation and error handling around the fact that MySql requires mode requires that the account have access to mysql.proc. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/error_exception.cfm (M)</li>
		
		<li>/GangPlank/docs/installation.cfm (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Updated a bit of documentation.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/docs/index.cfm (M)</li>
		
		<li>/GangPlank/docs (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug in MSSQL stored proc creation routine, which caused an error to be thrown whenever joined tables were used.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug caused by lazily replacing all commas with a comma and a break. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added smallmoney datatype to constants.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/base/constants.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug in column escaping.  Bug was causing creation of linking tables to fail. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed issue with multiple output variables in MSSQL.  Basically GangPlank correctly put more than output variable into a structure, but didn't change the function output type to structure.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed issue with multiple output variables in MSSQL.  Basically GangPlank correctly put more than output variable into a structure, but didn't change the function output type to structure.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Increasing the timeout on the application refresher.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/refresh/index.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed issue with multiple output variables in Oracle.  The previous fix for MSSQL broke things for Oracle.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed issue with multiple output variables in Oracle.  The previous fix for MSSQL broke things for Oracle.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Removed cfdump/cfabort combo that was occasionally called.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/refresh/index.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00271</h3>
		<p><strong>Tue, November 20, 2007 6:39:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt></st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a series of bugs preventing GangPlank from running in Linux. Mostly related to casing of components. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/sqlstoredprocactive.cfc (A)</li>
		
		<li>/GangPlank/cfc/oracle/SQLStoredProcActive.cfc (D)</li>
		
		<li>/GangPlank/cfc/oracle/foreignKey.cfc (D)</li>
		
		<li>/GangPlank/cfc/mysql/foreignkey.cfc (A)</li>
		
		<li>/GangPlank/Application.cfc (M)</li>
		
		<li>/GangPlank/cfc/oracle/SQLStoredProc.cfc (D)</li>
		
		<li>/GangPlank/cfc/mysql/sqlstoredproc.cfc (A)</li>
		
		<li>/GangPlank/cfc/base/SQLStoredProcActive.cfc (D)</li>
		
		<li>/GangPlank/cfc/base/sqlstoredprocactive.cfc (A)</li>
		
		<li>/GangPlank/cfc/base/SQLStoredProc.cfc (D)</li>
		
		<li>/GangPlank/cfc/functionhelper.cfc (A)</li>
		
		<li>/GangPlank/cfc/stepTracker.cfc (D)</li>
		
		<li>/GangPlank/cfc/antBuilder.cfc (D)</li>
		
		<li>/GangPlank/cfc/cfstoredproc.cfc (A)</li>
		
		<li>/GangPlank/cfc/mssql/SQLStoredProcActive.cfc (D)</li>
		
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (A)</li>
		
		<li>/GangPlank/cfc/mssql/foreignKey.cfc (D)</li>
		
		<li>/GangPlank/cfc/mssql/SQLStoredProc.cfc (D)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (D)</li>
		
		<li>/GangPlank/cfc/mysql/sqlstoredprocactive.cfc (A)</li>
		
		<li>/GangPlank/cfc/mysql/foreignKey.cfc (D)</li>
		
		<li>/GangPlank/cfc/oracle/foreignkey.cfc (A)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (D)</li>
		
		<li>/GangPlank/cfc/oracle/sqlstoredproc.cfc (A)</li>
		
		<li>/GangPlank/cfc/base/sqlstoredproc.cfc (A)</li>
		
		<li>/GangPlank/cfc/functionHelper.cfc (D)</li>
		
		<li>/GangPlank/cfc/steptracker.cfc (A)</li>
		
		<li>/GangPlank/cfc/antbuilder.cfc (A)</li>
		
		<li>/GangPlank/cfc/CFstoredProc.cfc (D)</li>
		
		<li>/GangPlank/cfc/mysql/help.cfc (M)</li>
		
		<li>/GangPlank/cfc/mssql/foreignkey.cfc (A)</li>
		
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug where generated application would not run in Linux becasue of case issue with Application.cfm file.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfms.cfm (M)</li>
		
		<li>/GangPlank/config/facebook_linux.cfm (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where MYSQL select method was ommiting prefix _ characters. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added precision and scale to the metadata in order to properly handle decimal data.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/sqlstoredprocactive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/database.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/sqlstoredproc.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/help.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added configuration "settings" "IgnoreXMLCache".  This feature tells GangPlank to stop looking at the XML cache. It speeds up table analysis at the cost of the features of the XML cache.  If you don't know what they are, then you can safely set this to true.

Hopefully someday I can improve the performance of the XML cache, rendering this feature obsolete.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/config/cigar.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
		<li>/GangPlank/config/defaultPreLoad.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixing bug which caused GangPlank to truncate decimal values.  </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
		<li>/GangPlank/cfc/mssql/sqlstoredprocactive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mssql/sqlstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Adding proper decimal support to Oracle.  That was shockingly easy. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/cfstoredproc.cfc (M)</li>
		
		<li>/GangPlank/cfc/oracle/help.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added Oracle application to the list of applications that gets unit tested by default. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/refresh/index.cfm (M)</li>
		
		<li>/GangPlank/build.xml (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug in CFUnit tests that caused it not to work with Oracle.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfunit.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Altered the format of generated cfstoredproc calls. It was based on a suggestion by Nathan Mische http://www.mischefamily.com/nathan/. Instead of having the conditional decide whether or not the proc would pass null, the change pipes the conditional right into the null parameter.  

Thanks Nathan, that's very elegant.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/cfstoredproc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Refactored database analysis for performance. Reduced the cost of comparing to the XMLCache by about 50%. This should lead to a 25% to 33% reduction in time for builds depending on your configuration. 
</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00254</h3>
		<p><strong>Mon, November 05, 2007 12:12:00 AM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Made a change that prevented GangPlank from creating lists of linking tables in the business object of a table linked by a linking table.  Why? Well since those linking tables don't really store information in their own right, why include them.  </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added Oracle database inspection.  </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/foreignKey.cfc (A)</li>
		
		<li>/GangPlank/cfc/oracle/database.cfc (A)</li>
		
		<li>/GangPlank/cfc/oracle (A)</li>
		
		<li>/GangPlank/cfc/oracle/table.cfc (A)</li>
		
		<li>/GangPlank/cfc/oracle/help.cfc (A)</li>
		
		<li>/GangPlank/cfc/oracle/constants.cfc (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug caused by ORACLE timestamp meaning something very different from other database timestamps.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Checking in ORACLE code. It doesn't work just yet. I have to spend some time thinking about how to implement this feature.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/SQLStoredProcActive.cfc (A)</li>
		
		<li>/GangPlank/cfc/oracle/SQLStoredProc.cfc (A)</li>
		
		<li>/GangPlank/config/blog_oracle.cfm (A)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Seemingly have Oracle Stored procedure creation working. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/cfc/oracle/database.cfc (M)</li>
		
		<li>/GangPlank/cfc/oracle/help.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Seemingly have Oracle Stored procedure creation working.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/package.cfc (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a few changed to make Oracle work. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Perfecting Oracle support.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made changes to support Oracle.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/base/constants.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made changes to support Oracle.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfunit.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made changes to support Oracle.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt></st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/cfc/oracle/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Oracle components pass all unit tests.  GangPlank now officially supports Oracle. Queue bug reports in 3....2...1....</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/oracle/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/steps/cfunit.cfm (M)</li>
		
		<li>/GangPlank/templates/customtagtemplates/default/formTemplate.cfm (M)</li>
		
		<li>/GangPlank/cfc/oracle/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
		<li>/GangPlank/config/blog_oracle.cfm (M)</li>
		
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
		<li>/GangPlank/cfc/oracle/help.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/config/defaultPreLoad.cfm (M)</li>
		
		<li>/GangPlank/cfc/oracle/package.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made DAO's and gateway's take db parameters as init arguments.  But they are defaulted to application values so as not to break backwards compatibility. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/function.cfc (M)</li>
		
		<li>/GangPlank/templates/cfmltemplates/fkCrazy/applicationTemplate.cfm (M)</li>
		
		<li>/GangPlank/templates/cfmltemplates/simple/applicationTemplate.cfm (M)</li>
		
		<li>/GangPlank/templates/cfmltemplates/simple/objectTemplate.cfm (M)</li>
		
		<li>/GangPlank/templates/customtagtemplates/simple/formTemplate.cfm (M)</li>
		
		<li>/GangPlank/steps/cfc_dao_gateway.cfm (M)</li>
		
		<li>/GangPlank/templates/cfmltemplates/default/applicationTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added coldspringGenerateConfig step. GangPlank now generates Coldspring config files.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/buildDirectories.cfm (M)</li>
		
		<li>/GangPlank/config/blog_mysql.cfm (M)</li>
		
		<li>/GangPlank/config/defaultPostLoad.cfm (M)</li>
		
		<li>/GangPlank/steps/coldspringGenerateConfig.cfm (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt></st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/cfcDoc/index.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00227</h3>
		<p><strong>Tue, October 23, 2007 1:01:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fixed bug that caused updates to child rows to fail due to a missing DAO reference.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused delete procs for tables with an active column to deactivate all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused insert and update procs in MySQL for tables with an active column to overwrite all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added more generated comments to the dynamic business objects. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where unique constraints were not honored for tables in Mysql in active/deactive mode.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where order by was not working properly in stored procedures in MySQL.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added option in fkCrazy template to alter the value of the submit button. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added table or object name to the class of edit forms. So that you can create css based on your objects.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made sure that ui cflocations in fkcrazy template were using appendToken to false.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug caused by direct reference in baseBusiness Object to the form scope, instead of the passed in reference to the form scope. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/baseCFCs/default/baseBusiness.cfc (M)</li>
		
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added checksumming feature to table analysis.  Now certain operations only run when they need to be on a table by table basis.  For example if you don't change any tables, then the auto generated stored procedures don't have to be altered, and the custom tags (which are based on the tables not the procs) don't need to be altered. 

This can be overridden by using the force refresh option, deleting the tables.xml file, or deleting the checksum for a particular table from the tables.xml file.

This results in about a 25% reduction in run time for a moderately complex table. More if you have a lot of foreign keys, less if you don't. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/customtags.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
		<li>/GangPlank/steps/sqlWriteStoredProcs.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a change to allow foreignKeySelector custom tag to handle non-nullable fields gracefully. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/basecustomtags/foreignKeySelector.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added documentation on how GangPlank reacts to certain database features including foreign keys and unique constraints.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/docs/img/oneToMany.jpg (A)</li>
		
		<li>/GangPlank/build.xml (M)</li>
		
		<li>/GangPlank/docs/databaseFeatures.cfm (A)</li>
		
		<li>/GangPlank/docs/img/manyToMany.jpg (A)</li>
		
		<li>/GangPlank (M)</li>
		
		<li>/GangPlank/docs/img/dropDowns.jpg (A)</li>
		
		<li>/GangPlank/docs/img/uniqueContstraint.jpg (A)</li>
		
		<li>/GangPlank/docs/img (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (A)</li>
		
		<li>/GangPlank/customtags/navDoc.cfm (M)</li>
		
		<li>/GangPlank/docs/img/foriegnkeys.jpg (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added Riaforge publisher. 

Added SVN History publisher. 

Should be last step to one step build. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/index.cfm (M)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (D)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Updated pdfgenerator</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/pdfgenerator/index.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00225</h3>
		<p><strong>Tue, October 23, 2007 1:00:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fixed bug that caused updates to child rows to fail due to a missing DAO reference.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused delete procs for tables with an active column to deactivate all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused insert and update procs in MySQL for tables with an active column to overwrite all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added more generated comments to the dynamic business objects. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where unique constraints were not honored for tables in Mysql in active/deactive mode.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where order by was not working properly in stored procedures in MySQL.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added option in fkCrazy template to alter the value of the submit button. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added table or object name to the class of edit forms. So that you can create css based on your objects.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made sure that ui cflocations in fkcrazy template were using appendToken to false.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug caused by direct reference in baseBusiness Object to the form scope, instead of the passed in reference to the form scope. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/baseCFCs/default/baseBusiness.cfc (M)</li>
		
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added checksumming feature to table analysis.  Now certain operations only run when they need to be on a table by table basis.  For example if you don't change any tables, then the auto generated stored procedures don't have to be altered, and the custom tags (which are based on the tables not the procs) don't need to be altered. 

This can be overridden by using the force refresh option, deleting the tables.xml file, or deleting the checksum for a particular table from the tables.xml file.

This results in about a 25% reduction in run time for a moderately complex table. More if you have a lot of foreign keys, less if you don't. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/customtags.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
		<li>/GangPlank/steps/sqlWriteStoredProcs.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a change to allow foreignKeySelector custom tag to handle non-nullable fields gracefully. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/basecustomtags/foreignKeySelector.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added documentation on how GangPlank reacts to certain database features including foreign keys and unique constraints.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/docs/img/oneToMany.jpg (A)</li>
		
		<li>/GangPlank/build.xml (M)</li>
		
		<li>/GangPlank/docs/databaseFeatures.cfm (A)</li>
		
		<li>/GangPlank/docs/img/manyToMany.jpg (A)</li>
		
		<li>/GangPlank (M)</li>
		
		<li>/GangPlank/docs/img/dropDowns.jpg (A)</li>
		
		<li>/GangPlank/docs/img/uniqueContstraint.jpg (A)</li>
		
		<li>/GangPlank/docs/img (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (A)</li>
		
		<li>/GangPlank/customtags/navDoc.cfm (M)</li>
		
		<li>/GangPlank/docs/img/foriegnkeys.jpg (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added Riaforge publisher. 

Added SVN History publisher. 

Should be last step to one step build. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/index.cfm (M)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (D)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Updated pdfgenerator</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/pdfgenerator/index.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00222</h3>
		<p><strong>Tue, October 23, 2007 12:39:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fixed bug that caused updates to child rows to fail due to a missing DAO reference.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused delete procs for tables with an active column to deactivate all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused insert and update procs in MySQL for tables with an active column to overwrite all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added more generated comments to the dynamic business objects. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where unique constraints were not honored for tables in Mysql in active/deactive mode.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where order by was not working properly in stored procedures in MySQL.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added option in fkCrazy template to alter the value of the submit button. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added table or object name to the class of edit forms. So that you can create css based on your objects.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made sure that ui cflocations in fkcrazy template were using appendToken to false.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug caused by direct reference in baseBusiness Object to the form scope, instead of the passed in reference to the form scope. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/baseCFCs/default/baseBusiness.cfc (M)</li>
		
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added checksumming feature to table analysis.  Now certain operations only run when they need to be on a table by table basis.  For example if you don't change any tables, then the auto generated stored procedures don't have to be altered, and the custom tags (which are based on the tables not the procs) don't need to be altered. 

This can be overridden by using the force refresh option, deleting the tables.xml file, or deleting the checksum for a particular table from the tables.xml file.

This results in about a 25% reduction in run time for a moderately complex table. More if you have a lot of foreign keys, less if you don't. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/customtags.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
		<li>/GangPlank/steps/sqlWriteStoredProcs.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a change to allow foreignKeySelector custom tag to handle non-nullable fields gracefully. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/basecustomtags/foreignKeySelector.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added documentation on how GangPlank reacts to certain database features including foreign keys and unique constraints.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/docs/img/oneToMany.jpg (A)</li>
		
		<li>/GangPlank/build.xml (M)</li>
		
		<li>/GangPlank/docs/databaseFeatures.cfm (A)</li>
		
		<li>/GangPlank/docs/img/manyToMany.jpg (A)</li>
		
		<li>/GangPlank (M)</li>
		
		<li>/GangPlank/docs/img/dropDowns.jpg (A)</li>
		
		<li>/GangPlank/docs/img/uniqueContstraint.jpg (A)</li>
		
		<li>/GangPlank/docs/img (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (A)</li>
		
		<li>/GangPlank/customtags/navDoc.cfm (M)</li>
		
		<li>/GangPlank/docs/img/foriegnkeys.jpg (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added Riaforge publisher. 

Added SVN History publisher. 

Should be last step to one step build. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/index.cfm (M)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (D)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00223</h3>
		<p><strong>Tue, October 23, 2007 12:39:00 PM GMT</strong></p>
		<p>
				
				
	<dl>
	<dt>Fixed bug that caused updates to child rows to fail due to a missing DAO reference.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused delete procs for tables with an active column to deactivate all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed a bug that caused insert and update procs in MySQL for tables with an active column to overwrite all rows, not just the target row.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added more generated comments to the dynamic business objects. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/cfc_business_dynamic.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where unique constraints were not honored for tables in Mysql in active/deactive mode.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug where order by was not working properly in stored procedures in MySQL.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/cfc/mysql/SQLStoredProcActive.cfc (M)</li>
		
		<li>/GangPlank/cfc/mysql/SQLStoredProc.cfc (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added option in fkCrazy template to alter the value of the submit button. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added table or object name to the class of edit forms. So that you can create css based on your objects.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/customtagtemplates/fkCrazy/formTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made sure that ui cflocations in fkcrazy template were using appendToken to false.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/cfmltemplates/fkCrazy/objectTemplate.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Fixed bug caused by direct reference in baseBusiness Object to the form scope, instead of the passed in reference to the form scope. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/baseCFCs/default/baseBusiness.cfc (M)</li>
		
		<li>/GangPlank/templates/baseCFCs/fkCrazy/baseBusiness.cfc (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added checksumming feature to table analysis.  Now certain operations only run when they need to be on a table by table basis.  For example if you don't change any tables, then the auto generated stored procedures don't have to be altered, and the custom tags (which are based on the tables not the procs) don't need to be altered. 

This can be overridden by using the force refresh option, deleting the tables.xml file, or deleting the checksum for a particular table from the tables.xml file.

This results in about a 25% reduction in run time for a moderately complex table. More if you have a lot of foreign keys, less if you don't. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/steps/customtags.cfm (M)</li>
		
		<li>/GangPlank/config/wrdscommunity.cfm (M)</li>
		
		<li>/GangPlank/cfc/base/database.cfc (M)</li>
		
		<li>/GangPlank/steps/sqlWriteStoredProcs.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Made a change to allow foreignKeySelector custom tag to handle non-nullable fields gracefully. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/templates/basecustomtags/foreignKeySelector.cfm (M)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added documentation on how GangPlank reacts to certain database features including foreign keys and unique constraints.</st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/docs/img/oneToMany.jpg (A)</li>
		
		<li>/GangPlank/build.xml (M)</li>
		
		<li>/GangPlank/docs/databaseFeatures.cfm (A)</li>
		
		<li>/GangPlank/docs/img/manyToMany.jpg (A)</li>
		
		<li>/GangPlank (M)</li>
		
		<li>/GangPlank/docs/img/dropDowns.jpg (A)</li>
		
		<li>/GangPlank/docs/img/uniqueContstraint.jpg (A)</li>
		
		<li>/GangPlank/docs/img (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (A)</li>
		
		<li>/GangPlank/customtags/navDoc.cfm (M)</li>
		
		<li>/GangPlank/docs/img/foriegnkeys.jpg (A)</li>
		
	</ul>
	</dd>
	</dl>

	
	<dl>
	<dt>Added Riaforge publisher. 

Added SVN History publisher. 

Should be last step to one step build. </st>

	<dd>
	<p style="font-size: .9em;">Files Effected</p>
	<ul style="font-size: .8em;">
	
		<li>/GangPlank/tools/releasenotesBuilder/pulldownfromRIAForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/index.cfm (M)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/publishToRiaForge.cfm (A)</li>
		
		<li>/GangPlank/tools/releasenotesBuilder/getHistory.cfm (D)</li>
		
	</ul>
	</dd>
	</dl>

	
				
				</p>
	<hr />

	
		<h3>Version 2.0.00193</h3>
		<p><strong>Wed, October 17, 2007 4:56:00 AM GMT</strong></p>
		<p>
				
				<p>Most of the changes here have to do with Foreign Keys and the FKCrazy template. GangPlank can now detect many to many relationships across [table]To[table] assuming that their are foreign keys in the tableToTable table and they are named the same as the primary keys in joined tables. It allows you to add and delete those relationships.  If you actually read this, and this doesn't make sense drop me a line.  I'll record another video to explain it. (I really don't know how to explain it.)  If you are using the FKCrazy template, make sure you replace the baseBusiness.cfc.</p>

<p>Unique constraints are now recognized by GangPlank. If there is a unique constraint on a table, it writes a read by column procedure automatically, and can be used in business object instantiation. </p>

<p>Made sure that all columns in a stored procedure is referenced wrapped in qualifying terms.</p>
				
				</p>
	<hr />

	
		<h3>Version 2.0.00183</h3>
		<p><strong>Fri, October 12, 2007 6:38:00 PM GMT</strong></p>
		<p>
				
				<p>Updated a fair amount of documentation</p>
<p>Refactored a few things to make code base more miantainable.</p>
<p>Fixed bugs related to cfimage anf fonts on different OS's </p>
<p>Added a new feature with foriegn keys: child autowiring. It's a bit hard to explain but let me try explain.  Let's say you have a table entry and table comment.  Comment contains a foreign key to entry, denoting that comments are many to one children of entry.  When you view the read method for entry, the child comments will be displayed.  Additionally the option to add a comment to entry with the comment form will be displayed. If you actually read this, and it doesn't make sense drop me a line, it's a really cool feature that's hard to explain.</p>
<p>To experiment with child autowiring, add the following to your config file:

<code>
<!--- Configure the steps the application will take. --->
<cfset config['application']['steps'] = arrayNew(1) />
<cfset arrayAppend(config['application']['steps'], "buildDirectories") />
<cfset arrayAppend(config['application']['steps'], "sqlAnalyzeTables") />
<cfset arrayAppend(config['application']['steps'], "sqlWriteStoredProcs") />
<cfset arrayAppend(config['application']['steps'], "sqlAnalyzeProcs") />
<cfset arrayAppend(config['application']['steps'], "cfc_dao_gateway") />
<cfset arrayAppend(config['application']['steps'], "cfc_business_dynamic") />
<cfset arrayAppend(config['application']['steps'], "customtags") />
<cfset arrayAppend(config['application']['steps'], "cfms") />
<cfset arrayAppend(config['application']['steps'], "ant") />
<cfset arrayAppend(config['application']['steps'], "refreshApplication") />

<cfset config['settings']['applicationTemplate'] = "fkCrazy" />
</code>

</p>

<p>Note the changes are include swapping cfc_business_dynamic in for cfc_business and chaning the application template to "fkCrazy" cause it really is fkCrazy to do this. If you are going against an already made GangPlank application make sure that you do one of two things: delete your business cfc directory or change all of the inheritance so that the top level business objects inherit from their lower counterparts. </p>
				
				</p>
	<hr />

	
		<h3>Version 2.0.00164</h3>
		<p><strong>Mon, October 08, 2007 8:15:00 PM GMT</strong></p>
		<p>
				
				<p><strong>Only necessary for MYSQL users</strong></p>

<p>Made image crud work for MySQL.  Requires IsImage to be manually set on the blob column in the XML disk cache. This can be found in the tables.xml in your generated application's sql folder.</p>

<p>Configuration generator works for MySQL now.</p>

<p>Default configs have been slightly tweaked to work better. </p>

<p>Doc's slightly updated.</p>
				
				</p>
	<hr />

	
		<h3>Version 2.0.00156</h3>
		<p><strong>Mon, October 08, 2007 4:32:00 PM GMT</strong></p>
		<p>
				
				Ignore release.  Testing publishing mechanism.
				
				</p>
	<hr />

	
		<h3>Version 2.0.00159</h3>
		<p><strong>Mon, October 08, 2007 4:32:00 PM GMT</strong></p>
		<p>
				
				Ignore release.  Testing publishing mechanism.

No different for users than 155.
				
				</p>
	<hr />

	
		<h3>Version 2.0.00155</h3>
		<p><strong>Sun, October 07, 2007 11:32:00 PM GMT</strong></p>
		<p>
				
				Added a little extra CRUD for images.
Made refreshing the application a default step.
				
				</p>
	<hr />

	
		<h3>Version 2.0.00150</h3>
		<p><strong>Sat, September 29, 2007 11:01:00 PM GMT</strong></p>
		<p>
				
				Fixed more bugs with MySQL support. 
Added more user feedback on adds and updated to the UI and custom tag layer.
				
				</p>
	<hr />

	
		<h3>Version 2.0.00147</h3>
		<p><strong>Thu, September 27, 2007 6:52:00 PM GMT</strong></p>
		<p>
				
				<p>By adding MySql support I attracted Mac users to give GangPlank a try. <a href="http://angry-fly.com/">Russ Johnson</a> found a number of bugs that crop on a Mac.  Most were because I missed a few "\"'s that should have been "/"'s. Plus I might have discovered a CFImage bug on CF 8 for Mac OSX.</p>

<p>Thanks, Russ, for finding the bugs, and forcing me to get my Mac Mini up an running. </p>
				
				</p>
	<hr />

	
		<h3>Version 2.0.00123</h3>
		<p><strong>Sun, September 23, 2007 6:28:00 AM GMT</strong></p>
		<p> <p>New features: </p><ul><li><strong>MySql 5.0 Support </strong></li><li>It creates Ant Build files for common tasks 
			</li><li>It can run CFUnit tests that it creates during its build </li><li>It now will use CF8 rich elements it the generated crud * </li><li>It now 
			handles images * </li><li><div>It's now a little easier to extend </div><ul><li>It's easy to add steps. </li><li>It's possible to add 
			application templates </li></ul></li><li>Modified XML configuration allows developer to override certain defaults like form field labels. </li><li>New 
			Configuration Builder </li><li>New Shiny Web 2.0 looks (Okay, not a feature per see.) </li><li>Cheesey Web 2.0 Logos created for every application. 
			</li></ul><p>* CF 8 features can be turned off if application will not be running on a CF8 server. </p><p>Deprecated Features: 
			</p><ul><li>Simple Applications (They are still available, but they won't be updated) </li></ul><p>Removed Features: 
			</p><ul><li>Threading (Speed Enhancements weren't enough to justify added complexity) </li></ul><p>Requirements: 
			</p><ul><li>GangPlank: ColdFusion 8 </li><li>Database: Microsoft SQL 2000 or 2005; MySql 5.0 </li><li>Generated Application Using MSSQL:
			ColdFusion 7 or 8 </li><li>Generated Application Using MySql: ColdFusion 8 </li></ul><p>Notes: </p><ul><li>For the most part, your old 
			config files will still work. However the more changes you made the more likely they are to have problems. </li></ul><p>Old versions of GangPlank still available at
			<a href="http://www.numtopia.com/GangPlank">http://www.numtopia.com/GangPlank</a>.</p> </p>
	<hr />

	
		<h3>Version .9.9.2</h3>
		<p><strong>Fri, July 20, 2007 4:11:00 AM GMT</strong></p>
		<p> Overzealous refactoring led to bugs when a stored procedure returned multiple results. </p>
	<hr />

	
		<h3>Version .9.9.1</h3>
		<p><strong>Thu, July 19, 2007 2:14:00 AM GMT</strong></p>
		<p> Mostly bug fixes. Who knew adding threading would be so hard. Also fixed an issue with stored procedures with "fake table names." Basically when "usp_<this part here>_action 
			isn't a table, it was throwing an error. This is wrong behavior. </p>
	<hr />

	
		<h3>Version .9.9.0</h3>
		<p><strong>Tue, July 03, 2007 10:21:00 PM GMT</strong></p>
		<p> A whole bunch of little things: Forced GangPlank application scope to refresh on everypage call. Forced GangPlank application to be unique to the file path on the server. Added better
			comments for generated functions. Added optional CF8 threading for performance improvement. Only happens if config['settings']['useColdFusion8Features'] = TRUE. Which is set by default to 
			false. </p>
	<hr />

	
		<h3>Version .9.8.9</h3>
		<p><strong>Wed, June 27, 2007 10:36:00 PM GMT</strong></p>
		<p> In my haste to get the new features out today, I created a bug. Specificly, BUG 19. This is now fixed. </p>
	<hr />

	
		<h3>Version .9.8.8</h3>
		<p><strong>Wed, June 27, 2007 5:53:00 PM GMT</strong></p>
		<p> Added a feature: With the config flag - config['settings']['generateStoredProcedureFiles'] set to true, GangPlank will write a sql file for every stored procedure containing a drop
			procedure, create procedure and a grant permission. Caught two minor bugs: One was in the search stored procedure creator. It wasn't working properly depending on your column order. The 
			other was in the part that writes to stored procedures to disk. It wasn't as up to date at the rest.This has been fixed. </p>
	<hr />

	
		<h3>Version .9.8.7</h3>
		<p><strong>Tue, June 26, 2007 8:08:00 PM GMT</strong></p>
		<p> Note: This will definitely require you to reset the application scope of your installation of GangPlank. Call the index.cfm page of GangPlank with the url variable resetApp=true.
			Additionally, you will want to update your baseBusiness.cfc's. As they have been changed, and I don't want to update them automatically. Corrected stored procedure process to only create 
			foreign key related tables if they are appropriate. This creates less stored procedures and is a little neater. Further corrected behavior of bit fields in the application. They now cause 
			the UI to create a radio box for them instead of a text box. Also did a bunch of refactoring with an eye towards performance. I changed the unit testing component to test that all the UI 
			components call be called with out throwing an error. It's not an especially thorough test, but it does catch a lot of errors for me. Finally, I changed the unit test calling page to be 
			usable for the simple application type. Basically many of these changes were due to the fact that one user of the application was running it against a much larger database then I was 
			testing with. Your mileage with performance updates may vary. </p>
	<hr />

	
		<h3>Version .9.8.6</h3>
		<p><strong>Sat, June 23, 2007 5:46:00 AM GMT</strong></p>
		<p> Tweaked application configuration. Fixed Configuration documentation. Fixed issue 18: Default bit values in DAO create / update are not set to boolean values Refactored, and slightly 
			improved the speed due to a suspected performance issue which ended up being due to ColdFusion server monitoring being enabled. This isn't a problem with Coldfusion. The results are to be 
			expected. </p>
	<hr />

	
		<h3>Version .9.8.5</h3>
		<p><strong>Tue, June 05, 2007 11:54:00 PM GMT</strong></p>
		<p> Couple of Minor fixes this time around. Fixed a bug where GangPlank was referring to <tablename>ID instead of the actual identity column of the table. Added settings to allow for
			custom CSS. Refactored a few things. Altered foreign key procedures to create appropriate joins. Fixed an error where in active/deactive mode the delete method was changing the createdon 
			instead of the updatedon. Fixed requirement for the identity key to be passed back into the business custom tag template, because the business object already contain a value for it. Made 
			the version number of GangPlank appear in the comments of a stored proc. Altered the menus on the ui framework patterns. </p>
	<hr />

	
		<h3>Version .9.8.4</h3>
		<p><strong>Fri, May 25, 2007 4:55:00 PM GMT</strong></p>
		<p> Fixed a slight bug with simple/versus business objects. It was forcing business objects despite explictly turning them off. </p>
	<hr />

	
		<h3>Version .9.8.3</h3>
		<p><strong>Thu, May 24, 2007 5:53:00 PM GMT</strong></p>
		<p> Another big feature added, with some smaller updates. GangPlank now generates it's own CFUnit tests. Currently they only test the CRUD for tables with identities in the DAO's, but in
			the near future I will be looking to expand these out a little further. Additionally this testing rig supports user defined tests as well. If you place your tests in the test directory, 
			then they will be added to GangPlank's tests the next time GangPlank is run. This feature will require <a href="http://cfunit.sourceforge.net/">CFUnit</a>. Also: Altered the
			way file locations were handled. Instead of forcing the file locations to be set in every config, I added a default file configuration that handles setting up directories relative to the 
			file output, if those directories haven't already been setup in the user's config. Refactored a bunch of things, and fixed a few bugs. Based on issues that were revealed by unit testing. 
			Fixed a bug with stored procedures with the word "as" in the comments. </p>
	<hr />

	
		<h3>Version .9.8.2</h3>
		<p><strong>Mon, May 21, 2007 3:39:00 AM GMT</strong></p>
		<p> Refactored some bugs. Added some more documentation. Added support for custom UI's using config['settings']['applicationTemplate']. Deprecated config['settings']['useBusinessObjects']. 
			Same results can be achieved by setting config['settings']['applicationTemplate'] to business. </p>
	<hr />

	
		<h3>Version .9.8.1</h3>
		<p><strong>Tue, May 15, 2007 6:20:00 PM GMT</strong></p>
		<p> Fixed a bug in Active table creation. Updated documentation. </p>
	<hr />

	
		<h3>Version .9.8</h3>
		<p><strong>Fri, May 11, 2007 6:57:00 PM GMT</strong></p>
		<p> 
			<p>Added a huge feature: Foreign Key support.</p>
			Summary: Input forms will display a select box of appropriate values for foreign
			keyed fields.</p>
			<p>List and Read UI components will show an appropriate column from the foreign
			table instead of the local table value.</p>
			
			<p>It's bound to be really buggy, I did try and take it through its paces though. In any
			case use with caution.</p>
			
			<p>Expect a .9.8.5 release with some documentation too.</p>
			
			<p>How this works: For every table a "foreign key label" is computed (The second
			column in the table.)</p>
			
			<p>For Display New StoredProcs are generated specifically a select_with_FK and a
			list_with_fk. These are generated as a select or list operation with all of the
			correct joins in place, and the foreign key's column in the displayed table being
			replaced by the "foreign key label" of the linked table. These with_fk procs are
			then used by the UI display widgets instead of the default select and read items.</p>
			
			<p>For Editing A new storedproc was added that allowed for a quick retrial of a query
			of ID and "foreign key label". This is in turn used by a custom tag that will display
			a select box for foreign keyed columns.</p>
			
			<p>Thanks to Antonio Vivas and Karen Leary, both at Wharton for pushing this
			feature, and giving an elegant idea for how to implement it.</p>  </p>
	<hr />

	
		<h3>Version .9.7.1</h3>
		<p><strong>Wed, May 09, 2007 6:51:00 PM GMT</strong></p>
		<p> Slight bug in the business object stuff. Fixed. </p>
	<hr />

	
		<h3>Version .9.7</h3>
		<p><strong>Wed, May 09, 2007 3:13:00 PM GMT</strong></p>
		<p> Two major changes were added, both are optional to use. <ol> <li>Added a business objects layer that sits above the DAO. You pass it an instance of a DAO, and it handles a 
			few operations out of the gate for you, like not having to determine if an object exists and needing to decide between creation and updating. It was championed by <a 
			href="http://www.lifelikeweeds.com/tech/">Dave Konopka</a>, and it's pretty good stuff. You can use it by setting: <code> <cfset 
			config['settings']['createBusinessObjects'] = TRUE /> </code> </li> <li>Rewired the generated custom tags and templates to optionally use the new business layer. You 
			can use this by setting: <code> <cfset config['settings']['useBusinessObjects'] = TRUE/> </code> </li> <li> Added an optional XML based disk cache of the 
			structure of the database and stored procedures. Currently you can do two things with it. <ol> <li>Set an orderby using SQL notation that will affect the default list 
			functions. </li> <li>Set a Display name for database fields that will affect the labels on the CRUD UI components.</li> </ol></li> It's important to note 
			that once you turn this on, You'll no longer be updating from the database. So you don't want to use this until your database model is complete. You can use this by seting: <code> 
			<cfset config['settings']['useDiskCache'] = TRUE /> </code> </li> </ol> </p>
	<hr />

	
		<h3>Version .9.6</h3>
		<p><strong>Wed, April 18, 2007 8:21:00 PM GMT</strong></p>
		<p> Fixed Issue #17. GangPlank now looks to stored procedure parameters to determine if the calling function arguments that correspond to the params are required. Up until now, we were
			looking at the table - IsNullable for that. Added an extra method to the gateway. Now gateways will also have a "search" function that allows any column or group of columns to be passed 
			in and searched. So if you wanted to search for all firstname = 'Terrence' and all lastname = 'Ryan' you can do that. Varchar fields use like for matching, while all other fields look for 
			an exact match. Also fixed a bug in the delete stored procedure created for a table with an "active" column. </p>
	<hr />

	
		<h3>Version .9.5</h3>
		<p><strong>Fri, April 13, 2007 3:21:00 AM GMT</strong></p>
		<p> Fixed bugs dealing with multiple selects in stored procedures. It was over-counting selects because of the word "select" in comments and stored procedure name. Fixed through the magic 
			of regular expressions. Fixed bug associated with reserved words. They were using "find" operations, instead of finding exact words. </p>
	<hr />

	
		<h3>Version .9.4</h3>
		<p><strong>Thu, April 05, 2007 4:46:00 PM GMT</strong></p>
		<p> Fixed an issue with unicode char and varchar fields being reported as double their length (which caused issues around the upper limit of their acceptable length.) (Thanks John H.) Also 
			reset CFC output=false, to reduce whitespace in the generation process. (Which speeds it up a bit.) </p>
	<hr />

	
		<h3>Version .9.3</h3>
		<p><strong>Tue, April 03, 2007 5:47:00 AM GMT</strong></p>
		<p> Updated Configuration reference in Installation Documentation. Updated FAQ's. Added first pass of validation to Custom Tags in created application. (Enforces required attributes.) 
			Added exclusion prefix to configuration, allowing all tables with a given prefix. (Thanks to Mark Ireland for the suggestion.) Added exclusion list to configuration, allowing a list of 
			tables to be excluded from scaffolding. </p>
	<hr />

	
		<h3>Version .9.2</h3>
		<p><strong>Fri, March 30, 2007 4:45:00 AM GMT</strong></p>
		<p> Responded to two responses to issues with this update. 1. Fixed guid length bug, reported in issue 15. 2. Added enhancement which allows for delete operation to be replaced with action 
			that marks records as inactive, instead of deleting them from the database. Woooooo fun stuff. </p>
	<hr />

	
		<h3>Version .9.1</h3>
		<p><strong>Tue, March 27, 2007 8:26:00 PM GMT</strong></p>
		<p> Support for multiple OUT variables from Stored Procedures have been added. Support for multiple results sets from Stored Procedures have been added. In both cases when more than one 
			result (either more than one output variable, or more than one query) is possible for a given stored procedure, the function that wraps it returns a struct containing all of the items. 
			Made slight changes to the custom tags, which allow them to be slightly more reusable. Added an override-able setting for default cffunction access attribute. By default it is "public" 
			but you could make all of the functions be "remote" if you were say... working on a Flex App for the front end. </p>
	<hr />

	
		<h3>Version .9.0</h3>
		<p><strong>Fri, March 23, 2007 3:12:00 AM GMT</strong></p>
		<p> Modified configuration routine to default many of the settings to make old config files work without throwing errors. Isolated much of the MS SQL specific code to start allowing for 
			other database providers. Modified Custom Tag creation to make list, read, and form customs tags more portable. Altered default behavior for user imported stored procedures. Now function 
			returns type "any" to accommodate stored procedures that return a query, or no value. Figured this was a good compromise. Fleshed out the sql variable type list. </p>
	<hr />

	
		<h3>Version .8.9</h3>
		<p><strong>Thu, March 22, 2007 1:39:00 AM GMT</strong></p>
		<p> Fixed a few bugs. Added additional support for SQL 2005. </p>
	<hr />

	
		<h3>Version .8.8</h3>
		<p><strong>Mon, February 26, 2007 9:25:00 PM GMT</strong></p>
		<p> Fixed a few bugs. Cleaned up support for a few data types (bit, float). Make sure you update your config files from the new copy of sample.cfm. </p>
	<hr />

	
		<h3>Version .8.7</h3>
		<p><strong>Mon, February 19, 2007 3:33:00 AM GMT</strong></p>
		<p> Fixed some issues with Number data types. </p>
	<hr />

	
		<h3>Version .8.6</h3>
		<p><strong>Thu, February 15, 2007 5:09:00 AM GMT</strong></p>
		<p> Nothing major just a few slight improvements to performance, and whitespace reduction. </p>
	<hr />

	
		<h3>Version .8.5</h3>
		<p><strong>Wed, February 07, 2007 10:39:00 PM GMT</strong></p>
		<p> 
			
			<p>Another day, another buttload of issues.</p>

<p>A number of issue were revealed using the Northwind Database.  Thanks for pointing them all out, Chad. (No sarcasm).</p>

<p>Images datatypes from the database were causing errors. They now gracefully fail to display. Will think about how to deal with images in upcoming releases. (Fixed Issue 7)</p>

<p>Tables or views with spaces caused all sorts of odd failures. Long story short, spaces are removed spaced table and view names in storedprocs cfc's and customtags.     (Fixed Issue 6)</p>

<p>The sample.cfm was missing a default value for binary data.</p> </p>
	<hr />

	
		<h3>Version .8.4</h3>
		<p><strong>Wed, February 07, 2007 10:10:00 AM GMT</strong></p>
		<p><p>Fixed issue 5. </p>

<p>Removed restriction against underscores in table names.</p>

<p>Cleaned up behavior of image field in AutoCrud portion of application.</p> </p>
	<hr />

	
		<h3>Version .8.3</h3>
		<p><strong>Tue, February 06, 2007 10:36:00 PM GMT</strong></p>
		<p> 
			<p>Yeah, so I'm not so good with the making the code good.</p>
			
			<p>Fixed issue 4.</p>
			
			<p>Added ability to output created application to a subdirectory of output
				folder.</p>
			
			<p>Updated documentation.</p>
			
			<p>Added comment headers to the stored procedures.</p> </p>
	<hr />

	
		<h3>Version .8.2</h3>
		<p><strong>Mon, February 05, 2007 9:08:00 PM GMT</strong></p>
		<p>Fixed issues 1, 2, and 3.</p>
	<hr />

	
		<h3>Version .8.1</h3>
		<p><strong>Mon, February 05, 2007 1:10:00 PM GMT</strong></p>
		<p> I uploaded a few fixes to bugs that would only allow themselves to be discovered
			AFTER I uploaded to RIAforge. The included Edit/Add New form was throwing
			exception because it was appending ID to the table name for the identity field
			instead of referencing the actual identity field. </p>
	<hr />

	


