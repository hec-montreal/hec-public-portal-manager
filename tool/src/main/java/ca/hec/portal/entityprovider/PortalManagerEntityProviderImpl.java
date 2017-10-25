package ca.hec.portal.entityprovider;

import ca.hec.commons.utils.FormatUtils;
import ca.hec.portal.api.OfficialCourseDescriptionService;
import ca.hec.portal.api.PortalManagerService;
import ca.hec.portal.logic.SakaiProxy;
import ca.hec.portal.model.OfficialCourseDescription;
import ca.hec.portal.model.SimpleOfficialCourseDescription;
import lombok.Setter;
import org.apache.commons.lang.StringUtils;
import org.sakaiproject.entitybroker.EntityReference;
import org.sakaiproject.entitybroker.EntityView;
import org.sakaiproject.entitybroker.entityprovider.CoreEntityProvider;
import org.sakaiproject.entitybroker.entityprovider.annotations.EntityCustomAction;
import org.sakaiproject.entitybroker.entityprovider.capabilities.*;
import org.sakaiproject.entitybroker.entityprovider.extension.Formats;
import org.sakaiproject.entitybroker.entityprovider.search.Search;
import org.sakaiproject.entitybroker.exception.EntityNotFoundException;
import org.sakaiproject.entitybroker.exception.FormatUnsupportedException;
import org.sakaiproject.entitybroker.util.AbstractEntityProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

public class PortalManagerEntityProviderImpl extends AbstractEntityProvider
	implements CoreEntityProvider, AutoRegisterEntityProvider, Resolvable, Sampleable, Outputable, ActionsExecutable {

    public final static String ENTITY_PREFIX = "portalManager";

    @Setter
    @Autowired
    private PortalManagerService portalManagerService;

	@Setter
	@Autowired
	private OfficialCourseDescriptionService officialCourseDescriptionService;

    @Setter
    @Autowired
    private SakaiProxy sakaiProxy;

    public String[] getHandledOutputFormats() {
	return new String[] { Formats.JSON, Formats.HTML, Formats.XML };
    }


	@EntityCustomAction(action = "getOfficialCourseDescription", viewKey = EntityView.VIEW_LIST)
	public Object getOfficialCourseDescription(EntityView view, Map<String, Object> params) {
		String courseId = view.getPathSegment(2);
		return officialCourseDescriptionService.getOfficialCourseDescription(courseId);
	}

	@EntityCustomAction(action = "getOfficialCourseDescriptions", viewKey = EntityView.VIEW_LIST)
	public List<?> getOfficialCourseDescriptions(EntityView view, Map<String, Object> params) {
		Search search = new Search();
		List<String> seachScopesList = null;
		Map<String, String> eqCriteria = new HashMap<String, String>();
		Map<String, String> seachCriteria = new HashMap<String, String>();
		String searchWords = null;
		String searchScope = (String)params.get("searchScope");
		List<SimpleOfficialCourseDescription> listSimpleOfficialCourseDescriptions;

		if (searchScope != null){
			seachScopesList = Arrays.asList(searchScope.split(","));
		}

		for (String  param : params.keySet()) {
			if (param.equals("department")
					|| param.equals("career")
					|| param.equals("courseId")) {
				eqCriteria.put(param, (String) params.get(param));
			}

			if (param.equals("searchWords")) {
				String stringSearch =(String)params.get(param);
				for (String scope : seachScopesList) {
					seachCriteria.put(scope, stringSearch);
				}
			}
		}

		listSimpleOfficialCourseDescriptions =
				simplifyOfficialCourseDescriptions(officialCourseDescriptionService.getOfficialCourseDescriptions(
						eqCriteria, seachCriteria));

		// unless we have search criteria (in this case we sort by search
		// criteria), we sort catalog descriptions according to the session #,
		// course # and year (we get it from courseId parameter)
		if (seachCriteria.isEmpty()) {
			Collections.sort(listSimpleOfficialCourseDescriptions);
		}

		return listSimpleOfficialCourseDescriptions;
	}

	public List<SimpleOfficialCourseDescription> simplifyOfficialCourseDescriptions(
			List<OfficialCourseDescription> officialCourseDescriptions) {
		List<SimpleOfficialCourseDescription> simpleOfficialCourseDescriptions =
				new ArrayList<SimpleOfficialCourseDescription>();

		// convert raw OfficialCourseDescriptions into decorated catalog descriptions
		for (OfficialCourseDescription cd : officialCourseDescriptions) {

			SimpleOfficialCourseDescription simpleCd = simplifyOfficialCourseDescription(cd);
			if (simpleCd.getDepartmentGroup() != null) {
				simpleOfficialCourseDescriptions.add(simpleCd);
			}
		}

		return simpleOfficialCourseDescriptions;
	}

	public SimpleOfficialCourseDescription simplifyOfficialCourseDescription(
			OfficialCourseDescription cd) {
		SimpleOfficialCourseDescription scd = new SimpleOfficialCourseDescription();

		scd.setTitle(cd.getTitle());
		scd.setDescription(cd.getDescription());
		scd.setDepartmentGroup(portalManagerService.getDepartmentGroup(cd.getDepartment()));
		scd.setCareerGroup(portalManagerService.getCareerGroup(cd.getCareer()));
		scd.setRequirements(cd.getRequirements());
		scd.setCourseId(cd.getCourseId());
		scd.setHyphenatedCourseId(FormatUtils.formatCourseId(cd.getCourseId()));
		scd.setCredits("" + cd.getCredits());

		String lang = cd.getLanguage();
		if (lang != null)
			scd.setLang(lang.substring(0, 2));

		return scd;
	}


	@EntityCustomAction(action = "getDepartments", viewKey = EntityView.VIEW_LIST)
    public List<?> getDepartments(EntityView view, Map<String, Object> params) {
	String locale = view.getPathSegment(2);
	return portalManagerService.getDepartments(locale);
    }

    @EntityCustomAction(action = "getCareers", viewKey = EntityView.VIEW_LIST)
    public List<?> getCareers(EntityView view, Map<String, Object> params) {
	String locale = view.getPathSegment(2);
	return portalManagerService.getCareers(locale);
    }

    @EntityCustomAction(action = "getBundles", viewKey = EntityView.VIEW_LIST)
    public Map<?, ?> getBundles(EntityView view, Map<String, Object> params) {
	String locale = view.getPathSegment(2);
	return portalManagerService.getBundle(locale);
    }

    @EntityCustomAction(action = "public_syllabus", viewKey = EntityView.VIEW_SHOW)
    public Object getPublicSyllabus(EntityView view) {
	String courseId = view.getPathSegment(1);

	// check that courseid is supplied
	if (StringUtils.isBlank(courseId)) {
	    throw new IllegalArgumentException(
		    "CourseId must be set in order to get public course outline via the URL /portalManager/:ID:/public_syllabus");
	}

	String site_id = null;
	try {
	    site_id = sakaiProxy.getAssociatedCourseSiteId(courseId);
	} catch (Exception e) {
	    e.printStackTrace();
	}
	
	if (site_id == null)
	    throw new EntityNotFoundException("No public course outline available", courseId);

	if (view.getFormat().equals(Formats.HTML)) {
	    String html = sakaiProxy.getCourseOutlineHTML(site_id);
	    
	    if (html != null)
		return html;
	    else
		throw new EntityNotFoundException("No public course outline available", courseId);
	}
	else if (view.getFormat().equals(Formats.JSON)){
	    Map<String, String> courseInfo = new HashMap<String, String>();
	    String pdf_url = "";

	    // if there is only one '.' it is a shareable course site OR
	    // the string following the last '.' is P1 - P9 (it's a shareable from MBA)
	    Boolean shareable = 
		    (site_id.indexOf('.') == site_id.lastIndexOf('.') ||
		    site_id.substring(site_id.lastIndexOf('.')+1).matches("P[1-9]"));
	    
	    if (site_id != "") {
		pdf_url = "/sdata/c/attachment/" + site_id + "/OpenSyllabus/" + 
			site_id + (shareable ? ".00" : "") + "_public.pdf";
	    }
		
	    courseInfo.put("site_id", site_id);	
	    courseInfo.put("pdf_url", pdf_url);

	    return courseInfo;
	}
	else throw new FormatUnsupportedException("", site_id, view.getFormat());
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
