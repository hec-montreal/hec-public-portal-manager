<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:java="java">
<xsl:output method="html" encoding="ISO-8859-1" omit-xml-declaration="yes"/>

<xsl:include href="templates.xsl"/>
<xsl:include href="ressources.xsl"/>

<xsl:variable name="locale" select="java:util.Locale.new(planCours/@lang)"/>
<xsl:variable name="labels" select="java:util.ResourceBundle.getBundle('html/course_outline', $locale)"/>
<xsl:template match="/">
<html>
	<meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"></meta>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
    <meta name="description" content=""></meta>
    <meta name="author" content=""></meta>
	<head>
		<title><xsl:call-template name="sigle"/> - <xsl:value-of select="planCours/cours/libelle"/></title>
	
		<link href="../../../portail/css/hec-public-portal.css" rel="stylesheet"/>    
	</head>

	<body>
		<div id='wrap' class="courseOutline">

		<!-- Header -->
		<div id="HEC-header" class="navbar">
			<div class="navbar-inner">
				<div class="container">
					<a id="brand" href="#">
						<img style="border: none" src="../../../portail/images/HECMontreal_bleu-med.png" alt="HEC Montréal" />
					</a>			
				</div>
			</div>
		</div>
		<!-- /Header -->
		
			<div id="main" class="container clear-top courseOutline-main">
				<div class="row">

					<div id="title">
						<h2><xsl:call-template name="sigle"/> - <xsl:value-of select="planCours/cours/libelle"/></h2>
					</div>

					<!-- menu -->
					<div id="" class="span6" >
							<ul class="menu">
								<li>
									<a id="linkPresentation" data-target="#coursePresentation" href="#" class="menu-link">
										<xsl:value-of select="java:getString($labels,'menuLblPresentation')"/>
									</a>
								</li>
								<li>
									<a id="linkContact" data-target="#courseCoordinates" href="#" class="menu-link">
										<xsl:value-of select="java:getString($labels,'menuLblContact')"/>
									</a>
								</li>
								<li>
									<a id="linkMaterials" data-target="#courseMaterials" href="#" class="menu-link">
										<xsl:value-of select="java:getString($labels,'menuLblMaterials')"/>
									</a>
								</li>
								<li>
									<a><xsl:value-of select="java:getString($labels,'menuLblEvaluations')"/></a>
									<xsl:apply-templates select="planCours/evaluations"/>
								</li>
								<li>
									<a><xsl:value-of select="java:getString($labels,'menuLblLectures')"/></a>
									<xsl:apply-templates select="planCours/seances"/>
								</li>
							</ul>
					</div>
					
					<!-- course outline column -->
					<div id="" class="span9">
						<div id="coursePresentation" class="content">
							<xsl:apply-templates select="planCours/presentation"/>
						</div>							
						<div id="courseCoordinates" class="content" style="display:none">							
							<xsl:apply-templates select="planCours/coordonnees" />
						</div>
						<div id="courseMaterials" class="content" style="display:none">
							<xsl:apply-templates select="planCours/materiel"/>
						</div>
						<xsl:apply-templates select="planCours/evaluations/evaluation"/>
						<xsl:call-template name="seances-divs">
							<xsl:with-param name="seances" select="planCours/seances"/>
						</xsl:call-template>
					</div>
					
				</div>
			</div>
		</div>
		
<!-- Scripts. -->		
    <script src="../../../portail/plugins/jquery/jquery-1.8.1.min.js"></script>
	<script src="../../../portail/js/html-view.js"></script>
<!-- end scripts -->
		
	</body>
</html>

</xsl:template>

</xsl:stylesheet>