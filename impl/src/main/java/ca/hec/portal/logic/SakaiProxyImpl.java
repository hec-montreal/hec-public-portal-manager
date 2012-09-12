package ca.hec.portal.logic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import lombok.Setter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.coursemanagement.api.AcademicSession;
import org.sakaiproject.coursemanagement.api.CourseManagementService;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SiteService;

import org.sakaiquebec.opensyllabus.common.api.OsylSiteService;
import org.sakaiquebec.opensyllabus.common.model.COModeledServer;
import org.sakaiquebec.opensyllabus.shared.model.COContent;
import org.sakaiquebec.opensyllabus.shared.model.COElementAbstract;
import org.sakaiquebec.opensyllabus.shared.model.COModelInterface;
import org.sakaiquebec.opensyllabus.shared.model.COSerialized;
import org.sakaiquebec.opensyllabus.shared.model.COStructureElement;
import org.sakaiquebec.opensyllabus.shared.model.COUnit;
import org.sakaiquebec.opensyllabus.shared.model.COUnitStructure;

import ca.hec.portal.model.SimpleCourseOutline;

/**
 * Implementation of {@link SakaiProxy}
 */
public class SakaiProxyImpl implements SakaiProxy {
    private static Log log = LogFactory.getLog(SakaiProxyImpl.class);

    @Setter
    private SiteService siteService;

    @Setter
    private OsylSiteService osylSiteService;
    
    @Setter 
    private CourseManagementService cmService;

    // Class for comparing the academic sessions by Id Descending.
    public class ComparableAcademicSession implements Comparator<AcademicSession> {	 
	    public int compare(AcademicSession o1, AcademicSession o2) {
		return o2.getEid().compareTo(o1.getEid());
	    }
	}
    
    /**
     * {@inheritDoc}
     */
    public String getAssociatedCourseSiteTitle(String courseId) {
	Date today = new Date();
	
	List<AcademicSession> sessions = cmService.getAcademicSessions();
	Collections.sort(sessions, new ComparableAcademicSession());
	
	ArrayList<String> sessionNames = new ArrayList<String>();

	// get all academic sessions, and add their formatted names to the list
	for (AcademicSession session : sessions) {
	    String sessionName = osylSiteService.getSessionName(session);
	    
	    // if the session is completed and not yet in the list, add it
	    if (session.getEndDate().before(today) && !sessions.contains(sessionName)) {
		sessionNames.add(sessionName);
	    }
	}
	
	// Start searching the sessions for a course site with a published course outline to use
	for (String sessionName : sessionNames) {
	    // Get the sites with the given Id and Session in the title
	    List<Site> sites = siteService.getSites(SiteService.SelectionType.ANY, "course",
		courseId + "." + sessionName, null, SiteService.SortType.TITLE_ASC, null);

	    for (Site s : sites) {
		if (osylSiteService.hasBeenPublished(s.getId())) {
		    return s.getTitle();
		}
	    }
	}
		
	return "";
    }
    
    public SimpleCourseOutline getCourseOutlineContent(String siteId) {
	SimpleCourseOutline courseOutline = new SimpleCourseOutline();
	
	COSerialized coSerialized;
	COContent coContent = null;
	
	try {
	    // TODO this has to change (get the right CO
	    coSerialized = osylSiteService.getAllCO().get(0);//osylSiteService.getSerializedCourseOutline(siteId, "http://localhost:8080/osyl-editor-sakai-tool/");
	    COModeledServer coModeledServer =
		    new COModeledServer(coSerialized);
	    coModeledServer.XML2Model();
	    coContent = coModeledServer.getModeledContent();
	    
	} catch (Exception e) {
	    e.printStackTrace();
	}
	
	// displaying all branches
	List<COElementAbstract> children = null;
//	if (coContent.isCourseOutlineContent()
//		|| coContent.isCOStructureElement()
//		|| coContent.isCOUnitStructure() 
//		|| coContent.isCOUnit()) {
	    children = coContent.getChildrens();
//	} else {
//	    return;
//	}

	Iterator<COElementAbstract> iter = children.iterator();
	while (iter.hasNext()) {
	    // this can be a Lecture leaf
	    COElementAbstract itemModel = (COElementAbstract) iter.next();
	    // Compute the maximum tree width

	    if (itemModel.isCOStructureElement()) {
//		List<COModelInterface> subModels =
//			getController().getOsylConfig().getOsylConfigRuler()
//				.getAllowedSubModels(itemModel);
//		if (itemModel.getChildrens().size() == 1 && subModels.isEmpty()) {
//		    COElementAbstract childOfAsmStruct =
//			    (COElementAbstract) itemModel.getChildrens().get(0);
//		    if (childOfAsmStruct.isCOUnit()) {
//			addUnitTreeItem(currentTreeItem,
//				(COUnit) childOfAsmStruct);
//			((COUnit) childOfAsmStruct).addEventHandler(this);
//		    } else if (childOfAsmStruct.isCOStructureElement()) {
//			addStructTreeItem(currentTreeItem,
//				(COStructureElement) childOfAsmStruct);
//			((COStructureElement) childOfAsmStruct)
//				.addEventHandler(this);
//		    }
//		    refreshSubModelsViews(childOfAsmStruct);

//		} else {
//		    addStructTreeItem(currentTreeItem,
//			    (COStructureElement) itemModel);
//		    ((COStructureElement) itemModel).addEventHandler(this);
//		    if (!itemModel.getChildrens().isEmpty())
//			refreshSubModelsViews(itemModel);
//		}
	    } else if (itemModel.isCOUnitStructure()) {
//		if (currentModel.getChildrens().size() > 1) {
//		    addUnitStructureTreeItem(currentTreeItem,
//			    (COUnitStructure) itemModel);
//		    refreshSubModelsViews(itemModel);
//		}
	    } else if (itemModel.isCOUnit()) {
//		addUnitTreeItem(currentTreeItem, (COUnit) itemModel);
//		((COUnit) itemModel).addEventHandler(this);
//		refreshSubModelsViews(itemModel);
	    } else {
//		break;
	    }

	    courseOutline.getTitles().add(((COUnit)itemModel.getChildrens().get(0)).getLabel());
	}

//	courseOutline.getTitles().add("Presentation du course");
//	courseOutline.getTitles().add("coordonnees");
//	courseOutline.getTitles().add("materiel pedagogique");
	
	return courseOutline;
    }

    /**
     * init - perform any actions required here for when this bean starts up
     */
    public void init() {
    	log.info("init");
    }
}
