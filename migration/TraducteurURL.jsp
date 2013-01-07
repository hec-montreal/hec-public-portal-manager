<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Traducteur URL zc1 - zc2</title>
</head>

<%!
String zc2Server = "http://zonecours2.hec.ca/portail/";

String annuaire1 = "http://zonecours.hec.ca/d";

String annuaire2 = "http://zonecours.hec.ca/af1Presentation.txp?instId=a-";

String repertoire = "http://zonecours.hec.ca/accueil.txp?";

%>

<%
String urlZc2 = "";

String urlZc1 = "";

if (request.getParameter("url") != null) {
    
    urlZc1 = request.getParameter("url");
    
    if(urlZc1.startsWith(annuaire1)){
		urlZc2 = convertAnnuaire1(urlZc1);
    }
    else if(urlZc1.startsWith(annuaire2)){
		urlZc2 = convertAnnuaire2(urlZc1);
    }
    else if(urlZc1.startsWith(repertoire)){
		urlZc2 = convertRepertoire(urlZc1);
    }
    else{
	  urlZc2 = "Je suis incapable de convertir votre url";
    }
}
%>



<%!

private String convertAnnuaire1(String urlZc1){
    
    String zc2 = "";
    
    String courseId = urlZc1.substring(annuaire1.length());
    
    courseId = courseId.substring(0, courseId.indexOf(".html"));
    
    zc2 = zc2Server+"?FR#cours="+formatCourseId(courseId);
    
    return zc2;
}


private String convertAnnuaire2(String urlZc1){
    
    String zc2 = "";
    
    String courseId = urlZc1.substring(annuaire2.length());
    String lang = "";
    
    if(courseId.indexOf("&")!=-1){
        courseId = courseId.substring(0, courseId.indexOf("&"));
    }
           
  	if(urlZc1.indexOf("lang=")!=-1) {
        lang = urlZc1.substring(urlZc1.indexOf("lang=")+5);
		if (lang.indexOf("&")!=-1) {
			lang = lang.substring(0, lang.indexOf("&"));
		}
    }

    zc2 = zc2Server;
    if(lang.toLowerCase().equals("en")) {
        zc2 += "?EN";
    } else {
		zc2 += "?FR";
	}

    zc2 += "#cours="+formatCourseId(courseId);
    
    return zc2;
}


private String convertRepertoire(String urlZc1){
    
    String zc2 = "Je suis incapable de convertir votre url";
    
    String t = "";
    String v = "";
	String lang = "";
    
    if(urlZc1.indexOf("t=")!=-1){
		
		t = urlZc1.substring(urlZc1.indexOf("t=")+2);
		
		if(t.indexOf("&")!=-1){
		    t = t.substring(0, t.indexOf("&"));
		}	
    }
    
    if(urlZc1.indexOf("v=")!=-1){
	
		v = urlZc1.substring(urlZc1.indexOf("v=")+2);
		
		if(v.indexOf("&")!=-1){
		    v = v.substring(0, v.indexOf("&"));
		}	
    }
  
  	if(urlZc1.indexOf("lang=")!=-1) {

		lang = urlZc1.substring(urlZc1.indexOf("lang=")+5);

		if (lang.indexOf("&")!=-1) {
			lang = lang.substring(0, lang.indexOf("&"));
		}
    }
    
	zc2 = zc2Server;
	if(lang.toLowerCase().equals("en")) {
		zc2 += "?EN";
	} else {
		zc2 += "?FR";
	}
	
    if(t.equals("programme")){
		zc2 += "#programme="+v;
	
    }
    else if(t.equals("service")){
		zc2 += "#discipline="+v;
	
    }

    return zc2;
}


private String formatCourseId(String courseId) {
	
	String cheminement;
	String numero;
	String annee;
	String formattedCourseId;
	
	if (courseId.length() == 6) {
	    cheminement = courseId.substring(0, 1);
	    numero = courseId.substring(1, 4);
	    annee = courseId.substring(4);
	}

	else if (courseId.length() == 7) {
	    if (courseId.endsWith("A") || courseId.endsWith("E")
		    || courseId.endsWith("R")) {
		cheminement = courseId.substring(0, 1);
		numero = courseId.substring(1, 4);
		annee = courseId.substring(4);
	    } else {
		cheminement = courseId.substring(0, 2);
		numero = courseId.substring(2, 5);
		annee = courseId.substring(5);
	    }
	}

	else if (courseId.length() == 8) {
	    cheminement = courseId.substring(0, 2);
	    numero = courseId.substring(2, 5);
	    annee = courseId.substring(5);
	}

	else {
	    return courseId;
	}

	formattedCourseId = cheminement + "-" + numero + "-" + annee;
	
	return formattedCourseId;
}



%>


<body>
	<form id="urlForm" method="GET" action="/url/TraducteurURL.jsp" enctype="application/x-www-form-urlencoded">
		<table>
			<tr>
				<td>Entrer l'url ZoneCours 1 à convertir:</td>
				<td><input name="url" id="url"/ size="150" value="<%=urlZc1%>"></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td>Url ZoneCours 2 :</td>
				<td><a href="<%=urlZc2%>" target="_blank"><%=urlZc2%></a></td>
			</tr>
		</table>
	</form>
	
	<br>
    Quelques remarques:<br>
    <ul>
      <li>Les langues support&eacute;es pour l'instant sont fran&ccedil;ais (<i><b>FR</b></i>)
        et anglais (<i><b>EN</b></i>)</li>
      <li>Les disciplines support&eacute;es sont:</li>
      <ul>
        <li>Affaires internationales (#discipline=<i><b>INTERNAT</b></i>)</li>
        <li>Finance (#discipline=<b><i>FINANCE</i></b>)</li>
        <li>Gestion des op&eacute;rations et de la logistique (GOL)
          (#discipline=<i><b>GOL</b></i>)</li>
        <li>Gestion des ressources humaines (GRH) (#discipline=<i><b>GRH</b></i>)&nbsp;&nbsp;&nbsp;
          <br>
        </li>
        <li>Management (#discipline=<i><b>MNGT</b></i>) <br>
        </li>
        <li>Marketing (#discipline=<i><b>MARKETING</b></i>)&nbsp;&nbsp;&nbsp; <br>
        </li>
        <li>M&eacute;thodes quantitatives de gestion (MQG) (#discipline=<i><b>MQG</b></i>)</li>
        <li>Sciences comptables (#discipline=<i><b>SC.COMPT.</b></i>) <br>
        </li>
        <li>Technologies de l'information (TI) (#discipline=<i><b>TI</b></i>)</li>
        <li>&Eacute;conomie appliqu&eacute;e (IEA) (#discipline=<i><b>IEA</b></i>)</li>
        <li>Langues (#discipline=<i><b>QUAL.COMM.</b></i>)</li>
        <li>Cours hors discipline (#discipline=<i><b>P.ETUD.SUP+BAA+DOCTORAT+MSC+CERTIFICAT+DIPLOMES+MBA+BUR.REGIST</b></i>)</li>
      </ul>
      <li>Les programmes support&eacute;s sont:</li>
      <ul>
        <li>Baccalaur&eacute;at en administration des affaires (B.A.A.) (#programme=<i><b>BAA+APRE</b></i>)</li>
        <li>Certificat (#programme=<i><b>CERT</b></i>)</li>
        <li>MBA (#programme=<i><b>MBA</b></i>)</li>
        <li>Dipl&ocirc;mes d'&eacute;tudes sup&eacute;rieures (#programme=<i><b>DES</b></i>)&nbsp;&nbsp;&nbsp;
          <br>
        </li>
        <li>M. Sc. (#programme=<i><b>MSCP+MSC</b></i>) <br>
        </li>
        <li>Ph. D. en administration (#programme=<i><b>PHD+PHDP</b></i>)&nbsp;&nbsp;&nbsp;&nbsp;</li>
      </ul>
    </ul>

	<br>
      <table border="1" cellpadding="2" cellspacing="2" width="1243" height="162">
        <tbody>
          <tr>
            <td bgcolor="#cccccc" valign="top">Lien <br>
            </td>
            <td bgcolor="#cccccc" valign="top">Format<br>
            </td>
            <td bgcolor="#cccccc" valign="top">Exemple d'adresse<br>
            </td>
          </tr>
          <tr>
            <td valign="top">Acc&egrave;s aux descriptions annuaires de la
              discipline &lt;DIS&gt; dans la langue &lt;LANG&gt;<br>
            </td>
            <td valign="top">/?&lt;LANG&gt;#discipline=&lt;DIS&gt;</td>
            <td valign="top"><a class="moz-txt-link-freetext" href="http://zonecours2.hec.ca/portail/?FR#discipline=FINANCE">http://zonecours2.hec.ca/portail/?FR#discipline=FINANCE</a></td>
          </tr>
          <tr>
            <td valign="top">Acc&egrave;s aux descriptions annuaires du
              programme &lt;PROG&gt; dans la langue &lt;LANG&gt;</td>
            <td valign="top">/?&lt;LANG&gt;#programme=&lt;PROG&gt;</td>
            <td valign="top"><a class="moz-txt-link-freetext" href="http://zonecours2.hec.ca/portail/?FR#programme=MBA">http://zonecours2.hec.ca/portail/?FR#programme=MBA</a><br>
            </td>
          </tr>
          <tr>
            <td valign="top">Acc&egrave;s aux r&eacute;sultats de recherche du mot-cl&eacute;
              &lt;WORD&gt; dans la langue &lt;LANG&gt;</td>
            <td valign="top">/?&lt;LANG&gt;#recherche=&lt;WORD&gt;</td>
            <td valign="top"><a class="moz-txt-link-freetext" href="http://zonecours2.hec.ca/portail/?EN#recherche=analyse">http://zonecours2.hec.ca/portail/?EN#recherche=analyse</a><br>
            </td>
          </tr>
          <tr>
            <td valign="top">Acc&egrave;s aux r&eacute;sultats de recherche des
              mots-cl&eacute; &lt;WORD1&gt; et &lt;WORD2&gt; dans la langue
              &lt;LANG&gt;</td>
            <td valign="top">/?&lt;LANG&gt;#recherche=&lt;WORD1&gt;+&lt;WORD2&gt;</td>
            <td valign="top"><a class="moz-txt-link-freetext" href="http://zonecours2.hec.ca/portail/?EN#recherche=analyse+marketing">http://zonecours2.hec.ca/portail/?EN#recherche=analyse+marketing</a><br>
            </td>
          </tr>
        </tbody>
      </table>

</body>
</html>
