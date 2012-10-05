<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output cdata-section-elements="disponibilite commentaire courriel"/>
	
	<xsl:template match="asmContext[@xsi:type='PeopleContext']">
		<ressource type="staff">
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
			
			<nom><xsl:value-of select="Person/surname"/></nom>
			<prenom><xsl:value-of select="Person/firstname"/></prenom>
			<xsl:if test="Person/title!=''">
				<role><xsl:value-of select="Person/title"/></role>
			</xsl:if>
			<xsl:if test="Person/officeroom!=''">
				<bureau><xsl:value-of select="Person/officeroom"/></bureau>
			</xsl:if>
			<xsl:if test="Person/email!=''">
				<courriel>
					<!-- hack for display <a> in CData section -->
					<xsl:text disable-output-escaping="no">
						&lt;a href="mailto:
					</xsl:text>
					<xsl:value-of select="Person/email"/>
					<xsl:text disable-output-escaping="no">
						"&gt;
					</xsl:text>
					<xsl:value-of select="Person/email"/>
					<xsl:text disable-output-escaping="no">
						&lt;/a&gt;
					</xsl:text>
				</courriel>
			</xsl:if>
			<xsl:if test="Person/tel!=''">
				<telephone><xsl:value-of select="Person/tel"/></telephone>
			</xsl:if>
			<xsl:if test="availability!='' and availability!='&lt;br&gt;'">
				<disponibilite><xsl:value-of select="availability"/></disponibilite>
			</xsl:if>
			<xsl:if test="comment!='' and comment!='&lt;br&gt;'">
				<commentaire><xsl:value-of select="comment"/></commentaire>
			</xsl:if>
		</ressource>
	</xsl:template>
</xsl:stylesheet>
