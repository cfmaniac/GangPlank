<cfsavecontent variable="cssToInject">
	<style type="text/css">
		.captionedimage{
			float:right;
			border:2px solid #b95c00;
			margin: 0 5px 5px 5px;
			width: 400px;
		}

		.captionedimage img{
			border:1px solid #cccccc;
			margin: 5px;
			clear: right;
		}

		.captionedimage .caption{
			margin: 0 5px;
		}

	</style>
</cfsavecontent>

<cfhtmlhead text="#cssToInject#" />


<h2>Effects of various database features on GangPlank</h2>

<h3>Foreign Keys</h3>

<div class="captionedimage">
	<img src="img/oneToMany.jpg" width="382" height="182" alt="Illustration of foreign key relationship." />
	<p class="caption"><strong>Figure 1.</strong> Foreign key relationship.</p>
</div>
<p>If a foreign key relationship is defined between two tables the following will occur:</p>
<ul>
	<li>Stored Procedures
		<ul>
			<li>Procs for table with foreign key in relationship will be created named usp_[tableName]_select_with_fk and usp_[tableName]_list_with_fk will be created</li>
			<li>Proc for table with primary key in relationship will be created named usp_[tableName]_list_foreign_key_labels which lists the primary key and the second column in the  table for use in the UI layer. Also a proc will be created named usp_[tableName]_list_by_foreign_key_field for selecting all items from related field where they match the primary key of the primary key table.</li>
		</ul>
	</li>
	<div class="captionedimage">
			<img src="img/dropdowns.jpg" width="363" height="97" alt="Illustration of Custom tag form dropdowns." />
			<p class="caption"><strong>Figure 2.</strong> Example of form custom tag showing foreign keys as a select box.</p>
		</div>
	<li>Business Objects


		<ul>
			<li>Read method for object will return results from the usp_[tableName]_select_with_fk procedure if the withLinks option is selected</li>
			<li>* Methods named add_[foriegnTable]_by_[foreignkeycolumn] are added.</li>
		</ul>
	</li>


	<li>Custom Tags

		<ul>
			<li>Form for item will present a select field instead of a text input box for foreign keyed field.</li>
		</ul>
	</li>
	<li>UI Layer
		<div class="captionedimage">
				<img src="img/foriegnkeys.jpg" width="379" height="234" alt="Illustration of additional UI components." />
				<p class="caption"><strong>Figure 3.</strong> Example of additional components added to UI.</p>
			</div>
		<ul>
			<li>Read method will call withLinks to display the item with the foreign key labels instead of the foreign key.</li>
			<li>* Read method will display a list of all related items in the foreign table</li>
			<li>* Read method will display a form that will allow one to create record in related tables.</li>
			<li>List method will call usp_[tableName]_list_with_fk through the gateway</li>

		</ul>

	</li>
</ul>
<hr style="clear:both;">

<div class="captionedimage" style="width:300px;">
	<img src="img/manytoMany.jpg" width="245" height="220" alt="Illustration of many to many relationship." />
	<p class="caption"><strong>Figure 4.</strong> Example of many to many relationship as setup for use in GangPlank.</p>
</div>
<p>If a foreign key relationships are setup such that they define a many to many relationship through a linking table the following will occur:</p>
<ul>
	<li>Stored Procedures</li>
	<ul>
		<li>Proc for table will be created named usp_[tableName]_select_by_unique_join which will return the record that has the primary key values of both linked tables.</li>
	</ul>

	<li>Business Objects
		<ul>
			<li>* Business objects for each linked table will have an add and remove method for the other table which will create relationships for them in the liking table.</li>
		</ul>
	</li>
	<li>UI</li>
	<ul>
		<li>* Read method will list records in linked table through the linking table.</li>
		<li>* Read method displays form that allows for created related records in the linked table through the linking table.</li>
	</ul>
</ul>
<p>In order for this to happen:</p>
<ul>
	<li>The linking table needs to have the primary key of each other table set as a foreign key</li>
	<li>The foreign keys need to have the same name</li>
	<li>The table needs to be named tableToTable.</li>
</ul>
<hr style="clear:both;">

<h3>Unique Constraints</h3>
<p>When a unique constraint is set for a column the following occurs:</p>
<ul>
	<li>Stored Procedures</li>
	<ul>
		<li>A stored procedure named usp_[tableName]_select_by_uniquecolumn is created</li>
	</ul>
	<li>Business Objects</li>
	<ul>
		<li>* The init method read in a record based on its unique record by setting the Keyfield and keyValue arguments to the appropriate item</li>
	</ul>
	<li>UI</li>
	<ul>
		<li>* Ui will allow you to link records by just passing in the unique column, rather than the whole value</li>
	</ul>
</ul>

<p>* - Only occurs in fkCrazy template.</p>