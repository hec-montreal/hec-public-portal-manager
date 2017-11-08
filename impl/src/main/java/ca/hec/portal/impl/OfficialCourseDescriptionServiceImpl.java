package ca.hec.portal.impl;

import ca.hec.portal.api.OfficialCourseDescriptionDao;
import ca.hec.portal.api.OfficialCourseDescriptionService;
import ca.hec.portal.model.OfficialCourseDescription;
import lombok.Setter;

import java.util.List;
import java.util.Map;

/**
 * @author 11091096
 */
public class OfficialCourseDescriptionServiceImpl implements OfficialCourseDescriptionService {

    @Setter
    private OfficialCourseDescriptionDao officialCourseDescriptionDao;
    
    public void init() {
	
    }

    public List<OfficialCourseDescription> getOfficialCourseDescriptions(Map<String, String> searchWords, Map<String, String> searchScope){

		return officialCourseDescriptionDao.getOfficialCourseDescriptions(searchWords, searchScope);
    }

    public OfficialCourseDescription getOfficialCourseDescription(String courseId){
		return officialCourseDescriptionDao.getOfficialCourseDescription(courseId);
    }



}
