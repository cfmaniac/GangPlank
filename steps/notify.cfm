<!---    notify.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:33:25 AM
DESCRIPTION			: A simple notify script, more an example of a step as opposed to a great thing to do .
---->
<cftimer label="Notifying Your Team" type="inline">
<h2>Notifying Your Team</h2>

<cfmail to="#configObj.get('notify','to')#" from="#configObj.get('notify','from')#" subject="#configObj.get('application','appname')# - Updated" type="html">
<p>One of your fellow developers has rerun GangPlank on #configObj.get('application','appname')#.</p>
<p>If something breaks, it's probably their fault.</p>
</cfmail>

</cftimer>