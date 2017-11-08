package ca.hec.portal.tool.controller;

import ca.hec.portal.logic.SakaiProxy;
import ca.hec.portal.model.Correspondence;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controller that handle ajax calls made by the Portal Manager front end
 * 
 * @author <a href="mailto:cyril.mace@hec.ca">Cyril Mace</a>
 */
@Controller
public class CorrespondenceController {

    private static Log log = LogFactory.getLog(CorrespondenceController.class);

    @Setter
    @Getter
    @Autowired
    private SakaiProxy sakaiProxy = null;

    /*
     * Called whenever a user press the "Save" button of the form.
     */
    @RequestMapping(value = "/saveCorrespondence.json", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> saveCorrespondence(@RequestParam("courseId") String courseId, @RequestParam("courseSection") String courseSection) throws Exception {

	String returnStatus = null;

	try {
	    sakaiProxy.saveCorrespondence(courseId, courseSection);
	    returnStatus = "success";
	} catch (Exception e) {
	    log.error("Exception while saving correspondence: " + e);
	    returnStatus = "failure";
	}

	Map<String, String> model = new HashMap<String, String>();
	model.put("status", returnStatus);

	return  model;
    }

    /*
     * Called at the initialisation of the Correspondence table.
     */
    @RequestMapping(value = "/listCorrespondences.json", method= RequestMethod.GET)
    public @ResponseBody Map<String, Object> listOfficialCourseDescription() throws Exception {

	List<Correspondence> listCorrespondence = null;
	String returnStatus = null;
	Map<String, Object> model = new HashMap<String, Object>();
	try {
	    listCorrespondence = sakaiProxy.getCorrespondences();
	    List<Object> tableValue = new ArrayList<Object>();

	    for (Correspondence correspondence : listCorrespondence) {
		List<String> array = new ArrayList<String>();

		array.add(correspondence.getCourseId());
		array.add(correspondence.getCourseSection());
		array.add(""
			+ DateFormat.getInstance().format(
				correspondence.getLastModifiedDate()));
		tableValue.add(array);
	    }
	    model.put("aaData", tableValue);
	    model.put("sEcho", listCorrespondence.size());
	    model.put("iTotalRecords", listCorrespondence.size());
	    model.put("iTotalDisplayRecords", listCorrespondence.size());
	    returnStatus = "success";
	} catch (Exception e) {
	    log.error("Exception while getting correspondences: " + e);
	    returnStatus = "failure";
	}

	model.put("status", returnStatus);

	return model;
    }

    /*
     * Called whenever a user press the "Delete" button of a table row.
     */
    @RequestMapping(value = "/deleteCorrespondence.json", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> getOfficialCourseDescription(@RequestParam("courseId") String courseId ) throws Exception {

	String returnStatus = null;

	try {
	    sakaiProxy.deleteCorrespondence(courseId);
	    returnStatus = "success";
	} catch (Exception e) {
	    log.error("Exception while deleting correspondence: " + e);
	    returnStatus = "failure";
	}

	Map<String, String> model = new HashMap<String, String>();
	model.put("status", returnStatus);

	return  model;
    }
}
