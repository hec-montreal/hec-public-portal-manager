package ca.hec.portal.entityprovider;

import java.util.List;
import java.util.Map;

import lombok.Setter;

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

import ca.hec.portal.api.PortalManagerService;

public class PortalManagerEntityProviderImpl extends AbstractEntityProvider 
	implements CoreEntityProvider, AutoRegisterEntityProvider, Resolvable, Sampleable, Outputable, ActionsExecutable {

	public final static String ENTITY_PREFIX = "portalManager";
	
	
	@Setter 
	private PortalManagerService portalManagerService;

	public String[] getHandledOutputFormats() {
		return new String[] { Formats.JSON };
	}

	@EntityCustomAction(action="getDepartments", viewKey=EntityView.VIEW_LIST)
	public List<?> getDepartments(EntityView view, Map<String, Object> params) {		
				return portalManagerService.getDepartments();
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
