<cfcontent type="text/css; charset=ISO-8859-1">

	html{
	background-image: url(<cfoutput>#application.relativePath#</cfoutput>img/bg.jpg);
		background-position: top;
		background-repeat: repeat-x;

	}



	body{
		font-family:  Calibri, Verdana, Arial, Helvetica, sans-serif;
		font-size: 80%;
		width: 60em;
		margin: 0 auto;

	}
	h1{
		font-size: 8em;
		color: #FFAC59;
		width: 100%;
		padding: 0 .1em .0 0;
		margin: .2em 0 0 0;
		float: left;
		height: 115px;
	}

	h2{
		font-size: 1.2em;
		background-color: #F1F1E2;
		border: 1px solid #CCCCCC;
		padding-left: 5px;
		background-image: url(<cfoutput>#application.relativePath#</cfoutput>img/h2bg.jpg);
		background-repeat: repeat-x;
		width: 100%;
	}

	label{
		float: left;
		display: block;
		width: 100px;
		font-weight: bold;
	}

	input.text{
		width: 300px;
		margin-bottom: 3px;
	}

	fieldset{
		margin-bottom: 10px;
	}

	legend{
		font-size: 14px;
		font-weight: bold;
		color: #ffac59;
	}

	#footer{
		color: #AAAAAA;
		background-color:#F0F0F0;
		border: 1px solid #999999;
		padding: .2em .1em;
		font-weight: bold;
		margin: 3em 0 3em 0;
		padding-left: 5px;
		width: 100%;
		background-image: url(<cfoutput>#application.relativePath#</cfoutput>img/h2bg.jpg);
		background-repeat: repeat-x;
		clear: both;
	}

	.logging{
		font-family: Consolas, "Courier New", Courier, monospace;
		font-size: 80%;
	}



	.error{
		font-weight: bold;
		color: #910000;
		border: 1px solid #333333;
		width: auto;
		padding: .5em;
		background-color:#FFFFCC;
		font-size: 1.5em;
	}

	.error h2{
		font-weight: bold;
		color: #FF0000;
		font-size:2em;
		margin: 0;
		border: 0;
		background: none;
	}
	th{	text-align: left;}

	.even{		background-color: #FFFFFF;	}
	.odd{	background-color: #EEEEEE;	}

	thead tr th{
		background-color:#FFAC59;
		border-right: 1px solid #AA5500;
		background-image: url(<cfoutput>#application.relativePath#</cfoutput>img/thbg.jpg);
		background-repeat: repeat-x;

	}

	table{width: 60em;}

	tbody tr.odd th{background-color: #DCDCBA;}

	tbody tr.even th{background-color: #F1F1E2;}

	tbody tr:hover td, tbody tr:hover th{background-color: #FFD9B3;	}

	td, th{
		vertical-align: top;
		padding: 0 .5em .5em .2em;
		border-right: 1px solid #999999;
		font-size: .9em;

	}
	table{
		border-top: 1px solid #999999;
		border-bottom: 1px solid #999999;
		border-left: 1px solid #999999;
	}

	li{
		vertical-align: top;
		padding-bottom: .5em;
		list-style: disc;
	}

	ol li{

		list-style: decimal;
	}

	.attention{	color: #D76B00	}

	.logging li{padding-bottom: .1em;}

	#toolbar{
		width: 100%;
		height: 2em;
		list-style: none;
		margin: 0 0 0 0 ;
		padding: 0 0 0 5px;
		background-color:#F0F0F0;
		border: 1px solid #999999;
		background-image: url(<cfoutput>#application.relativePath#</cfoutput>img/tbbg.jpg);
		background-repeat: repeat-x;
		clear: both;


	}
	#toolbar li{
		float: left;
		display: block;
		margin: 0 1em 0 0;
		padding-top: .4em;


	}




	a:link{ color: #FFAC59;}
	a:visited{ color: #B95C00;}
	a:hover{color: #FFD3A8;	}
	a:active{color: #FFD3A8;	}
	#toolbar li a{ text-decoration:none; font-weight: bold;}
	#toolbar li a:hover{color: #000000;	}
	#toolbar li a:active{color: #000000;	}


	dl{margin-left: 2em; margin-bottom: 2em;}
	dt{	font-style: italic;	font-weight: bold; margin: 0 0 0 0;	}
	dd{ margin: 0 0 .5em 0;}

	.option{
		font-size: .8em;
	}


	#main{
	width: 65%;
	float: left;

	}

	#secondary{
	width: 30%;
	float: left;
	margin-left: 3%;
	}

	#secondary p{
		padding: 2px 5px;

	}
	#vb{
		vertical-align:top;
	}

	.requires{
		font-style:italic;
		margin-bottom: 10px;
	}