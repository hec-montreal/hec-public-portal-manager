<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:template match="asmContext[@xsi:type='ReferenceContext' and ./asmResource[@xsi:type='Document']]">
		<xsl:variable name="docid">
			<xsl:value-of select="asmResource/@id" />			
		</xsl:variable>

		<ressource type="TX_Document">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		

			<libelle>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="label"/>
			</libelle>			
			<description>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="comment"/>
			</description>
			<niveau>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="level"/>
			</niveau>
			<uri>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="asmResource/identifier[@type='uri']"/>
			</uri>
			<type>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>			
				<xsl:value-of select="asmResource/asmResourceType"/>
			</type>
		</ressource>
	</xsl:template>
</xsl:stylesheet>
