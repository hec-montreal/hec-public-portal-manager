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
							<img src="../../../portail/images/HECMontreal_blanc-med.png" alt="HEC Montréal" width="189" height="24" />
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
									<a id="linkPresentation" data-target="#coursePresentation" href="#" class="menu-link">Présentation du cours</a>
								</li>
								<li>
									<a id="linkCoordinates" data-target="#courseCoordinates" href="#" class="menu-link">Coordonnées</a>
								</li>
								<li>
									<a id="linkMaterials" data-target="#courseMaterials" href="#" class="menu-link">Matériel Pédagogique</a>
								</li>
								<li>
									<a>Évaluations</a>
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
<!-- <div class='rubrique'> <div class="logoRubrique"></div> <div class='titreRubrique'> <a name="#jumpDescription"><h3>Description</h3></a> </div> <div class='contenuRubrique'> <div class='texte'>Voici notre <span style="font-weight: bold;">crédo philosophique</span>.<br/>Comme plusieurs collègues en finance, nous faisons la profession de foi que l'enseignement universitaire doit être axé sur le dépassement et la responsabilisation de l'étudiant plutôt que sur la facilité et la prise en charge. Le monde universitaire se doit de viser l'excellence tant du point de vue de la recherche que du point de vue de la pédagogie et des attentes envers les étudiants.<br/><br/>Nous croyons que le maintien des critères d'évaluation dans les différents cours permet d'augmenter la valeur relative du diplôme HEC auprès des employeurs. Le cours « Finance » a contribué, en partie du moins, à cette augmentation de la valeur du diplôme en maintenant le cap et en obligeant les étudiants à "sauter la barre" fixée depuis plus de 10 ans dans ce cours. Le maintien des critères d'évaluation a un effet bénéfique sur nos diplômés et sur la valeur au marché de notre diplôme de B.A.A.<br/><br/><span style="font-weight: bold;">Révision des acquis en mathématique</span><br/>Pendant la troisième semaine de cours, le centre d'aide en mathématique offre une séance de révision des notions mathématiques importantes au cours. Les étudiants éprouvant de la difficultés avec des notions tels que les exposants, l'actualisation, l'annuité, la perpétuité, la conversion de taux et la résolution d'équations avec Excel sont invités à s'inscrire à cette séance de révision à l'adresse suivante: <a target="_blank" href="http://web.hec.ca/virtuose/applications/math_inscription/etudiants/ident_etud.cfm">http://web.hec.ca/virtuose/applications/math_inscription/etudiants/ident_etud.cfm</a><br/>Notez que ces notions pourront être révisées en classe, mais puisque le cours est très chargé, il se peut que certaines d'entre elles fassent l'objet d'un survol rapide ou qu'elles soient simplement considérées comme acquises.</div> </div> </div> <div class='rubrique'> <div class="logoRubrique"></div> <br/><div class='titreRubrique'> <a name="#jumpObjectifs"><h3>Objectifs</h3></a> </div> <div class='contenuRubrique'> <div class='texte'><DIV align='justify'>Le cours de finance vise essentiellement à initier l'étudiant à la finance corporative. L'accent est donc mis sur l'apprentissage des outils de base en finance ainsi que sur la compréhension des concepts les plus importants de ce domaine. Plus précisément, le cours a pour objectif de familiariser l'étudiant aux sujets suivants : </DIV><DIV align='justify'></DIV><DIV align='justify'><UL><UL><LI>Les fondements de l'évaluation</LI> <LI>La décision d'investissement</LI> <LI>Le coût du capital et du financement des entreprises</LI> <LI>Les aspects pratiques du financement des entreprises </LI></UL></UL></DIV><P></P>Finance (2-200-96) a comme pré-requis le cours "Mathématiques financières". Il est essentiel d'avoir bien compris les mathématiques financières avant de prendre le cours Finance (2-200-96). Pour vous rappeler les bases des mathématiques financières, il est fortement conseillé de refaire les examens antérieurs de mathématiques financière.</div> </div> </div> <div class='rubrique'> <div class="logoRubrique"></div> <div class='titreRubrique'> <a name="#jumpApproche">Approche pédagogique</a> </div> <div class='contenuRubrique'> <div class='texte'>Le cours est constitué d'exposés magistraux introduisant les concepts théoriques ainsi que des exemples pratiques. Des lectures et des exercices sont prévus afin d'approfondir les notions couvertes aux cours.</div> </div> </div> -->
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