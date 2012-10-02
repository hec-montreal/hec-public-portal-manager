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
	<h4><xsl:value-of select="$labels//label[@id='contactsLbl']"/></h4>
	<xsl:for-each select="coordonnee">
		<p>
			<xsl:value-of select="role"/><xsl:text> : </xsl:text><xsl:value-of select="prenom"/><xsl:text> </xsl:text><xsl:value-of select="nom"/><br/>
			<xsl:value-of select="$labels//label[@id='bureauLbl']"/><xsl:value-of disable-output-escaping="yes" select="bureau"/><br/>
			<xsl:value-of select="$labels//label[@id='courrielLbl']"/><xsl:value-of disable-output-escaping="yes" select="courriel"/><br/>
			<xsl:value-of select="$labels//label[@id='telLbl']"/><xsl:value-of disable-output-escaping="yes" select="telephone"/><br/>
			<xsl:value-of select="$labels//label[@id='dispoLbl']"/><xsl:value-of disable-output-escaping="yes" select="disponibilite"/><br/>
			<xsl:value-of disable-output-escaping="yes" select="commentaire"/>
		</p>
	</xsl:for-each>
</xsl:template>

<!-- ========================================= -->
<!-- =========== Materiels Pedagogique ======= -->
<!-- ========================================= -->

<xsl:template match="materiel">
	<xsl:if test="ressources/rubriqueRessourcesGenerales">
		<h4><xsl:value-of select="$labels//label[@id='ressourcesGeneralesLbl']"/></h4>
		<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
	</xsl:if>
	<xsl:if test="ressources/rubriqueCas">
		<h4><xsl:value-of select="$labels//label[@id='casLbl']"/></h4>
		<xsl:apply-templates select='ressources/rubriqueCas/ressource'/>
	</xsl:if>
	<xsl:if test="ressources/rubriqueBibliographie">
		<h4><xsl:value-of select="$labels//label[@id='biblioLbl']"/></h4>
		<xsl:apply-templates select='ressources/rubriqueBibliographie/ressource'/>
	</xsl:if>
	<xsl:if test="ressources/rubriqueRessourcesComplementaires">
		<h4><xsl:value-of select="$labels//label[@id='ressourcesComplementairesLbl']"/></h4>
		<xsl:apply-templates select='ressources/rubriqueRessourcesComplementaires/ressource'/>
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
	<ul>
	<xsl:for-each select="evaluation">
		<li>
			<a id="linkEvaluation{position()}" data-target="#courseEvaluation{position()}" href="#" class="menu-link">
				<xsl:value-of select="position()"/> : <xsl:value-of select="global/libelle"/>
			</a>
		</li>
	</xsl:for-each>
	</ul>
</xsl:template>

<!-- template for the evaluations divs -->
<xsl:template match="evaluation">
	<div id="courseEvaluation{position()}" class="courseOutline" style="display:none">
		<h4>
			<xsl:value-of select="global/libelle"/><xsl:text> (</xsl:text><xsl:value-of select="global/valeur"/><xsl:text>%)</xsl:text>
		</h4>
		<p>
			<xsl:value-of disable-output-escaping="yes" select="global/description"/>
		</p>
	</div>
</xsl:template>

<!-- ========================================= -->
<!-- ============== Seance =================== -->
<!-- ========================================= -->

<!-- template for the seances menu list -->
<xsl:template match="seances">
	<ul>
	<xsl:for-each select="seance">
		<li>
			<a id="linkLecture{position()}" data-target="#courseLecture{position()}" href="#" class="menu-link">
				<xsl:value-of select="no"/> : <xsl:value-of select="libelle"/>
			</a>
		</li>
	</xsl:for-each>
	</ul>
</xsl:template>

<!-- template for the seance divs -->
<xsl:template match="seance">
	<div id="courseLecture{position()}" class="courseOutline" style="display:none">
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
			<h4><xsl:value-of select="$labels//label[@id='activitesRessourcesAvantSeanceLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesAvantSeance/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueActivitesRessourcesApresSeance">
			<h4><xsl:value-of select="$labels//label[@id='activitesRessourcesApresSeanceLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueActivitesRessourcesApresSeance/ressource'/>
		</xsl:if>
		<xsl:if test="ressources/rubriqueRessourcesGenerales">
			<h4><xsl:value-of select="$labels//label[@id='ressourcesGeneralesLbl']"/></h4>
			<xsl:apply-templates select='ressources/rubriqueRessourcesGenerales/ressource'/>
		</xsl:if>
	</div>
</xsl:template>

<!-- template for formatting course id -->
<xsl:template name="sigle">
	<xsl:choose>
		<xsl:when test="contains(/planCours/cours/no,'A')">
			<xsl:value-of select="/planCours/cours/no"/>
		</xsl:when>
		<xsl:when test="contains(/planCours/cours/no,'E')">
			<xsl:value-of select="/planCours/cours/no"/>
		</xsl:when>
		<xsl:when test="contains(/planCours/cours/no,'I')">
			<xsl:value-of select="/planCours/cours/no"/>
		</xsl:when>
		<xsl:when test="contains(/planCours/cours/no,'O')">
			<xsl:value-of select="/planCours/cours/no"/>
		</xsl:when>
		<xsl:when test="contains(/planCours/cours/no,'U')">
			<xsl:value-of select="/planCours/cours/no"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="substring(/planCours/cours/no,0,string-length(/planCours/cours/no)-4)"/>
			<xsl:text>-</xsl:text>
			<xsl:value-of select="substring(/planCours/cours/no,string-length(/planCours/cours/no)-4,3)"/>
			<xsl:text>-</xsl:text>
			<xsl:value-of select="substring(/planCours/cours/no,string-length(/planCours/cours/no)-1,2)"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="planCours/cours/session/libelle"/>
			<xsl:if test="not(planCours/cours/section/no = '00')">
				<xsl:text>.</xsl:text><xsl:value-of select="planCours/cours/session/libelle"/>
			</xsl:if>	
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>