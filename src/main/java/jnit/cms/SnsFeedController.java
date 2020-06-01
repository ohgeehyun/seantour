/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.UrlUtil;
import jnit.com.util.FileStream;
import net.sf.json.xml.XMLSerializer;
import twitter4j.MediaEntity;
import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;

@Controller
public class SnsFeedController {

	private Log log = LogFactory.getLog(getClass());
	
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    
    @RequestMapping("/twitter/timeline.do")
    public String twitterTimeline(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    		JSONObject result = new JSONObject();
    		int pageCount = NullUtil.nullInt(request.getParameter("page"));
    		String latestPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + "sns" + SEPERATOR + "twitter.json";
	    	String latestDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + "sns";
	    	File dataFile = new File(latestPath);
    		Boolean hasFile = false;
    		File latestDir = new File(latestDirPath);
    		if(!latestDir.exists()){
    			latestDir.mkdir();
    		}
    		if(pageCount == 0){
    			pageCount = 1;
    		}
    		if(!dataFile.exists()){
    			hasFile = false;
    		}else{
    			hasFile = true;
    		}	
    		Calendar cal = Calendar.getInstance();
    		try {
	    		if(hasFile){
	    			String JsonStr = FileStream.readFileToString(dataFile, "UTF-8");
	    			//log.debug("time gap : " + (cal.getTimeInMillis() - dataFile.lastModified()));
	    			// 5분이 지난 데이터는 새로 로드한다.
	    			if( (cal.getTimeInMillis() - dataFile.lastModified()) < 60000 * 5){
	    				
	    				model.addAttribute("json",net.sf.json.JSONObject.fromObject(JsonStr));
	    				
	    			}else{
	    				AccessToken accesstoken = new AccessToken("76295962-NWXflLo6kohPIYoUZAlqoUbQXW3o4PvZmsa1i6cnr", "84TzpZu38rKOyi6K4QhhovGYYZzU1o0CFctcs1DOlXl9P");
					    Twitter twitter = TwitterFactory.getSingleton();
					    twitter.setOAuthConsumer("sjOBIxsnhJhbifXv561JFVCkH", "mqqUZL33WS2YhLBAZK6tl24ntjC2XW22vXrjHdkop0tCxYc2To");
					    twitter.setOAuthAccessToken(accesstoken);
					    User user = twitter.verifyCredentials();
					    Paging page = new Paging (pageCount, 64);
					    List<Status> list = twitter.getUserTimeline(page);
					    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					    result.put("name", user.getScreenName());
					    result.put("ProfileImage", user.getMiniProfileImageURL());
					    int i = 0;
					    for(Status status : list) {
					        for (MediaEntity mediaEntity : status.getMediaEntities()) {
					            result.put("line"+i+"mediaurl", mediaEntity.getURL().replaceAll(" ",""));
					            result.put("line"+i+"imgurl",  mediaEntity.getMediaURL());
					        }
					        result.put("line"+i+"url", "https://twitter.com/cromtwins/status/"+status.getId());
					        result.put("line"+i, status.getText());
					        result.put("line"+i+"fc", status.getFavoriteCount());
					        result.put("line"+i+"date", sdf.format(status.getCreatedAt()));
					        i++;
					    }
					    FileWriter latestFileW = new FileWriter(latestPath);
						latestFileW.write(result.toString());
						latestFileW.flush();
						latestFileW.close();
						model.addAttribute("json",result);
	    			}
	    			
	    		}else{
	    			AccessToken accesstoken = new AccessToken("76295962-NWXflLo6kohPIYoUZAlqoUbQXW3o4PvZmsa1i6cnr", "84TzpZu38rKOyi6K4QhhovGYYZzU1o0CFctcs1DOlXl9P");
				    Twitter twitter = TwitterFactory.getSingleton();
				    twitter.setOAuthConsumer("sjOBIxsnhJhbifXv561JFVCkH", "mqqUZL33WS2YhLBAZK6tl24ntjC2XW22vXrjHdkop0tCxYc2To");
				    twitter.setOAuthAccessToken(accesstoken);
				    User user = twitter.verifyCredentials();
				    Paging page = new Paging (pageCount, 64);
				    List<Status> list = twitter.getUserTimeline(page);
				    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				    result.put("name", user.getScreenName());
				    result.put("ProfileImage", user.getMiniProfileImageURL());
				    int i = 0;
				    for(Status status : list) {
				        for (MediaEntity mediaEntity : status.getMediaEntities()) {
				            result.put("line"+i+"mediaurl", mediaEntity.getURL().replaceAll(" ",""));
				            result.put("line"+i+"imgurl",  mediaEntity.getMediaURL());
				        }
				        result.put("line"+i+"url", "https://twitter.com/cromtwins/status/"+status.getId());
				        result.put("line"+i, status.getText());
				        result.put("line"+i+"fc", status.getFavoriteCount());
				        result.put("line"+i+"date", sdf.format(status.getCreatedAt()));
				        i++;
				    }
				    FileWriter latestFileW = new FileWriter(latestPath);
					latestFileW.write(result.toString());
					latestFileW.flush();
					latestFileW.close();
					model.addAttribute("json",result);
	    		}
			    
			}catch (java.lang.IllegalStateException e) {
				if(hasFile){
	    			String JsonStr = FileStream.readFileToString(dataFile, "UTF-8");
	    			//log.debug("time gap : " + (cal.getTimeInMillis() - dataFile.lastModified()));
	    			// 5분이 지난 데이터는 새로 로드한다.
	    			if( (cal.getTimeInMillis() - dataFile.lastModified()) < 60000 * 5){
	    				
	    				model.addAttribute("json",net.sf.json.JSONObject.fromObject(JsonStr));
	    				
	    			}else{
						Twitter twitter = TwitterFactory.getSingleton();
					    User user = twitter.verifyCredentials();
					    Paging page = new Paging (pageCount, 64);
					    List<Status> list = twitter.getUserTimeline(page);
					    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					    
					    result.put("name", user.getScreenName());
					    result.put("ProfileImage", user.getMiniProfileImageURL());
					    int i = 0;
					    for(Status status : list) {
					        for (MediaEntity mediaEntity : status.getMediaEntities()) {
					            result.put("line"+i+"mediaurl", mediaEntity.getURL().replaceAll(" ",""));
					            result.put("line"+i+"imgurl",  mediaEntity.getMediaURL());
					        }
					        result.put("line"+i+"url", "https://twitter.com/cromtwins/status/"+status.getId());
					        result.put("line"+i, status.getText());
					        result.put("line"+i+"fc", status.getFavoriteCount());
					        result.put("line"+i+"date", sdf.format(status.getCreatedAt()));
					        i++;
					    }
					    FileWriter latestFileW = new FileWriter(latestPath);
						latestFileW.write(result.toString());
						latestFileW.flush();
						latestFileW.close();
						model.addAttribute("json",result);
	    			}
				}else{
					Twitter twitter = TwitterFactory.getSingleton();
				    User user = twitter.verifyCredentials();
				    Paging page = new Paging (pageCount, 64);
				    List<Status> list = twitter.getUserTimeline(page);
				    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				    
				    result.put("name", user.getScreenName());
				    result.put("ProfileImage", user.getMiniProfileImageURL());
				    int i = 0;
				    for(Status status : list) {
				        for (MediaEntity mediaEntity : status.getMediaEntities()) {
				            result.put("line"+i+"mediaurl", mediaEntity.getURL().replaceAll(" ",""));
				            result.put("line"+i+"imgurl",  mediaEntity.getMediaURL());
				        }
				        result.put("line"+i+"url", "https://twitter.com/cromtwins/status/"+status.getId());
				        result.put("line"+i, status.getText());
				        result.put("line"+i+"fc", status.getFavoriteCount());
				        result.put("line"+i+"date", sdf.format(status.getCreatedAt()));
				        i++;
				    }
				    FileWriter latestFileW = new FileWriter(latestPath);
					latestFileW.write(result.toString());
					latestFileW.flush();
					latestFileW.close();
					model.addAttribute("json",result);
				}
			   
			}
    		catch (Exception e) {
			    log.error(e.getMessage());
			   
			}
    		return "/jnit/util/json"; 
	}
    
    @RequestMapping("/naver/getrss.do")
    public String naverGetRss(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    		net.sf.json.JSONObject result = new net.sf.json.JSONObject();
	    	StringBuilder sbUrl = new StringBuilder("http://blog.rss.naver.com/seoulwonsoon.xml");
	    	String latestPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + "sns" + SEPERATOR + "naverblog.json";
	    	String latestDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + "sns";
	    	File dataFile = new File(latestPath);
    		Boolean hasFile = false;
    		File latestDir = new File(latestDirPath);
    		if(!latestDir.exists()){
    			latestDir.mkdir();
    		}
	        try {
	        	if(!dataFile.exists()){
	    			hasFile = false;
	    		}else{
	    			hasFile = true;
	    		}		
	    		Calendar cal = Calendar.getInstance();
	    		if(hasFile){
	    			String JsonStr = FileStream.readFileToString(dataFile, "UTF-8");
	    			//log.debug("time gap : " + (cal.getTimeInMillis() - dataFile.lastModified()));
	    			// 5분이 지난 데이터는 새로 로드한다.
	    			if( (cal.getTimeInMillis() - dataFile.lastModified()) < 60000 * 5){
	    				result =  net.sf.json.JSONObject.fromObject(JsonStr);
	    				
	    			}else{
	    				String blogxml = UrlUtil.getStringByUrl(sbUrl.toString());
			        	//log.debug(blogxml);
			        	result = (net.sf.json.JSONObject)new XMLSerializer().read(blogxml);
			        	FileWriter latestFileW = new FileWriter(latestPath);
						latestFileW.write(result.toString());
						latestFileW.flush();
						latestFileW.close();
	    			}
	    		}else{
		        	String blogxml = UrlUtil.getStringByUrl(sbUrl.toString());
		        	//log.debug(blogxml);
		        	result = (net.sf.json.JSONObject)new XMLSerializer().read(blogxml);
		        	FileWriter latestFileW = new FileWriter(latestPath);
					latestFileW.write(result.toString());
					latestFileW.flush();
					latestFileW.close();
	    		}
	        } catch (IOException e){
	        	log.error(e.getMessage());
    			//에러가 발생시 파일을 읽어옴
    			String JsonStr = FileStream.readFileToString(dataFile, "UTF-8");
    			result =  net.sf.json.JSONObject.fromObject(JsonStr);
			}
    		catch (Exception e) {
			    log.error(e.getMessage());
    			//에러가 발생시 파일을 읽어옴
    			String JsonStr = FileStream.readFileToString(dataFile, "UTF-8");
    			result =  net.sf.json.JSONObject.fromObject(JsonStr);
			}
    		
    		model.addAttribute("json",result);
    		return "/jnit/util/json"; 
	}
}