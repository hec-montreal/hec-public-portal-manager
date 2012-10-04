<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	<xsl:template name="createLevel">
			<xsl:choose>
				<xsl:when test="level='mandatory'">
					<obligatoire>
						<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
						vrai
					</obligatoire>
				</xsl:when>
				<xsl:when test="level='complementary'">
				<complementaire>
					<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>				
					vrai
				</complementaire>
				</xsl:when>
			</xsl:choose>
	</xsl:template>		
</xsl:stylesheet>
