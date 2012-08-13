package ca.hec.portal.logic;

import java.util.List;

import lombok.Setter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SiteService;

import org.sakaiquebec.opensyllabus.common.api.OsylSiteService;

/**
 * Implementation of {@link SakaiProxy}
 */
public class SakaiProxyImpl implements SakaiProxy {
    private static Log log = LogFactory.getLog(SakaiProxyImpl.class);

    @Setter
    private SiteService siteService;

    @Setter
    private OsylSiteService osylSiteService;

    /**
     * {@inheritDoc}
     */
    public String getSpecificCourse(String courseId) {
	List<Site> sites = siteService.getSites(SiteService.SelectionType.ANY, "course",
		courseId, null, SiteService.SortType.CREATED_ON_DESC, null);
	
	for (Site s : sites) {
	    if (osylSiteService.hasBeenPublished(s.getId()))
		return s.getTitle();
	}
	return "";
    }

    /**
     * init - perform any actions required here for when this bean starts up
     */
    public void init() {
    	log.info("init");
    }
}
