<cfcomponent extends="GangPlank2.cfc.base.database">

	<!---***********************************************************--->
	<!---init                                    --->
	<!---Psuedo constructor, and all around nice function.           --->
	<!---***********************************************************--->
	<cffunction access="public" name="init" output="FALSE" >
		<cfargument name="configObj" type="any" required="no" default="" hint="The configuration of the application." />

		<cfset variables.overrideList ="displayName,orderBy,ForeignKeyLabel,IsImage,label" />
		<cfset variables.configObj = arguments.configObj />
		<cfset variables.databaseStruct = StructNew() />
		<cfset variables.tableArray = ArrayNew(1) />

		<cfinvoke component="#configObj.get('cfc','help')#" method="init" returnvariable="variables.helpObj">
			<cfinvokeargument name="datasource" value="#configObj.get('db', 'datasource')#" />
			<cfinvokeargument name="username" value="#configObj.get('db', 'username')#" />
			<cfinvokeargument name="password" value="#configObj.get('db', 'password')#" />
			<cfinvokeargument name="database" value="#configObj.get('db', 'database')#" />
			<cfinvokeargument name="configObj" value="#variables.configObj#" />
		</cfinvoke>


		<cfobjectcache action = "clear" />
		<cfset inspectTables() />

		<cfreturn This />
	</cffunction>


	<!---***********************************************************--->
	<!---analyzeProcText                       --->
	<!---Analyzes the text of a storeProc in order to determine things about it.       --->
	<!---***********************************************************--->
	<cffunction access="public" name="analyzeProcText" output="false" returntype="struct" description="Analyzes the text of a storeProc in order to determine things about it. " >
		<cfargument name="procQuery" type="query" required="yes" default="" hint="The query of code that declares a proc. " />

		<cfset var spContentsText = valueList(arguments.procQuery.text, chr(13)) />
		<cfset var spStruct = structNew() />
		<cfset var stringStruct = structNew() />
		<cfset var i = 0 />
		<cfset var tempStruct = StructNew() />

		<!--- Remove comments as sometimes crap in their can screw stuff up.  --->
		<cfset spContentsText = REReplaceNoCase(spContentsText, "/\*.*\*/", "", "ALL") />


		<cfset stringStruct['pare']['start']= FindNoCase("(", spContentsText) + 1 />
		<cfset stringStruct['pare']['end']= FindNoCase(")", spContentsText, stringStruct['pare']['start']) />

		<cfset stringStruct['body']['start']= FindNoCase("BEGIN", spContentsText) + 5 />
		<cfset stringStruct['body']['end']= FindNoCase("END", spContentsText)  />


		<cfset spStruct['params'] = Trim(Mid(spContentsText, stringStruct['pare']['start'], stringStruct['pare']['end'] - stringStruct['pare']['start']))>


		<cfset spStruct['params'] = ListToArray(spStruct['params'], ",") />


		<cfloop index="i" from="1" to="#arrayLen(spStruct['params'])#">
			<cfset tempStruct = analyzeProcParam(spStruct['params'][i]) />
			<cfif not tempStruct['cursor']>
				<cfset spStruct['params'][i] =  tempStruct />
			</cfif>
		</cfloop>

		<cfloop index="i" from="#arrayLen(spStruct['params'])#" to="1" step="-1">
			<cfif not IsStruct(spStruct['params'][i])>
				<cfset ArrayDeleteAt(spStruct['params'], i) />
			</cfif>
		</cfloop>

		<cfset spStruct['body'] = Trim(Mid(spContentsText, stringStruct['body']['start'], stringStruct['body']['end'] - stringStruct['body']['start']))>

		<cfreturn spStruct/>
	</cffunction>

	<!---***********************************************************--->
	<!---analyzeProcParam                       --->
	<!---Turns one line of a stored proc declaration into a structure that can be used for meta data.           --->
	<!---***********************************************************--->
	<cffunction access="private" name="analyzeProcParam" output="false" returntype="struct" description="Turns one line of a stored proc declaration into a structure that can be used for meta data. " >
		<cfargument name="paramString" type="string" required="yes" default="" hint="The line of code that declares a param. " />

		<cfset var tempString = arguments.paramString />
		<cfset var results = StructNew() />

		<cfset results['name'] = Trim(GetToken(tempString, 1)) />
		<cfset results['type'] = Trim(GetToken(tempString, 2)) />
		<cfset results['default'] = Replace(Trim(ReplaceNoCase(GetToken(tempString, 2, "="),"output", "" ,"ALL")), "'", "" , "ALL")/>

		<cfif findNocase("(", results['type'])>
			<cfset results['length'] = Trim(ReplaceNoCase(GetToken(results['type'], 2,"("),")", "", "ALL")) />
			<cfset results['type'] = Trim(GetToken(results['type'], 1,"(")) />
		</cfif>

		<!--- TODO: Figure out is there a way to support INOUT? --->
		<cfif ListLen(tempString," ") eq 3 and CompareNoCase(getToken(tempString, 2, " "),"out") eq 0 >
			<cfset results['inout']="OUT" />
		<cfelse>
			<cfset results['inout']="IN" />
		</cfif>

		<cfif FindNoCase(".", arguments.paramString)>
			<cfset results['cursor']= TRUE />
		<cfelse>
			<cfset results['cursor']= FALSE />
		</cfif>


		<cfreturn results />
	</cffunction>



	<cffunction access="private" name="countOutputVariables" output="false" returntype="numeric" hint="Counts the number of output variables in a procedure." >
		<cfargument name="spTextStruct" type="struct" required="yes" hint="The spTextStruct" />
		
		<cfset var outputcount = 0 />
		<cfset var i = 0 />	
		<cfset var inoutArray = StructFindKey(arguments.spTextStruct,"inout") />
		
		<cfloop index="i" from="1" to="#arrayLen(inoutArray)#">
			<cfif CompareNoCase(inoutArray[i].owner.inout, "OUT")>
				<cfset outputcount = outputcount + 1 />
			</cfif>
		
		</cfloop>
	
		
	
	
		<cfreturn outputcount />
	</cffunction>



</cfcomponent>