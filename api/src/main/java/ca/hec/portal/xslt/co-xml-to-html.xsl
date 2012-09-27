<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" omit-xml-declaration="yes"/>

<!-- <xsl:include href="xml2html/libelles_fr.xsl"/> -->
<!-- <xsl:include href="xml2html/commun.xsl"/> -->
<!-- <xsl:include href="xml2html/ressources.xsl"/> -->

<xsl:include href="templates.xsl"/> 

<xsl:template match="/">

<html>

	<head>
		<title><xsl:call-template name="sigle"/> - <xsl:value-of select="planCours/cours/libelle"/></title>
	
		<link href="../../../portail/css/hec-public-portal.css" rel="stylesheet"/>
		<link href="../../../portail/plugins/bootstrap-2.1/css/bootstrap.css" rel="stylesheet"/>
		<link href="../../../portail/plugins/bootstrap-2.1/css/bootstrap-custom_style.css" rel="stylesheet"/>
		<link href="../../../portail/css/hec-public-portal.css" rel="stylesheet"/>    
		
	</head>

	<body>
		<div id='wrap'>
	
			<div id="HEC-header" class="navbar navbar-fixed-top">
				<div class="navbar-inner">
					<div class="container">
						<a class="brand" href="#" style="padding: 4px 12px 4px 18px">
							<img src="../../../portail/images/HECMontreal_blanc-med.png" alt="HEC Montr�al" width="189" height="24" />
						</a>
					</div>
				</div>
			</div>
		
			<div id="main" class="container clear-top">
				<div class="row">

					<div class="row span12">
						<h3><xsl:call-template name="sigle"/> - <xsl:value-of select="planCours/cours/libelle"/></h3>
					</div>

					<!-- menu -->
					<div id="" class=" span4" >
						<div class="well" style="padding: 8px 0 ">
							<ul class="nav nav-list ">
								<li>
									<a id="linkPresentation" data-target="#coursePresentation" href="#" class="menu-link">Pr�sentation du cours</a>
								</li>
								<li>
									<a id="linkCoordinates" data-target="#courseCoordinates" href="#" class="menu-link">Coordonn�es</a>
								</li>
								<li>
									<a id="linkMaterials" data-target="#courseMaterials" href="#" class="menu-link">Mat�riel P�dagogique</a>
								</li>
								<li>
									<a>�valuations</a>
									<xsl:apply-templates select="planCours/evaluations"/>
								</li>
								<li>
									<a>Organisation du Cours</a>
									<xsl:apply-templates select="planCours/seances"/>
								</li>
							</ul>
						</div>
					</div>
					
					<!-- course presentation column -->
					<div id="" class="span8">
						<div id="coursePresentation" class="courseOutline" style="display:none">
<!-- <div class='rubrique'> <div class="logoRubrique"></div> <div class='titreRubrique'> <a name="#jumpDescription"><h3>Description</h3></a> </div> <div class='contenuRubrique'> <div class='texte'>Voici notre <span style="font-weight: bold;">cr�do philosophique</span>.<br/>Comme plusieurs coll�gues en finance, nous faisons la profession de foi que l'enseignement universitaire doit �tre ax� sur le d�passement et la responsabilisation de l'�tudiant plut�t que sur la facilit� et la prise en charge. Le monde universitaire se doit de viser l'excellence tant du point de vue de la recherche que du point de vue de la p�dagogie et des attentes envers les �tudiants.<br/><br/>Nous croyons que le maintien des crit�res d'�valuation dans les diff�rents cours permet d'augmenter la valeur relative du dipl�me HEC aupr�s des employeurs. Le cours � Finance � a contribu�, en partie du moins, � cette augmentation de la valeur du dipl�me en maintenant le cap et en obligeant les �tudiants � "sauter la barre" fix�e depuis plus de 10 ans dans ce cours. Le maintien des crit�res d'�valuation a un effet b�n�fique sur nos dipl�m�s et sur la valeur au march� de notre dipl�me de B.A.A.<br/><br/><span style="font-weight: bold;">R�vision des acquis en math�matique</span><br/>Pendant la troisi�me semaine de cours, le centre d'aide en math�matique offre une s�ance de r�vision des notions math�matiques importantes au cours. Les �tudiants �prouvant de la difficult�s avec des notions tels que les exposants, l'actualisation, l'annuit�, la perp�tuit�, la conversion de taux et la r�solution d'�quations avec Excel sont invit�s � s'inscrire � cette s�ance de r�vision � l'adresse suivante: <a target="_blank" href="http://web.hec.ca/virtuose/applications/math_inscription/etudiants/ident_etud.cfm">http://web.hec.ca/virtuose/applications/math_inscription/etudiants/ident_etud.cfm</a><br/>Notez que ces notions pourront �tre r�vis�es en classe, mais puisque le cours est tr�s charg�, il se peut que certaines d'entre elles fassent l'objet d'un survol rapide ou qu'elles soient simplement consid�r�es comme acquises.</div> </div> </div> <div class='rubrique'> <div class="logoRubrique"></div> <br/><div class='titreRubrique'> <a name="#jumpObjectifs"><h3>Objectifs</h3></a> </div> <div class='contenuRubrique'> <div class='texte'><DIV align='justify'>Le cours de finance vise essentiellement � initier l'�tudiant � la finance corporative. L'accent est donc mis sur l'apprentissage des outils de base en finance ainsi que sur la compr�hension des concepts les plus importants de ce domaine. Plus pr�cis�ment, le cours a pour objectif de familiariser l'�tudiant aux sujets suivants : </DIV><DIV align='justify'></DIV><DIV align='justify'><UL><UL><LI>Les fondements de l'�valuation</LI> <LI>La d�cision d'investissement</LI> <LI>Le co�t du capital et du financement des entreprises</LI> <LI>Les aspects pratiques du financement des entreprises </LI></UL></UL></DIV><P></P>Finance (2-200-96) a comme pr�-requis le cours "Math�matiques financi�res". Il est essentiel d'avoir bien compris les math�matiques financi�res avant de prendre le cours Finance (2-200-96). Pour vous rappeler les bases des math�matiques financi�res, il est fortement conseill� de refaire les examens ant�rieurs de math�matiques financi�re.</div> </div> </div> <div class='rubrique'> <div class="logoRubrique"></div> <div class='titreRubrique'> <a name="#jumpApproche">Approche p�dagogique</a> </div> <div class='contenuRubrique'> <div class='texte'>Le cours est constitu� d'expos�s magistraux introduisant les concepts th�oriques ainsi que des exemples pratiques. Des lectures et des exercices sont pr�vus afin d'approfondir les notions couvertes aux cours.</div> </div> </div> -->
<!--
							<xsl:call-template name="rubriques">
								<xsl:with-param name="chemin" select="/planCours/presentation/ressources"/>
							</xsl:call-template>
							-->
						</div>							
						<div id="courseCoordinates" class="courseOutline" style="display:none">
							<xsl:apply-templates select="/planCours/coordonnees/*" />
						</div>
						<div id="courseMaterials" class="courseOutline" style="display:none">
<!--
							<xsl:call-template name="rubriques">
								<xsl:with-param name="chemin" select="/planCours/materiel/ressources"/>
							</xsl:call-template>
							-->
						</div>
						<div id="courseEvaluation1" class="courseOutline" style="display:none">
							<xsl:apply-templates select="/planCours/evaluations/evaluation" />
						</div>
						<div id="courseLecture1" class="courseOutline" style="display:none">
						adfkladlsdfhjklah ajldf jahfd asd fasdfad asf sdfsasdf  
						</div>
					</div>
					
				</div>
			</div>
		</div>
		
<!-- Scripts. -->		
    <script src="../../../portail/plugins/jquery/jquery-1.7.1.min.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-transition.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-alert.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-modal.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-dropdown.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-scrollspy.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-tab.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-tooltip.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-popover.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-button.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-collapse.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-carousel.js"></script>
    <script src="../../../portail/plugins/bootstrap-2.1/js/bootstrap-typeahead.js"></script>    
    <script src="../../../portail/plugins/tablesorter/jquery.tablesorter.js"></script>
	<script src="../../../portail/js/hec-public-portal.js"></script>
	
	<script src="../../../portail/js/html-view.js"></script>

<!-- end scripts -->
		
	</body>
</html>

</xsl:template>

</xsl:stylesheet>