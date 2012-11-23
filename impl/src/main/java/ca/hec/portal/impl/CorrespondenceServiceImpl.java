package ca.hec.portal.impl;

import java.util.Date;
import java.util.List;

import lombok.Setter;
import ca.hec.portal.api.CorrespondenceDao;
import ca.hec.portal.api.CorrespondenceService;
import ca.hec.portal.model.Correspondence;

/**
 * @author <a href="mailto:cyril.mace@hec.ca">Cyril Mace</a>
 */
public class CorrespondenceServiceImpl implements CorrespondenceService {

    @Setter
    private CorrespondenceDao correspondenceDao;
    
    public void init() {
	
    }

    public List<Correspondence> getCorrespondences() throws Exception {
	return correspondenceDao.getCorrespondences();
    }

    public Correspondence getCorrespondence(String courseId) throws Exception {
	return correspondenceDao.getCorrespondence(courseId);
    }

    public void saveCorrespondence(String courseId, String courseSession)
	    throws Exception {
	Correspondence correspondence =
		correspondenceDao.getCorrespondence(courseId);
	
	//we create the correspondence if it doesn't exist
	if (correspondence == null) {
	    correspondence = new Correspondence();
	    correspondence.setCourseId(courseId);
	    correspondence.setLastModifiedDate(new Date());
	}
	
	correspondence.setCourseSection(courseSession);

	correspondenceDao.saveCorrespondence(correspondence);
    }

    public void deleteCorrespondence(String courseId) throws Exception {
	Correspondence correspondence =
		correspondenceDao.getCorrespondence(courseId);
	
	//we throw an exception if correspondence doesn't exist
	if (correspondence == null) {
	    throw new Exception("course doesn't exist: we can't deleteCorrespondence");
	}
	correspondenceDao.deleteCorrespondence(correspondence);
    }

}
