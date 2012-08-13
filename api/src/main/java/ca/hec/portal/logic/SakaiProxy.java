package ca.hec.portal.logic;


/**
 * An interface to abstract all Sakai related API calls in a central method that can be injected into our app.
 * 
 * @author Curtis van Osch (curtis.van-osch@hec.ca)
 *
 */
public interface SakaiProxy {
	
	/**
	 * Gets the specific course title associated to the given catalog description
	 *
	 * @param courseId	the course id of the catalog description
	 * @return the title of the most recently created course offering (that has been published)
	 */
	public String getSpecificCourse(String courseId);
}
