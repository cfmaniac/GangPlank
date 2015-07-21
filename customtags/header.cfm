<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.onLoad" type="string" default = "" />
<cfparam name="attributes.displayHeader" type="boolean" default = "TRUE" />
<cfparam name="attributes.displayToolbar" type="boolean" default = "TRUE" />
<!---!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>GangPlank</title>
<cfoutput><link rel="stylesheet" href="#application.relativePath#/css/master.cfm" type="text/css"/>
<script language="JavaScript" src="#application.relativePath#/scripts/lib.js" type="text/javascript"></script></cfoutput>
</head>

<cfif len(attributes.onLoad) gt 0>
	<cfoutput><body onload="#attributes.onLoad#"></cfoutput>
<cfelse>
	<body>
</cfif>
<cfif attributes.displayheader>
<cfoutput><h1><img src="#application.relativePath#/img/title.gif" height="115" width="422" alt="GangPlank" title="title" />
<img src="#application.relativePath#/img/vblive.jpg" width="252" height="92" id="vb" /></h1></cfoutput>
</cfif>
<cfif attributes.displayToolbar>
<cfoutput>
<cf_nav />
</cfoutput>
</cfif--->
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>GangPlank :: Scaffolding Engine</title>

        <!-- Bootstrap core CSS -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <!-- Documentation extras -->
        <link href="assets/css/docs.css" rel="stylesheet">
        <link href="assets/css/pygments-manni.css" rel="stylesheet">
        <!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <!-- Favicons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="shortcut icon" href="assets/ico/favicon.png">

        </head>
        <body>
        <div class="container bs-docs-container">
            <div class="row">
        <cfif attributes.displayToolbar>
        <cfoutput>
        <cf_nav />
        </cfoutput>
        </cfif>
</cfprocessingdirective>
<cfexit method="exitTag" />