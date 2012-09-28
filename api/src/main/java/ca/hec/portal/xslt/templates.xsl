<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ========================================= -->
<!-- ========== Coordonnées ================== -->
<!-- ========================================= -->

<xsl:template match="coordonnees">
	<h4>Coordonnées</h4>
	<xsl:for-each select="coordonnee">
		<p>
			<xsl:value-of select="role"/><xsl:text> : </xsl:text><xsl:value-of select="prenom"/><xsl:text> </xsl:text><xsl:value-of select="nom"/>
			<xsl:value-of select="$bureauLbl"/><xsl:value-of disable-output-escaping="yes" select="bureau"/>
			<xsl:value-of select="$courrielLbl"/><xsl:value-of disable-output-escaping="yes" select="courriel"/>
			<xsl:value-of select="$telLbl"/><xsl:value-of disable-output-escaping="yes" select="telephone"/>
			<xsl:value-of select="$dispoLbl"/><xsl:value-of disable-output-escaping="yes" select="disponibilite"/>
			<xsl:value-of disable-output-escaping="yes" select="commentaire"/>
		</p>
	</xsl:for-each>
</xsl:template>

<!-- ========================================= -->
<!-- =========== Presentation================= -->
<!-- ========================================= -->
<xsl:template match="presentation">
	<xsl:for-each select="ressources/rubriqueDescription[*]">
		<xsl:if test="position()=1">
			<h4><xsl:value-of select="$descriptionLbl"/></h4>
		</xsl:if>
		<p>
			<xsl:apply-templates select='ressource'/>
		</p>
	</xsl:for-each>
	<xsl:for-each select="ressources/rubriqueObjectifs[*]">
		<xsl:if test="position()=1">
			<h4><xsl:value-of select="$objectifsLbl"/></h4>
		</xsl:if>
		<p>
			<xsl:apply-templates select='ressource'/>
		</p>
	</xsl:for-each>
	<xsl:for-each select="ressources/rubriqueApprochePedagogique[*]">
		<xsl:if test="position()=1">
			<h4><xsl:value-of select="$approcheLbl"/></h4>
		</xsl:if>
		<p>
			<xsl:apply-templates select='ressource'/>
		</p>
	</xsl:for-each>
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

	<!--
<xsl:template match="evaluation/global/date">
	<div class='date'>
		<xsl:value-of select="$evalDateLbl"/><xsl:value-of select="."/>
	</div>
</xsl:template>
		-->


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
				<xsl:text>.</xsl:text><xsl:value-of select="planCour/cours/session/libelle"/>
			</xsl:if>	
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>