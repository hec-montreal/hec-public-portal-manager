<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" omit-xml-declaration="yes"/>

<xsl:include href="templates.xsl"/>
<xsl:include href="ressources.xsl"/>

<xsl:variable name="labelsFilename">labels_<xsl:value-of select="planCours/@lang"/>.xml</xsl:variable>
<xsl:variable name="labels" select="document($labelsFilename)" />

<xsl:template match="/">
<html>

	<head>
		<title><xsl:call-template name="sigle"/> - <xsl:value-of select="planCours/cours/libelle"/></title>
	
	<!--
		<link href="../../../portail/plugins/bootstrap-2.1/css/bootstrap.css" rel="stylesheet"/>
		<link href="../../../portail/plugins/bootstrap-2.1/css/bootstrap-custom_style.css" rel="stylesheet"/>
		-->
		<link href="../../../portail/css/hec-public-portal.css" rel="stylesheet"/>    
	</head>

	<body>
		<div id='wrap'>
			<div id="HEC-header" class="navbar navbar-fixed-top">
				<div class="navbar-inner">
					<div class="container">
						<a class="brand" href="#" style="padding: 4px 12px 4px 18px">
							<img src="../../../portail/images/HECMontreal_blanc-med.png" alt="HEC Montréal" width="189" height="24" />
						</a>
					</div>
				</div>
			</div>
		
			<div id="main" class="container clear-top">
				<div class="row">

					<div class="row span12">
						<h2><xsl:call-template name="sigle"/> - <xsl:value-of select="planCours/cours/libelle"/></h2>
					</div>

					<!-- menu -->
					<div id="" class=" span4" >
						<div class="menu" style="padding: 8px 0 ">
							<ul class="nav nav-list ">
								<li>
									<a id="linkPresentation" data-target="#coursePresentation" href="#" class="menu-link">
										<xsl:value-of select="$labels//label[@id='menuLblPresentation']"/>
									</a>
								</li>
								<li>
									<a id="linkContact" data-target="#courseCoordinates" href="#" class="menu-link">
										<xsl:value-of select="$labels//label[@id='menuLblContact']"/>
									</a>
								</li>
								<li>
									<a id="linkMaterials" data-target="#courseMaterials" href="#" class="menu-link">
										<xsl:value-of select="$labels//label[@id='menuLblMaterials']"/>
									</a>
								</li>
								<li>
									<a><xsl:value-of select="$labels//label[@id='menuLblEvaluations']"/></a>
									<xsl:apply-templates select="planCours/evaluations"/>
								</li>
								<li>
									<a><xsl:value-of select="$labels//label[@id='menuLblLectures']"/></a>
									<xsl:apply-templates select="planCours/seances"/>
								</li>
							</ul>
						</div>
					</div>
					
					<!-- course outline column -->
					<div id="" class="span8">
						<div id="coursePresentation" class="courseOutline">
							<xsl:apply-templates select="planCours/presentation"/>
						</div>							
						<div id="courseCoordinates" class="courseOutline" style="display:none">							
							<xsl:apply-templates select="planCours/coordonnees" />
						</div>
						<div id="courseMaterials" class="courseOutline" style="display:none">
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
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap.min.js"></script> 
	<script src="../../../portail/js/html-view.js"></script>
<!-- end scripts -->
		
	</body>
</html>

</xsl:template>

</xsl:stylesheet>