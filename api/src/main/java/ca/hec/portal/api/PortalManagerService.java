package ca.hec.portal.api;

import java.util.List;
import java.util.Map;

import ca.hec.portal.model.Career;
import ca.hec.portal.model.Department;

//import org.sakaiproject.entity.api.EntityProducer;

public interface PortalManagerService // extends EntityProducer
{
    public void init();

    public List<Department> getDepartments();

    public List<Career> getCareers();
    
    public String getDescriptionDepartment(String department);
    
    public String getDescriptionCareer(String career);
    
    public Map<String, String> getBundle(String locale);
}
