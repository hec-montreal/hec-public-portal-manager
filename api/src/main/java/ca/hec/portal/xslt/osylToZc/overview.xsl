<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsl xsi">
	
	<xsl:template match="asmStructure[@xsi:type='OverviewStruct']">
		<presentation>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:call-template name="createRubric"/>
		</presentation>
	</xsl:template>
		
</xsl:stylesheet>
