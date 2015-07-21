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


<strong>with BusinessDynamic Template</strong>

<cfset customTagObj = CreateObject("component", attributes.generatorCFCpath).init() />
<cfset customTagObj.create(name="#attributes.tableObj.getCFversionofTableName()#Form") />
<cfset customTagObj.addAttribute(name="#attributes.tableObj.getCFversionofTableName()#Obj", type="Any", required=TRUE) />
<cfset customTagObj.addAttribute(name="message", type="string", required=FALSE, default="") />
<cfset customTagObj.addAttribute(name="alert", type="string", required=FALSE, default="") />
<cfset customTagObj.addAttribute(name="actionTarget", type="string", required=FALSE, defaultvalue="#attributes.tableObj.getCFversionofTableName()#.cfm") />
<cfset customTagObj.addAttribute(name="submitValue", type="string", required=FALSE, defaultvalue="Save") />

<cfset displayData = "" />


<cfset displayData = displayData.concat('<cfif FindNoCase("updated#attributes.tableObj.getCFversionofTableName()#", attributes.message)>' & chr(13)) />
<cfset displayData = displayData.concat('	<cfset alert = "Your changes have been made." />' & chr(13)) />
<cfset displayData = displayData.concat('<cfelseif FindNoCase("added#attributes.tableObj.getCFversionofTableName()#", attributes.message)>' & chr(13)) />
<cfset displayData = displayData.concat('	<cfset alert = "Your #attributes.tableObj.getCFversionofTableName()# has been added." />' & chr(13)) />
<cfset displayData = displayData.concat('<cfelse>' & chr(13)) />
<cfset displayData = displayData.concat('	<cfset alert = attributes.alert />' & chr(13)) />
<cfset displayData = displayData.concat('</cfif>' & chr(13)) />


<cfset displayData = displayData.concat("<cfif isNumeric(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#attributes.tableObj.getIdentity()#')) >" & chr(13)) />
<cfset displayData = displayData.concat(chr(9) & "<cfset #attributes.tableObj.getIdentity()# = attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#attributes.tableObj.getIdentity()#') />" & chr(13)) />
<cfset displayData = displayData.concat("<cfelse>" & chr(13)) />
<cfset displayData = displayData.concat(chr(9) & "<cfset #attributes.tableObj.getIdentity()# = 0 />" & chr(13)) />
<cfset displayData = displayData.concat("</cfif>" & chr(13)) />


<cfset displayData = displayData.concat("<cfoutput>" & chr(13)) />
<cfset displayData = displayData.concat('<cfform action="##attributes.actionTarget##" method="post" class="editForm #attributes.tableObj.getCFversionofTableName()#" enctype="multipart/form-data">' & chr(13)) />

<cfset displayData = displayData.concat("<cfif len(alert) gt 0>" & chr(13)) />
<cfset displayData = displayData.concat('<p class="alert">##alert##</p>' & chr(13)) />
<cfset displayData = displayData.concat("</cfif>" & chr(13)) />

<cfset displayData = displayData.concat("<fieldset>" & chr(13)) />



<cfloop list="#attributes.tableObj.getEditElligibleColumnList()#" index="columnName">
	<cfif columnName eq attributes.tableObj.getIdentity()>
		<cfset displayData = displayData.concat('<input name="#columnName#" type="hidden" value="###attributes.tableObj.getIdentity()###" />' & chr(13)) />
	<cfelse>
		<cfset customTagObj.addAttribute(name="display#columnName#", type="boolean", required=FALSE, defaultvalue="TRUE") />

		<cfset displayData = displayData.concat("<cfif attributes.display#columnName#>" & chr(13) & chr(9)) />

		<cfif not CompareNoCase(tableData['columnlist'][columnName]['type'], "text") or
				not CompareNoCase(tableData['columnlist'][columnName]['type'], "ntext") or
					not CompareNoCase(tableData['columnlist'][columnName]['type'], "CLOB") or
						not CompareNoCase(tableData['columnlist'][columnName]['type'], "NCLOB")>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<cfset displayData = displayData.concat('<cftextarea name="#columnName#" id="#columnName#"') />

			<cfif not tableData['columnlist'][columnName]['nullable']>
				<cfset displayData = displayData.concat(' required="true"') />
				<cfset displayData = displayData.concat(' message="#tableData['columnlist'][columnName]['displayName']# is a required field."') />
			</cfif>

			<cfif attributes.configObj.get('ui','RichTextAreas')>
				<cfset displayData = displayData.concat(' richtext="true" skin="#attributes.configObj.get('ui','RichTextAreasSkin')#" toolbar="#attributes.configObj.get('ui','RichTextAreasToolbar')#"') />
			</cfif>


			<cfset displayData = displayData.concat('>') />
			<cfset displayData = displayData.concat('##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#'')##') />
			<cfset displayData = displayData.concat('</cftextarea><br />' & chr(13)) />
		<cfelseif len(tableData['columnlist'][columnName]['linkedField'])>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<cfset displayData = displayData.concat('<cf_foreignKeySelector gateway="##application.gateway.#tableData['columnlist'][columnName]['linkedTable']#Obj##" fieldName="#columnName#" fieldValue="##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#'')##" /><br />' & chr(13)) />
		<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "datetime") AND attributes.configObj.get('ui','DateField')>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />


			<cfset displayData = displayData.concat('<cfinput name="#columnName#" id="#columnName#" type="datefield" value="##DateFormat(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#''),"mm/dd/yy")##" ') />
			<cfif not tableData['columnlist'][columnName]['nullable']>
				<cfset displayData = displayData.concat(' required="true"') />
				<cfset displayData = displayData.concat(' message="#tableData['columnlist'][columnName]['displayName']# is a required field."') />
			</cfif>
			<cfset displayData = displayData.concat(' /><br /><br /><br />' & chr(13)) />


		<cfelseif tableData['columnlist'][columnName]['isImage']>

			<cfif attributes.configObj.get('ui','images')>
				<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
				<cfset displayData = displayData.concat('<cfinput name="#columnName#" id="#columnName#" type="file" ><br />' & chr(13)) />
				<cfset displayData = displayData.concat('<cfinput name="#columnName#ImageExists" type="hidden" value="ImageExists" />' & chr(13)) />
				<cfset displayData = displayData.concat("<cfif len(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#')) gt 0>" & chr(13))/>
				<cfset displayData = displayData.concat("	<cfset myImage#columnName# = ImageNew(##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get('#columnName#')##)>" & chr(13))/>
				<cfset displayData = displayData.concat("	<cfset ImageResize(myImage#columnName#, #attributes.configObj.get('ui','ImageReadWidth')#,"""")>" & chr(13))/>
				<cfset displayData = displayData.concat('	<label >Current Image:</label>') />
				<cfset displayData = displayData.concat("	<cfimage action='writeToBrowser' source='##myImage#columnName###' />" & chr(13))/>
				<cfset displayData = displayData.concat("<br /><br />" & chr(13))/>
				<cfset displayData = displayData.concat('	<label for="#columnName#RemoveImage">Remove Image (#columnName#):</label>') />
				<cfset displayData = displayData.concat('<cfinput name="#columnName#RemoveImage" type="checkbox" value="TRUE" id="#columnName#RemoveImage" class="checkbox" /><br />' & chr(13)) />




				<cfset displayData = displayData.concat("</cfif>" & chr(13))/>

			<cfelse>
				<cfset displayData = displayData.concat('<!--- You''re going to have to customize an image handeler here --->' & chr(13)) />
			</cfif>

		<cfelseif compareNoCase(attributes.configObj.get('reservedwords','password'), columnName) eq 0>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<cfset displayData = displayData.concat('<cfinput name="#columnName#" id="#columnName#" type="password" value="##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#'')##" ') />
			<cfif not tableData['columnlist'][columnName]['nullable']>
				<cfset displayData = displayData.concat(' required="true"') />
				<cfset displayData = displayData.concat(' message="#tableData['columnlist'][columnName]['displayName']# is a required field."') />
			</cfif>
			<cfset displayData = displayData.concat(' /><br />' & chr(13)) />



		<cfelseif not CompareNoCase(tableData['columnlist'][columnName]['type'], "bit")>


			<cfset displayData = displayData.concat('<cfif isBoolean(attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#''))>'& chr(13))/>
			<cfset displayData = displayData.concat(chr(9) & '<cfset checked = ##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#'')## />' & chr(13)) />
			<cfset displayData = displayData.concat('<cfelse>'& chr(13))/>
			<cfset displayData = displayData.concat(chr(9) & '<cfset checked = FALSE />' & chr(13)) />
			<cfset displayData = displayData.concat('</cfif>'& chr(13))/>


			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>' & chr(13)) />
			<cfset displayData = displayData.concat('<label for="#columnName#yes" class="radio"><input name="#columnName#" type="radio" value="TRUE" id="#columnName#yes" checked="##checked##" class="radio" />Yes</label>'& chr(13)) />
			<cfset displayData = displayData.concat('<label for="#columnName#no" class="radio"><input name="#columnName#" type="radio" value="FALSE" id="#columnName#no" checked="##not checked##" class="radio" />No</label><br /><br />'& chr(13)) />

		<cfelse>
			<cfset displayData = displayData.concat('<label for="#columnName#">#tableData['columnlist'][columnName]['displayName']#:</label>') />
			<cfset displayData = displayData.concat('<cfinput name="#columnName#" id="#columnName#" type="text" value="##attributes.#attributes.tableObj.getCFversionofTableName()#Obj.Get(''#columnName#'')##" ') />
			<cfif not tableData['columnlist'][columnName]['nullable']>
				<cfset displayData = displayData.concat(' required="true"') />
				<cfset displayData = displayData.concat(' message="#tableData['columnlist'][columnName]['displayName']# is a required field."') />
			</cfif>
			<cfset displayData = displayData.concat(' /><br />' & chr(13)) />
		</cfif>

		<cfset displayData = displayData.concat("</cfif>" & chr(13)) />

	</cfif>
</cfloop>
<cfset displayData = displayData.concat('<input name="submit" type="submit" class="submit" value="##attributes.submitValue##" />' & chr(13)) />
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