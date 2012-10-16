<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		<xsl:output cdata-section-elements="libelle description"/>

	<xsl:template match="asmContext[@xsi:type='BiblioContext']">
		<ressource type="citation">
			<xsl:attribute name="visible"><xsl:call-template name="visible"/></xsl:attribute>
			<xsl:call-template name="important"/>

			<libelle><xsl:call-template name="formatCitation"/></libelle>
			<isbn><xsl:value-of select="asmResource/identifier[@type='isn']"/></isbn>
			<description><xsl:value-of select="comment"/></description>
			<niveau><xsl:value-of select="level"/></niveau>
			<type><xsl:value-of select="asmResource/asmResourceType"/></type>
			<biblio_url><xsl:value-of select="asmResource/identifier[@type='library']"/></biblio_url>
			<coop_url><xsl:value-of select="asmResource/identifier[@type='bookstore']"/></coop_url>
			<other_url>
				<xsl:attribute name="libelle"><xsl:value-of select="asmResource/identifier/@label"/></xsl:attribute>
				<xsl:value-of select="asmResource/identifier[@type='other_link']"/>
			</other_url>
		</ressource>
	</xsl:template>

	<xsl:template name="formatCitation">
			<xsl:if test="asmResource/resourceType='book'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i&gt;</xsl:text>, <xsl:value-of select="asmResource/publisher"/>, <xsl:value-of select="asmResource/publicationLocation"/>.</xsl:if>
			<xsl:if test="asmResource/resourceType='article'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). «<xsl:value-of select="asmResource/title"/> », <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/journal"/> <xsl:text>&lt;/i&gt;</xsl:text>, vol.<xsl:value-of select="asmResource/volume"/> , no.<xsl:value-of select="asmResource/issue"/> , p.<xsl:value-of select="asmResource/pages"/> .</xsl:if>
			<xsl:if test="asmResource/resourceType='report'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i&gt;</xsl:text>, <xsl:value-of select="asmResource/publisher"/>, <xsl:value-of select="asmResource/publicationLocation"/>.</xsl:if>
			<xsl:if test="asmResource/resourceType='proceed'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). «<xsl:value-of select="asmResource/title"/> », <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/journal"/> <xsl:text>&lt;/i&gt;</xsl:text>, vol.<xsl:value-of select="asmResource/volume"/> , no.<xsl:value-of select="asmResource/issue"/> , p.<xsl:value-of select="asmResource/pages"/></xsl:if>
			<xsl:if test="asmResource/resourceType='unknown'"><xsl:value-of select="asmResource/title"/></xsl:if>
	</xsl:template>

</xsl:stylesheet>
