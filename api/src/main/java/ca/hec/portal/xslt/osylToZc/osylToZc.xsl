<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsl xsi">
	<xsl:output method="xml" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

	<xsl:include href="rubric.xsl"/>
	<xsl:include href="overview.xsl"/>
	<xsl:include href="staff.xsl"/>
	<xsl:include href="evaluation.xsl"/>
	<xsl:include href="pedagogical.xsl"/>
	<xsl:include href="learningMaterial.xsl"/>

	<xsl:variable name="cid_global" select="/OSYL/CO/courseId[@type='HEC']"/>
	
	<xsl:template match="/OSYL/CO">
		<planCours>
			<xsl:attribute name="lang">
				<xsl:choose>
					<xsl:when test="language='FR-CA'">fr</xsl:when>
					<xsl:when test="language='ES'">es</xsl:when>
					<xsl:otherwise>en</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<cours>
				<id>
					<xsl:value-of select="courseId[@type='HEC']"/>
				</id>
				<no>
					<xsl:call-template name="getCourseIdentifier"/>
				</no>
				<libelle>
					<xsl:value-of select="title[@type='HEC']"/>
				</libelle>
				<service>
					<xsl:value-of select="department[@type='HEC']"/>
				</service>
				<session>
					<no>
						<xsl:call-template name="getCodeSession"/>.<xsl:call-template name="getPeriode"/>
					</no>
					<libelle>
						<xsl:call-template name="getSession"/>
					</libelle>
				</session>
				<section>
					<no>
						<xsl:call-template name="getSection"/>
					</no>
				</section>
			</cours>
			<xsl:apply-templates select="*"/>
		</planCours>
	</xsl:template>

	<xsl:template name="getSession">
		<xsl:value-of select="substring-before(substring-after($cid_global,'.'),'.')"/>
	</xsl:template>
	
	<xsl:template name="getCodeSession">
		<xsl:variable name="sess"><xsl:call-template name="getSession"/></xsl:variable>
		<xsl:value-of select="substring($sess,2,1)"/><xsl:value-of select="substring($sess,4,2)"/>
		<xsl:choose>
			<xsl:when test="substring($sess,1,1)='H'">1</xsl:when>
			<xsl:when test="substring($sess,1,1)='E'">2</xsl:when>
			<xsl:when test="substring($sess,1,1)='A'">3</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="getSection">
		<xsl:choose>
			<xsl:when test="contains(substring-after(substring-after($cid_global,'.'),'.'),'.')">
				<xsl:value-of select="substring-after(substring-after(substring-after($cid_global,'.'),'.'),'.')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring-after(substring-after($cid_global,'.'),'.')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="getPeriode">
			<xsl:choose>
			<xsl:when test="contains(substring-after(substring-after($cid_global,'.'),'.'),'.')">
				<xsl:value-of select="substring-before(substring-after(substring-after($cid_global,'.'),'.'),'.')"/>
			</xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="getCourseIdentifier">
		<xsl:call-template name="cleanCourseIdentifier">
			<xsl:with-param name="cid" select="substring-before($cid_global,'.')"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="cleanCourseIdentifier">
		<xsl:param name="cid"/>
		<xsl:choose>
			<xsl:when test="contains($cid,'-')">
				<xsl:value-of select="substring-before($cid,'-')"/>
				<xsl:call-template name="cleanCourseIdentifier">
					<xsl:with-param name="cid" select="substring-after($cid,'-')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$cid"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="text()"/>	

	<xsl:template name="important" match="importance">
		<xsl:if test="importance='true'">
			<important/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="visible">
		<xsl:choose>
			<xsl:when test="@access='public' and visible='true'">true</xsl:when>
			<xsl:when test="@access='public' and not(visible)">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	
</xsl:stylesheet>
