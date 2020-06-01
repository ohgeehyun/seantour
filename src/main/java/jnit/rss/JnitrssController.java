/**
 * @version 3.2.0.1
 */
package jnit.rss;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : JnitrssController.java
 * @Description : RSS를 읽어온다
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.09.08
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller

public class JnitrssController {
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    String skin = "normal";
    String rssUrl;
	String mode;
	String rssId;
	int entryIdx;
    /**
     * RSS Reader List
     */
    @RequestMapping(value="/rss/reader.do")
    public String RssReader(
    		HttpServletRequest request, 
    		ModelMap model)
            throws Exception {
    	model.addAttribute("ctxRoot",request.getContextPath());
    	mode = NullUtil.nullString(request.getParameter("mode"));
    	skin = (NullUtil.nullString(request.getParameter("skin")).equals("") ? skin : NullUtil.nullString(request.getParameter("skin")));
    	rssId = NullUtil.nullString(request.getParameter("rssId"));
    	entryIdx = NullUtil.nullInt(request.getParameter("entryIdx"));
    	mode = (rssId.equals(""))?"list":mode;
		int intRssId = (rssId.equals(""))?0:Integer.parseInt(rssId);
		switch(intRssId){
			case 1://전체뉴스 
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php";
				break;
			case 2://이달의포커스
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php?sgidx=1";
				break;
			case 3://영상뉴스
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php?sgidx=3";
				break;
			case 4://보도자료
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php?sgidx=2";
				break;
			case 5://포토갤러리
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php?sgidx=4";
				break;
			case 6://정보마당
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php?sgidx=6";
				break;
			case 7://많이본기사
				rssUrl = "http://enews2.gurye.go.kr/rss/rss.php?kind=best";
				break;
			default://error
				if("true".equals(deDug)) System.out.println("rssId값이 넘어오지 않았습니다.");
				return "/jnit/rss/readerList";
		}
        if(mode.equals("list") || mode.equals("")){
        	if("true".equals(deDug)) System.out.println("list");
        	return RssList(request, model, skin, rssUrl);	
        }
        if(mode.equals("view")){
        	if("true".equals(deDug)) System.out.println("view");
        	return RssView(request, model, skin, rssUrl, entryIdx);
        }
        
        return "/jnit/rss/readerList";
    }
    /**
     * RSS Reader List
     */
    public String RssList(
    		HttpServletRequest request,
    		ModelMap model,
    		String skin,
    		String rssUrl)
            throws Exception {

    	model.addAttribute("rssUrl", rssUrl);
/*
        SyndFeedInput input = new SyndFeedInput();
        SyndFeed feed = input.build(new XmlReader(new URL(rssUrl)));
        
        List feedList = feed.getEntries();
        model.addAttribute("feedList",feedList);
        System.out.println(feedList);
*/
        skin = skin.replace("/", "");

    	return "/jnit/rss/"+skin+"/list";
    }
    /**
     * RSS Reader View
     */
    public String RssView(
    		HttpServletRequest request,
    		ModelMap model,
    		String skin,
    		String rssUrl,
    		int entryIdx)
            throws Exception {

    	model.addAttribute("rssUrl", rssUrl);
    	model.addAttribute("entryIdx", entryIdx);
    	
    	model.addAttribute("skin", skin);
    	model.addAttribute("rssId", NullUtil.nullString(request.getParameter("rssId")));
    	
/*    	
        SyndFeedInput input = new SyndFeedInput();
        SyndFeed feed = input.build(new XmlReader(new URL(rssUrl)));
        List feedList = feed.getEntries();
        SyndEntry feedView = (SyndEntry)feedList.get(entryIdx);
        model.addAttribute("feedView",feedView);
*/        
        skin = skin.replace("/", "");
    	return "/jnit/rss/"+skin+"/view";
    }
    
}
