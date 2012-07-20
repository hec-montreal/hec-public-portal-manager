package ca.hec.portal.impl;

import java.util.ArrayList;
import java.util.List;

import org.sakaiproject.util.ResourceLoader;

import ca.hec.portal.api.PortalManagerService;
import ca.hec.portal.model.Department;

public class PortalManagerServiceImpl implements PortalManagerService {

		private ResourceLoader msgs = null; 
	
	public void init() {
		msgs = new ResourceLoader("portal");
	}

	public List<Department> getDepartments(){
	    Department dp = new Department();
	    dp.setId("id");
	    dp.setDescription("description");
	    List<Department> listDpt = new ArrayList<Department>();
	    listDpt.add(dp);
	    return listDpt;
	}
}
