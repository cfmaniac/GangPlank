<!---    applicationTemplate.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Template for the application.cfm file in the output CRUD application.
					 Did it as custom tag instead of a function because it was easier to edit.
					 plus one template to output file ratio seems more understandable in my mind.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.result" type="string" default="result" />
<cfparam name="attributes.configObj" type="any" />




<strong>with BusinessDynamic Template</strong>

<!--- tpryan 5/2007 Added to aid in autoinstaniation of objects for business layer. --->
<cffunction name="convertFilePathToCFCPath">
	<cfargument name="webrootPath" type="string" required="yes" hint="Corresponds to the path for \ in the cfadmin tool." />
	<cfargument name="CFCPath" type="string" required="yes" hint="The file path of the CFC." />

	<cfset var results = ReplaceNoCase(arguments.CFCPath, arguments.webrootPath, "", "ALL") />
	<cfset results = Left(results, Len(results) -4) />
	<cfset results = ReplaceList(results, "\,/", ".,.") />

	<cfif left(results,1) eq ".">
		<cfset results = Right(results, Len(results) - 1) />
	</cfif>

	<cfreturn results />
</cffunction>

<!--- tpryan 5/2007 Added to aid in autoinstaniation of objects for business layer. --->
<cffunction name="convertCFCPathtoApplicationVariable">
	<cfargument name="CFCRootPath" type="string" required="yes" hint="Teh top level CFC folder for the application." />
	<cfargument name="CFCPath" type="string" required="yes" hint="The cfc path of the CFC." />

	<cfset var results = ReplaceNoCase(arguments.CFCPath, arguments.CFCRootPath, "", "ALL") />
	<cfset results = ReplaceNoCase(results, "..", ".", "ALL") />
	<cfset results = ReplaceNoCase(results, ".", "", "ONCE") />

	<cfif left(results,1) eq ".">
		<cfset results = Right(results, Len(results) - 1) />
	</cfif>


	<cfreturn results />
</cffunction>

<!--- tpryan 5/2007 Added to aid in autoinstaniation of objects for business layer. --->
<cfdirectory directory="#attributes.configObj.get('filelocations','cfc')#" action="list" name="applicationDirectory" recurse="true" filter="*.cfc" />

<!--- tpryan 5/2007 Added to aid in autoinstaniation of objects for business layer. --->
<cfquery name="applicationDirectory" dbtype="query">
	SELECT 	directory + '/' + name as component
	FROM	applicationDirectory
	WHERE	directory not like '%dynamic%'
	AND		directory not like '%business%'
</cfquery>

<cfset cfmloutput = "" />
<cfset cfmloutput = cfmloutput & '<cfapplication name="' & attributes.configObj.get('application','appname') & '" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '<cfset application.datasource = "' & attributes.configObj.get('db','datasource') & '" />' & chr(13) />
<cfset initList = "datasource=application.datasource" />
<!--- Only put the username and password if they were passed in.  --->
<cfif len(attributes.configObj.get('db','username')) gt 0 AND len(attributes.configObj.get('db','password')) gt 0>
	<cfset cfmloutput = cfmloutput & '<cfset application.dbusername = "' & attributes.configObj.get('db','username') & '" />' & chr(13) />
	<cfset initList = ListAppend(initList, "dbusername=application.dbusername") />
	<cfset cfmloutput = cfmloutput & '<cfset application.dbpassword = "' & attributes.configObj.get('db','password') & '" />' & chr(13) />
	<cfset initList = ListAppend(initList, "dbpassword=application.dbpassword") />
</cfif>


<cfset cfmloutput = cfmloutput & '<cfif not StructKeyExists(application, "started") or StructKeyExists(url, "reset_app")>' & chr(13) />

<!--- tpryan 5/2007 Added to aid in autoinstaniation of objects for business layer. --->
<cfloop query="applicationDirectory">
	<cfset cfcToCall = convertFilePathToCFCPath(attributes.configObj.get('filelocations','webroot'),'#component#') />
	<cfset cfcvariable = convertCFCPathtoApplicationVariable(attributes.configObj.get('application','CFCpathCFCStyle'),'#cfcToCall#') />
	<cfset cfmloutput = cfmloutput & '	<cfset application.' & cfcvariable & 'Obj = createObject("component","' & cfcToCall & '").init(#initList#) />' & chr(13) />
</cfloop>

<cfset cfmloutput = cfmloutput & '<cfset application.started = TRUE />' & chr(13) />

<cfset cfmloutput = cfmloutput & '</cfif>' & chr(13) />


<cfset cfmloutput = cfmloutput & chr(13)/>

<cfset cfmloutput = cfmloutput & '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' & chr(13) />
<cfset cfmloutput = cfmloutput & '<html xmlns="http://www.w3.org/1999/xhtml">' & chr(13) />
<cfset cfmloutput = cfmloutput & '<head>' & chr(13) />
<cfset cfmloutput = cfmloutput & '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />' & chr(13) />
<cfset cfmloutput = cfmloutput & '<title>' & attributes.configObj.get('application','appname') & '</title>' & chr(13) />
<cfset cfmloutput = cfmloutput &  '<link rel="stylesheet" href="' & attributes.configObj.get('application','url') & "/" & attributes.configObj.get('application','cssPath') &'/default.css" type="text/css"/>' & chr(13) />
<cfset cfmloutput = cfmloutput & '</head>' & chr(13) />

<cfset cfmloutput = cfmloutput & '<body>' & chr(13) />

<cfif FileExists("#attributes.configObj.get('filelocations','images')#\logo.jpg")>
	<cfset cfmloutput = cfmloutput & '<h1><img src="#attributes.configObj.get("application","url")#/#attributes.configObj.get("application","imagePath")#/logo.jpg" width="500" height="50" alt="#attributes.configObj.get("application","appname")#"></h1>' & chr(13) />
<cfelse>
 	<cfset cfmloutput = cfmloutput & '<h1>' & attributes.configObj.get('application','appname') & '</h1>' & chr(13) />
</cfif>



<cfset caller[attributes.result]  = cfmloutput />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />