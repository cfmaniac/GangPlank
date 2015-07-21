<!---    readTemplate.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Template for the read customtag file in the output CRUD application.
					 Did it as custom tag instead of a function because it was easier to edit.
					 plus one template to output file ratio seems more understandable in my mind.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.result" type="string" default="result" />
<cfparam name="attributes.tableObj" type="any" />
<cfparam name="attributes.cfcPath" type="string" default="" />

<cfparam name="attributes.generatorCFCpath" type="string" default="" />

<cfset dataretriever = "" />
<cfset displayData = "" />
<cfset customTagObj = "" />
<cfset customTagBody = "" />

<cfset tableData = attributes.tableObj.getTable() />


<strong>with BusinessDynamic Template</strong>

<cfset customTagObj = CreateObject("component", attributes.generatorCFCpath).init() />
<cfset customTagObj.create(name="#attributes.tableObj.getCFversionofTableName()#Read") />
<cfset customTagObj.addAttribute(name="#attributes.tableObj.getCFversionofTableName()#Obj", type="any", required=TRUE) />





<cfset displayData = displayData.concat("<table>" & chr(13)) />
<cfset displayData = displayData.concat("<thead />" & chr(13)) />
<cfset displayData = displayData.concat("<tr>" & chr(13)) />
<cfset displayData = displayData.concat("<cfoutput><tbody>" & chr(13)) />

<cfloop list="#attributes.tableObj.getReadElligibleColumnList()#" index="columnName">

	<cfif not CompareNoCase(tableData['columnlist'][columnName]['type'], "datetime")>
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>##DateFormat(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#'), 'mmmm d, yyyy')## ##TimeFormat(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#'), 'h:mm tt')##</td></tr>" & chr(13))/>
	<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "money")>
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>##DollarFormat(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#'))##</td></tr>" & chr(13))/>
	<cfelseif tableData['columnlist'][columnName]['isImage']>

		<cfif attributes.configObj.get('ui','images')>
			<cfset displayData = displayData.concat("<cfif len(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#')) gt 0>" & chr(13))/>
			<cfset displayData = displayData.concat("<cfset myImage#columnName# = ImageNew(##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#')##)>" & chr(13))/>
			<cfset displayData = displayData.concat("<cfset ImageResize(myImage#columnName#, #attributes.configObj.get('ui','ImageReadWidth')#,"""")>" & chr(13))/>
			<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td><cfimage action='writeToBrowser' source='##myImage#columnName###' /></td></tr>" & chr(13))/>
			<cfset displayData = displayData.concat("<cfelse>" & chr(13))/>
			<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td></td></tr>" & chr(13))/>
			<cfset displayData = displayData.concat("</cfif>" & chr(13))/>
		<cfelse>
			<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>[Cannot Display Image]</td></tr>" & chr(13))/>
		</cfif>

	<cfelseif compareNoCase(attributes.configObj.get('reservedwords','password'), columnName) eq 0>
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>********</td></tr>" & chr(13))/>

	<cfelse>
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#')##</td></tr>" & chr(13))/>
	</cfif>

</cfloop>

<cfset displayData = displayData.concat("</tbody></cfoutput>" & chr(13)) />
<cfset displayData = displayData.concat("</table>" & chr(13)) />

<cfset customTagBody = dataretriever.concat(displayData) />

<cfinvoke component="#customTagObj#" method="appendBody">
	<cfinvokeargument name="bodyContent" value="#customTagBody#" />
</cfinvoke>

<cfset caller[attributes.result]  = customTagObj.GetCustomTag() />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />