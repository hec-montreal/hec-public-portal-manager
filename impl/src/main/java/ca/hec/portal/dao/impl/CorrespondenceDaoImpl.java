package ca.hec.portal.dao.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import ca.hec.portal.api.CorrespondenceDao;
import ca.hec.portal.model.Correspondence;

public class CorrespondenceDaoImpl extends HibernateDaoSupport implements
	CorrespondenceDao {
    
    private static Log log = LogFactory.getLog(CorrespondenceDaoImpl.class);

    public List<Correspondence> getCorrespondences() throws Exception {
	try {
	    List<Correspondence> listResults = (List<Correspondence>) getHibernateTemplate().find("from Correspondence");
	    return listResults;
	}catch (Exception e) {
	    log.error("Exception during listing proces: " + e);
	    throw new Exception(e);
	}
    }
    
    public void saveCorrespondence(Correspondence correspondence) throws Exception {
	try {
	    getHibernateTemplate().saveOrUpdate(correspondence);
	}catch (Exception e) {
	    log.error("Exception during saving proces: " + e);
	    throw new Exception(e);
	}
    }
   
    public void deleteCorrespondence(Correspondence correspondence) throws Exception {
	try {
	    getHibernateTemplate().delete(correspondence);
	}catch (Exception e) {
	    log.error("Exception during deleting proces: " + e);
	    throw new Exception(e);
	}
    }

    public Correspondence getCorrespondence(String courseId) throws Exception {
	try {
	    DetachedCriteria dc =
			DetachedCriteria
				.forClass(Correspondence.class)
				.add(Restrictions.eq("courseId",
					courseId));

	List<Correspondence> correspondenceList = (List<Correspondence>) getHibernateTemplate().findByCriteria(dc);
	
	if (correspondenceList.size() == 0){
	    return null; 
	}
	else if (correspondenceList.size() == 1){
	   return correspondenceList.get(0); 
	}
	else{
	    throw new Exception("courseId is present in more than one row");  
	}
	}catch (Exception e) {
	    log.error("Exception during getting process: " + e);
	    throw new Exception(e);
	}
    }

}

