<cfcomponent output="false">

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." >
		<cfreturn This />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- conditionallyCreateDirectory                       --->
	<!--- Checks to see if a directory exists if it doesn't it creates it.          --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="conditionallyCreateDirectory" output="false" returntype="void" description="Checks to see if a directory exists if it doesn't it creates it." >
		<cfargument name="directory" type="string" required="yes" default="" hint="Driectory to create if it doesn't already exist." />

		<cfif not DirectoryExists(arguments.directory)>
			<cfdirectory directory="#arguments.directory#" action="create" />
		</cfif>

	</cffunction>

	<!--- *********************************************************** --->
	<!--- conditionallyWriteFile                       --->
	<!--- Checks to see if a directory exists if it doesn't it creates it.          --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="conditionallyWriteFile" output="false" returntype="void" description="Checks to see if a file exists if it doesn't it writes to it." >
		<cfargument name="fileName" type="string" required="yes" default="" hint="File to create if it doesn't already exist." />
		<cfargument name="output" type="string" required="yes" default="" hint="The content to write to the file." />

		<cfif not fileExists(arguments.fileName)>
			<cffile action="write" addnewline="yes" file="#arguments.fileName#" output="#arguments.output#" fixnewline="no" />
		</cfif>

	</cffunction>

	<!--- *********************************************************** --->
	<!--- convertFilePathToCFCPath                       --->
	<!--- Takes an absolute file path and converts it to a            --->
	<!--- cfc object variable name.                           --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="convertFilePathToCFCPath" output="false" returntype="string" hint="Takes an absolute file path and converts it to a application object variable name.">
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

	<!--- *********************************************************** --->
	<!--- createGUID                  								  --->
	<!--- Returns a UUID in the Microsoft form.        				  --->
	<!--- @author Nathan Dintenfass (nathan@changemedia.com)          --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="createGUID" output="false" returntype="string" description="Returns a UUID in the Microsoft form. @author Nathan Dintenfass (nathan@changemedia.com)" >
		<cfreturn insert("-", CreateUUID(), 23) />
	</cffunction>

	<cffunction access="public" name="convertToCFVersion" output="false" returntype="string" hint="Used to convert a table name to the ColdFusion version of itself. " >
		<cfargument name="tableName" type="string" required="yes" default="" hint="The table name to convert." />

		<cfreturn Replace(arguments.tableName, " ", "", "ALL") />
	</cffunction>

	<cffunction access="public" name="correctCFCPathsToAbsolute" output="false" returntype="string" hint="Handles cases where relative pathing isn't enough. " >
		<cfargument name="relatitveCFCPath" type="string" required="yes" hint="The path of the CFC that you are trying to target." />
		<cfargument name="absoluteCFCPathofApplication" type="string" required="yes" hint="The path of the CFC base." />

		<cfreturn ListDeleteAt(absoluteCFCPathofApplication, listLen(absoluteCFCPathofApplication,"."),".") & "." & relatitveCFCPath >
	</cffunction>

	<cffunction access="public" name="writeWeb20Logo" output="false" returntype="any" hint="Takes a text string and returns a web 2.0 logo version of it. " >
		<cfargument name="text" type="string" required="yes" hint="The text to write to an image." />
		<cfargument name="width" type="numeric" default="500" hint="The width of the output image." />
		<cfargument name="height" type="numeric" default="75" hint="The height of the output image." />
		<cfargument name="imageType" type="string" required="no" default="rgb" hint="The cfimage type of the image." />
		<cfargument name="canvasColor" type="string" required="no" default="##FFFFFF" hint="The hex color of the image background." />
		<cfargument name="textColor" type="string" required="no" default="##000000" hint="The hex color of the text color." />
		<cfargument name="textX" type="numeric" required="no" default="10" hint="The x position of the text." />
		<cfargument name="texty" type="numeric" required="no" default="30" hint="The y position of the text." />
		<cfargument name="fontStruct" type="any" required="no" default="" hint="The settings of the font for the text." />

		<cfset var baseImage = imageNew("", arguments.width, arguments.height, arguments.imageType, arguments.canvasColor) />
		<cfset var reflectionImage = imageNew("", arguments.width, arguments.height, arguments.imageType, arguments.canvasColor) />
		<cfset var reflectionImageInfo = StructNew() />
		<cfset var i =0 />
		<cfset var percentage = 0 />
		<cfset var iinc = 0 />


		<!--- Maybe Ben Nadel will have an issue with this.  It is kinda unassertive.  Oh well, he won't read this.' --->
		<cfif not isStruct(fontStruct)>
			<cfset arguments.fontStruct= StructNew() />
			<cfset arguments.fontStruct.font= "Arial" />
			<cfset arguments.fontStruct.size= "30" />
			<cfset arguments.fontStruct.style= "bold" />
			<cfset arguments.fontStruct.strikethrough = "no" />
			<cfset arguments.fontStruct.underline = "no" />
		</cfif>

		<!--- Create the base image with the text phrase --->
		<cfset ImageSetAntialiasing(baseImage, "ON") />
		<cfset ImageSetDrawingColor(baseImage, arguments.textColor) />
		<cfset ImageDrawText(baseImage, arguments.text, arguments.textX, arguments.textY, arguments.fontStruct) />

		<!--- Write the reflection image. --->
		<cfset ImageSetAntialiasing(reflectionImage, "ON") />
		<cfset ImageSetDrawingTransparency (reflectionImage, 80) />
		<cfset ImageSetDrawingColor(reflectionImage, arguments.textColor) />
		<cfset ImageDrawText(reflectionImage, arguments.text, arguments.textX, arguments.textY, arguments.fontStruct) />
		<cfset ImageFlip(reflectionImage, "vertical") />

		<!--- Distort it a bit. --->
		<cfset ImageShear(reflectionImage,.05,"horizontal", "bicubic")>
		<cfset ImageResize(reflectionImage,"100%","40%","highestQuality",2)>

		<!--- Get some measurements  --->
		<cfset reflectionImageInfo = ImageInfo(reflectionImage)>
		<!--- Trim the leading deadspace. --->
		<cfset ImageCrop(reflectionImage, 0, .2 * arguments.height,  reflectionImageInfo.width, Round(reflectionImageInfo.height * .95) )>

		<cfset reflectionImageInfo = ImageInfo(reflectionImage)>

		<!--- Now we're going to overlay lines that get more and more opaque to simulate a fade.' --->
		<!--- Algorithm here modified from http://www.jonhartmann.com/programming/index.cfm/2007/8/14/CFImage-Effects --->
		<!--- Thanks CFJon --->
		<cfset ImageSetDrawingColor(reflectionImage, arguments.canvasColor) />
		<cfset iInc = 50/reflectionImageInfo.height />

		<cfloop index="i" from="1" to="#reflectionImageInfo.height#">
			<cfset percentage = 100 -round(iInc*i*2.5)>

			<cfif percentage lt 0>
				<cfset percentage = 0 />
			</cfif>

			<cfset ImageSetDrawingTransparency(reflectionImage, percentage) />
		    <cfset ImageDrawLine(reflectionImage, 0, i, reflectionImageInfo.width, i) />
		</cfloop>

		<!--- Over lay the top image back on the original image. --->
		<cfset ImagePaste(baseImage, reflectionImage, 0, arguments.textY + 8) />


		<cfreturn baseImage />
	</cffunction>


</cfcomponent>