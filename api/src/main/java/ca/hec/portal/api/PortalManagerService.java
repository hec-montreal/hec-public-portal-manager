package ca.hec.portal.api;



import java.util.List;

import ca.hec.portal.model.Department;

//import org.sakaiproject.entity.api.EntityProducer;

public interface PortalManagerService // extends EntityProducer
{
    public void init();

    /**
     * Get a Catalog Description by database id
     * 
     * @param id - the db id of the catalog description
     * @return the catalog description with details
     */
    public List<Department> getDepartments();  
}
