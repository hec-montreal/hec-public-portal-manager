
package ca.hec.portal.api;
import java.util.List;

import ca.hec.portal.model.Correspondence;

/**
 * This is the interface for the Dao of our Correspondences
 * 
 * @author <a href="mailto:cyril.mace@hec.ca">Cyril Mace</a>
 * @version $Id: $
 */
public interface CorrespondenceDao {
    
    public List<Correspondence> getCorrespondences() throws Exception;
    
    public Correspondence getCorrespondence(String courseId) throws Exception;
    
    public void saveCorrespondence(Correspondence correspondence) throws Exception;
    
    public void deleteCorrespondence(Correspondence correspondence) throws Exception;

}

