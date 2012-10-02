package ca.hec.portal.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import ca.hec.portal.api.PortalManagerService;
import ca.hec.portal.model.Item;
import ca.hec.portal.model.ItemFactory;

public class PortalManagerServiceImpl implements PortalManagerService {

    private ResourceBundle msgs = null;
    private ResourceBundle listDepartmentsToDisplay = null;
    private ResourceBundle listCareersToDisplay = null;
    private Map<String, String> careerGroups = null;
    private Map<String, String> departmentGroups = null;

    public void init() {
	
    }

    
    /**
     * Return the departments/careers that need to be displayed in HEC public portal
     * Each department/career have a description and is associated to a group (can include several careers/departments)
     * @param  itemsType: department/career
     */
    public List<Item> getItems(String itemsType) {
	ItemFactory listDpt = new ItemFactory();
	Item dpTemp = null;
	ResourceBundle listItemsToDisplay = null;
	 Map<String, String> itemGroups;
	
	if ("career".equals(itemsType)){
	    listItemsToDisplay = listCareersToDisplay;
	    itemGroups =  careerGroups;
	}
	else{
	    listItemsToDisplay = listDepartmentsToDisplay;
	    itemGroups =  departmentGroups;
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
		dp.setItemGroup(itemGroups.get(itemKey));
		listDpt.add(dp);
	    }
	    
	    
	}
	return listDpt.getListItem();
    }
    
    
    /**
     *  Init  the list of career or department groups specified in the properties files
     * 	A career/department group can include several careers/departments
     *  @param  itemsType: department/career
     */
    public void initGroup(String itemsType) {
	ResourceBundle listItemsToDisplay = null;
	Map<String, String> listitemGroups = null;
	Map<String, String> listItemDescriptions  = new HashMap<String, String>();
	
	if ("career".equals(itemsType)){
	    listItemsToDisplay = listCareersToDisplay;
	    careerGroups = new HashMap<String, String>();
	    listitemGroups = careerGroups;
	}
	else{
	    listItemsToDisplay = listDepartmentsToDisplay;
	    departmentGroups = new HashMap<String, String>();
	    listitemGroups = departmentGroups;
	}
	
	for (String key : listItemsToDisplay.keySet()) {
	    String itemDescription = listItemsToDisplay.getString(key);
	    String itemGroup =   listItemDescriptions.get(itemDescription);
	    if (itemGroup == null){
		listItemDescriptions.put(itemDescription, key.replace(".", ""));
	    }
	    else{
		listItemDescriptions.put(itemDescription, itemGroup + key.replace(".", ""));
	    }
	    
	}
	
	for (String key : listItemsToDisplay.keySet()) {
	    String itemDescription = listItemsToDisplay.getString(key);
	    listitemGroups.put(key, listItemDescriptions.get(itemDescription));
	}
	
    }
    

    /**
     *  Return the group description associated with the passed item (career/department) 
     * 	A career/department group can include several careers/departments
     *  @param  itemsType: department/career, itemValue: id of the department/career
     */
    public String getItemDescription(String itemType, String itemValue) {
	ResourceBundle listItemsToDisplay = null;
	String description = null;
	
	if ("career".equals(itemType)){
	    listItemsToDisplay = listCareersToDisplay;
	}
	else{
	    listItemsToDisplay = listDepartmentsToDisplay;
	}
	
	try{
	    description =  listItemsToDisplay.getString(itemValue);
	}
	catch(Exception e){
	    description = msgs.getString("label_unknown_category");
	}
   	    return description;
       }
    
    public String getDepartmentDescription(String department) {
	return getItemDescription("department", department);
    }

    public String getCareerDescription(String career) {
	return getItemDescription("career", career);
    }
    
    
    
    public Map<String, String> getBundle(String locale) {
	Map<String, String> msgsBundle = new HashMap<String, String>();
	msgs = ResourceBundle.getBundle("portal", new Locale(locale));	
	listDepartmentsToDisplay = ResourceBundle.getBundle("departments",new Locale(locale));
	listCareersToDisplay = ResourceBundle.getBundle("careers",new Locale(locale));
	
	for (String key : msgs.keySet()) {
	    msgsBundle.put((String) key, (String) msgs.getString(key));
	}
	
	initGroup("career");
	initGroup("department");
	
	
	return msgsBundle;
    }


    public String getDepartmentGroup(String department) {
	return departmentGroups.get(department);
    }


    public String getCareerGroup(String career) {
	return careerGroups.get(career);
    }    

    
    public List<Item> getDepartments() {
	return getItems("department");
    }
    
    public List<Item> getCareers() {
	return getItems("career");
    }
}
