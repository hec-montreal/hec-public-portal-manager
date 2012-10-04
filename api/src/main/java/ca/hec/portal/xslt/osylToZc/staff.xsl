<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:include href="staffRess.xsl"/>
	
	<xsl:template match="asmStructure[@xsi:type='StaffStruct']">
		<coordonnees>
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:call-template name="createRubric"/>
		</coordonnees >
	</xsl:template>
		
</xsl:stylesheet>
