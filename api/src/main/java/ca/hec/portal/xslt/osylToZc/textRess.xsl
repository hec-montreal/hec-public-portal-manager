<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<!--                                                     -->
	<xsl:output cdata-section-elements="texte"/>
	<!--                                                     -->
	<xsl:template match="asmContext[@xsi:type='InformationContext' and ./asmResource[@xsi:type='Text']]">
		<ressource type="RessTexte" koId="">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
			<texte>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="asmResource/text"/>
			</texte>
		</ressource>
	</xsl:template>

</xsl:stylesheet>