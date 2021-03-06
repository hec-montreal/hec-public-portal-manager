package ca.hec.portal.logic;

import java.util.List;

import ca.hec.portal.model.Correspondence;

/**
 * An interface to abstract all Sakai related API calls in a central method that
 * can be injected into our app.
 * 
 * @author Curtis van Osch (curtis.van-osch@hec.ca)
 */
public interface SakaiProxy {

    /**
     * Gets the ID of the course site associated to the given catalog
     * description. (Same course id, from a session that has been completed, and
     * with a published OpenSyllabus course outline)
     * 
     * @param officialCourseDescriptionId the id of the catalog description
     * @return the title of the most recently created course offering (that has
     *         been published)
     * @throws Exception 
     */
    public String getAssociatedCourseSiteId(String courseId) throws Exception;

    /**
     * Apply the xslt transformation to convert the OpenSyllabus XML into an XML
     * of readable format
     * 
     * @param siteId The site id for the course outline to retrieve
     * @return The course outline for the given site id as a readable xml
     */
    public String getCourseOutlineXML(String siteId);

    /**
     * Apply the xslt transformation to convert the readable course outline XML
     * into an HTML document for displaying to the user
     * 
     * @param siteId The site id for the course outline to retrieve
     * @return The course outline for the given site id as an HTML document
     */
    public String getCourseOutlineHTML(String siteId);

    /**
     * get the list of correspondences between course and course section that we choose for the displayed course outline
     * 
     * @param 
     * @return List of correspondences
     */
    public List<Correspondence> getCorrespondences() throws Exception;

    /**
     * Save a correspondence between course and course section that we choose for the displayed course outline
     * 
     * @param courseId/courseSession
     * @return 
     */
    public void saveCorrespondence(String courseId, String courseSection)
	    throws Exception;

    /**
     * Delete a correspondence between course and course section that we choose for the displayed course outline
     * 
     * @param courseId
     * @return 
     */
    public void deleteCorrespondence(String courseId) throws Exception;
}
