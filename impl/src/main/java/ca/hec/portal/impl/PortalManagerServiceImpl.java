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
import ca.hec.portal.model.Item;
import ca.hec.portal.model.ItemFactory;

public class PortalManagerServiceImpl implements PortalManagerService {

    private ResourceBundle msgs = null;
    private ResourceLoader listDepartmentsToDisplay = null;
    private ResourceLoader listCareersToDisplay = null;

    public void init() {	
	listDepartmentsToDisplay = new ResourceLoader("departments");
	listCareersToDisplay = new ResourceLoader("careers");
    }

    
    /**
     * * Return the departments/careers that need to be displayed in HEC public portal
     * @param  itemsType: department/career
     */
    public List<Item> getItems(String itemsType) {
	ItemFactory listDpt = new ItemFactory();
	Item dpTemp = null;
	ResourceLoader listItemsToDisplay = null;
	
	if ("career".equals(itemsType)){
	    listItemsToDisplay = listCareersToDisplay;
	}
	else{
	    listItemsToDisplay = listDepartmentsToDisplay;
	}
	
	for (String itemKey : (Set<String>) listItemsToDisplay
		.keySet()) {
	    String description = listItemsToDisplay.getString(itemKey);
	    dpTemp = listDpt.getItemByDescription(description);
	    
	    //if dp != null it means that we already have a department associated with this description, so we will update this department instead of creating a new one
	    if (dpTemp != null){
		dpTemp.addId(itemKey);
	    }
	    else{
		Item dp = new Item();
		dp.addId(itemKey);
		dp.setDescription(listItemsToDisplay.getString(itemKey));
		listDpt.add(dp);
	    }
	    
	    
	}
	return listDpt.getListItem();
    }
    
    public List<Item> getDepartments() {
	return getItems("department");
    }
    
    public List<Item> getCareers() {
	return getItems("career");
    }

    public String getDepartmentDescription(String department) {
	String description =  listDepartmentsToDisplay.getString(department);
	if (description != null ){
	    return description;
	}
	else{
	    return department;
	}
    }

    public String getCareerDescription(String career) {
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
