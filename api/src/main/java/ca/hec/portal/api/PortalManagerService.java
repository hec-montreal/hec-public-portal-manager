package ca.hec.portal.api;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import ca.hec.portal.model.Item;

public interface PortalManagerService
{
    public void init();

    public List<Item> getDepartments(String locale);

    public List<Item> getCareers(String locale);
    
    public String getDepartmentDescription(String department, Locale locale);
    
    public String getCareerDescription(String career, Locale locale);
    
    public Map<String, String> getBundle(String locale);

    public String getDepartmentGroup(String department);

    public String getCareerGroup(String career);
}
