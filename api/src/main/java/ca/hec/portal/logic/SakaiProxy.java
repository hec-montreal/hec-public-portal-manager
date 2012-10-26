package ca.hec.portal.logic;

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

	/**
	 * Apply the xslt transformation to convert the OpenSyllabus XML into an XML of readable format
	 *
	 * @param siteId	The site id for the course outline to retrieve
	 * @return 		The course outline for the given site id as a readable xml
	 */
	public String getCourseOutlineXML(String siteId);
	
	/**
	 * Apply the xslt transformation to convert the readable course outline XML into an HTML document
	 * for displaying to the user
	 *
	 * @param siteId	The site id for the course outline to retrieve
	 * @return 		The course outline for the given site id as an HTML document
	 */
	public String getCourseOutlineHTML(String siteId);
	public String getOsylCO(String siteId);
}
