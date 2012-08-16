package ca.hec.portal.logic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import lombok.Setter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.coursemanagement.api.AcademicSession;
import org.sakaiproject.coursemanagement.api.CourseManagementService;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SiteService;

import org.sakaiquebec.opensyllabus.common.api.OsylSiteService;

/**
 * Implementation of {@link SakaiProxy}
 */
public class SakaiProxyImpl implements SakaiProxy {
    private static Log log = LogFactory.getLog(SakaiProxyImpl.class);

    @Setter
    private SiteService siteService;

    @Setter
    private OsylSiteService osylSiteService;
    
    @Setter 
    private CourseManagementService cmService;

    // Class for comparing the academic sessions by Id Descending.
    public class ComparableAcademicSession implements Comparator<AcademicSession> {	 
	    public int compare(AcademicSession o1, AcademicSession o2) {
		return o2.getEid().compareTo(o1.getEid());
	    }
	}
    
    /**
     * {@inheritDoc}
     */
    public String getSpecificCourse(String courseId) {
	Date today = new Date();
	
	List<AcademicSession> sessions = cmService.getAcademicSessions();
	Collections.sort(sessions, new ComparableAcademicSession());
	
	ArrayList<String> sessionNames = new ArrayList<String>();

	// get all academic sessions, and add their formatted names to the list
	for (AcademicSession session : sessions) {
	    String sessionName = getSessionName(session);
	    
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

    private String getSessionName(AcademicSession session) {
	String sessionName = null;
	String sessionId = session.getEid();
	Date startDate = session.getStartDate();
	String year = startDate.toString().substring(0, 4);

	if ((sessionId.charAt(3)) == '1')
	    sessionName = OsylSiteService.WINTER + year;
	if ((sessionId.charAt(3)) == '2')
	    sessionName = OsylSiteService.SUMMER + year;
	if ((sessionId.charAt(3)) == '3')
	    sessionName = OsylSiteService.FALL + year;

	return sessionName;
    }

    
    /**
     * init - perform any actions required here for when this bean starts up
     */
    public void init() {
    	log.info("init");
    }
}
