package ca.hec.portal.logic;

import ca.hec.portal.model.SimpleCourseOutline;

/**
 * An interface to abstract all Sakai related API calls in a central method that can be injected into our app.
 * 
 * @author Curtis van Osch (curtis.van-osch@hec.ca)
 *
 */
public interface SakaiProxy {
	
	/**
	 * Gets the title of the course site associated to the given catalog description. (Same course id, from a 
	 * session that has been completed, and with a published OpenSyllabus course outline)
	 *
	 * @param catalogDescriptionId	the id of the catalog description
	 * @return the title of the most recently created course offering (that has been published)
	 */
	public String getAssociatedCourseSiteTitle(String courseId);

	public SimpleCourseOutline getCourseOutlineContent(String siteId);
}
