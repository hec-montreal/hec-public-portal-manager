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
			<coop_url>
				<xsl:choose>
					<xsl:when test="asmResource/identifier[@type='bookstore']">
						<xsl:if test="asmResource/identifier[@type='bookstore']!='inactif'">
							<xsl:value-of select="asmResource/identifier[@type='bookstore']"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="asmResource/identifier[@type='isn'] and (asmResource/resourceType='book' or asmResource/resourceType='chapter' or asmResource/resourceType='report')">
						<!-- hard-coded url, could be fixed. -->
						http://www.coophec.com/product_livre.aspx?isbn=<xsl:value-of select="asmResource/identifier[@type='isn']"/>
					</xsl:when>
				</xsl:choose>
			</coop_url>
			<other_url>
				<xsl:attribute name="libelle"><xsl:value-of select="asmResource/identifier/@label"/></xsl:attribute>
				<xsl:value-of select="asmResource/identifier[@type='other_link']"/>
			</other_url>
		</ressource>
	</xsl:template>

	<xsl:template name="formatCitation">
		<xsl:variable name="issue">
			<xsl:if test="/OSYL/CO/language='EN'">iss.</xsl:if>
			<xsl:if test="not(/OSYL/CO/language='EN')">no.</xsl:if>
		</xsl:variable>
		<xsl:variable name="edition">
			<xsl:if test="/OSYL/CO/language='FR-CA'">éd</xsl:if>
			<xsl:if test="not(/OSYL/CO/language='FR-CA')">ed</xsl:if>
		</xsl:variable>
		<xsl:variable name="retrievedOn">
			<xsl:if test="/OSYL/CO/language='EN'">Retrieved on </xsl:if>
			<xsl:if test="not(/OSYL/CO/language='EN')">Récupéré le </xsl:if>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="asmResource/resourceType='article' or asmResource/resourceType='proceed'">
				<xsl:apply-templates select="asmResource/author"/>
				<xsl:if test="asmResource/year"><xsl:text> (</xsl:text><xsl:value-of select="asmResource/year"/><xsl:text>)</xsl:text></xsl:if>
				<xsl:text>. «</xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>»</xsl:text>
				<xsl:if test="asmResource/journal"><xsl:text>, &lt;i></xsl:text><xsl:value-of select="asmResource/journal"/><xsl:text>&lt;/i></xsl:text></xsl:if>
				<xsl:if test="asmResource/volume"><xsl:text>, vol. </xsl:text><xsl:value-of select="asmResource/volume"/></xsl:if>
				<xsl:if test="asmResource/issue"><xsl:text>, </xsl:text><xsl:value-of select="$issue"/><xsl:text> </xsl:text><xsl:value-of select="asmResource/issue"/></xsl:if>
				<xsl:if test="asmResource/pages"><xsl:text>, p. </xsl:text><xsl:value-of select="asmResource/pages"/></xsl:if>
				<xsl:text>.</xsl:text>
			</xsl:when>
			<xsl:when test="asmResource/resourceType='book' or asmResource/resourceType='report'">
				<xsl:apply-templates select="asmResource/author"/>
				<xsl:if test="asmResource/year"><xsl:text> (</xsl:text><xsl:value-of select="asmResource/year"/><xsl:text>)</xsl:text></xsl:if>
				<xsl:text>. &lt;i></xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i></xsl:text>
				<xsl:if test="asmResource/publicationLocation"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/publicationLocation"/></xsl:if>
				<xsl:if test="asmResource/publisher"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/publisher"/></xsl:if>
				<xsl:text>.</xsl:text>
			</xsl:when>
			<xsl:when test="asmResource/resourceType='chapter'">
				<xsl:apply-templates select="asmResource/author"/>
				<xsl:if test="asmResource/year"><xsl:text> (</xsl:text><xsl:value-of select="asmResource/year"/><xsl:text>)</xsl:text></xsl:if>
				<xsl:text>. «</xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>»</xsl:text>
				<xsl:if test="asmResource/journal"><xsl:text>, &lt;i></xsl:text><xsl:value-of select="asmResource/journal"/><xsl:text>&lt;/i></xsl:text></xsl:if>
				<xsl:if test="asmResource/edition"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/edition"/><xsl:text> </xsl:text><xsl:value-of select="$edition"/></xsl:if>
				<xsl:if test="asmResource/publicationLocation"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/publicationLocation"/></xsl:if>
				<xsl:if test="asmResource/publisher"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/publisher"/></xsl:if>
				<xsl:if test="asmResource/startPage and asmResource/endPage"><xsl:text>, p. </xsl:text><xsl:value-of select="asmResource/startPage"/><xsl:text>-</xsl:text><xsl:value-of select="asmResource/endPage"/></xsl:if>				
				<xsl:text>.</xsl:text>
			</xsl:when>
			<xsl:when test="asmResource/resourceType='thesis'">
				<xsl:apply-templates select="asmResource/author"/>
				<xsl:if test="asmResource/year"><xsl:text> (</xsl:text><xsl:value-of select="asmResource/year"/><xsl:text>)</xsl:text></xsl:if>
				<xsl:text>. &lt;i></xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i></xsl:text>
				<xsl:if test="asmResource/documentType"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/documentType"/></xsl:if>
				<xsl:if test="asmResource/publicationLocation"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/publicationLocation"/></xsl:if>
				<xsl:if test="asmResource/university"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/university"/></xsl:if>
				<xsl:if test="asmResource/pages"><xsl:text>, p. </xsl:text><xsl:value-of select="asmResource/pages"/></xsl:if>
				<xsl:text>.</xsl:text>
			</xsl:when>
			<xsl:when test="asmResource/resourceType='electronic'">
				<xsl:apply-templates select="asmResource/author"/>
				<xsl:if test="asmResource/year"><xsl:text> (</xsl:text><xsl:value-of select="asmResource/year"/><xsl:text>)</xsl:text></xsl:if>
				<xsl:text>. &lt;i></xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i></xsl:text>
				<xsl:if test="asmResource/journal"><xsl:text>, </xsl:text><xsl:value-of select="asmResource/journal"/></xsl:if>
				<xsl:if test="asmResource/dateRetrieved"><xsl:text>. </xsl:text><xsl:value-of select="$retrievedOn"/><xsl:value-of select="asmResource/dateRetrieved"/></xsl:if>
				<xsl:text>.</xsl:text>
			</xsl:when>
			<xsl:when test="asmResource/resourceType='unknown'">
				<xsl:value-of select="asmResource/title"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="author">
	    <xsl:variable name="author"><xsl:value-of select="."/></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($author, '&amp;')">
				<xsl:value-of select="substring-before($author, ' &amp;')"/><xsl:text>&lt;i> et al. &lt;/i></xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$author"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
