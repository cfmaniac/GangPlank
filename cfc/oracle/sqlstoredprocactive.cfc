<!---   SQLstoredprocActive.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Handles all of the rules assoiciated with creating SQL stored procedures
--->
<!--- 3/29/2007 tpryan updated to allow for active inactive delete instead of actual deleting of records. --->
<cfcomponent output="FALSE" extends="sqlstoredproc">











	<!---***********************************************************--->
	<!---createProcedureDelete                   --->
	<!---Creates a stored proc for a table delete.                   --->
	<!---***********************************************************--->
	<cffunction access="public" name="createProcedureDelete" output="false" returntype="struct" description="Creates a stored proc for a table delete.">
		<cfargument name="columnInfo" type="struct" required="yes" hint="The columnInfo struct." />
		<cfargument name="noCountOn" type="boolean" required="no" default="TRUE" hint="Whether or not to set no count on." />

		<cfset var results = StructNew() />
		<cfset var procContents = "" />
		<cfset var displayName = "DESTROY" />
		<cfset var procName = displayName />


		<cfset procContents = procContents.concat("PROCEDURE #procName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(Chr(9) & "(p_#variables.Identity# IN NUMBER)" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("IS" & Chr(13) & Chr(10) & "BEGIN" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(createComment(name=procName, author="GangPlank", description="Deletes one record in table #variables.tableName#")) />

		<cfset procContents = procContents.concat("UPDATE" & Chr(9) & "#variables.tableName#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("SET" & Chr(9) & configObj.get('reservedWords', 'active') & "= 0" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("WHERE"	& Chr(9) & "#variables.Identity# = p_#variables.Identity#" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat(";" & Chr(13) & Chr(10)) />
		<cfset procContents = procContents.concat("END;" & Chr(13) & Chr(10)) />

		<cfset results.contents = procContents />
		<cfset results.name = procName />
		<cfset results.displayName = displayName />

		<cfreturn results />
	</cffunction>





</cfcomponent>