<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<!-- we are interessted only on the 1st asmStructure of type 'AssessmentStruct 'ignore all nested asmStructure-->
	<xsl:template match="asmStructure[@xsi:type='AssessmentStruct' and not(../../asmStructure)]">
		<evaluations>
			<xsl:apply-templates select="*"/>
		</evaluations>
	</xsl:template>
		
	<xsl:template match="asmUnit[@xsi:type='AssessmentUnit']">
		<evaluation>
				<libelle><xsl:value-of select="label"/></libelle>
				<valeur><xsl:value-of select="weight"/></valeur>
				<lieu><xsl:value-of select="location"/></lieu>
				<modalite><xsl:value-of select="modality"/></modalite>
				<mode><xsl:value-of select="mode"/></mode>
				<type><xsl:value-of select="assessmentType"/></type>
				<remise><xsl:value-of select="submition_type"/></remise>
				<xsl:call-template name="createDateEvaluation"/>
				<xsl:call-template name="createRubric"/>
		</evaluation>
	</xsl:template>	

	<!-- create date from osyl format (ie. 2010-06-15T14:16:34-04:00) to zc format (ie: 2010-06-15)-->
	<xsl:template name="createDateEvaluation">
		<xsl:variable name="d"><xsl:value-of select="date-end"/></xsl:variable>
		<xsl:if test="$d!=''">
			<date>
				<xsl:value-of select="substring($d,0,11)"/>
			</date>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
