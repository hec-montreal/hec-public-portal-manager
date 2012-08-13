package ca.hec.portal.entityprovider;

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
	return new String[] { Formats.JSON };
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

    @EntityCustomAction(action = "specific-course", viewKey = EntityView.VIEW_SHOW)
    public Object getSpecificCourse(EntityView view) {
	String courseId = view.getPathSegment(1);

	// check that courseid is supplied
	if (StringUtils.isBlank(courseId)) {
	    throw new IllegalArgumentException(
		    "CourseId must be set in order to get specific course via the URL /portalManager/getSpecificCourse/:ID:");
	}

	return sakaiProxy.getSpecificCourse(courseId);
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
