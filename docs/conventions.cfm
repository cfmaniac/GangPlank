<h2>Convention Reference</h2>


<dl>

	<dt>Column Conventions</dt>
	<dd>These conventions deal with names of columns, and what happens when you use them</dd>

	<dl>
		<dt>CreatedOn (datetime)</dt>
		<dd>
			<ul>
				<li>Value set automatically</li>
				<li>Will be set only in the create method.</li>
				<li>Will be set to current_timestamp in the database.</li>
				<li>Input will not bubble up to the user.</li>
			</ul>
		</dd>
		<dt>UpdatedOn (datetime)</dt>
		<dd>
			<ul>
				<li>Value set automatically</li>
				<li>Will be set to current_timestamp in the database.</li>
				<li>Input will not bubble up to the user.</li>
			</ul>
		</dd>
		<dt>CreatedBy</dt>
		<dd>
			<ul>
				<li>Will be set only in the create method.</li>
			</ul>
		</dd>
		<dt>Active (bit)</dt>
		<dd>
			<ul>
				<li>Will not bubble up to the user in input or output.</li>
				<li>Will make delete work by deactivating records instead of deleting them from table.</li>
			</ul>
		</dd>

	</dl>

	<dt>Table Conventions</dt>
	<dd>These conventions deal with names of tables, and what happens when you use them</dd>
	<dl>
		<dt><em>table</em><strong>To</strong><em>Table</em></dt>
		<dd>If you do a pass through join through a table named tablenameToOtherTableName, GangPlank will create a stored proc that will join through the middle table.</dd>
	</dl>

</dl>