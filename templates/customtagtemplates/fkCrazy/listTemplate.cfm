<!---    listTemplate.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Template for the list customtag file in the output CRUD application.
					 Did it as custom tag instead of a function because it was easier to edit.
					 plus one template to output file ratio seems more understandable in my mind.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.result" type="string" default="result" />
<cfparam name="attributes.tableObj" type="any" />
<cfparam name="attributes.cfcPath" type="string" default="" />
<cfparam name="attributes.columnList" type="string" default="" />
<cfparam name="attributes.generatorCFCpath" type="string" default="" />

<cfset dataretriever = "" />
<cfset displayData = "" />
<cfset customTagObj = "" />
<cfset customTagBody = "" />

<cfset tableData = attributes.tableObj.getTable() />

<strong>with BusinessDynamic Template</strong>

<cfset customTagObj = CreateObject("component", attributes.generatorCFCpath).init() />
<cfset customTagObj.create(name="#attributes.tableObj.getCFversionofTableName()#List") />
<cfset customTagObj.addAttribute(name="listQuery", type="query", required=TRUE) />
<cfset customTagObj.addAttribute(name="deleteTarget", type="string", required=FALSE, defaultvalue="#attributes.tableObj.getCFversionofTableName()#.cfm?method=delete_process&amp;") />
<cfset customTagObj.addAttribute(name="editTarget", type="string", required=FALSE, defaultvalue="#attributes.tableObj.getCFversionofTableName()#.cfm?method=edit&amp;") />
<cfset customTagObj.addAttribute(name="readTarget", type="string", required=FALSE, defaultvalue="#attributes.tableObj.getCFversionofTableName()#.cfm?method=read&amp;") />


<cfset displayData = displayData.concat("<table>" & chr(13)) />
<cfset displayData = displayData.concat("<thead>" & chr(13) )/>


<cfset displayData = displayData.concat("<tr>" & chr(13) )/>
<cfloop list="#attributes.tableObj.getReadElligibleColumnList()#" index="columnName">
	<cfset displayData = displayData.concat("<th>#tableData['columnlist'][columnName]['displayName']#</th>" & chr(13)) />
</cfloop>
<cfset displayData = displayData.concat("</tr>" & chr(13)) />
<cfset displayData = displayData.concat("</thead>" & chr(13)) />
<cfset displayData = displayData.concat("<tbody><cfoutput>" & chr(13)) />

<cfset displayData = displayData.concat('<cfloop query="attributes.listQuery">' & chr(13)) />
<cfset displayData = displayData.concat('	<cfif CurrentRow Mod 2><tr class="odd"><cfelse><tr></cfif>' & chr(13)) />
<cfloop list="#attributes.tableObj.getReadElligibleColumnList()#" index="columnName">
	<cfif not CompareNoCase(tableData['columnlist'][columnName]['type'], "datetime")>
		<cfset displayData = displayData.concat('	<td>##DateFormat(#columnName#, "mmmm d, yyyy")## ##TimeFormat(#columnName#, "h:mm tt")##</td>' & chr(13)) />
	<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "money")>
		<cfset displayData = displayData.concat('	<td>##DollarFormat(#columnName#)##</td>' & chr(13)) />
	<cfelseif tableData['columnlist'][columnName]['isImage']>


		<cfif attributes.configObj.get('ui','images')>
			<cfset displayData = displayData.concat("<cfif len(#columnName#) gt 0>" & chr(13))/>
			<cfset displayData = displayData.concat("	<cfset myImage#columnName# = ImageNew(#columnName#)>" & chr(13))/>
			<cfset displayData = displayData.concat("	<cfset ImageResize(myImage#columnName#, #attributes.configObj.get('ui','ImageListWidth')#,"""")>" & chr(13))/>
			<cfset displayData = displayData.concat("	<td><cfimage action='writeToBrowser' source='##myImage#columnName###' /></td>" & chr(13))/>
			<cfset displayData = displayData.concat("<cfelse>" & chr(13))/>
			<cfset displayData = displayData.concat("<td></td>" & chr(13))/>
			<cfset displayData = displayData.concat("</cfif>" & chr(13))/>

		<cfelse>
			<cfset displayData = displayData.concat('	<td>[Cannot display image]</td>' & chr(13)) />
		</cfif>

	<cfelseif compareNoCase(attributes.configObj.get('reservedwords','password'), columnName) eq 0>
		<cfset displayData = displayData.concat('	<td>********</td>' & chr(13)) />

	<cfelse>
		<cfset displayData = displayData.concat('	<td>###columnName###</td>' & chr(13)) />
	</cfif>
</cfloop>

<!--- Ensure that views don't screw anything up.  --->
<cfif attributes.tableObj.isProperTable()>
	<cfset displayData = displayData.concat('		<td><a href="##attributes.readTarget##' & attributes.tableObj.getIdentity() & '=##' & attributes.tableObj.getIdentity() & '##">Read</a></td>' & chr(13)) />
	<cfset displayData = displayData.concat('		<td><a href="##attributes.editTarget##' & attributes.tableObj.getIdentity() & '=##' & attributes.tableObj.getIdentity() & '##">Edit</a></td>' & chr(13))/>
	<cfset displayData = displayData.concat('		<td><a href="##attributes.deleteTarget##' & attributes.tableObj.getIdentity() & '=##' & attributes.tableObj.getIdentity() & '##" onclick="if (confirm(''Are you sure?'')) { return true}; return false"">Delete</a></td>' & chr(13)) />
</cfif>
<cfset displayData = displayData.concat('	</tr>' & chr(13)) />
<cfset displayData = displayData.concat('</cfloop>' & chr(13) )/>
<cfset displayData = displayData.concat("</cfoutput></tbody>" & chr(13)) />
<cfset displayData = displayData.concat("</table>" & chr(13)) />

<cfset customTagBody = dataretriever.concat(displayData) />

<cfinvoke component="#customTagObj#" method="appendBody">
	<cfinvokeargument name="bodyContent" value="#customTagBody#" />
</cfinvoke>

<cfset caller[attributes.result]  = customTagObj.GetCustomTag() />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />