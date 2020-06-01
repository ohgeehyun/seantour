/**
 * @version 3.2.0.1
 */
package jnit.analytics;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.analytics.Analytics;
import com.google.api.services.analytics.Analytics.Data.Ga.Get;
import com.google.api.services.analytics.AnalyticsScopes;
import com.google.api.services.analytics.model.GaData;
import com.google.api.services.analytics.model.RealtimeData;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.AdminUtil;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.util.PathUtil;


/**
 * This is a basic hello world sample for the Google Analytics API. It is designed to run from the
 * command line and will prompt a user to grant access to their data. Once complete, the sample will
 * traverse the Management API hierarchy by going through the authorized user's first account, first
 * web property, and finally the first profile and retrieve the first profile id. This ID is then
 * used with the Core Reporting API to retrieve the top 25 organic search terms.
 *
 * @author api.nickm@gmail.com
 */
@Controller
public class HelloAnalyticsApi {

	public static Log log = LogFactory.getLog(HelloAnalyticsApi.class);
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	private final static String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
	
	@Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
	  /**
	   * Main demo. This first initializes an Analytics service object. It then queries for the top 25
	   * organic search keywords and traffic sources by visits. Finally each important part of the
	   * response is printed to the screen.
	   *
	   * @param args command line args.
	   */
      @RequestMapping(value="/analytics.do")
	  public String main(ModelMap model,
	    		HttpServletRequest request) throws IOException {
    	// This is the .p12 file you got from the google api console by clicking generate new key
    	  String returnPath = "";
    	  String req = NullUtil.nullString(request.getParameter("mode"));
  		  String searchSite = NullUtil.nullString(request.getParameter("searchSite"));
  		  model.addAttribute("searchSite",searchSite);
    	  try {
    		
    	    if(req.equals("")){
    	    	req = "date";
    	    }
    	    String analyticsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/analyticsProp.prop";
    		
    		Properties analytics = new Properties();
    		File currentDefaultPropFile = new File(analyticsPath);
    		InputStreamReader isr = null;
    		FileInputStream fis = null;
    		if(currentDefaultPropFile.exists()){
    			try {
    				fis = new FileInputStream(currentDefaultPropFile);
    				isr = new InputStreamReader(fis, "UTF-8");
    				analytics.load(isr);
    			} catch (UnsupportedEncodingException e) {
    				log.error(e.getMessage());
    			}  finally {
    				isr.close();
    				fis.close();
    			}
    			
    		}
    		String debug = EgovProperties.getProperty("Globals.Debug");
    		if(debug.equals("true")){
    			log.debug(analytics.get("apiEmail"));
        		log.debug(analytics.get("applicationName"));
        		log.debug(analytics.get("viewId"));
        		log.debug(uploadDir+analytics.get("analyticsKeyFile"));
    		}
    		
    		
    		
    		File analyticsKeyFile = new File(uploadDir+analytics.get("analyticsKeyFile"));

    	    // This is the service account email address that you can find in the api console
    	    String apiEmail = (String) analytics.get("apiEmail");
    	    
    	    GoogleCredential credential = new GoogleCredential.Builder()
    	        .setTransport(HTTP_TRANSPORT)
    	        .setJsonFactory(JSON_FACTORY)
    	        .setServiceAccountId(apiEmail)
    	        .setServiceAccountScopes(Arrays.asList(AnalyticsScopes.ANALYTICS_READONLY))
    	        .setServiceAccountPrivateKeyFromP12File(analyticsKeyFile).build();

    	    Analytics analyticsService = new Analytics.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential)
    	        .setApplicationName((String) analytics.get("applicationName"))
    	        .build();
    	    
    	    JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    		siteSearchVO.setFirstIndex(0);
    		siteSearchVO.setLastIndex(1000);
    		siteSearchVO.setRecordCountPerPage(1000);
    		List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    		model.addAttribute("resultSiteList", resultSiteList);
    		HashMap<String, String> site = new HashMap<String, String>();
    		Iterator i = (Iterator)resultSiteList.iterator();	
    		while(i.hasNext()){
	  			EgovMap siteList = (EgovMap)i.next();
	  			site.put(String.valueOf(siteList.get("sitePath")), String.valueOf(siteList.get("siteNm")));
	  			
    		}
    		model.addAttribute("site",site);
    		if(req.equals("time")){
    	    	model.addAllAttributes(time(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/time";
    	    	AdminUtil.setMenuId("m03010100");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/timeExcel";
    	    	}
    	    }
    	    if(req.equals("browser")){
    	    	model.addAllAttributes(browser(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/browser";
    	    	AdminUtil.setMenuId("m03010200");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/browserExcel";
    	    	}
    	    }
    	    if(req.equals("os")){
    	    	model.addAllAttributes(os(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/os";
    	    	AdminUtil.setMenuId("m03010300");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/osExcel";
    	    	}
    	    }
    		
    	    if(req.equals("date")){
    	    	model.addAllAttributes(date(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/date";
    	    	AdminUtil.setMenuId("m03010400");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/dateExcel";
    	    	}
    	    }
    	    if(req.equals("month")){
    	    	model.addAllAttributes(month(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/month";
    	    	AdminUtil.setMenuId("m03010500");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/monthExcel";
    	    	}
    	    }
    	    if(req.equals("year")){
    	    	model.addAllAttributes(year(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/year";
    	    	AdminUtil.setMenuId("m03010600");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/yearExcel";
    	    	}
    	    }
    	    if(req.equals("pageview")){
    	    	model.addAllAttributes(pageview(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/pageview";
    	    	AdminUtil.setMenuId("m03010700");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/pageviewExcel";
    	    	}
    	    }
    	    
    	    if(req.equals("real")){
    	    	model.addAllAttributes(real(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/main";
    	    }
    	    if(req.equals("popular")){
    	    	model.addAllAttributes(popular(analyticsService,request,model,(String) analytics.get("viewId")));
    	    	returnPath = "/jnit/stats/popular";
    	    	AdminUtil.setMenuId("m03010800");
    	    	if(NullUtil.nullString(request.getParameter("excel")).equals("excel")){
    	    		returnPath = "/jnit/stats/popularExcel";
    	    	}
    	    }
    	    
    	   
    	 }catch (GeneralSecurityException e) {
    		 log.error(e.getMessage());
 	     }catch(FileNotFoundException e){
 			//log.error(e.getMessage());
 			if(!req.equals("real")){
	 			model.addAttribute("alert","ANALYTICS 설정을 불러 올 수 없습니다.");
	 			model.addAttribute("path","/cms/");
	 			return "/jnit/util/alertMove";
 			}
 	     }catch (IOException e) {
 	    	log.error(e.getMessage());  
 	     } catch (Exception e) {
 	    	log.error(e.getMessage());
		}
    	   return returnPath;
      }
      
      private ModelMap time(Analytics analyticsService,HttpServletRequest request,ModelMap model, String viewId){
        	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
        	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
        	String filter = NullUtil.nullString(request.getParameter("searchSite"));
      		Calendar date = Calendar.getInstance();
      /*
      		log.debug(termdate.get(Calendar.YEAR));
      		log.debug(termdate.get(Calendar.MONTH));
      		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
      */	    
        	
          	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
            String month = String.valueOf((date.get(Calendar.MONTH)+1));
            String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
            if((date.get(Calendar.MONTH)+1)<10){
            	month = "0"+(date.get(Calendar.MONTH)+1);
            }
            if(date.get(Calendar.DAY_OF_MONTH)<10){
            	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
            }
            now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
            if(startDate.equals("")){
            	startDate = now;
            }
            if(endDate.equals("")){
            	endDate = startDate;
            }
        	    String mertrics = "ga:users,ga:sessions";

        	    // Use the analytics object build a query
        	    Get get;
      		try {
      			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
      		
        	    get.setDimensions("ga:hour");
        	    if(!filter.equals("")){
        	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
            	    
        	    }
        	    //get.setSort("-ga:sessions");

        	    // Run the query
        	    GaData data = get.execute();

        	    // Do something with the data
        	    ArrayList<List> list = new ArrayList<List>(); 
      			
        	    if (data.getRows() != null) {
        	        for (List<String> row : data.getRows()) {
        	           
        	        	list.add(row);
        	        }
        	    }
        	    model.addAttribute("list",list);
        	    model.addAttribute("rsvStartKeyword",startDate);
        	    model.addAttribute("rsvEndKeyword",endDate);
        	    
      		}catch (IOException e) {
      			log.error(e.getMessage());  
      	    }
          	  return model;
            }
        private ModelMap browser(Analytics analyticsService,HttpServletRequest request,ModelMap model, String viewId){
          	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
          	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
          	String filter = NullUtil.nullString(request.getParameter("searchSite"));
        		Calendar date = Calendar.getInstance();
        /*
        		log.debug(termdate.get(Calendar.YEAR));
        		log.debug(termdate.get(Calendar.MONTH));
        		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
        */	    
          	
            	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
              String month = String.valueOf((date.get(Calendar.MONTH)+1));
              String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
              if((date.get(Calendar.MONTH)+1)<10){
              	month = "0"+(date.get(Calendar.MONTH)+1);
              }
              if(date.get(Calendar.DAY_OF_MONTH)<10){
              	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
              }
              now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
              if(startDate.equals("")){
              	startDate = now;
              }
              if(endDate.equals("")){
              	endDate = startDate;
              }
          	    String mertrics = "ga:users,ga:sessions";

          	    // Use the analytics object build a query
          	    Get get;
        		try {
        			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
        		
          	    get.setDimensions("ga:browser");
          	    if(!filter.equals("")){
            	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
                	    
            	    }
          	    //get.setSort("-ga:sessions");

          	    // Run the query
          	    GaData data = get.execute();

          	    // Do something with the data
          	    ArrayList<List> list = new ArrayList<List>(); 
        			
          	    if (data.getRows() != null) {
          	        for (List<String> row : data.getRows()) {
          	           
          	        	list.add(row);
          	        }
          	    }
          	    model.addAttribute("list",list);
          	    model.addAttribute("rsvStartKeyword",startDate);
          	    model.addAttribute("rsvEndKeyword",endDate);
          	    
        		}catch (IOException e) {
        			log.error(e.getMessage());  
        	    }
            	  return model;
              }
        
        private ModelMap os(Analytics analyticsService,HttpServletRequest request,ModelMap model, String viewId){
          	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
          	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
          	String filter = NullUtil.nullString(request.getParameter("searchSite"));
        		Calendar date = Calendar.getInstance();
        /*
        		log.debug(termdate.get(Calendar.YEAR));
        		log.debug(termdate.get(Calendar.MONTH));
        		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
        */	    
          	
            	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
              String month = String.valueOf((date.get(Calendar.MONTH)+1));
              String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
              if((date.get(Calendar.MONTH)+1)<10){
              	month = "0"+(date.get(Calendar.MONTH)+1);
              }
              if(date.get(Calendar.DAY_OF_MONTH)<10){
              	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
              }
              now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
              if(startDate.equals("")){
              	startDate = now;
              }
              if(endDate.equals("")){
              	endDate = startDate;
              }
          	    String mertrics = "ga:users,ga:sessions";

          	    // Use the analytics object build a query
          	    Get get;
        		try {
        			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
        		
          	    get.setDimensions("ga:operatingSystem");
          	    if(!filter.equals("")){
            	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
            	    }
          	    //get.setSort("-ga:sessions");

          	    // Run the query
          	    GaData data = get.execute();

          	    // Do something with the data
          	    ArrayList<List> list = new ArrayList<List>(); 
        			
          	    if (data.getRows() != null) {
          	        for (List<String> row : data.getRows()) {
          	           
          	        	list.add(row);
          	        }
          	    }
          	    
          	    get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
            		
          	    get.setDimensions("ga:operatingSystem,ga:operatingSystemVersion");
          	    if(!filter.equals("")){
            	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
            	    }
          	    //get.setSort("-ga:sessions");

          	    // Run the query
          	    data = get.execute();

          	    // Do something with the data
          	    ArrayList<List> versionList = new ArrayList<List>(); 
        			
          	    if (data.getRows() != null) {
          	        for (List<String> row : data.getRows()) {
          	           
          	        	versionList.add(row);
          	        }
          	    }
          	    model.addAttribute("list",list);
          	    model.addAttribute("versionList",versionList);
          	    model.addAttribute("rsvStartKeyword",startDate);
          	    model.addAttribute("rsvEndKeyword",endDate);
          	    
        		}catch (IOException e) {
        			log.error(e.getMessage());  
        	    }
            	  return model;
              }
      
      private ModelMap date(Analytics analyticsService,HttpServletRequest request,ModelMap model, String viewId){
    	  	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
      		String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
      		String filter = NullUtil.nullString(request.getParameter("searchSite"));
    		Calendar date = Calendar.getInstance();
    /*
    		log.debug(termdate.get(Calendar.YEAR));
    		log.debug(termdate.get(Calendar.MONTH));
    		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
    */	    
      	
        	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
          String month = String.valueOf((date.get(Calendar.MONTH)+1));
          String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
          if((date.get(Calendar.MONTH)+1)<10){
          	month = "0"+(date.get(Calendar.MONTH)+1);
          }
          if(date.get(Calendar.DAY_OF_MONTH)<10){
          	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
          }
          now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
          if(startDate.equals("")){
          	startDate = date.get(Calendar.YEAR) + "-" + month + "-" + "01";
          }
          if(endDate.equals("")){
          	endDate = now;
          }
  	    String mertrics = "ga:users,ga:sessions";

  	    // Use the analytics object build a query
  	    Get get;
		try {
			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
		
  	    get.setDimensions("ga:year,ga:month,ga:day");
  	    if(!filter.equals("")){
	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
    	    
	    }
  	    //get.setSort("-ga:sessions");

  	    // Run the query
  	    GaData data = get.execute();

  	    // Do something with the data
  	    ArrayList<List> list = new ArrayList<List>(); 
			
  	    if (data.getRows() != null) {
  	        for (List<String> row : data.getRows()) {
  	           
  	        	list.add(row);
  	        }
  	    }
  	    model.addAttribute("list",list);
	    model.addAttribute("rsvStartKeyword",startDate);
	    model.addAttribute("rsvEndKeyword",endDate);
		}catch (IOException e) {
			log.error(e.getMessage());  
	    }
    	  return model;
      }
      
      private ModelMap month(Analytics analyticsService,HttpServletRequest request,ModelMap model,String viewId){
    	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
      	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
      	String filter = NullUtil.nullString(request.getParameter("searchSite"));
    		Calendar date = Calendar.getInstance();
    /*
    		log.debug(termdate.get(Calendar.YEAR));
    		log.debug(termdate.get(Calendar.MONTH));
    		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
    */	    
      	
        	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
          String month = String.valueOf((date.get(Calendar.MONTH)+1));
          String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
          if((date.get(Calendar.MONTH)+1)<10){
          	month = "0"+(date.get(Calendar.MONTH)+1);
          }
          if(date.get(Calendar.DAY_OF_MONTH)<10){
          	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
          }
          now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
          if(startDate.equals("")){
          	startDate = date.get(Calendar.YEAR) + "-" + "01" + "-" + "01";
          }
          if(endDate.equals("")){
          	endDate = now;
          }
  	    String mertrics = "ga:users,ga:sessions";

  	    // Use the analytics object build a query
  	    Get get;
		try {
			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
		
  	    get.setDimensions("ga:year,ga:month");
  	    if(!filter.equals("")){
	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
    	    
	    }
  	    //get.setSort("-ga:sessions");

  	    // Run the query
  	    GaData data = get.execute();

  	    // Do something with the data
  	    ArrayList<List> list = new ArrayList<List>(); 
			
  	    if (data.getRows() != null) {
  	        for (List<String> row : data.getRows()) {
  	           
  	        	list.add(row);
  	        }
  	    }
  	    model.addAttribute("list",list);
	    model.addAttribute("rsvStartKeyword",startDate);
	    model.addAttribute("rsvEndKeyword",endDate);
		}catch (IOException e) {
			log.error(e.getMessage());  
	    }
    	  return model;
      }
      private ModelMap year(Analytics analyticsService,HttpServletRequest request,ModelMap model,String viewId){
    	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
      	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
      	String filter = NullUtil.nullString(request.getParameter("searchSite"));
    		Calendar date = Calendar.getInstance();
    /*
    		log.debug(termdate.get(Calendar.YEAR));
    		log.debug(termdate.get(Calendar.MONTH));
    		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
    */	    
      	
    	  String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
          String month = String.valueOf((date.get(Calendar.MONTH)+1));
          String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
          if((date.get(Calendar.MONTH)+1)<10){
          	month = "0"+(date.get(Calendar.MONTH)+1);
          }
          if(date.get(Calendar.DAY_OF_MONTH)<10){
          	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
          }
          now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
          if(startDate.equals("")){
          	startDate = date.get(Calendar.YEAR) + "-" + "01" + "-" + "01";
          }
          if(endDate.equals("")){
          	endDate = now;
          }
  	    String mertrics = "ga:users,ga:sessions";

  	    // Use the analytics object build a query
  	    Get get;
		try {
			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
		
  	    get.setDimensions("ga:year");
  	    if(!filter.equals("")){
	    	get.setFilters("ga:pagePathLevel1==/"+filter+"/");
    	    
	    }
  	    //get.setSort("-ga:sessions");

  	    // Run the query
  	    GaData data = get.execute();

  	    // Do something with the data
  	    ArrayList<List> list = new ArrayList<List>(); 
			
  	    if (data.getRows() != null) {
  	        for (List<String> row : data.getRows()) {
  	           
  	        	list.add(row);
  	        }
  	    }
  	    model.addAttribute("list",list);
	    model.addAttribute("rsvStartKeyword",startDate);
	    model.addAttribute("rsvEndKeyword",endDate);
		}catch (IOException e) {
			log.error(e.getMessage());  
	    }
    	  return model;
      }
      
      private ModelMap real(Analytics analyticsService,HttpServletRequest request,ModelMap model,String viewId){
  	    // Use the analytics object build a query
    	Calendar date = Calendar.getInstance();
  /*
  		log.debug(termdate.get(Calendar.YEAR));
  		log.debug(termdate.get(Calendar.MONTH));
  		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
  */	    
    	
      	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
        String month = String.valueOf((date.get(Calendar.MONTH)+1));
        String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
        if((date.get(Calendar.MONTH)+1)<10){
        	month = "0"+(date.get(Calendar.MONTH)+1);
        }
        if(date.get(Calendar.DAY_OF_MONTH)<10){
        	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
        }
        now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
        
	  	  try {
	  		com.google.api.services.analytics.Analytics.Data.Realtime.Get realtimeRequest = analyticsService.data().realtime().get(viewId, "rt:activeUsers").setDimensions("rt:deviceCategory");
			RealtimeData realtimeData = realtimeRequest.execute();
	  	    
		  	  if (realtimeData.getTotalResults() > 0) {
		  	// Do something with the data
		  		  ArrayList<List> list = new ArrayList<List>(); 
					
		  		  for (List<String> row : realtimeData.getRows()) {
		  			  list.add(row);
		  		  }
		  		  model.addAttribute("diviceList",list);
		  	  }else{
		  		  log.debug("No data");
		  	  }
	  	    
		  	    String mertrics = "ga:pageviews";
		
		  	    // Use the analytics object build a query
		  	    Get get;
				get = analyticsService.data().ga().get(viewId, now, now, mertrics);
				
		  	    get.setDimensions("ga:hour,ga:minute");
		  	    //get.setFilters("ga:country==Canada");
		  	    get.setSort("-ga:hour,-ga:minute");
		        get.setMaxResults(20);
		  	    // Run the query
		  	    GaData data = get.execute();
		
		  	    // Do something with the data
		  	    ArrayList<List> list = new ArrayList<List>(); 
					
		  	    if (data.getRows() != null) {
		  	        for (List<String> row : data.getRows()) {
		  	           
		  	        	list.add(row);
		  	        }
		  	    }
		  	    model.addAttribute("pageviewList",list);
		  	    
		  	  
			
	    	  
				}catch (IOException e) {
					log.error(e.getMessage());  
			    }
			return model;
      }
      
      private ModelMap pageview(Analytics analyticsService,HttpServletRequest request,ModelMap model, String viewId){
    	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
    	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
    	String filter = NullUtil.nullString(request.getParameter("searchSite"));
  		Calendar date = Calendar.getInstance();
  /*
  		log.debug(termdate.get(Calendar.YEAR));
  		log.debug(termdate.get(Calendar.MONTH));
  		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
  */	    
    	
      	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
        String month = String.valueOf((date.get(Calendar.MONTH)+1));
        String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
        if((date.get(Calendar.MONTH)+1)<10){
        	month = "0"+(date.get(Calendar.MONTH)+1);
        }
        if(date.get(Calendar.DAY_OF_MONTH)<10){
        	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
        }
        now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
        if(startDate.equals("")){
        	startDate = now;
        }
        if(endDate.equals("")){
        	endDate = now;
        }
    	    String mertrics = "ga:users,ga:sessions,ga:pageviews";

    	    // Use the analytics object build a query
    	    Get get;
  		try {
  			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
  		
    	    get.setDimensions("ga:pagePathLevel1");
    	    get.setFilters("ga:pagePathLevel1!@=");
    	    //get.setSort("-ga:sessions");

    	    // Run the query
    	    GaData data = get.execute();

    	    // Do something with the data
    	    ArrayList<List> list = new ArrayList<List>(); 
  			
    	    if (data.getRows() != null) {
    	        for (List<String> row : data.getRows()) {
    	            row.set(0, row.get(0).replace("/", ""));
    	        	list.add(row);
    	        }
    	    }
    	    model.addAttribute("list",list);
    	    model.addAttribute("rsvStartKeyword",startDate);
    	    model.addAttribute("rsvEndKeyword",endDate);
    	    
  		}catch (IOException e) {
  			log.error(e.getMessage());  
  	    }
      	  return model;
        }
      
      public static ModelMap realTime(ModelMap model,
	    		HttpServletRequest request){
    	  try {
    		String req = NullUtil.nullString(request.getParameter("mode"));
    	    if(req.equals("")){
    	    	req = "date";
    	    }
    	    String analyticsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/analyticsProp.prop";
    		
    		Properties analytics = new Properties();
    		File currentDefaultPropFile = new File(analyticsPath);
    		InputStreamReader isr = null;
    		FileInputStream fis = null;
    		if(currentDefaultPropFile.exists()){
    			try {
    				fis = new FileInputStream(currentDefaultPropFile);
    				isr = new InputStreamReader(fis, "UTF-8");
    				analytics.load(isr);
    			} catch (UnsupportedEncodingException e) {
    				log.error(e.getMessage());
    			} finally {
    				isr.close();
    				fis.close();
    			}
    			
    		}
    		String debug = EgovProperties.getProperty("Globals.Debug");
    		if(debug.equals("true")){
    			log.debug(analytics.get("apiEmail"));
        		log.debug(analytics.get("applicationName"));
        		log.debug(analytics.get("viewId"));
        		log.debug(uploadDir+analytics.get("analyticsKeyFile"));
    		}
    		
    		
    		
    		File analyticsKeyFile = new File(uploadDir+analytics.get("analyticsKeyFile"));
    		if(analyticsKeyFile.exists() == false){
    			return null;
    		}
    	    // This is the service account email address that you can find in the api console
    	    String apiEmail = (String) analytics.get("apiEmail");
    	    
    	    GoogleCredential credential = new GoogleCredential.Builder()
    	        .setTransport(HTTP_TRANSPORT)
    	        .setJsonFactory(JSON_FACTORY)
    	        .setServiceAccountId(apiEmail)
    	        .setServiceAccountScopes(Arrays.asList(AnalyticsScopes.ANALYTICS_READONLY))
    	        .setServiceAccountPrivateKeyFromP12File(analyticsKeyFile).build();

    	    Analytics analyticsService = new Analytics.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential)
    	        .setApplicationName((String) analytics.get("applicationName"))
    	        .build();

	    	  // Use the analytics object build a query
	      	  Calendar date = Calendar.getInstance();
	
	          String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
	          String month = String.valueOf((date.get(Calendar.MONTH)+1));
	          String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
	          if((date.get(Calendar.MONTH)+1)<10){
	          	month = "0"+(date.get(Calendar.MONTH)+1);
	          }
	          if(date.get(Calendar.DAY_OF_MONTH)<10){
	          	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
	          }
	          now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
	          
	  	  		com.google.api.services.analytics.Analytics.Data.Realtime.Get realtimeRequest = analyticsService.data().realtime().get((String) analytics.get("viewId"), "rt:activeUsers").setDimensions("rt:deviceCategory");
	  			RealtimeData realtimeData = realtimeRequest.execute();
	  	  	    
	  		  	  if (realtimeData.getTotalResults() > 0) {
	  		  	// Do something with the data
	  		  		  ArrayList<List> list = new ArrayList<List>(); 
	  					
	  		  		  for (List<String> row : realtimeData.getRows()) {
	  		  			  list.add(row);
	  		  		  }
	  		  		  model.addAttribute("diviceList",list);
	  		  	  }else{
	  		  		  log.debug("No data");
	  		  	  }
  	  	    
  		  	    String mertrics = "ga:pageviews";
  		
  		  	    // Use the analytics object build a query
  		  	    Get get;
  				get = analyticsService.data().ga().get((String) analytics.get("viewId"), now, now, mertrics);
  				
  		  	    get.setDimensions("ga:hour,ga:minute");
  		  	    //get.setFilters("ga:country==Canada");
  		  	    get.setSort("-ga:hour,-ga:minute");
  		        get.setMaxResults(20);
  		  	    // Run the query
  		  	    GaData data = get.execute();
  		
  		  	    // Do something with the data
  		  	    ArrayList<List> list = new ArrayList<List>(); 
  					
  		  	    if (data.getRows() != null) {
  		  	        for (List<String> row : data.getRows()) {
  		  	           
  		  	        	list.add(row);
  		  	        }
  		  	    }
  		  	    
  		  	    model.addAttribute("pageviewList",list);
  		  	    
  		  	    mertrics = "ga:sessions";
  		  	    get = analyticsService.data().ga().get((String) analytics.get("viewId"), "2014-01-01", now, mertrics);
				
		  	    //get.setDimensions("ga:hour,ga:minute");
		  	    //get.setFilters("ga:country==Canada");
		        get.setMaxResults(20);
		  	    // Run the query
		  	    data = get.execute();
		
		  	    // Do something with the data
		  	    list = new ArrayList<List>(); 
					
		  	    if (data.getRows() != null) {
		  	        for (List<String> row : data.getRows()) {
		  	           
		  	        	list.add(row);
		  	        }
		  	    }
		  	    model.addAttribute("allUser",list);
		  	    
		  	    mertrics = "ga:sessions";
		  	    get = analyticsService.data().ga().get((String) analytics.get("viewId"), now, now, mertrics);
				
		  	    //get.setDimensions("ga:hour,ga:minute");
		  	    //get.setFilters("ga:country==Canada");
		        get.setMaxResults(20);
		  	    // Run the query
		  	    data = get.execute();
		
		  	    // Do something with the data
		  	    list = new ArrayList<List>(); 
					
		  	    if (data.getRows() != null) {
		  	        for (List<String> row : data.getRows()) {
		  	           
		  	        	list.add(row);
		  	        }
		  	    }
		  	    model.addAttribute("todayUser",list);
		  	    
	        }catch (GeneralSecurityException e) {
	        	log.error(e.getMessage());
		    }catch (IOException e) {
		    	log.error(e.getMessage());
		         
		    }
	     return model;
      }

      private ModelMap popular(Analytics analyticsService,HttpServletRequest request,ModelMap model, String viewId){
      	String startDate = NullUtil.nullString(request.getParameter("rsvStartKeyword"));
      	String endDate = NullUtil.nullString(request.getParameter("rsvEndKeyword"));
      	String filter = NullUtil.nullString(request.getParameter("searchSite"));
      	int maxResult = NullUtil.nullInt(request.getParameter("maxResult"));
    		Calendar date = Calendar.getInstance();
    /*
    		log.debug(termdate.get(Calendar.YEAR));
    		log.debug(termdate.get(Calendar.MONTH));
    		log.debug(termdate.get(Calendar.DAY_OF_MONTH));
    */	    
      	if(maxResult == 0){
      		maxResult = 100;
      	}
        	String now = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH)+1) + "-" + date.get(Calendar.DAY_OF_MONTH);
          String month = String.valueOf((date.get(Calendar.MONTH)+1));
          String day = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
          if((date.get(Calendar.MONTH)+1)<10){
          	month = "0"+(date.get(Calendar.MONTH)+1);
          }
          if(date.get(Calendar.DAY_OF_MONTH)<10){
          	day = "0"+(date.get(Calendar.DAY_OF_MONTH));
          }
          now =  date.get(Calendar.YEAR) + "-" + month + "-" + day;
          if(startDate.equals("")){
          	startDate = now;
          }
          if(endDate.equals("")){
          	endDate = startDate;
          }
      	    String mertrics = "ga:users,ga:sessions,ga:pageviews";

      	    // Use the analytics object build a query
      	    Get get;
    		try {
    			get = analyticsService.data().ga().get(viewId, startDate, endDate, mertrics);
    		
      	    get.setDimensions("ga:pageTitle,ga:pagePath");
      	    if(!filter.equals("")){
        	    	get.setFilters("ga:pagePath!@=;ga:pagePathLevel1==/"+filter+"/");
        	    }
      	    get.setSort("-ga:pageviews");
      	    get.setMaxResults(maxResult);
      	    // Run the query
      	    GaData data = get.execute();

      	    // Do something with the data
      	    ArrayList<List> list = new ArrayList<List>(); 
    			
      	    if (data.getRows() != null) {
      	        for (List<String> row : data.getRows()) {
      	           
      	        	list.add(row);
      	        }
      	    }
      	    
      	    model.addAttribute("list",list);
      	    model.addAttribute("rsvStartKeyword",startDate);
      	    model.addAttribute("rsvEndKeyword",endDate);
      	    model.addAttribute("maxResult",maxResult);
      	    
    		}catch (IOException e) {
    			log.error(e.getMessage());  
    	    }
    
    		return model;
      }
      
}

