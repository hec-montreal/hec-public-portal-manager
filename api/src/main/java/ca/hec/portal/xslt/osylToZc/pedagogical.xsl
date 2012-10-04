<?xml version="1.0" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<!-- we are interessted only on the 1st asmStructure of type 'Pedagogical 'ignore all nested asmStructure-->
	<xsl:template match="asmStructure[@xsi:type='PedagogicalStruct' and not(../../asmStructure)]">
		<seances>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:apply-templates select="*"/>
		</seances>
	</xsl:template>
		
	<!-- the nested PedagogicalStructs are groups of seances -->
	<xsl:template match="asmStructure[@xsi:type='PedagogicalStruct' and ../../asmStructure]">
		<group>
			<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>
			<libelle><xsl:value-of select="label"/></libelle>
			<description><xsl:value-of select="description"/></description>
			<xsl:apply-templates select="*"/>
		</group>
	</xsl:template>
		
	<xsl:template match="asmUnit[@xsi:type='Lecture']">
		<seance type="Seance" coursType="specifique">
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:call-template name="createSeanceContent"/>
		</seance>
	</xsl:template>	
	
	<xsl:template match="asmUnit[@xsi:type='WorkSession']">
		<seance type="TP" coursType="specifique">
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:call-template name="createSeanceContent"/>
		</seance>
	</xsl:template>	
	
	<xsl:template name="createSeanceContent">
		<xsl:variable name="no">
			<xsl:choose>
				<xsl:when test="prefix"><xsl:value-of select="prefix"/></xsl:when>
				<xsl:otherwise><xsl:call-template name="numbering"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:attribute name="no"><xsl:value-of select="$no"/></xsl:attribute>
		<xsl:attribute name="koId"><xsl:call-template name="getCoursekoIdentifier"/>.<xsl:call-template name="prefixNumber"/><xsl:value-of select="$no"/></xsl:attribute>
		<no>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:value-of select="$no"/>
		</no>
		<libelle>
				<xsl:attribute name="securite"><xsl:call-template name="securite" /></xsl:attribute>		
			<xsl:value-of select="label"/>
		</libelle>
		<xsl:call-template name="createRubric"/>
	</xsl:template>	
			
	<!-- count all preceding lecture and worksession and add 1 to obtain lecture number -->	
	<xsl:template name="numbering">
	<xsl:variable name="t"><xsl:value-of select="./@xsi:type"/></xsl:variable>
	<xsl:value-of select="count(preceding::asmUnit[@xsi:type=$t]) + 1"/>
	</xsl:template>	
	
	<xsl:template name="prefixNumber">
		<xsl:variable name="t"><xsl:value-of select="./@xsi:type"/></xsl:variable>
		<xsl:variable name="pref">
			<xsl:choose>
				<xsl:when test=" $t= 'Lecture' ">S</xsl:when>
				<xsl:when test=" $t= 'WorkSession' ">TP</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$pref"/>
	</xsl:template>
			
</xsl:stylesheet>
