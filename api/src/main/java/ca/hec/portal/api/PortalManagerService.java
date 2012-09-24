package ca.hec.portal.api;

import java.util.List;
import java.util.Map;

import ca.hec.portal.model.Item;

//import org.sakaiproject.entity.api.EntityProducer;

public interface PortalManagerService // extends EntityProducer
{
    public void init();

    public List<Item> getDepartments();

    public List<Item> getCareers();
    
    public String getDepartmentDescription(String department);
    
    public String getCareerDescription(String career);
    
    public Map<String, String> getBundle(String locale);

    public String getDepartmentGroup(String department);

    public String getCareerGroup(String career);
}
