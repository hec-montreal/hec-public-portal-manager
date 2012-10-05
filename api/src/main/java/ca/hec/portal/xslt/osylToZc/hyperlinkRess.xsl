<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output cdata-section-elements="libelle description"/>

	<xsl:template match="asmContext[@xsi:type='ReferenceContext' and ./asmResource[@xsi:type='URL']]">
		<ressource type="url">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
			<libelle><xsl:value-of select="label"/></libelle>
			<description><xsl:value-of select="comment"/></description>
			<url><xsl:value-of select="asmResource/identifier[@type='uri']"/></url>
			<niveau><xsl:value-of select="level"/></niveau>
		</ressource>
	</xsl:template>
</xsl:stylesheet>
