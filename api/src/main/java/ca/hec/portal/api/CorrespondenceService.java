package ca.hec.portal.api;

import java.util.List;

import ca.hec.portal.model.Correspondence;

/**
 * This is the interface of services used to manage Correspondences
 *  
 * @author <a href="mailto:cyril.mace@hec.ca">Cyril Mace</a> 
 */
public interface CorrespondenceService { 
 
    public List<Correspondence> getCorrespondences() throws Exception;
    
    public void saveCorrespondence(String courseId, String courseSession) throws Exception;
    
    public void deleteCorrespondence(String courseId) throws Exception;
}

