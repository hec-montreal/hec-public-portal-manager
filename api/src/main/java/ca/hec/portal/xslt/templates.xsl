<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- coordonnee -->
<xsl:template match="coordonnee">
	<div class='rubrique'>
		<div class="logoRubrique"></div>
		<div class='titreRubrique'>
			<xsl:value-of select="role"/><xsl:text> : </xsl:text><xsl:value-of select="prenom"/><xsl:text> </xsl:text><xsl:value-of select="nom"/>
		</div>
		<div class='contenuRubrique'>
			<div class='bureau'><xsl:apply-templates select="bureau"/></div>
			<div class='courriel'><xsl:apply-templates select="courriel"/></div>
			<div class='telephone'><xsl:apply-templates select="telephone"/></div>
			<div class='disponibilite'><xsl:apply-templates select="disponibilite"/></div>
			<div class='commentaires'><xsl:apply-templates select="commentaire"/></div>
		</div>
	</div>
</xsl:template>

<xsl:template match="bureau">
		<div class='libelleBureau'>
<!--
			<xsl:value-of select="$bureauLbl"/>
-->
		</div>
		<div class='contenuBureau'>
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</div>
</xsl:template>

<xsl:template match="courriel">
		<div class='libelleCourriel'>
		<!--
			<xsl:value-of select="$courrielLbl"/>
			-->
		</div><!-- libelleCourriel -->
		<div class='contenuCourriel'>
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</div><!-- contenuCourriel -->
</xsl:template>

<xsl:template match="telephone">
		<div class='libelleTelephone'>
		<!--
			<xsl:value-of select="$telLbl"/>
			-->
		</div>
		<div class='contenuTelephone'>
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</div>
</xsl:template>

<xsl:template match="disponibilite">
		<div class='libelleDispo'>
		<!--
			<xsl:value-of select="$dispoLbl"/>
			-->
		</div><!-- libelleDispo -->
		<div class='contenuDispo'>
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</div><!-- contenuDispo -->
</xsl:template>

<xsl:template match="commentaire">
		<div class='contenuCommentaire'>
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</div><!-- contenuCommentaire -->
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
	<div class='ressource'>
		<div class="logoRessource"></div>
		<div class='titreRessource'>
			<xsl:value-of select="global/libelle"/><xsl:text> (</xsl:text><xsl:value-of select="global/valeur"/><xsl:text>%)</xsl:text>
		</div>
		<div class='contenuRessource'>
			<xsl:apply-templates select="local/*" />
			<xsl:apply-templates select="global/*" />
		</div>
	</div>
</xsl:template>

<xsl:template match="evaluation/global/date">
	<div class='date'>
	<!--
		<xsl:value-of select="$evalDateLbl"/><xsl:value-of select="."/>
		-->
	</div>
</xsl:template>


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