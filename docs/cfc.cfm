

<h2>CFC Reference</h2>
<p>Below are listed the default CFC methods that are created for each table. Your CFC's may contain additional methods,
	due to either stored procedures that you create or, additional methods you add to your static objects.</p>









	
		
		

		

	

	
		
		

		
		
		

	

	
		
		

		

	

	
		
		

		
		
		

	

	
		
		

		
		
		

	

	
		
		

		
		
		

	

	
		
		

		

	

	
		
		

		

	








	
		
		
		


	<h3>Gateway Object Methods</h3>
<dl>

	<dt>init</dt>
	<dd>This is the pseudo constructor that allows us to play little object games.</dd>
	
		
		<dd><strong>Parameters</strong></dd>
		<dl>


		
		<dt>datasource</dt>
		
			<dd>string<br />
		
		
		The datasource for database operations.
		
			</dd>
		
		<dt>dbusername</dt>
		
			<dd>string<br />
		
		
		The database username for database operations.
		
			</dd>
		
		<dt>dbpassword</dt>
		
			<dd>string<br />
		
		
		The database password for database operations.
		
			</dd>
		

		</dl>
		
	



	<dt>list</dt>
	<dd>This function retrieves a list of entry(s) from the database.</dd>
	



	<dt>list_by_categoryID</dt>
	<dd>This function retrieves a list of entry(s) from the database.</dd>
	
		
		<dd><strong>Parameters</strong></dd>
		<dl>


		
		<dt>categoryID</dt>
		
			<dd>numeric<br />
		
		
			</dd>
		

		</dl>
		
	



	<dt>list_by_commentId</dt>
	<dd>This function retrieves a list of entry(s) from the database.</dd>
	
		
		<dd><strong>Parameters</strong></dd>
		<dl>


		
		<dt>commentId</dt>
		
			<dd>numeric<br />
		
		
			</dd>
		

		</dl>
		
	



	<dt>list_foreign_key_labels</dt>
	<dd>This function retrieves the primary key and foreign key label of entry(s). Used in building select boxes. </dd>
	



	<dt>list_with_FK</dt>
	<dd>This function retrieves a list of entry(s) from the database with foreign key labels in place of foreign keyed columns.</dd>
	



	<dt>listDisplay</dt>
	<dd>This function will handle returning the correct information to deal with foreign keys.</dd>
	



	<dt>search</dt>
	<dd>This function performs a search for entry(s) based on input parameters.</dd>
	
		
		<dd><em>Parameters will consist of columns from the database table.</em></dd>
		
	



</dl>








 																








	
		
		

		
		
		

	

	
		
		

		
		
		

	

	
		
		

		
		
		

	

	
		
		

		

	

	
		
		

		
		
		

	

	
		
		

		
		
		

	

	
		
		

		

	

	
		
		

		
		
		

	

	
		
		

		
		
		

	



	

	

	
		
		

		
		
		

	







	

	

	

	

	
		
		
		


	<h3>DAO Object Methods</h3>
<dl>

	<dt>init</dt>
	<dd>This is the pseudo constructor that allows us to play little object games.</dd>
	
		
		<dd><strong>Parameters</strong></dd>
		<dl>


		
		<dt>datasource</dt>
		
			<dd>string<br />
		
		
		The datasource for database operations.
		
			</dd>
		
		<dt>dbusername</dt>
		
			<dd>string<br />
		
		
		The database username for database operations.
		
			</dd>
		
		<dt>dbpassword</dt>
		
			<dd>string<br />
		
		
		The database password for database operations.
		
			</dd>
		

		</dl>
		
	



	<dt>Commit</dt>
	<dd>Takes an instance of a business object, and persists the object's properties back to the database via internal CRUD methods.</dd>
	
		
		<dd><strong>Parameters</strong></dd>
		<dl>


		
		<dt>ObjInstance</dt>
		
		
		An instance of a business object to persist back to the database.
		
			</dd>
		

		</dl>
		
	



	<dt>create</dt>
	<dd>This function inserts a single entry record into the database.</dd>
	
		
		<dd><em>Parameters will consist of columns from the database table.</em></dd>
		
	



	<dt>describe</dt>
	<dd>This function will describe the data in the table this cfc represents.</dd>
	



	<dt>destroy</dt>
	<dd>This function deletes a single entry record from the database.</dd>
	
		
		<dd><em>Parameters will consist of columns from the database table.</em></dd>
		
	



	<dt>read</dt>
	<dd>This function retrieves a single entry record from the database.</dd>
	
		
		<dd><em>Parameters will consist of columns from the database table.</em></dd>
		
	



	<dt>read_with_FK</dt>
	<dd>This function retrieves a single entry record from the database with foreign key labels in place of foreign keyed columns.</dd>
	
		
		<dd><em>Parameters will consist of columns from the database table.</em></dd>
		
	



	<dt>readDisplay</dt>
	<dd>This function will handle returning the correct information to deal with foreign keys.</dd>
	
		
		<dd><strong>Parameters</strong></dd>
		<dl>


		
		<dt>id</dt>
		
			<dd>numeric<br />
		
		
			</dd>
		

		</dl>
		
	



	<dt>sample</dt>
	<dd>This function will create a sample blank record from the database.</dd>
	



	<dt>update</dt>
	<dd>This function updates a single entry record from the database.</dd>
	
		
		<dd><em>Parameters will consist of columns from the database table.</em></dd>
		
	



</dl>











	
	
	
	
	
	

	
	
	
	

	
	
	
	

	
	
	
	
	

	
	
	
	
	

	
	
	
	
	


	
	
	
	
	


	
	
	
	
	
	


	
	
	
	
	

	
	
	
	
	






	
	
	
	
	

	
	
	
	
	

	
	
	
	
	


	
	
	
	
	
	

	
	
	
	
	
	


	
	
	
	
	









	
		
		

		

	

	
		
		

		

	

	
		
		

		

	

	

	
		
		

		
		
		

	

	
		
		

		

	

	

	

	
		
		

		
		
		

	

	

	
		
		

		
		
		

	

	
		
		

		
		
		

	

	

	
		
		

		

	






	

	

	

	

	
		
		
		


	<h3>Business Object Methods</h3>
<dl>

	<dt>init</dt>
	<dd>Initializes the object, populates properties with a persisted object values when a key value is passed in.</dd>
	
		<dd><strong>Parameters</strong></dd>
		<dl>
		
		<dt>DAO</dt>
		<dd>any<br />
		The DAO which to manipulate. Used this was to encourage use of singleton dao's in teh application scope.</dd>
		
		<dt>KeyValue</dt>
		<dd>any<br />
		Primary key value, pass in to load an existing object from the database</dd>
		
		<dt>FormValues</dt>
		<dd>struct<br />
		</dd>
		
		<dt>WithLinks</dt>
		<dd>boolean<br />
		Whether or not to read in tables with FK links.</dd>
		
		</dl>
	



	<dt>Commit</dt>
	<dd>Persists object state back to the database.</dd>
	



	<dt>Destroy</dt>
	<dd>Remove object from the database.</dd>
	



	<dt>formImageProcessor</dt>
	<dd>Takes a input form  structure and handles turning input image into cfimage objects for use with image crud.</dd>
	
		<dd><strong>Parameters</strong></dd>
		<dl>
		
		<dt>formValues</dt>
		<dd>struct<br />
		The form to manipulate.</dd>
		
		</dl>
	



	<dt>Get</dt>
	<dd>Public method for getting cfc property values.</dd>
	
		<dd><strong>Parameters</strong></dd>
		<dl>
		
		<dt>PropertyName</dt>
		<dd>string<br />
		The name of the property to be gotten.</dd>
		
		</dl>
	



	<dt>New</dt>
	<dd>Empties all object properties.</dd>
	



	<dt>ObjectState</dt>
	<dd>Diagnostic function -- returns a snapshot struct of the object's current state.</dd>
	



	<dt>Refresh</dt>
	<dd>If a key field is set properties are refreshed from the database. If not, properties are emptied. WARNING: This destroys any uncomitted changes made to the object.</dd>
	



	<dt>Set</dt>
	<dd>Public method for setting cfc property values.</dd>
	
		<dd><strong>Parameters</strong></dd>
		<dl>
		
		<dt>PropertyName</dt>
		<dd>string<br />
		The name of the property to be set.</dd>
		
		<dt>PropertyValue</dt>
		<dd>any<br />
		The value to set the property.</dd>
		
		</dl>
	



</dl>



