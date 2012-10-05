<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- ========================================= -->
	<!-- =========== Presentation================= -->
	<!-- ========================================= -->
	<xsl:template match="presentation">
		<xsl:if test="ressources/rubriqueDescription">
			<h4><xsl:value-of select="$labels//label[@id='descriptionLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueDescription/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueObjectifs">
			<h4><xsl:value-of select="$labels//label[@id='objectifsLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueObjectifs/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueApprochePedagogique">
			<h4><xsl:value-of select="$labels//label[@id='approcheLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueApprochePedagogique/ressource'/>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- ========== Coordonnées ================== -->
	<!-- ========================================= -->

	<xsl:template match="coordonnees">
		<xsl:if test="ressources/rubriqueCoordonnateurs">
			<h4><xsl:value-of select="$labels//label[@id='coordonnateursLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueCoordonnateurs/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueEnseignants">
			<h4><xsl:value-of select="$labels//label[@id='enseignantsLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueEnseignants/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueStagiairesEnseignement">
			<h4><xsl:value-of select="$labels//label[@id='stagiairesEnseignementLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueStagiairesEnseignement/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueConferenciers">
			<h4><xsl:value-of select="$labels//label[@id='conferenciersLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueConferenciers/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueSecretaires">
			<h4><xsl:value-of select="$labels//label[@id='secretairesLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueSecretaires/ressource'/>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Materiels Pedagogique ======= -->
	<!-- ========================================= -->

	<xsl:template match="materiel">
		<xsl:if test="ressources/rubriqueBibliographie">
			<h4><xsl:value-of select="$labels//label[@id='biblioLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueBibliographie/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueRessourcesComplementaires">
			<h4><xsl:value-of select="$labels//label[@id='ressourcesComplementairesLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueRessourcesComplementaires/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueRessourcesGenerales">
			<h4><xsl:value-of select="$labels//label[@id='ressourcesGeneralesLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueCas">
			<h4><xsl:value-of select="$labels//label[@id='casLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueCas/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueOutils">
			<h4><xsl:value-of select="$labels//label[@id='outilsLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueOutils/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueAnciensExamens">
			<h4><xsl:value-of select="$labels//label[@id='anciensExamensLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueAnciensExamens/ressource'/>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Evaluation ================== -->
	<!-- ========================================= -->

	<!-- template for the evaluations menu list -->
	<xsl:template match="evaluations">
		<ul class="nav-sublist">
			<xsl:for-each select="evaluation">
				<li>
					<a id="linkEvaluation{position()}" data-target="#courseEvaluation{position()}" href="#" class="menu-link">
						<xsl:value-of select="position()"/> : <xsl:value-of select="libelle"/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<!-- template for the evaluations divs -->
	<xsl:template match="evaluation">
		<div id="courseEvaluation{position()}" class="courseOutline" style="display:none">
			<h3>
				<xsl:value-of select="libelle"/>
				<xsl:if test="valeur!=''"><xsl:text> (</xsl:text><xsl:value-of select="valeur"/><xsl:text>%)</xsl:text></xsl:if>
			</h3>

			<div class="ressource evaluation-details">
				<xsl:call-template name="eval-details"/>
			</div>
			<xsl:if test="ressources/rubriqueDescription">
				<h4><xsl:value-of select="$labels//label[@id='descriptionLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueDescription/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueObjectifs">
				<h4><xsl:value-of select="$labels//label[@id='objectifsLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueObjectifs/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueCritereEvaluation">
				<h4><xsl:value-of select="$labels//label[@id='critereEvaluationLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueCritereEvaluation/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriquePreparationEvaluation">
				<h4><xsl:value-of select="$labels//label[@id='preparationEvaluationLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriquePreparationEvaluation/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueRemises">
				<h4><xsl:value-of select="$labels//label[@id='remisesLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueRemises/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueRessourcesGenerales">
				<h4><xsl:value-of select="$labels//label[@id='ressourcesGeneralesLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
			</xsl:if>
		</div>
	</xsl:template>

	<!-- format and translate the evaluation details -->
	<xsl:template name="eval-details">
		<xsl:if test="mode='individual'">
			<xsl:value-of select="$labels//label[@id='modeIndividuelLbl']"/>
		</xsl:if>
		<xsl:if test="mode='team'">
			<xsl:value-of select="$labels//label[@id='modeEnEquipLbl']"/>
		</xsl:if>
		<xsl:if test="lieu!=''">
			<xsl:text> / </xsl:text>
			<xsl:if test="lieu='home/inClass'">
				<xsl:value-of select="$labels//label[@id='lieuHomeClasseLbl']"/>
			</xsl:if>
			<xsl:if test="lieu='home'">
				<xsl:value-of select="$labels//label[@id='lieuHomeLbl']"/>
			</xsl:if>
			<xsl:if test="lieu='inClass'">
				<xsl:value-of select="$labels//label[@id='lieuClasseLbl']"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="modalite!=''">
			<xsl:text> / </xsl:text>
			<xsl:if test="modalite='oral/written'">
				<xsl:value-of select="$labels//label[@id='modaliteOralWrittenLbl']"/>
			</xsl:if>
			<xsl:if test="modalite='oral'">
				<xsl:value-of select="$labels//label[@id='modaliteOralLbl']"/>
			</xsl:if>
			<xsl:if test="modalite='written'">
				<xsl:value-of select="$labels//label[@id='modaliteWrittenLbl']"/>
			</xsl:if>
		</xsl:if>
		<br/>
		<xsl:if test="remise!=''">
			<xsl:value-of select="$labels//label[@id='remiseModeLbl']"/>
			<xsl:if test="remise='elect/paper'">
				<xsl:value-of select="$labels//label[@id='remiseElectPapierLbl']"/>
			</xsl:if>
			<xsl:if test="remise='elect'">
				<xsl:value-of select="$labels//label[@id='remiseElectLbl']"/>
			</xsl:if>
			<xsl:if test="remise='paper'">
				<xsl:value-of select="$labels//label[@id='remisePapierLbl']"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- ============== Seance =================== -->
	<!-- ========================================= -->

	<!-- template for the seances menu list -->
	<xsl:template match="seances">
		<ul class="nav-sublist">
			<xsl:for-each select="group">
				<xsl:variable name="groupNum"><xsl:value-of select="position()"/></xsl:variable>
				<li>
					<a><xsl:value-of select="libelle"/></a>
					<ul class="nav-sublist">
						<xsl:for-each select="seance">
							<li>
								<a id="linkSeance-group{$groupNum}-{position()}" data-target="#seance-group{$groupNum}-{position()}" href="#" class="menu-link">
									<xsl:value-of select="no"/> : <xsl:value-of select="libelle"/>
								</a>
							</li>
						</xsl:for-each>
					</ul>
				</li>
			</xsl:for-each>
			<xsl:for-each select="seance">
				<li>
					<a id="linkSeance-{position()}" data-target="#seance-{position()}" href="#" class="menu-link">
						<xsl:value-of select="no"/> : <xsl:value-of select="libelle"/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<!-- templates for the seance divs -->
	<xsl:template name="seances-divs">
		<xsl:param name="seances"/>

		<xsl:for-each select="$seances/group">
			<xsl:variable name="groupNum"><xsl:value-of select="position()"/></xsl:variable>
			<xsl:for-each select="seance">
				<xsl:call-template name="seance">
					<!-- pass the id to use for the div to respond to clicks in the menu -->
					<xsl:with-param name="target">seance-group<xsl:value-of select="$groupNum"/>-<xsl:value-of select="position()"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="$seances/seance">
			<xsl:call-template name="seance">
				<!-- pass the id to use for the div to respond to clicks in the menu -->
				<xsl:with-param name="target">seance-<xsl:value-of select="position()"/></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="seance">
		<xsl:param name="target"/>

		<div id="{$target}" class="courseOutline" style="display:none">
			<h3>
				<xsl:value-of select="libelle"/>
			</h3>
			<xsl:if test="ressources/rubriqueDescription">
				<h4><xsl:value-of select="$labels//label[@id='descriptionLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueDescription/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueObjectifs">
				<h4><xsl:value-of select="$labels//label[@id='objectifsLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueObjectifs/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueActivitesRessourcesAvantSeance">
				<h4><xsl:value-of select="$labels//label[@id='resourceBeforeLectureLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesAvantSeance/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueActivitesRessourcesPendantSeance">
				<h4><xsl:value-of select="$labels//label[@id='resourceDuringLectureLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesPendantSeance/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueActivitesRessourcesApresSeance">
				<h4><xsl:value-of select="$labels//label[@id='resourceAfterLectureLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesApresSeance/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueRessourcesGenerales">
				<h4><xsl:value-of select="$labels//label[@id='ressourcesGeneralesLbl']"/></h4>
				<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
			</xsl:if>
		</div>
	</xsl:template>

</xsl:stylesheet>