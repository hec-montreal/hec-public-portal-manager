<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output cdata-section-elements="reference"/>
	
	<xsl:template match="asmContext[@xsi:type='BiblioContext']">
		<ressource type="Entree" koId="334343">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:call-template name="createLocalCitation"/>
			<xsl:call-template name="createGlobalCitation"/>
		</ressource>
	</xsl:template>
	
	<xsl:template name="createLocalCitation">
		<local>
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<code>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
			</code>
			<libelle>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
			</libelle>
			<xsl:call-template name="createLevel"/>
			<xsl:choose>
				<xsl:when test="asmResource/identifier[@type='library']">
					<biblio>
						<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
						vrai
					</biblio>
				</xsl:when>
				<xsl:when test="asmResource/identifier[@type='bookstore']">
					<coop>
						<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
						vrai
					</coop>
				</xsl:when>
			</xsl:choose>
		</local>
	</xsl:template>		
	
	<xsl:template name="createGlobalCitation">
		<global>
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:call-template name="createReferenceCitation"/>
			<description>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="comment"/>
			</description>
			<xsl:if test="asmResource/identifier[@type='isn']">
				<isbn>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
				<xsl:value-of select="asmResource/identifier[@type='isn']"/>
				</isbn>
			</xsl:if>
		</global>
	</xsl:template>	
	
	<xsl:template name="createReferenceCitation">
		<reference>
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:choose>
				<xsl:when test="asmResource/identifier[@type='library'] or asmResource/identifier[@type='bookstore'] or asmResource/identifier[@type='other_link']">
					<xsl:call-template name="createLinkReference"/>
				</xsl:when>
				<xsl:otherwise><xsl:call-template name="formatCitation"/></xsl:otherwise>
			</xsl:choose>
		</reference>
	</xsl:template>
	
	<xsl:template name="createLinkReference">
		<!-- hack for display <a> in CData section -->
		<xsl:text disable-output-escaping="yes">
				&lt;a href="
			</xsl:text>
			<xsl:choose>
				<xsl:when test="asmResource/identifier[@type='library']">
					<xsl:value-of select="asmResource/identifier[@type='library']"/>
				</xsl:when>
				<xsl:when test="asmResource/identifier[@type='bookstore']">
					<xsl:value-of select="asmResource/identifier[@type='bookstore']"/>
				</xsl:when>
				<xsl:when test="asmResource/identifier[@type='other_link']">
					<xsl:value-of select="asmResource/identifier[@type='other_link']"/>
				</xsl:when>
			</xsl:choose>
			<xsl:text disable-output-escaping="yes">
				"&gt;
			</xsl:text>
			<xsl:call-template name="formatCitation"/>
			<xsl:text disable-output-escaping="yes">
				&lt;/a&gt;
			</xsl:text>
	</xsl:template>
	
	<xsl:template name="formatCitation">
			<xsl:if test="asmResource/resourceType='book'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i&gt;</xsl:text>, <xsl:value-of select="asmResource/publisher"/>, <xsl:value-of select="asmResource/publicationLocation"/>.</xsl:if>
			<xsl:if test="asmResource/resourceType='article'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). «<xsl:value-of select="asmResource/title"/> », <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/journal"/> <xsl:text>&lt;/i&gt;</xsl:text>, vol.<xsl:value-of select="asmResource/volume"/> , no.<xsl:value-of select="asmResource/issue"/> , p.<xsl:value-of select="asmResource/pages"/> .</xsl:if>
			<xsl:if test="asmResource/resourceType='report'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/title"/><xsl:text>&lt;/i&gt;</xsl:text>, <xsl:value-of select="asmResource/publisher"/>, <xsl:value-of select="asmResource/publicationLocation"/>.</xsl:if>
			<xsl:if test="asmResource/resourceType='proceed'"><xsl:value-of select="asmResource/author"/> (<xsl:value-of select="asmResource/year"/>). «<xsl:value-of select="asmResource/title"/> », <xsl:text>&lt;i&gt;</xsl:text><xsl:value-of select="asmResource/journal"/> <xsl:text>&lt;/i&gt;</xsl:text>, vol.<xsl:value-of select="asmResource/volume"/> , no.<xsl:value-of select="asmResource/issue"/> , p.<xsl:value-of select="asmResource/pages"/></xsl:if>
			<xsl:if test="asmResource/resourceType='unknown'"><xsl:value-of select="asmResource/title"/></xsl:if>
	</xsl:template>

</xsl:stylesheet>
