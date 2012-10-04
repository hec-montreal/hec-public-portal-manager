<?xml version="1.0"  encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- ========================================= -->
	<!-- =============== Texte =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='RessTexte']">
		<xsl:if test="@securite='0'">
			<p><xsl:value-of disable-output-escaping="yes" select="texte"/></p>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =============== Coordonnées ============= -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='RessStaff']">
		<xsl:if test="@securite='0'">
			<p>
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
			</p>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== TXDocument =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='TX_Document']">
		<xsl:if test="@securite='0'">
			<p>
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
			</p>
		</xsl:if>	
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== TXURL =================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='TX_URL']">
		<xsl:if test="@securite='0'">
			<p>
				<a href="{global/url}"><xsl:value-of select="local/libelle"/></a> <br/>
				<div class="comment">
					<xsl:value-of disable-output-escaping="yes" select="local/description"/>
				</div>
			</p>
		</xsl:if>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Entrée ====================== -->
	<!-- ========================================= -->

	<xsl:template match="ressource[@type='Entree']">
		<div class='ressource2007'>
			<table border ='0' > 
				<tr>
					<td width = "40px"> </td> 
					<td width="49px">
						<xsl:if test="contains(local/coop,'vrai')">
							<img src='../../../portail/img/iconeCoop.gif' alt='Disponible à la COOP HEC'/>
						</xsl:if>
						<xsl:if test="not(contains(local/coop,'vrai'))">
							<p></p> 
						</xsl:if>
					</td> 
					<td width="49px">
						<xsl:if test="contains(local/biblio,'vrai')">
							<img src='../../../portail/images/iconeBiblio.gif' alt='Disponible à la	bibliothèque' />
						</xsl:if>
						<xsl:if test="not(contains(local/biblio,'vrai'))">
							<p></p> 
						</xsl:if>
					</td> 
					<td width="20px">
						<xsl:if test="contains(local/complementaire,'vrai')">
							<img src='../../../portail/images/iconeComp.gif' alt='Complémentaire' />
						</xsl:if>
						<xsl:if test="contains(local/obligatoire,'vrai')  ">
							<img src='../../../portail/images/iconeObl.gif' alt='Obligatoire' />
						</xsl:if>
						<xsl:if	test="not(contains(local/obligatoire,'vrai')) and not(contains(local/complementaire,'vrai'))  ">
							<p></p> 
						</xsl:if>
					</td>

					<td width = "20px" align = 'center'> 
						<img src='../../../portail/images/point.gif' />
					</td> 
					<td width = "700px" align = "left"> 

						<span class='titreRessource'>
							<xsl:value-of disable-output-escaping="yes" select="global/reference"/>
							<!--
						<xsl:call-template name="boutonsVote">
							<xsl:with-param name="koid" select="global/code"/>
							<xsl:with-param name="docid" select="@koid"/>
						</xsl:call-template>
						-->
						</span>
					</td> 
				</tr>

				<tr> 
					<td></td> 
					<td></td> 
					<td></td> 
					<td> </td> 
					<td> </td> 
					<td>
						<div class='contenuRessource'>

							<xsl:apply-templates select="global/isbn" />
							<xsl:apply-templates select="global/description" />
							<xsl:apply-templates select="local/description" />
							<xsl:apply-templates select="global/documents" />

						</div>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<!-- ========================================= -->
	<!-- =========== Commun ====================== -->
	<!-- ========================================= -->

	<xsl:template name="niveau">
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