<?xml version="1.0"  encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:java="java">

	<!-- ========================================= -->
	<!-- =============== Texte =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='text']">
		<xsl:if test="@visible='true'">
			<xsl:if test="important">
				<div class="important_header">
					<xsl:value-of select="java:getString($labels,'importantLbl')"/>
				</div>
			</xsl:if>
			<div>
			<xsl:attribute name="class">ressource <xsl:if test="important">important_body</xsl:if></xsl:attribute>
			<table class="ressource">
				<tr>
					<td style="vertical-align:top;">
						<xsl:call-template name="niveau"/>
					</td>
					<td>
						<xsl:value-of disable-output-escaping="yes" select="text"/>
					</td>
				</tr>
			</table>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =============== Coordonnées ============= -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='staff']">
		<xsl:if test="@visible='true'">
			<div class="ressource">
				<xsl:value-of select="prenom"/><xsl:text> </xsl:text><font style="text-transform: uppercase;"><xsl:value-of select="nom"/></font><br/>
				<xsl:if test="role">
					<xsl:value-of select="role"/><br/>
				</xsl:if>
				<xsl:if test="courriel">
					<xsl:value-of disable-output-escaping="yes" select="courriel"/><br/>
				</xsl:if>
				<xsl:if test="telephone">
					<xsl:value-of disable-output-escaping="yes" select="telephone"/><br/>
				</xsl:if>
				<xsl:if test="bureau">
					<xsl:value-of select="java:getString($labels,'bureauLbl')"/><xsl:value-of disable-output-escaping="yes" select="bureau"/><br/>
				</xsl:if>
				<xsl:if test="disponibilite">
					<xsl:value-of select="java:getString($labels,'dispoLbl')"/><xsl:value-of disable-output-escaping="yes" select="disponibilite"/>
				</xsl:if>
				<xsl:value-of disable-output-escaping="yes" select="commentaire"/>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Document =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='document']">
		<xsl:if test="@visible='true'">
			<xsl:if test="important">
				<div class="important_header">
					<xsl:value-of select="java:getString($labels,'importantLbl')"/>
				</div>
			</xsl:if>
			<div>
			<xsl:attribute name="class">ressource <xsl:if test="important">important_body</xsl:if></xsl:attribute>
			<table class="ressource">
				<tr>
					<td style="vertical-align:top;">
						<xsl:call-template name="niveau"/>
					</td>
					<td>
						<a href="/sdata/c{uri}" target="_blank"><xsl:value-of select="libelle"/></a>
						<xsl:call-template name="type"/>
						<xsl:text>(</xsl:text><xsl:call-template name="getFilename"><xsl:with-param name="string"><xsl:value-of select="uri"/></xsl:with-param></xsl:call-template><xsl:text>)</xsl:text>
						<div class="comment">
							<xsl:value-of disable-output-escaping="yes" select="description"/>
						</div>
					</td>
				</tr>
			</table>
			</div>
		</xsl:if>	
	</xsl:template>

	<!-- ========================================= -->
	<!-- ================= Url =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='url']">
		<xsl:if test="@visible='true'">
			<xsl:if test="important">
				<div class="important_header">
					<xsl:value-of select="java:getString($labels,'importantLbl')"/>
				</div>
			</xsl:if>
			<div>
			<xsl:attribute name="class">ressource <xsl:if test="important">important_body</xsl:if></xsl:attribute>

			<table class="ressource">
				<tr>
					<td style="vertical-align:top;">
						<xsl:call-template name="niveau"/>
					</td>
					<td>
						<a href="{url}"><xsl:value-of select="libelle"/></a> <br/>
						<xsl:text>(</xsl:text><xsl:value-of select="url"/><xsl:text>)</xsl:text>
						<div class="comment">
							<xsl:value-of disable-output-escaping="yes" select="description"/>
						</div>
					</td>
				</tr>
			</table>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== References ================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='citation']">
		<xsl:if test="@visible='true'">
			<xsl:if test="important">
				<div class="important_header">
					<xsl:value-of select="java:getString($labels,'importantLbl')"/>
				</div>
			</xsl:if>
			<div>
			<xsl:attribute name="class">ressource <xsl:if test="important">important_body</xsl:if></xsl:attribute>

			<table class="ressource">
				<tr>
					<td style="vertical-align:top;">
						<xsl:call-template name="niveau"/>
					</td>
					<td colspan="2">
						<xsl:value-of disable-output-escaping="yes" select="libelle"/><br/>
						<xsl:if test="isbn!=''"><xsl:value-of select="java:getString($labels,'isbnLbl')"/><xsl:value-of select="isbn"/><br/></xsl:if>
						<xsl:call-template name="type"/>
						<div class="comment"><xsl:value-of disable-output-escaping="yes" select="description"/></div>
					</td>

				</tr>
				<xsl:if test="biblio_url!=''">
					<tr>
						<td></td>
						<td width="1px">
							<img src="../../../portail/images/iconeBiblio.gif"/>
						</td>
						<td>
							<a href="{biblio_url}" target="_blank"><xsl:value-of select="java:getString($labels,'availableLibraryLbl')"/></a><br/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="coop_url!=''">
					<tr>
						<td></td>
						<td>
							<img src="../../../portail/images/iconeCoop.gif"/>
						</td>
						<td>
							<a href="{coop_url}" target="_blank"><xsl:value-of select="java:getString($labels,'availableBookstoreLbl')"/></a><br/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="other_url!=''">
					<tr>
						<td></td>
						<td>
							<img src="../../../portail/images/iconeAutre.gif"/>
						</td>
						<td>
							<a href="{other_url}" target="_blank"><xsl:value-of select="other_url/@libelle"/></a><br/>
						</td>
					</tr>
				</xsl:if>

			</table>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Commun ====================== -->
	<!-- ========================================= -->
	<xsl:template name="type">
		<xsl:if test="type!=''">
			<xsl:variable name="typeLabel">Resource.Type.<xsl:value-of select="type"/></xsl:variable>
			<xsl:text> [</xsl:text><xsl:value-of select="java:getString($labels, $typeLabel)"/><xsl:text>]</xsl:text><br/>
		</xsl:if> 
	</xsl:template>

	<xsl:template name="niveau">
		<xsl:choose>
			<xsl:when test="niveau='mandatory'">
				<div class="icone-niveau">
					<img class="icone-niveau" src="../../../portail/images/mandatory.png">
						<xsl:attribute name="title"><xsl:value-of select="java:getString($labels, 'mandatory')"/></xsl:attribute>
					</img>
				</div>
			</xsl:when>
			<xsl:when test="niveau='recommended'">
				<div class="icone-niveau">
					<img class="icone-niveau" src="../../../portail/images/recommended.png">
						<xsl:attribute name="title"><xsl:value-of select="java:getString($labels, 'recommended')"/></xsl:attribute>
					</img>
				</div>
			</xsl:when>
			<xsl:when test="niveau='complementary'">
				<div class="icone-niveau">
					<img class="icone-niveau" src="../../../portail/images/complementary.png">
						<xsl:attribute name="title"><xsl:value-of select="java:getString($labels, 'complementary')"/></xsl:attribute>
					</img>
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- remove ".00" in the course id -->
	<xsl:template name="sigle">
		<xsl:choose>
			<xsl:when test="substring-after(substring-after(planCours/cours/id, '.'), '.')='00'">
				<xsl:value-of select="substring-before(planCours/cours/id, '.')"/>
				<xsl:text>.</xsl:text>
				<xsl:value-of select="substring-before(substring-after(planCours/cours/id, '.'), '.')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="planCours/cours/id"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- recursive function to get the filename from a uri -->
	<xsl:template name="getFilename">
		<xsl:param name="string"/>	
		<xsl:choose>
			<xsl:when test="contains($string, '/')">
				<xsl:call-template name="getFilename">
					<xsl:with-param name="string" select="substring-after($string, '/')" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>