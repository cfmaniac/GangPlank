<!---    formTemplate.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Template for the form customtag file in the output CRUD application.
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

<!--- Prevents views with Spaces from causing problems. --->

<cfset customTagObj = CreateObject("component", attributes.generatorCFCpath).init() />
<cfset customTagObj.create(name="#attributes.tableObj.getCFversionofTableName()#Form") />
<cfset customTagObj.addAttribute(name="readQuery", type="query", required=TRUE) />


<cfset displayData = "" />
<cfset displayData = displayData.concat("<cfoutput>" & chr(13)) />
<cfset displayData = displayData.concat('<cfform action="#attributes.tableObj.getCFversionofTableName()#.cfm" method="post" class="editForm">' & chr(13)) />
<cfset displayData = displayData.concat("<fieldset>" & chr(13)) />



<cfloop list="#attributes.tableObj.getEditElligibleColumnList()#" index="columnName">
	<cfif columnName eq attributes.tableObj.getIdentity()>
		<cfset displayData = displayData.concat('<input name="#columnName#" type="hidden" value="##attributes.' & attributes.tableObj.getIdentity() & '##" />' & chr(13)) />
	<cfelse>
		<cfif not CompareNoCase(tableData['columnlist'][columnName]['type'], "text") or not CompareNoCase(tableData['columnlist'][columnName]['type'], "ntext")>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<cfset displayData = displayData.concat('<cftextarea name="#columnName#" id="#columnName#"') />

			<cfif not tableData['columnlist'][columnName]['nullable']>
				<cfset displayData = displayData.concat(' required="true"') />
				<cfset displayData = displayData.concat(' message="#tableData['columnlist'][columnName]['displayName']# is a required field."') />
			</cfif>

			<cfset displayData = displayData.concat('>') />
			<cfset displayData = displayData.concat('##attributes.readQuery.#columnName###') />
			<cfset displayData = displayData.concat('</cftextarea><br />' & chr(13)) />
		<cfelseif len(tableData['columnlist'][columnName]['linkedField'])>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<!--- ##application.gateway.#tableData['columnlist'][columnName]['linkedTable']#Obj## --->

			<cfset displayData = displayData.concat('<cf_foreignKeySelector gateway="##application.gateway.#tableData['columnlist'][columnName]['linkedTable']#Obj##" fieldName="#columnName#" fieldValue="##attributes.readQuery.#columnName###" /><br />' & chr(13)) />

		<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "image")>
			<cfset displayData = displayData.concat('<!--- You''re going to have to customize an image handeler here --->' & chr(13)) />
		<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "bit")>


			<cfset displayData = displayData.concat('<cfif isBoolean(attributes.readQuery.#columnName#)>'& chr(13))/>
			<cfset displayData = displayData.concat(chr(9) & '<cfset checked = attributes.readQuery.#columnName# />' & chr(13)) />
			<cfset displayData = displayData.concat('<cfelse>'& chr(13))/>
			<cfset displayData = displayData.concat(chr(9) & '<cfset checked = FALSE />' & chr(13)) />
			<cfset displayData = displayData.concat('</cfif>'& chr(13))/>


			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>' & chr(13)) />
			<cfset displayData = displayData.concat('<label for="#columnName#yes" class="radio"><input name="#columnName#" type="radio" value="TRUE" id="#columnName#yes" checked="##checked##" class="radio" />Yes</label>'& chr(13)) />
			<cfset displayData = displayData.concat('<label for="#columnName#no" class="radio"><input name="#columnName#" type="radio" value="FALSE" id="#columnName#no" checked="##not checked##" class="radio" />No</label><br /><br />'& chr(13)) />

		<cfelse>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<cfset displayData = displayData.concat('<cfinput name="#columnName#" id="#columnName#" type="text" value="##attributes.readQuery.#columnName###" ') />
			<cfif not tableData['columnlist'][columnName]['nullable']>
				<cfset displayData = displayData.concat(' required="true"') />
				<cfset displayData = displayData.concat(' message="#tableData['columnlist'][columnName]['displayName']# is a required field."') />
			</cfif>
			<cfset displayData = displayData.concat(' /><br />' & chr(13)) />
		</cfif>
	</cfif>
</cfloop>
<cfset displayData = displayData.concat('<input name="submit" type="submit" class="submit" value="Save" />' & chr(13)) />
<cfset displayData = displayData.concat("</fieldset>" & chr(13)) />
<cfset displayData = displayData.concat("</cfform>" & chr(13)) />
<cfset displayData = displayData.concat("</cfoutput>" & chr(13))/>





<cfset customTagBody = dataretriever.concat(displayData) />

<cfinvoke component="#customTagObj#" method="appendBody">
	<cfinvokeargument name="bodyContent" value="#customTagBody#" />
</cfinvoke>

<cfset caller[attributes.result]  = customTagObj.GetCustomTag() />
<cfset cfmloutput = "" />

</cfprocessingdirective>
<cfexit method="exitTag" />