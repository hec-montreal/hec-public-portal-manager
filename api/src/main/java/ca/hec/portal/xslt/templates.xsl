<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:java="java">

	<!-- ========================================= -->
	<!-- =========== Presentation================= -->
	<!-- ========================================= -->
	<xsl:template match="presentation">
		<xsl:if test="ressources/rubriqueDescription/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'descriptionLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueDescription/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueObjectifs/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'objectifsLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueObjectifs/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueApprochePedagogique/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'approcheLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueApprochePedagogique/ressource'/>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- ========== Coordonnées ================== -->
	<!-- ========================================= -->

	<xsl:template match="coordonnees">
		<xsl:if test="ressources/rubriqueCoordonnateurs/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'coordonnateursLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueCoordonnateurs/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueEnseignants/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'enseignantsLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueEnseignants/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueStagiairesEnseignement/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'stagiairesEnseignementLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueStagiairesEnseignement/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueConferenciers/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'conferenciersLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueConferenciers/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueSecretaires/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'secretairesLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueSecretaires/ressource'/>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Materiels Pedagogique ======= -->
	<!-- ========================================= -->

	<xsl:template match="materiel">
		<xsl:if test="ressources/rubriqueBibliographie/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'biblioLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueBibliographie/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueRessourcesComplementaires/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'ressourcesComplementairesLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueRessourcesComplementaires/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueRessourcesGenerales/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'ressourcesGeneralesLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueCas/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'casLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueCas/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueOutils/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'outilsLbl')"/></h4>
			<xsl:apply-templates select='ressources/rubriqueOutils/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueAnciensExamens/ressource/@visible='true'">
			<h4><xsl:value-of select="java:getString($labels,'anciensExamensLbl')"/></h4>
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
				<xsl:if test="valeur!=''"><xsl:text> (</xsl:text><xsl:value-of select="valeur"/><xsl:text>%) </xsl:text></xsl:if>
				<xsl:if test="date!=''"><xsl:value-of select="date"/></xsl:if>
			</h3>

			<div class="evaluation-details">
				<xsl:call-template name="eval-details"/>
			</div>
			<xsl:if test="ressources/rubriqueDescription/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'descriptionLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueDescription/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueObjectifs/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'objectifsLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueObjectifs/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueCritereEvaluation/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'critereEvaluationLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueCritereEvaluation/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriquePreparationEvaluation/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'preparationEvaluationLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriquePreparationEvaluation/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueRemises/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'remisesLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueRemises/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueRessourcesGenerales/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'ressourcesGeneralesLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
			</xsl:if>
		</div>
	</xsl:template>

	<!-- format and translate the evaluation details -->
	<xsl:template name="eval-details">
		<xsl:if test="mode='individual'">
			<xsl:value-of select="java:getString($labels,'modeIndividuelLbl')"/>
		</xsl:if>
		<xsl:if test="mode='team'">
			<xsl:value-of select="java:getString($labels,'modeEnEquipLbl')"/>
		</xsl:if>
		<xsl:if test="lieu!=''">
			<xsl:text> / </xsl:text>
			<xsl:if test="lieu='home/inClass'">
				<xsl:value-of select="java:getString($labels,'lieuHomeClasseLbl')"/>
			</xsl:if>
			<xsl:if test="lieu='home'">
				<xsl:value-of select="java:getString($labels,'lieuHomeLbl')"/>
			</xsl:if>
			<xsl:if test="lieu='inClass'">
				<xsl:value-of select="java:getString($labels,'lieuClasseLbl')"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="modalite!=''">
			<xsl:text> / </xsl:text>
			<xsl:if test="modalite='oral/written'">
				<xsl:value-of select="java:getString($labels,'modaliteOralWrittenLbl')"/>
			</xsl:if>
			<xsl:if test="modalite='oral'">
				<xsl:value-of select="java:getString($labels,'modaliteOralLbl')"/>
			</xsl:if>
			<xsl:if test="modalite='written'">
				<xsl:value-of select="java:getString($labels,'modaliteWrittenLbl')"/>
			</xsl:if>
		</xsl:if>
		<br/>
		<xsl:if test="remise!=''">
			<xsl:value-of select="java:getString($labels,'remiseModeLbl')"/>
			<xsl:if test="remise='elect/paper'">
				<xsl:value-of select="java:getString($labels,'remiseElectPapierLbl')"/>
			</xsl:if>
			<xsl:if test="remise='elect'">
				<xsl:value-of select="java:getString($labels,'remiseElectLbl')"/>
			</xsl:if>
			<xsl:if test="remise='paper'">
				<xsl:value-of select="java:getString($labels,'remisePapierLbl')"/>
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
			<xsl:if test="ressources/rubriqueDescription/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'descriptionLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueDescription/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueObjectifs/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'objectifsLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueObjectifs/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueActivitesRessourcesAvantSeance/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'resourcesBeforeLectureLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesAvantSeance/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueActivitesRessourcesPendantSeance/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'resourcesDuringLectureLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesPendantSeance/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueActivitesRessourcesApresSeance/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'resourcesAfterLectureLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesApresSeance/ressource'/>
			</xsl:if>
			<xsl:if test="ressources/rubriqueRessourcesGenerales/ressource/@visible='true'">
				<h4><xsl:value-of select="java:getString($labels,'ressourcesGeneralesLbl')"/></h4>
				<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
			</xsl:if>
		</div>
	</xsl:template>

</xsl:stylesheet>