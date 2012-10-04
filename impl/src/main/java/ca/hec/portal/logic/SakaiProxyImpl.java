package ca.hec.portal.logic;

import java.io.File;
import java.io.InputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import lombok.Setter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.coursemanagement.api.AcademicSession;
import org.sakaiproject.coursemanagement.api.CourseManagementService;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SiteService;

import org.sakaiquebec.opensyllabus.common.api.OsylSiteService;
import org.sakaiquebec.opensyllabus.shared.model.COSerialized;

/**
 * Implementation of {@link SakaiProxy}
 */
public class SakaiProxyImpl implements SakaiProxy {
    private static Log log = LogFactory.getLog(SakaiProxyImpl.class);

    @Setter private SiteService siteService;
    @Setter private OsylSiteService osylSiteService;
    @Setter private CourseManagementService cmService;
    
    private static Transformer transformerOsylToXml = null;
    private static Transformer transformerXmlToHtml = null;

    StringWriter writer = null;
    StringReader reader = null;
    Result result = null;
    Source source = null;	

    // Class for comparing the academic sessions by Id Descending.
    public class ComparableAcademicSession implements Comparator<AcademicSession> {	 
	    public int compare(AcademicSession o1, AcademicSession o2) {
		return o2.getEid().compareTo(o1.getEid());
	    }
	}
    
    /**
     * {@inheritDoc}
     */
    public String getAssociatedCourseSiteTitle(String courseId) {
	Date today = new Date();
	
	List<AcademicSession> sessions = cmService.getAcademicSessions();
	Collections.sort(sessions, new ComparableAcademicSession());
	
	ArrayList<String> sessionNames = new ArrayList<String>();

	// get all academic sessions, and add their formatted names to the list
	for (AcademicSession session : sessions) {
	    String sessionName = osylSiteService.getSessionName(session);
	    
	    // if the session is completed and not yet in the list, add it
	    if (session.getEndDate().before(today) && !sessions.contains(sessionName)) {
		sessionNames.add(sessionName);
	    }
	}
	
	// Start searching the sessions for a course site with a published course outline to use
	for (String sessionName : sessionNames) {
	    // Get the sites with the given Id and Session in the title
	    List<Site> sites = siteService.getSites(SiteService.SelectionType.ANY, "course",
		courseId + "." + sessionName, null, SiteService.SortType.TITLE_ASC, null);

	    for (Site s : sites) {
		if (osylSiteService.hasBeenPublished(s.getId())) {
		    return s.getTitle();
		}
	    }
	}
		
	return "";
    }
    
    /**
     * {@inheritDoc}
     */
    public String getCourseOutlineXML(String siteId) {
	COSerialized coSerialized;

	try {
	    // Get the Course Outline
	    // I think it's ok to pass null as webappDir, because it is only used if the Dao doesn't find a course outline (?)
	    // Otherwise it might be easiest to use the dao directly (or overload getSerializedCourseOutline)
	    coSerialized = osylSiteService.getSerializedCourseOutline(siteId, null);

	    writer = new StringWriter();
	    result = new StreamResult(writer);
		    
	    reader = new StringReader(coSerialized.getContent());
	    source = new StreamSource(reader);

	    transformerOsylToXml.transform(source, result);
	    
	} catch (TransformerException te) {
	    te.printStackTrace();		    
	} catch (Exception e) {
	    e.printStackTrace();
	}

	return writer.toString();
    }

    /**
     * {@inheritDoc}
     */
    public String getCourseOutlineHTML(String siteId) {
	String courseOutlineXml = getCourseOutlineXML(siteId);
	
	writer = new StringWriter();
	result = new StreamResult(writer);
	    
	reader = new StringReader(courseOutlineXml);
	source = new StreamSource(reader);

	try {
	    transformerXmlToHtml.transform(source, result);
	} catch (TransformerException te) {
	    te.printStackTrace();		    
	}
	
	return writer.toString();
    }
    
    /**
     * init - perform any actions required here for when this bean starts up
     */
    public void init() {
    	log.info("init");

    	// Create the XSLT Transformers (must not be initialized for every transformation)
    	TransformerFactory factory = TransformerFactory.newInstance();
    	
    	try {
    	    // change the factory's URIResolver before loading the resource xsl
    	    factory.setURIResolver(new osylToZcURIResolver());
    	    transformerOsylToXml = factory.newTransformer(
    		    new StreamSource(getClass().getClassLoader().
    			    getResourceAsStream("ca/hec/portal/xslt/osylToZc/osylToZc.xsl")));

    	    // change the factory's URIResolver before loading the resource xsl
    	    factory.setURIResolver(new xmlToHtmlURIResolver());
    	    transformerXmlToHtml= factory.newTransformer(
    		    new StreamSource(getClass().getClassLoader().
    			    getResourceAsStream("ca/hec/portal/xslt/co-xml-to-html.xsl")));
    	    
    	} catch (TransformerConfigurationException tce) {
    	    tce.printStackTrace();
    	}    	
    }
    
    // use this to correctly locate includes in the xsl
    class xmlToHtmlURIResolver implements URIResolver {
	public Source resolve(String href, String base)
		throws TransformerException {
	    try{
		InputStream inputStream = 
			this.getClass().getClassLoader().getResourceAsStream("ca/hec/portal/xslt/" + href);
		return new StreamSource(inputStream);
	    }
	    catch(Exception ex){
		ex.printStackTrace();
		return null;
	    }
	}
    }

    class osylToZcURIResolver implements URIResolver {
	public Source resolve(String href, String base)
		throws TransformerException {
	    try{
		InputStream inputStream = 
			this.getClass().getClassLoader().getResourceAsStream("ca/hec/portal/xslt/osylToZc/" + href);
		return new StreamSource(inputStream);
	    }
	    catch(Exception ex){
		ex.printStackTrace();
		return null;
	    }
	}
    }

}
