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


<strong>with Simple Template</strong>


<cfset customTagObj = CreateObject("component", attributes.generatorCFCpath).init() />
<cfset customTagObj.create(name="#attributes.tableObj.getCFversionofTableName()#Read") />
<cfset customTagObj.addAttribute(name="readQuery", type="query", required=TRUE) />


<cfset displayData = displayData.concat("<table>" & chr(13)) />
<cfset displayData = displayData.concat("<thead />" & chr(13)) />
<cfset displayData = displayData.concat("<tr>" & chr(13)) />
<cfset displayData = displayData.concat("<cfoutput><tbody>" & chr(13)) />

<cfloop list="#attributes.tableObj.getReadElligibleColumnList()#" index="columnName">
	



	<cfif not CompareNoCase(tableData['columnlist'][columnName]['type'], "datetime")>  
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>##DateFormat(attributes.readQuery.#columnName#, 'mmmm d, yyyy')## ##TimeFormat(attributes.readQuery.#columnName#, 'h:mm tt')##</td></tr>" & chr(13))/>
	<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "money")>  
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>##DollarFormat(attributes.readQuery.#columnName#)##</td></tr>" & chr(13))/>
	<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "image")>  
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>[Cannot Display Image]</td></tr>" & chr(13))/>
	<cfelse>
		<cfset displayData = displayData.concat("<tr><th>#tableData['columnlist'][columnName]['displayName']#</th><td>##attributes.readQuery.#columnName###</td></tr>" & chr(13))/>
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