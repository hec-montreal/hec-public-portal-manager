<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:template match="asmContext[@xsi:type='ReferenceContext' and ./asmResource[@xsi:type='Document']]">
		<ressource type="document">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<libelle><xsl:value-of select="label"/></libelle>			
			<description><xsl:value-of select="comment"/></description>
			<niveau><xsl:value-of select="level"/></niveau>
			<uri><xsl:value-of select="asmResource/identifier[@type='uri']"/></uri>
			<type><xsl:value-of select="asmResource/asmResourceType"/></type>
		</ressource>
	</xsl:template>
</xsl:stylesheet>
