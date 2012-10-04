<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="textRess.xsl"/>
	<xsl:include href="hyperlinkRess.xsl"/>
	<xsl:include href="citationRess.xsl"/>
	<xsl:include href="documentRess.xsl"/>

	<xsl:template name="createRubric">
		<ressources>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:if test=".//asmContext[semanticTag='description']">
				<rubriqueDescription>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='description']"/>
				</rubriqueDescription>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='objectives']">
				<rubriqueObjectifs>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='objectives']"/>
				</rubriqueObjectifs>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='learningstrat']">
				<rubriqueApprochePedagogique>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='learningstrat']"/>
				</rubriqueApprochePedagogique>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='misresources']">
				<rubriqueRessourcesGenerales>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='misresources']"/>
				</rubriqueRessourcesGenerales >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='ressinclass']">
				<rubriqueSupportsCours>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='ressinclass']"/>
				</rubriqueSupportsCours>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='case']">
				<rubriqueCas>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='case']"/>
				</rubriqueCas>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='readinglist']">
				<rubriqueLectures>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='readinglist']"/>
				</rubriqueLectures>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='exercises']">
				<rubriqueExercice>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='exercises']"/>
				</rubriqueExercice >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='bibliographicres']">
				<rubriqueBibliographie>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='bibliographicres']"/>
				</rubriqueBibliographie >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='complbibres']">
				<rubriqueRessourcesComplementaires>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='complbibres']"/>
				</rubriqueRessourcesComplementaires >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='tools']">
				<rubriqueOutils>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='tools']"/>
				</rubriqueOutils >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='pastexams']">
				<rubriqueAnciensExamens>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='pastexams']"/>
				</rubriqueAnciensExamens >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='actResBefore']">
				<rubriqueActivitesRessourcesAvantSeance>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='actResBefore']"/>
				</rubriqueActivitesRessourcesAvantSeance >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='actResDuring']">
				<rubriqueActivitesRessourcesPendantSeance>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='actResDuring']"/>
				</rubriqueActivitesRessourcesPendantSeance >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='actResAfter']">
				<rubriqueActivitesRessourcesApresSeance>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='actResAfter']"/>
				</rubriqueActivitesRessourcesApresSeance >
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='coordinators']">
				<rubriqueCoordonnateurs>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='coordinators']"/>
				</rubriqueCoordonnateurs>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='teachingassistants']">
				<rubriqueStagiairesEnseignement>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='teachingassistants']"/>
				</rubriqueStagiairesEnseignement>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='speakers']">
				<rubriqueConferenciers>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='speakers']"/>
				</rubriqueConferenciers>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='lecturers']">
				<rubriqueEnseignants>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='lecturers']"/>
				</rubriqueEnseignants>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='secretaries']">
				<rubriqueSecretaires>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='secretaries']"/>
				</rubriqueSecretaires>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='evalcriteria']">
				<rubriqueCritereEvaluation>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='evalcriteria']"/>
				</rubriqueCritereEvaluation>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='evalpreparation']">
				<rubriquePreparationEvaluation>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='evalpreparation']"/>
				</rubriquePreparationEvaluation>
			</xsl:if>
			<xsl:if test=".//asmContext[semanticTag='evalsubproc']">
				<rubriqueRemises>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					<xsl:apply-templates select=".//asmContext[semanticTag='evalsubproc']"/>
				</rubriqueRemises>
			</xsl:if>
		</ressources>
	</xsl:template>
	
</xsl:stylesheet>
