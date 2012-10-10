<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output cdata-section-elements="text"/>

	<xsl:template match="asmContext[@xsi:type='InformationContext' and ./asmResource[@xsi:type='Text']]">
		<ressource type="text">
			<xsl:attribute name="visible"><xsl:call-template name="visible" /></xsl:attribute>
			<xsl:call-template name="important"/>
			<niveau><xsl:value-of select="level"/></niveau>
			<text><xsl:value-of select="asmResource/text"/></text>
		</ressource>
	</xsl:template>

</xsl:stylesheet>