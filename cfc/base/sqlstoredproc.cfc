<!---   SQLstoredproc.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Handles all of the rules assoiciated with creating SQL stored procedures
--->
<cfcomponent output="false">

	<!---***********************************************************--->
	<!---createComment                           --->
	<!---Creates a comment string to document the stored procedure.  --->
	<!---***********************************************************--->
	<cffunction access="public" name="createComment" output="false" returntype="string" description="Creates a comment string to document the stored procedure.">
		<cfargument name="name" type="string" required="yes" hint="The name of the stored procedure." />
		<cfargument name="description" type="string" required="no" default="" hint="A decription of what the stored procedure does." />
		<cfargument name="author" type="string" required="no" default="" hint="The name of the author of the stored procedure." />

		<cfset var results = CreateObject("java","java.lang.StringBuilder").Init() />

		<cfset results.append('/**********************************************************************' & Chr(13) & Chr(10)) />
		<cfset results.append( chr(9) & 'Stored Procedure: #chr(9)# #arguments.name#' & Chr(13) & Chr(10)) />
		<cfif len(arguments.author) gt 0>
			<cfset results.append(chr(9) & 'Author: #chr(9)# #chr(9)# #chr(9)# #arguments.author# #variables.configObj.get("settings", "GangPlankVersion")#' & Chr(13) & Chr(10)) />
		</cfif>
		<cfif len(arguments.description) gt 0>
			<cfset results.append(chr(9) & 'Description: #chr(9)# #chr(9)# #arguments.description#' & Chr(13) & Chr(10)) />
		</cfif>
		<cfset results.append(chr(9) & 'Modified: #chr(9)# #chr(9)# #chr(9)# #DateFormat(now(), "mmmm d yyyy")# #TimeFormat(now(), "hh:mm tt")#' & Chr(13) & Chr(10)) />
		<cfset results.append('**********************************************************************/' & Chr(13) & Chr(10)) />

		<cfreturn results.toString() />
	</cffunction>

	<!---***********************************************************--->
	<!---addStoredProcToDB                       --->
	<!---Adds a stored proc to the DB.                               --->
	<!--- Encapsulates a couple other methods.                        --->
	<!---***********************************************************--->
	<cffunction access="private" name="addStoredProcToDB" output="false" returntype="void" description="Adds a stored proc to the DB. Encapsulates a couple other methods.">
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">
		<cfargument name="creationCode" type="string" required="yes" hint="Code to Create stored Proc.">

		<cfset var nameOfProc = arguments.name />
		<cfset var creationCodeOfProc = arguments.creationCode />
		<cfset var deleted = FALSE />
		<cfset var created = FALSE />
		<cfset var exists = StoredProcExists(name=nameOfProc) />



		<cfif exists>
			<cfset deleted =DropStoredProc(name=nameOfProc)>
		</cfif>

		<cfdump var="#exists#">

		<cfif deleted or not exists>
			<cfset created = CreateStoredProc(creationCode=creationCodeOfProc)>
		</cfif>

		<!--- This is the only part that needs a username for.  So if the username if blank, don't bother with this. --->
		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0 AND created>
			<cfset GrantExecStoredProc(name=nameOfProc)>
		</cfif>


	</cffunction>

	<!---***********************************************************--->
	<!---DropStoredProc                          --->
	<!---Drops a stored proc exists in a given database.             --->
	<!---***********************************************************--->
	<cffunction access="private" name="DropStoredProc" output="false" returntype="boolean" description="Drops a stored proc in a given database.">
		<cfargument name="name" type="string" required="yes" hint="Name of the stored Proc to test.">

		<cfset var drop = "" />

		<cftry>

			<!--- Adjust for fact that you may not have a database username and password. --->
			<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
				<cfquery name="drop" datasource="#configObj.get('db', 'datasource')#" username="#configObj.get('db', 'username')#" password="#configObj.get('db', 'password')#">
					DROP PROCEDURE #arguments.name#
				</cfquery>
			<cfelse>
				<cfquery name="drop" datasource="#configObj.get('db', 'datasource')#">
					DROP PROCEDURE #arguments.name#
				</cfquery>
			</cfif>

			<!--- Why a catch that does nothing? Because I couldn't figure out how to make these stop throwing errors.'--->
			<!--- It's intermitent and testing doesn't reveal any problems.' ' --->
			<cfcatch />
		</cftry>

		<cfreturn TRUE />
	</cffunction>

	<!---***********************************************************--->
	<!---CreateStoredProc                        --->
	<!---Creates a stored proc n a given database.                   --->
	<!---***********************************************************--->
	<cffunction access="private" name="CreateStoredProc" output="false" returntype="boolean" description="Creates a stored proc n a given database.">
		<cfargument name="creationCode" type="string" required="yes" hint="Code to Create stored Proc.">

		<cfset var create = "" />
		<cfset var errorText = "" />

		<cftry>
		<!--- Adjust for fact that you may not have a database username and password. --->
		<cfif len(configObj.get('db', 'username')) gt 0 and len(configObj.get('db', 'password')) gt 0>
			<cfquery name="create" datasource="#configObj.get('db', 'datasource')#" username="#configObj.get('db', 'username')#" password="#configObj.get('db', 'password')#">
				#PreserveSingleQuotes(arguments.creationCode)#
			</cfquery>
		<cfelse>
			<cfquery name="create" datasource="#configObj.get('db', 'datasource')#">
				#PreserveSingleQuotes(arguments.creationCode)#
			</cfquery>
		</cfif>

		<!--- Why a catch that does nothing? Because I couldn't figure out how to make these stop throwing errors.'--->
		<!--- It's intermitent and testing doesn't reveal any problems.' ' --->
		<cfcatch type="any">
			<cfif FindNoCase("The text, ntext, and image data types cannot be compared", cfcatch.detail) >
				<cfset errorText = ReplaceNoCase(arguments.creationCode, chr(13), "<br />", "ALL") />
				<cfthrow message="Problem with Generated Stored Procedure" detail="The stored procedure is trying to sort on a text, ntext, or image. Change the order of the columns table in the table #UCase(tableName)#.<p>#errorText#</p>" type="GangPlank" />
			</cfif>
			<cfdump var="#cfcatch#">

			<cfdump var="#arguments.creationCode#"><cfabort>


			<cfrethrow />	<!--- Comment out so you don't steal anybody's data accidently. ' --->
			<!--- <cfmail subject="Debug Email2" to="tpryan@wharton.upenn.edu" from="tpryan@wharton.upenn.edu" type="html">
					<cfdump var="#creationCode#">
					<cfdump var="#cfcatch#">
			</cfmail> --->
		</cfcatch>
		</cftry>

		<cfreturn TRUE />
	</cffunction>

	<!---***********************************************************--->
	<!---AutoGenerateProcs                     --->
	<!---Grants Exec Permissions on given database user.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="AutoGenerateProcs" output="false" returntype="struct" hint="Basically creates all of the different types of stored procs. ">
		<cfargument name="addToDatabase" type="boolean" required="no" default="TRUE" hint="Whether or not to add the stored procs to the database. " />

		<cfset var storedProcName = "" />
		<cfset var Proc = StructNew() />
		<cfset var results = StructNew() />

		<cfset var log = "" />
		<cfset var tableArray= databaseObj.getTableArray() />
		<cfset var j= 0 />
		<cfset var i= 0 />
		<cfset var joinTable = "" />
		<cfset var JoinTableProc = "" />
		<cfset var JoinTableProcName = "" />



		<!--- LIST --->
		<cfset Proc = createProcedureList(variables.columnInfo,TRUE) />
		<cfif arguments.addToDatabase>
			<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
		</cfif>
		<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />

		<!--- SEARCH (if db type is MSSQL) --->
		<cfif compareNoCase(configObj.get('db','type'), "mssql") eq 0>
			<cfset Proc = createProcedureSearch(variables.columnInfo,TRUE) />
			<cfif arguments.addToDatabase>
				<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
			</cfif>
			<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
		</cfif>


		<cfif tableObj.hasForeignKeys()>
			<!--- LIST WITH FK --->
			<cfset Proc = createProcedureListwithForeignKeys(variables.columnInfo,TRUE) />
			<cfif arguments.addToDatabase>
				<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
			</cfif>
			<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />

			<!---LIST BY FK --->
			<cfloop index="j" from="1" to="#ArrayLen(tableDetails.columnArray)#">
				<cfif len(tableDetails['columnlist'][tableDetails.columnArray[j]]['linkedField']) gt 0>
					<cfset Proc = createProcedureListByForeignKey(tableDetails.columnList,tableDetails['columnlist'][tableDetails.columnArray[j]]['name'])>
					<cfif arguments.addToDatabase>
						<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
					</cfif>
					<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
				</cfif>
			</cfloop>


		</cfif>


		<!--- LIST THROUGH JOIN TABLE --->
		<cfif tableObj.hasJoinTable()>
			<cfloop list="#tableObj.getJoinTableList()#" index="joinTable">
				<cfset Proc = createListThroughJoinTable(variables.columnInfo,TRUE, joinTable) />
				<cfif arguments.addToDatabase>
					<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
				</cfif>
				<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
			</cfloop>
		</cfif>



		<cfif tableObj.getType() neq "view" and tableObj.isProperTable()>

			<!--- READ --->
			<cfset Proc = createProcedureSelect(variables.columnInfo,TRUE) />
				<cfif arguments.addToDatabase>
					<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
				</cfif>
			<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />

			<!--- CREATE --->
			<cfset Proc = createProcedureInsert(variables.columnInfo,TRUE) />
			<cfif arguments.addToDatabase>
				<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
			</cfif>
			<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />

			<!--- UPDATE  --->
			<cfset Proc = createProcedureUpdate(variables.columnInfo,TRUE) />
			<cfif arguments.addToDatabase>
				<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
			</cfif>
			<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />

			<!--- DESTROY --->
			<cfset Proc = createProcedureDelete(variables.columnInfo,TRUE) />
			<cfif arguments.addToDatabase>
				<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
			</cfif>
			<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />

			<!--- LIST FK LABELS --->
			<cfif tableObj.isReferencedAsFK()>
				<cfset Proc = createProcedureListForeignKeyLabels(variables.columnInfo,TRUE) />
				<cfif arguments.addToDatabase>
					<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
				</cfif>
				<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
			</cfif>

			<!--- READ WITH FK --->
			<cfif tableObj.hasForeignKeys()>
				<cfset Proc = createProcedureSelectwithForeignKeys(variables.columnInfo,TRUE) />
				<cfif arguments.addToDatabase>
					<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
				</cfif>
				<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
			</cfif>

			<!--- READ BY UNIQUE JOIN --->
			<cfif tableObj.isJoinTable()>
				<cfset Proc = createProcedureJoinTableUnique(variables.columnInfo,TRUE,tableObj.getPassThroughTableLinkedFields()) />
				<cfif arguments.addToDatabase>
					<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
				</cfif>
				<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
			</cfif>

			<!--- READ BY UNIQUE COLUMN  --->
			<cfif len(tableObj.getUniqueList())>
				<cfloop list="#tableObj.getUniqueList()#" index="uniqueColumn">
					<cfset Proc = createProcedureSelect(variables.columnInfo,TRUE,uniqueColumn, tableObj.getColumnTypeAndLen(uniqueColumn)) />
					<cfif arguments.addToDatabase>
						<cfset addStoredProcToDB(name=Proc.name, creationCode=Proc.contents) />
					</cfif>
					<cfset results[proc.DisplayName] = wrapProc(proc.Name,proc.contents) />
				</cfloop>
			</cfif>


		</cfif>

		<cfreturn results />
	</cffunction>

	<!---***********************************************************--->
	<!---ScriptProcs                             --->
	<!---Creates all of the different types of stored procs in a sql file.             --->
	<!---***********************************************************--->
	<cffunction access="public" name="ScriptProcs" output="false" returntype="string" hint="Basically creates all of the different types of stored procs in a sql file. ">

		<cfset var generatedScript = CreateObject("java","java.lang.StringBuilder").Init() />
		<cfset var procStruct = AutoGenerateProcs(FALSE) />
		<cfset var proc ="" />

		<cfloop collection="#procStruct#" item="proc">
     		<cfset generatedScript.append(procStruct[proc]) />
   		</cfloop>

		<cfreturn generatedScript.toString() />
	</cffunction>

	<!---***********************************************************--->
	<!---setActive                                --->
	<!---Set's the active element of the cfc.                        --->
	<!---***********************************************************--->
	<cffunction access="public" name="setActive" output="false" returntype="void" description="Set's the active element of the cfc." >
		<cfargument name="active" type="boolean" required="yes" default="" hint="The value to set for active." />
		<cfset variables.active = arguments.active />
	</cffunction>

</cfcomponent>