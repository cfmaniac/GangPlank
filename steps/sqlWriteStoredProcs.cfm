<!---    sqlWriteStoredProcs.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:43:01 AM
DESCRIPTION			: Writes CRUD Stored procedures.
---->


<cfset stepTrackerObj.require("buildDirectories") />
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.forceProcRefresh" type="boolean" default="FALSE" />

<cfif url.forceRefresh>
	<cfset url.forceProcRefresh = TRUE />
</cfif>


<cftimer label="Writing Stored Procedures" type="inline">
<p class="alert alert-success">Writing Stored Procedures</p>
<cfobjectcache action = "clear" />
<cfset tableArray = databaseObj.GetTableArray() />
<!--- If you are generating the script, write it.  --->
<cfif configObj.get('settings','generateSQLScript')>
	<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','sql')#\script.sql" output="" fixnewline="no" />
</cfif>



<cfoutput>
<ul>
<!--- If you are generating the script, write it.  --->
<cfif configObj.get('settings','generateSQLScript')>
	<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','sql')#\script.sql" output="" fixnewline="no" />
</cfif>

<cfloop index="i" from="1" to="#arrayLen(tableArray)#">


	<cfset tableObj = "" />
	<cfset StoredProcObj = "" />

	<!--- Objectize the table --->
	<cfset tableObj = createObject("component",configObj.get('cfc','table')).init(databaseObj=databaseObj, configObj=configObj, tableName=tableArray[i]) />


	<cfif tableObj.hasChanged() or url.forceProcRefresh>

		<cfif tableObj.IsActive()>
			<cfset SqlCFCtoCall = configObj.get('cfc','sqlstoredprocactive') />
		<cfelse>
			<cfset SqlCFCtoCall = configObj.get('cfc','sqlstoredproc') />
		</cfif>


		<cfset StoredProcObj = createObject("component",SqlCFCtoCall).init(databaseObj=databaseObj, configObj=configObj, tableObj=tableObj) />


		<!--- Our SQL admins are poopheads. --->
		<cfif configObj.get('settings','generateSQLScript')>
			<li>Creating Script for #tableObj.getType()#: #tableObj.getTableName()#
			<cfset scriptContents = StoredProcObj.ScriptProcs() />
			<cffile action="append" addnewline="yes" file="#configObj.get('fileLocations','sql')#\script.sql" output="#scriptContents#" fixnewline="no" />
			- Done</li>
		<!--- Auto Create the stored procs. --->
		<cfelse>
			<li>Creating CRUD for  #tableObj.getType()#:  #tableObj.getTableName()#
			<cfset procStruct=StoredProcObj.AutoGenerateProcs() />
			- Done</li>
		</cfif>

		<cfif configObj.get('settings','generateStoredProcedureFiles')>

			<cfif not structKeyExists(variables,"procStruct")>
				<cfset procStruct=StoredProcObj.AutoGenerateProcs(FALSE) />
			</cfif>

			<cfloop collection="#procStruct#" item="proc">
				<cffile action="write" addnewline="yes" file="#configObj.get('fileLocations','sql')#\#proc#.sql" output="#procStruct[proc]#" fixnewline="no" />
		   	</cfloop>
		</cfif>
	<cfelse>
		<li>No Changes to #tableObj.getType()#:  #tableObj.getTableName()# - Done</li>

	</cfif>



	<!--- tpryan 6/2007 Manage memory a little better --->
	<cfset StructDelete(variables, "tableObj") />
	<cfset StructDelete(variables, "StoredProcObj") />

</cfloop>
</ul>
</cfoutput>




</cftimer>


