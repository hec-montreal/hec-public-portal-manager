package ca.hec.portal.entityprovider;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Setter;

import org.apache.commons.lang.StringUtils;
import org.sakaiproject.entitybroker.EntityReference;
import org.sakaiproject.entitybroker.EntityView;
import org.sakaiproject.entitybroker.entityprovider.CoreEntityProvider;
import org.sakaiproject.entitybroker.entityprovider.annotations.EntityCustomAction;
import org.sakaiproject.entitybroker.entityprovider.capabilities.ActionsExecutable;
import org.sakaiproject.entitybroker.entityprovider.capabilities.AutoRegisterEntityProvider;
import org.sakaiproject.entitybroker.entityprovider.capabilities.Outputable;
import org.sakaiproject.entitybroker.entityprovider.capabilities.Resolvable;
import org.sakaiproject.entitybroker.entityprovider.capabilities.Sampleable;
import org.sakaiproject.entitybroker.entityprovider.extension.Formats;
import org.sakaiproject.entitybroker.util.AbstractEntityProvider;
import org.springframework.beans.factory.annotation.Autowired;

import ca.hec.portal.logic.SakaiProxy;
import ca.hec.portal.api.PortalManagerService;

public class PortalManagerEntityProviderImpl extends AbstractEntityProvider
	implements CoreEntityProvider, AutoRegisterEntityProvider, Resolvable, Sampleable, Outputable, ActionsExecutable {

    public final static String ENTITY_PREFIX = "portalManager";

    @Setter
    @Autowired
    private PortalManagerService portalManagerService;

    @Setter
    @Autowired
    private SakaiProxy sakaiProxy;

    public String[] getHandledOutputFormats() {
	return new String[] { Formats.JSON, "pdf" };
    }

    @EntityCustomAction(action = "getDepartments", viewKey = EntityView.VIEW_LIST)
    public List<?> getDepartments(EntityView view, Map<String, Object> params) {
	return portalManagerService.getDepartments();
    }

    @EntityCustomAction(action = "getCareers", viewKey = EntityView.VIEW_LIST)
    public List<?> getCareers(EntityView view, Map<String, Object> params) {
	return portalManagerService.getCareers();
    }

    @EntityCustomAction(action = "getBundles", viewKey = EntityView.VIEW_LIST)
    public Map<?, ?> getBundles(EntityView view, Map<String, Object> params) {
	String locale = view.getPathSegment(2);
	return portalManagerService.getBundle(locale);
    }

    @EntityCustomAction(action = "public_syllabus_info", viewKey = EntityView.VIEW_SHOW)
    public Object getPublicSyllabus(EntityView view) {
	String courseId = view.getPathSegment(1);
	String extension = view.getExtension();

	// check that courseid is supplied
	if (StringUtils.isBlank(courseId)) {
	    throw new IllegalArgumentException(
		    "CourseId must be set in order to get specific course via the URL /portalManager/:ID:/public_syllabus_info");
	}

	Map<String, String> courseInfo = new HashMap<String, String>();
	String site_id = sakaiProxy.getAssociatedCourseSiteTitle(courseId);
	String pdf_url = "";

	// if there is only one '.' it is a shareable course site
	Boolean	shareable = (site_id.indexOf('.') == site_id.lastIndexOf('.'));
	if (site_id != "") {
	    pdf_url = "/sdata/c/attachment/" + site_id + "/OpenSyllabus/" + 
		    site_id + (shareable ? ".00" : "") + "_public.pdf";
	}
	
	courseInfo.put("site_id", site_id);	
	courseInfo.put("pdf_url", pdf_url);

//	if (view.getExtension().equals(Formats.JSON)) {
	    return sakaiProxy.getCourseOutlineContent(site_id);
//	}
//	else
//	    return courseInfo;
    }

    public String getEntityPrefix() {
	return ENTITY_PREFIX;
    }

    public Object getSampleEntity() {
	return null;
    }

    public Object getEntity(EntityReference ref) {
	return null;
    }

    public boolean entityExists(String id) {
	return false;
    }

}
