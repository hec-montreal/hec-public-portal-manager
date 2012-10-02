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
<!-- =========== Document =================== -->
<!-- ========================================= -->

<xsl:template match="ressource[@type='Document']">
	&lt;div class='ressource2007'>
	&lt;table border ='0' > 
		&lt;tr>
		&lt;td width = "40px"> &lt;/td> 
			&lt;td width="49px">
				<xsl:if test="contains(local/coop,'vrai')">
					&lt;img src='img/iconeCoop.gif' alt='Disponible à la COOP HEC'/>
				</xsl:if>
				<xsl:if test="not(contains(local/coop,'vrai'))">
					&lt;p>&lt;/p> 
				</xsl:if>
			&lt;/td> 
			&lt;td width="49px">
				<xsl:if test="contains(local/biblio,'vrai')">
					&lt;img src='img/iconeBiblio.gif' alt='Disponible à la	bibliothèque' />
				</xsl:if>
				<xsl:if test="not(contains(local/biblio,'vrai'))">
					&lt;p>&lt;/p> 
				</xsl:if>
			&lt;/td> 
			&lt;td width="20px">
				<xsl:if test="contains(local/complementaire,'vrai')">
					&lt;img src='img/iconeComp.gif' alt='Complémentaire' />
				</xsl:if>
				<xsl:if test="contains(local/obligatoire,'vrai')  ">
					&lt;img src='img/iconeObl.gif' alt='Obligatoire' />
				</xsl:if>
				<xsl:if	test="not(contains(local/obligatoire,'vrai')) and not(contains(local/complementaire,'vrai'))  ">
					&lt;p>&lt;/p> 
				</xsl:if>
			&lt;/td>
			
			&lt;td width = "20px" align = 'center'> 
					&lt;img src='img/point.gif' />
			&lt;/td> 
			&lt;td width = "700px" align = "left"> 
			
				&lt;span class='titreRessource'>
<!--				
					<xsl:if test="contains(global/url,'http://') or contains(global/url,'ftp://')">
						&lt;a href='<xsl:value-of select="global/url"/>' target='_blank'>
					</xsl:if>
					<xsl:if test="not(contains(global/url,'http://')) and not(contains(global/url,'ftp://'))">
						&lt;a href='documents/<xsl:value-of select="@koId"/>.<xsl:value-of select="substring-after(substring-after(global/url,'/'),'/')"/>' target='_blank'>
					</xsl:if>
-->
						<xsl:value-of select="local/libelle"/>
<!--
						&lt;/a>
-->						
<!--
						<xsl:call-template name="boutonsVote">
							<xsl:with-param name="koid" select="global/code"/>
							<xsl:with-param name="docid" select="@koid"/>
						</xsl:call-template>
	-->					
				&lt;/span>&lt;!-- titreRessource -->
				<!-- 
				<xsl:call-template name="boutonsVote">
						<xsl:with-param name="koid" select="@koId"/>
				</xsl:call-template>
 				-->
			&lt;/td> 
		&lt;/tr>

		&lt;tr> 
			&lt;td>&lt;/td> 
			&lt;td>&lt;/td> 
			&lt;td>&lt;/td> 
			&lt;td> &lt;/td> 
			&lt;td> &lt;/td> 
			&lt;td>
				&lt;div class='contenuRessource'>
					<xsl:apply-templates select="local/description" />
					<xsl:apply-templates select="global/description" />
				&lt;/div><!-- contenuRessource -->
			&lt;/td>
			&lt;/tr>
		&lt;/table>
	&lt;/div><!-- div ressource -->
</xsl:template>

<!-- ========================================= -->
<!-- =========== TXDocument =================== -->
<!-- ========================================= -->

<xsl:template match="ressource[@type='TX_Document']">
<!--	<xsl:if test="securite='0'"> -->
		
		<h5><xsl:value-of select="global/libelle"/></h5>
		<p><xsl:value-of disable-output-escaping="yes" select="global/description"/></p>
<!--	</xsl:if> -->
	<!--
	<div class='ressource2007'>
	<table border ='0' > 
		<tr>
			<td width = "40px"> </td> 
			<td width="49px">
				<xsl:if test="contains(local/coop,'vrai')">
					<img src='img/iconeCoop.gif' alt='Disponible à la COOP HEC'/>
				</xsl:if>
				<xsl:if test="not(contains(local/coop,'vrai'))">
					<p></p> 
				</xsl:if>
			</td>  
			<td width="49px">
				<xsl:if test="contains(local/biblio,'vrai')">
					<img src='img/iconeBiblio.gif' alt='Disponible à la	bibliothèque' />
				</xsl:if>
				<xsl:if test="not(contains(local/biblio,'vrai'))">
					<p></p> 
				</xsl:if>
			</td> 
			<td width="20px">
				<xsl:if test="contains(local/complementaire,'vrai')">
					<img src='img/iconeComp.gif' alt='Complémentaire' />
				</xsl:if>
				<xsl:if test="contains(local/obligatoire,'vrai')  ">
					<img src='img/iconeObl.gif' alt='Obligatoire' />
				</xsl:if>
				<xsl:if	test="not(contains(local/obligatoire,'vrai')) and not(contains(local/complementaire,'vrai'))  ">
					<p></p> 
				</xsl:if>
			</td>
			
			<td width = "20px" align = 'center'> 
					<img src='img/point.gif' />
			</td> 
			<td  align = "left"> 
			
					<span class='titreRessource'>
						<xsl:value-of select="local/libelle" />

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
					<xsl:apply-templates select="local/description" />
					<xsl:apply-templates select="global/description" />
				</div>
			</td>
		</tr>
	</table>
	</div>
	-->
</xsl:template>

<!-- ========================================= -->
<!-- =========== TXURL =================== -->
<!-- ========================================= -->

<xsl:template match="ressource[@type='TX_URL']">
	<xsl:if test="@securite='0'">
		<p>
			<a href="{global/url}"><xsl:value-of select="local/libelle"/></a>
		</p>	
	</xsl:if>
</xsl:template>

</xsl:stylesheet>