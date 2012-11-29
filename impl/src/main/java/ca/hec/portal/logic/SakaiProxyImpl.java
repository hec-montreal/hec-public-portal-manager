package ca.hec.portal.logic;

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

import lombok.Getter;
import lombok.Setter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.coursemanagement.api.AcademicSession;
import org.sakaiproject.coursemanagement.api.CourseManagementService;
import org.sakaiproject.exception.IdUnusedException;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SiteService;
import org.sakaiproject.user.api.UserDirectoryService;
import org.sakaiquebec.opensyllabus.common.api.OsylSiteService;
import org.sakaiquebec.opensyllabus.shared.model.COSerialized;

import ca.hec.portal.api.CorrespondenceService;
import ca.hec.portal.model.Correspondence;

/**
 * Implementation of {@link SakaiProxy}
 */
public class SakaiProxyImpl implements SakaiProxy {
    private static Log log = LogFactory.getLog(SakaiProxyImpl.class);

    @Setter private SiteService siteService;
    @Setter private OsylSiteService osylSiteService;
    @Setter private CourseManagementService cmService;
    @Getter
    @Setter
    private UserDirectoryService userDirectoryService;
    @Getter
    @Setter
    private CorrespondenceService correspondenceService;
    
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
     * @throws Exception 
     */
    public String getAssociatedCourseSiteTitle(String courseId) throws Exception {
	Correspondence c = correspondenceService.getCorrespondence(courseId);
	
	if (c == null)
	{	
	    Date today = new Date();
	
	    List<AcademicSession> sessions = cmService.getAcademicSessions();
	    Collections.sort(sessions, new ComparableAcademicSession());
	
	    ArrayList<String> sessionNames = new ArrayList<String>();

	    // get all academic sessions, and add their formatted names to the list
	    for (AcademicSession session : sessions) {
		String sessionName = osylSiteService.getSessionName(session);
	    
		// if the session is not MBA (contains P), is completed, and not yet in the list, add it
		if (!session.getEid().contains("P") && 
			session.getEndDate().before(today) && 
			!sessions.contains(sessionName)) {
		    sessionNames.add(sessionName);
		}
	    }
	
	    // Start searching the sessions for a course site with a published course outline to use
	    for (String sessionName : sessionNames) {
		// Get the sites with the given Id and Session in the title
		List<Site> sites = siteService.getSites(SiteService.SelectionType.ANY, "course",
			courseId + "." + sessionName, null, SiteService.SortType.TITLE_ASC, null);

		for (Site s : sites) {
		    try {
			// provider group id indicates that the site has been associated 
			// to course management in OpenSyllabus Manager
			if (s.getProviderGroupId() != null &&
				osylSiteService.hasBeenPublished(s.getId())) {
			    return s.getTitle();
			}
		    }
		    catch (Exception e) {}
		}
	    }
	}
	else {
	    if (c.getCourseSection() == null)
		return null;
	    
	    // get the site that is specified with the correspondence to make sure it exists, 
	    // has been published and associated to course management
	    Site s = siteService.getSite(courseId + "." + c.getCourseSection());
	    
	    if (s.getProviderGroupId() != null &&
		    osylSiteService.hasBeenPublished(s.getId())) {
		return s.getTitle();
	    }
	}
	
	return null;
    }
    
    /**
     * {@inheritDoc}
     */
    public String getCourseOutlineXML(String siteId) {
	COSerialized coSerialized;

	try {
	    // Get the Course Outline
	    coSerialized = osylSiteService.getSerializedPublicCourseOutline(siteId);
	    
	    writer = new StringWriter();
	    result = new StreamResult(writer);
		    
	    reader = new StringReader(coSerialized.getContent());
	    source = new StreamSource(reader);

	    transformerOsylToXml.transform(source, result);
	    
	} catch (IdUnusedException iue) {
	    return null;
	} catch (Exception e) {
	    e.printStackTrace();
	    return null;
	}

	return writer.toString();
    }

    /**
     * {@inheritDoc}
     */
    public String getCourseOutlineHTML(String siteId) {
	String courseOutlineXml = getCourseOutlineXML(siteId);
	
	if (courseOutlineXml == null)
	    return null;
	
	writer = new StringWriter();
	result = new StreamResult(writer);
	    
	reader = new StringReader(courseOutlineXml);
	source = new StreamSource(reader);

	try {
	    transformerXmlToHtml.transform(source, result);
	} catch (TransformerException te) {
	    te.printStackTrace();
	    return null;
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

    public List<Correspondence> getCorrespondences() throws Exception {
	if (isUserAllowedToManageCorrespondences()){
	    return correspondenceService.getCorrespondences();
	}
	else{
	    throw new Exception("User doesn't have the right to use the listing service");
	}
    }

    public void saveCorrespondence(String courseId, String courseSection)
	    throws Exception {
	if (isUserAllowedToManageCorrespondences()){
	    correspondenceService.saveCorrespondence(courseId, courseSection);
	}
	else{
	    throw new Exception("User doesn't have the right to use the saving service");
	}
    }

    public void deleteCorrespondence(String courseId) throws Exception {
	if (isUserAllowedToManageCorrespondences()){
	    correspondenceService.deleteCorrespondence(courseId);
	}
	else{
	    throw new Exception("User doesn't have the right to use the deleting service");
	}
    }

    private boolean isUserAllowedToManageCorrespondences(){
	String eid = null;
	try{
	    eid = userDirectoryService.getCurrentUser().getEid(); 
	}
	catch(Exception e){
	    log.error("Exception while retrieving current user id: " + e);
	}
	
	if (eid != null){
	    return true;
	}
	else{
	    return false; 
	}	
    }

}
