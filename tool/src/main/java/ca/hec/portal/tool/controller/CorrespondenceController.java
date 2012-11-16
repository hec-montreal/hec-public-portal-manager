package ca.hec.portal.tool.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import ca.hec.portal.api.CorrespondenceService;
import ca.hec.portal.model.Correspondence;

/**
 * Controller that handle ajax calls made by the Portal Manager front end
 *  
 * @author <a href="mailto:cyril.mace@hec.ca">Cyril Mace</a> 
 */
@Controller
public class CorrespondenceController {
    
    private static Log log = LogFactory.getLog(CorrespondenceController.class);
    
    @Autowired
    private CorrespondenceService correspondenceService;
    
    
    /*
     * Called whenever a user press the "Save" button of the form.
     */
    @RequestMapping(value = "/saveCorrespondence.json", method = RequestMethod.POST)
    public ModelAndView saveCorrespondence(HttpServletRequest request,
	    HttpServletResponse response) throws Exception {
    	
    	String courseId = request.getParameter("courseId");
    	String courseSession = request.getParameter("courseSession");

    	String returnStatus = null;

    	try {
    	correspondenceService.saveCorrespondence(courseId, courseSession);
    	returnStatus = "success";
    	}
    	catch (Exception e) {
	    	log.error("Exception while saving correspondence: " + e);
    		returnStatus = "failure";
    	}

    	Map<String, String> model = new HashMap<String, String>();
    	model.put("status", returnStatus);

    	return new ModelAndView("jsonView", model);
    }

    /*
     * Called at the initialisation of the Correspondence table. 
     */
    @RequestMapping(value = "/listCorrespondences.json")
    public ModelAndView listCatalogDescription(HttpServletRequest request,
	    HttpServletResponse response) throws Exception {

    	List<Correspondence> listCorrespondence =    			
    		correspondenceService.getCorrespondences();

    	List<Object> tableValue = new ArrayList<Object>();

    	for (Correspondence correspondence : listCorrespondence) {
    		List<String> array = new ArrayList<String>();

    		array.add(correspondence.getCourseId());
    		array.add(correspondence.getCourseOutlineSession());
    		array.add("" + DateFormat.getInstance().format(correspondence.getLastModifiedDate()));
    		tableValue.add(array);
    	}

    	Map<String, Object> model = new HashMap<String, Object>();
    	model.put("aaData", tableValue);
    	model.put("sEcho", listCorrespondence.size());
    	model.put("iTotalRecords", listCorrespondence.size());
    	model.put("iTotalDisplayRecords", listCorrespondence.size());

    	return new ModelAndView("jsonView", model);
    }

    /*
     * Called whenever a user press the "Delete" button of a table row.
     */
    @RequestMapping(value = "/deleteCorrespondence.json")
    public ModelAndView getCatalogDescription(HttpServletRequest request,
	    HttpServletResponse response) throws Exception {
	
	String courseId = request.getParameter("courseId");

    	String returnStatus = null;

    	try {
    	correspondenceService.deleteCorrespondence(courseId);
    	returnStatus = "success";
    	}
    	catch (Exception e) {
	    	log.error("Exception while deleting correspondence: " + e);
    		returnStatus = "failure";
    	}

    	Map<String, String> model = new HashMap<String, String>();
    	model.put("status", returnStatus);

    	return new ModelAndView("jsonView", model);
    }
 }

