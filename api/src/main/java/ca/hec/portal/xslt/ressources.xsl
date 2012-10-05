<?xml version="1.0"  encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- ========================================= -->
	<!-- =============== Texte =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='text']">
		<xsl:if test="@securite='0'">
			<div class="ressource text">
			<xsl:call-template name="niveau"/>
			<div><xsl:value-of disable-output-escaping="yes" select="text"/></div>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =============== Coordonnées ============= -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='staff']">
		<xsl:if test="@securite='0'">
			<div class="ressource staff">
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
					<xsl:value-of select="$labels//label[@id='bureauLbl']"/><xsl:value-of disable-output-escaping="yes" select="bureau"/><br/>
				</xsl:if>
				<xsl:if test="disponibilite">
					<xsl:value-of select="$labels//label[@id='dispoLbl']"/><xsl:value-of disable-output-escaping="yes" select="disponibilite"/>
				</xsl:if>
				<xsl:value-of disable-output-escaping="yes" select="commentaire"/>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== TXDocument =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='document']">
		<xsl:if test="@securite='0'">
			<div class="ressource doc">
				<xsl:call-template name="niveau"/>
				<a href="/sdata/c{uri}" target="_blank"><xsl:value-of select="libelle"/></a>
				<xsl:if test="type!=''">
					<xsl:text> [</xsl:text>
					<font style="text-transform: capitalize;"><xsl:value-of select="type"/></font>
					<xsl:text>]</xsl:text>
				</xsl:if> <br/>
				<xsl:text>(</xsl:text><xsl:call-template name="getFilename"><xsl:with-param name="string"><xsl:value-of select="uri"/></xsl:with-param></xsl:call-template><xsl:text>)</xsl:text>
				<div class="comment">
					<xsl:value-of disable-output-escaping="yes" select="description"/>
				</div>
			</div>
		</xsl:if>	
	</xsl:template>

	<!-- ========================================= -->
	<!-- ================= Url =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='url']">
		<xsl:if test="@securite='0'">
			<div class="ressource url">
				<xsl:call-template name="niveau"/>
				<a href="{url}"><xsl:value-of select="libelle"/></a> <br/>
				<xsl:text>(</xsl:text><xsl:value-of select="url"/><xsl:text>)</xsl:text>
				<div class="comment">
					<xsl:value-of disable-output-escaping="yes" select="description"/>
				</div>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== References ================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='citation']">
		<xsl:if test="@securite='0'">
			<div class="ressource reference">
				<xsl:call-template name="niveau"/>
				<xsl:value-of disable-output-escaping="yes" select="libelle"/><br/>
				<xsl:if test="isbn"><xsl:value-of select="$labels//label[@id='isbnLbl']"/><xsl:value-of select="isbn"/></xsl:if>
				<div class="comment"><xsl:value-of disable-output-escaping="yes" select="description"/></div>
				<xsl:if test="biblio_url!=''">
					<img src="../../../portail/images/iconeBiblio.gif"/>
					<a href="{biblio_url}" target="_blank"><xsl:value-of select="$labels//label[@id='availableLibraryLbl']"/></a><br/>
				</xsl:if>
				<xsl:if test="coop_url!=''">
					<img src="../../../portail/images/iconeCoop.gif"/>
					<a href="{coop_url}" target="_blank"><xsl:value-of select="$labels//label[@id='availableBookstoreLbl']"/></a><br/>
				</xsl:if>
				<xsl:if test="other_url!=''">
					<img src="../../../portail/images/iconeAutre.gif"/>
					<a href="{other_url}" target="_blank"><xsl:value-of select="other_url[@libelle]"/></a><br/>
				</xsl:if>
				
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Commun ====================== -->
	<!-- ========================================= -->

	<xsl:template name="niveau">
		<div class="level-icon">
		<xsl:choose>
			<xsl:when test="niveau='mandatory'">
				<img src="../../../portail/images/mandatory.png"/>
			</xsl:when>
			<xsl:when test="niveau='recommended'">
				<img src="../../../portail/images/recommended.png"/>
			</xsl:when>
			<xsl:when test="niveau='complementary'">
				<img src="../../../portail/images/complementary.png"/>
			</xsl:when>
		</xsl:choose>
		</div>
	</xsl:template>

	<!-- template for formatting course id -->
	<xsl:template name="sigle">
		<xsl:choose>
			<xsl:when test="contains(/planCours/cours/no,'A')">
				<xsl:value-of select="/planCours/cours/no"/>
			</xsl:when>
			<xsl:when test="contains(/planCours/cours/no,'E')">
				<xsl:value-of select="/planCours/cours/no"/>
			</xsl:when>
			<xsl:when test="contains(/planCours/cours/no,'I')">
				<xsl:value-of select="/planCours/cours/no"/>
			</xsl:when>
			<xsl:when test="contains(/planCours/cours/no,'O')">
				<xsl:value-of select="/planCours/cours/no"/>
			</xsl:when>
			<xsl:when test="contains(/planCours/cours/no,'U')">
				<xsl:value-of select="/planCours/cours/no"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring(/planCours/cours/no,0,string-length(/planCours/cours/no)-4)"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="substring(/planCours/cours/no,string-length(/planCours/cours/no)-4,3)"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="substring(/planCours/cours/no,string-length(/planCours/cours/no)-1,2)"/>
				<xsl:text>.</xsl:text>
				<xsl:value-of select="planCours/cours/session/libelle"/>
				<xsl:if test="not(planCours/cours/section/no = '00')">
					<xsl:text>.</xsl:text><xsl:value-of select="planCours/cours/session/libelle"/>
				</xsl:if>	
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