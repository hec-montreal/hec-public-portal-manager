package ca.hec.portal.logic;

/**
 * An interface to abstract all Sakai related API calls in a central method that can be injected into our app.
 * 
 * @author Curtis van Osch (curtis.van-osch@hec.ca)
 *
 */
public interface SakaiProxy {
	
	/**
	 * Gets the specific course site title associated to the given catalog description. (Same course id, from a 
	 * session that has been completed, and with a published OpenSyllabus course outline)
	 *
	 * @param courseId	the course id of the catalog description
	 * @return the title of the most recently created course offering (that has been published)
	 */
	public String getSpecificCourse(String courseId);
}
