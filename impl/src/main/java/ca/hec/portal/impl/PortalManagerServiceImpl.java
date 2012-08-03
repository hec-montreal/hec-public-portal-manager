package ca.hec.portal.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import org.sakaiproject.util.ResourceLoader;

import ca.hec.portal.api.PortalManagerService;
import ca.hec.portal.model.Career;
import ca.hec.portal.model.Department;

public class PortalManagerServiceImpl implements PortalManagerService {

    private ResourceBundle msgs = null;
    private ResourceLoader listDepartmentsToDisplay = null;
    private ResourceLoader listCareersToDisplay = null;

    public void init() {	
	listDepartmentsToDisplay = new ResourceLoader("departments");
	listCareersToDisplay = new ResourceLoader("careers");
    }

    public List<Department> getDepartments() {
	List<Department> listDpt = new ArrayList<Department>();
	for (String departmentKey : (Set<String>) listDepartmentsToDisplay
		.keySet()) {
	    Department dp = new Department();
	    dp.setId(departmentKey);
	    dp.setDescription(listDepartmentsToDisplay.getString(departmentKey));
	    listDpt.add(dp);
	}
	return listDpt;
    }
    
    public List<Career> getCareers() {
	List<Career> listCareer = new ArrayList<Career>();
	for (String careerKey : (Set<String>) listCareersToDisplay
		.keySet()) {
	    Career career = new Career();
	    career.setId(careerKey);
	    career.setDescription(listCareersToDisplay.getString(careerKey));
	    listCareer.add(career);
	}
	return listCareer;
    }

    public String getDescriptionDepartment(String department) {
	String description =  listDepartmentsToDisplay.getString(department);
	if (description != null ){
	    return description;
	}
	else{
	    return department;
	}
    }

    public String getDescriptionCareer(String career) {
	String description =  listCareersToDisplay.getString(career);
	if (description != null ){
	    return description;
	}
	else{
	    return career;
	}
    }
    
    public Map<String, String> getBundle(String locale) {
	Map<String, String> msgsBundle = new HashMap<String, String>();
	msgs = ResourceBundle.getBundle("portal", new Locale(locale));
	
	for (String key : msgs.keySet()) {
	    msgsBundle.put((String) key, (String) msgs.getString(key));
	}

	return msgsBundle;
    }
}
