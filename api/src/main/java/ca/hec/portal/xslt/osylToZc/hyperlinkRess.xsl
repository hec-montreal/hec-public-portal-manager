<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output cdata-section-elements="libelle description"/>

	<xsl:template match="asmContext[@xsi:type='ReferenceContext' and ./asmResource[@xsi:type='URL']]">
		<ressource type="TX_URL" koId="">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>							
			<xsl:call-template name="createLocalHyperlink"/>
			<xsl:call-template name="createGlobalHyperlink"/>
		</ressource>
	</xsl:template>

	<xsl:template name="createLocalHyperlink">
		<local>
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>							
			<libelle>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>								
				<xsl:value-of select="label"/>
			</libelle>
			<description>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>								
				<xsl:value-of select="comment"/>
			</description>
			<xsl:call-template name="createLevel"/>
		</local>
	</xsl:template>

	<xsl:template name="createGlobalHyperlink">
		<global>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>							
			<url>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>								
				<xsl:value-of select="asmResource/identifier[@type='uri']"/>
			</url>
		</global>
	</xsl:template>

</xsl:stylesheet>
