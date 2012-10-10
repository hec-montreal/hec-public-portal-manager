<?xml version="1.0" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<!-- we are interessted only on the 1st asmStructure of type 'Pedagogical 'ignore all nested asmStructure-->
	<xsl:template match="asmStructure[@xsi:type='PedagogicalStruct' and not(../../asmStructure)]">
		<seances>
			<xsl:apply-templates select="*"/>
		</seances>
	</xsl:template>
		
	<!-- the nested PedagogicalStructs are groups of seances -->
	<xsl:template match="asmStructure[@xsi:type='PedagogicalStruct' and ../../asmStructure]">
		<group>
			<libelle><xsl:value-of select="label"/></libelle>
			<description><xsl:value-of select="description"/></description>
			<xsl:apply-templates select="*"/>
		</group>
	</xsl:template>
		
	<xsl:template match="asmUnit[@xsi:type='Lecture']">
		<seance type="Seance">
			<xsl:call-template name="createSeanceContent"/>
		</seance>
	</xsl:template>	
	
	<xsl:template match="asmUnit[@xsi:type='WorkSession']">
		<seance type="TP">
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
		<no><xsl:value-of select="$no"/></no>
		<libelle><xsl:value-of select="label"/></libelle>
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
