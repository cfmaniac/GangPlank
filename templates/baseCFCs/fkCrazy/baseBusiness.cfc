<cfcomponent name="Base">

	<!--- Internal Declarations --->
	<cfset variables.DefaultValue = "-9999" />
	<cfset variables.Initialized = false />
	<cfset variables.InternalProperties = StructNew() />
	<cfset variables.ReadOnlyPropertyList = "" />
	<cfset variables.ReaderRecord = QueryNew("") />

	<!--- External Declarations --->
	<cfset this.KeyField = "" />
	<cfset this.IsDirty = false />
	<cfset this.IsNew = false />

	<!--- *********************************************************** --->
	<!--- Init                                                        --->
	<!--- *********************************************************** --->
	<cffunction name="init" output="false" access="public" returntype="any"
		hint="Initializes the object, populates properties with a persisted object values when a key value is passed in.">
		<cfargument name="DAO" type="any" required="yes"
			hint="The DAO which to manipulate. Used this was to encourage use of singleton dao's in teh application scope." />
		<cfargument name="KeyValue" type="any" required="no" default="#variables.DefaultValue#"
			hint="Primary key value, pass in to load an existing object from the database" />
		<cfargument name="FormValues" type="struct" required="no" default="#StructNew()#"
			hint="" />
		<cfargument name="WithLinks" type="boolean" required="no" default="FALSE"
			hint="Whether or not to read in tables with FK links." />
		<cfargument name="KeyField" type="any" required="no" default=""
			hint="A field other than the key field to try to use as they key field." />

		<cfset var formElement = "" />

		<!--- Internal declarations --->
		<cfset Variables.DAO = arguments.dao />

		<!--- Grab key field name from DAO --->
		<cfset this.KeyField = 	variables.DAO.Identity />


		<!--- Transform the input form field to handle images. --->
		<cfif left(server.coldFusion.productVersion, 1) gte 8>
			<cfset arguments.FormValues = formImageProcessor(arguments.FormValues) />
		</cfif>


		<!--- New object with values populated from a form struct --->
		<cfif StructCount(arguments.FormValues) GT 0>
			<cfif CompareNoCase(arguments.KeyValue,variables.DefaultValue) EQ 0>
				<cfset New() />
			<cfelse>

				<cfif arguments.WithLinks>
					<cfset variables.ReaderRecord = variables.DAO.readDisplay(arguments.KeyValue) />
				<cfelse>
					<cfif len(arguments.KeyField) gt 0>
						<cfinvoke component="#variables.DAO#" method="read_by_#arguments.KeyField#" returnvariable="variables.ReaderRecord">
							<cfinvokeargument name="#arguments.KeyField#" value="#arguments.KeyValue#" />
						</cfinvoke>
					<cfelse>
						<cfset variables.ReaderRecord = variables.DAO.read(arguments.KeyValue) />
					</cfif>

					<cfset variables.ReaderRecord = variables.DAO.read(arguments.KeyValue) />
				</cfif>
				<cfif variables.ReaderRecord.RecordCount EQ 1>
					<!--- Valid key value provided, load data into object properties --->
					<cfset variables.loadRecord() />
				<cfelse>
					<!--- Invalid key value provided --->
					<cfthrow type="Application"
							message="Object creation failure"
							detail="The supplied key value does not exist in the database, object could not be created." />
				</cfif>
			</cfif>

			<cfset variables.Initialized = true />

			<!--- Spin through the internal properties of this object --->
			<cfloop list="#StructKeyList(variables.InternalProperties)#" index="formElement">
				<cfif StructKeyExists(arguments.formValues,formElement)>
				<cfinvoke method="Set">
					<cfinvokeargument name="PropertyName" value="#formElement#" />
					<cfinvokeargument name="PropertyValue" value="#arguments.formValues[formElement]#" />
				</cfinvoke>
				</cfif>
			</cfloop>

		<!--- New object --->
		<cfelseif CompareNoCase(arguments.KeyValue,variables.DefaultValue) EQ 0>
			<cfset New() />

		<!--- Existing object, pull out record from dao layer --->
		<cfelse>
			<!--- Load DAO data record for supplied key --->
			<cfif arguments.WithLinks>
				<cfset variables.ReaderRecord = variables.DAO.readDisplay(arguments.KeyValue) />
			<cfelse>
				<cfif len(arguments.KeyField) gt 0>
					<cfinvoke component="#variables.DAO#" method="read_by_#arguments.KeyField#" returnvariable="variables.ReaderRecord">
						<cfinvokeargument name="#arguments.KeyField#" value="#arguments.KeyValue#" />
					</cfinvoke>
				<cfelse>
					<cfset variables.ReaderRecord = variables.DAO.read(arguments.KeyValue) />
				</cfif>
			</cfif>
			<cfif variables.ReaderRecord.RecordCount EQ 1>
				<!--- Valid key value provided, load data into object properties --->
				<cfset variables.loadRecord() />
			<cfelse>
				<!--- Invalid key value provided --->
				<cfthrow type="Application"
						message="Object creation failure"
						detail="The supplied key value does not exist in the database, object could not be created." />
			</cfif>
		</cfif>

		<cfset variables.Initialized = true />
		<cfreturn this />

	</cffunction>

	<!--- *********************************************************** --->
	<!--- New                                                         --->
	<!--- Empties all object properties.                              --->
	<!--- *********************************************************** --->
	<cffunction name="New" returntype="void" output="false" access="public"
		hint="Empties all object properties.">

		<cfset var describerQuery = variables.DAO.describe() />

		<cfset StructClear(variables.InternalProperties) />

		<cfloop query="describerQuery">
			<cfset variables.InternalProperties[name] = "" />
		</cfloop>

		<cfset this.IsNew = true />
 		<cfset variables.Initialized = true />

	</cffunction>

	<!--- *********************************************************** --->
	<!--- Commit                                                      --->
	<!--- Persists object state back to the database.                 --->
	<!--- *********************************************************** --->
	<cffunction name="Commit" output="false" returntype="void" access="public"
		hint="Persists object state back to the database.">

		<!--- If object state is valid, send to DAO for commit --->
		<cfif variables.validateCommit()>
			<cfset variables.DAO.Commit(this) />
		<cfelse>
			<!--- Handle validation failure --->
			<cfthrow type="application"
					message="Object data validation failure"
					detail="The object data is invalid and cannot be committed." />
		</cfif>

	</cffunction>

	<!--- *********************************************************** --->
	<!--- Destroy                                                     --->
	<!--- Remove object from the database.                            --->
	<!--- *********************************************************** --->
	<cffunction name="Destroy" output="false" returntype="void" access="public"
		hint="Remove object from the database.">

		<cfset variables.DAO.Destroy(this.Get(this.KeyField)) />
		<cfset New() />

	</cffunction>


	<!--- *********************************************************** --->
	<!--- Refresh                                                     --->
	<!--- Refreshes object with persisted data.                       --->
	<!--- *********************************************************** --->
	<cffunction name="Refresh" returntype="void" output="false" access="public"
		hint="If a key field is set properties are refreshed from the database. If not, properties are emptied. WARNING: This destroys any uncomitted changes made to the object.">

		<!--- Process only if key field is populated --->
		<cfif Len(this.Get(this.KeyField)) GT 0>
			<cfset variables.ReaderRecord = variables.DAO.read(this.Get(this.KeyField)) />
			<cfset variables.loadRecord() />
		<cfelse>
			<cfset this.New() />
		</cfif>

	</cffunction>


	<!--- *********************************************************** --->
	<!--- ObjectState                                                 --->
	<!--- Diagnostic function -- returns a snapshot struct of the     --->
	<!--- object's current state.                                     --->
	<!--- *********************************************************** --->
	<cffunction name="ObjectState" returntype="struct" output="false" access="public"
		hint="Diagnostic function -- returns a snapshot struct of the object's current state.">

		<cfset var returnStruct = StructNew() />

		<cfset returnStruct.InteralProperties = variables.InternalProperties />
		<cfset returnStruct.ExternalProperties = this />

		<cfreturn returnStruct />

	</cffunction>


	<!--- *********************************************************** --->
	<!--- Set                                                         --->
	<!--- Public method for setting cfc property values.              --->
	<!--- *********************************************************** --->
	<cffunction name="Set" returntype="void" output="false" access="public"
		hint="Public method for setting cfc property values.">

		<!--- TODO: Handle typing/validation for properties --->
		<cfargument name="PropertyName" type="string" required="yes"
			hint="The name of the property to be set." />
		<cfargument name="PropertyValue" type="any" required="yes"
			hint="The value to set the property." />

		<!--- Ensure object has been initialized before continuing --->
		<cfif not variables.Initialized>
			<cfthrow type="application"
					message="Set property failed"
					detail="The object has not been initialized, properties can not be set.">
		</cfif>

		<!--- Block changes to read-only properties --->
		<cfif ListFindNoCase(variables.ReadOnlyPropertyList,arguments.PropertyName) EQ 0>

			<cfif StructKeyExists(variables,"set#arguments.PropertyName#")>
				<!--- Fire custom property setter --->
				<cfinvoke method="set#arguments.PropertyName#">
					<cfinvokeargument name="PropertyValue" value="#arguments.PropertyValue#">
				</cfinvoke>
			<cfelse>
				<!--- Fire generic property setter --->
				<cfset defaultSet(arguments.PropertyName,arguments.PropertyValue) />
			</cfif>

			<!--- Indicate change to database persisted fields --->
			<cfset this.IsDirty = true />

		<cfelse>
			<!--- Handle read-only property set --->
			<cfthrow type="application"
					message="Read-only property change attempt"
					detail="You have attempted to change the value of a read-only property." />
		</cfif>

	</cffunction>

	<!--- *********************************************************** --->
	<!--- Get                                                         --->
	<!--- Public method for getting cfc property values.              --->
	<!--- *********************************************************** --->
	<cffunction name="Get" returntype="any" output="false" access="public"
		hint="Public method for getting cfc property values.">

		<cfargument name="PropertyName" type="string" required="yes"
			hint="The name of the property to be gotten." />

		<cfset var returnValue = "" />

		<!--- Ensure object has been initialized before continuing --->
		<cfif not variables.Initialized>
			<cfthrow type="application"
					message="Get property failed"
					detail="The object has not been initialized, properties can not be gotten.">
		</cfif>

		<cfif StructKeyExists(variables,"get#arguments.PropertyName#")>
			<!--- Fire custom property getter --->
			<cfinvoke method="get#arguments.PropertyName#" returnvariable="returnValue" />
		<cfelseif propertyExists(arguments.PropertyName)>
			<!--- Fire generic property getter --->
			<cfset returnValue = defaultGet(arguments.PropertyName) />
		<cfelse>
			<cfthrow type="application"
					message="Property get failure"
					detail="The requested property, #Ucase(arguments.PropertyName)#, cannot be found." />
		</cfif>

		<cfreturn returnValue />

	</cffunction>






	<!--- *********************************************************** --->
	<!--- defaultSet                                                  --->
	<!--- Default internal method for setting cfc property values.    --->
	<!--- *********************************************************** --->
	<cffunction name="defaultSet" returntype="void" output="false" access="private"
		hint="Default internal method for setting cfc property values.">

		<cfargument name="PropertyName" type="string" required="yes" hint="" />
		<cfargument name="PropertyValue" type="any" required="yes" hint="" />

		<cfif propertyExists(arguments.PropertyName)>
			<cfset variables.InternalProperties[arguments.PropertyName] = arguments.PropertyValue  />
		<cfelse>
			<cfthrow type="application"
				message="Property set failure"
				detail="The provided property ""#arguments.PropertyName#"" does not exist." />
		</cfif>

	</cffunction>

	<!--- *********************************************************** --->
	<!--- defaultGet                                                  --->
	<!--- Default internal method for getting cfc property values.    --->
	<!--- *********************************************************** --->
	<cffunction name="defaultGet" returntype="any" output="false" access="private"
		hint="Default internal method for getting cfc property values.">

		<cfargument name="PropertyName" type="string" required="yes" hint="" />

		<cfset var returnValue = "" />

		<cfif propertyExists(arguments.PropertyName) >
			<cfset returnValue = variables.InternalProperties[arguments.PropertyName] />
		<cfelse>
			<cfthrow type="application"
				message="Property get failure"
				detail="The provided property does not exist." />
		</cfif>

		<cfreturn returnValue />

	</cffunction>

	<!--- *********************************************************** --->
	<!--- propertyExists                                              --->
	<!--- Determines if an internal property exists.                  --->
	<!--- *********************************************************** --->
	<cffunction name="propertyExists" returntype="boolean" output="false" access="private"
		hint="Determines if an internal property exists.">

		<cfargument name="PropertyName" type="string" required="yes"
			hint="Name of the property to verify existence" />

		<cfset var propertyDoesExist = false />

		<cfif StructKeyExists(variables.InternalProperties,arguments.PropertyName) >
			<cfset propertyDoesExist = true />
		</cfif>

		<cfreturn propertyDoesExist />
	</cffunction>


	<!--- *********************************************************** --->
	<!--- loadRecord                                                  --->
	<!--- Loads data fields to object properties from the             --->
	<!--- variables.ReaderRecord query.                               --->
	<!--- *********************************************************** --->
	<cffunction name="loadRecord" returntype="void" output="false" access="private"
		hint="Loads data fields to object properties from the variables.ReaderRecord query.">

		<cfset var columnName =  "" />
		<cfif variables.ReaderRecord.RecordCount GT 0>

			<!--- Reset object meta-data --->
			<cfset this.IsDirty = false />
			<cfset this.IsNew = false />
			<cfset StructClear(variables.InternalProperties) />

			<!--- Loop through record columns --->
			<cfloop list="#variables.ReaderRecord.ColumnList#" index="columnName">
				<!--- Add data field to object properties --->
				<cfset variables.InternalProperties[columnName] = variables.ReaderRecord[columnName] />
			</cfloop>
		<cfelse>
			<cfthrow type="Application"
					Message="Object creation failed"
					Detail="Data reader record was not populated, object could not be created.">
		</cfif>

	</cffunction>

	<!--- *********************************************************** --->
	<!--- validateCommit                                              --->
	<!--- Stub method: Override in each biz object to perform         --->
	<!--- pre-commit data validation.                                 --->
	<!--- *********************************************************** --->
	<cffunction name="validateCommit" returntype="boolean" output="false" access="private"
		hint="Stub method: Override in each biz object to perform pre-commit data validation.">
		<cfreturn true />
	</cffunction>


	<!---*****************************************************--->
	<!---formImageProcessor--->
	<!---Takes a input form  structure and handles turning input image into cfimage objects for use with image crud.--->
	<!---*****************************************************--->
	<cffunction access="public" name="formImageProcessor" output="false" returntype="struct" hint="Takes a input form  structure and handles turning input image into cfimage objects for use with image crud." >
		<cfargument name="formValues" type="struct" required="yes" hint="The form to manipulate." />


		<cfset var i = 0 />
		<cfset var imageArray = StructFindValue(arguments.FormValues,"ImageExists")/>
		<cfset var commentObj = "" />
		<cfset var filefield = "" />
		<cfset var uploadedFile = "" />
		<cfset var imageFile = "" />
		<cfset var local = structNew() />
		<cfset local.FormValues = arguments.FormValues />


		<cfif arrayLen(imageArray) gt 0>
			<cfloop index="i" from="1" to="#arrayLen(imageArray)#">
				<cfset fileField = ReplaceNoCase(imageArray[i].key, "ImageExists", "", "Once") />
				<cfif len(local.FormValues[fileField]) gt 0>
					<cffile action="upload" destination="#getTempDirectory()#" nameConflict="makeunique" filefield="#fileField#"/>
					<cfset uploadedFile = cffile.ServerDirectory & "\" & cffile.serverfile />
					<cfimage action="read" source="#uploadedFile#" name="imageFile" />
					<cfset local.FormValues[fileField] = imageFile />
					<cfset structDelete(local.FormValues, "#fileField#ImageExists")/>
					<cffile action="delete" file="#uploadedFile#" />
				<cfelseif StructKeyExists(local.FormValues, "#fileField#RemoveImage") and local.FormValues["#fileField#RemoveImage"]>
					<cfset local.FormValues[fileField] = "" />
				<cfelse>
					<cfset structDelete(local.FormValues, fileField)/>
				</cfif>
				<cfset structDelete(local.FormValues, "#fileField#RemoveImage")/>
				<cfset structDelete(local.FormValues, "#fileField#ImageExists")/>
			<cfset structDelete(local.FormValues, "#fileField#RemoveImage")/>
			</cfloop>
		</cfif>


		<cfreturn local.FormValues>
	</cffunction>



</cfcomponent>