/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.File;
import java.io.FileWriter;
import java.io.InputStream;
import java.net.URL;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.property.EgovPropertyService;






@Controller
public class JnitweatherController {

    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    
    private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String WEATHER_PATH = "weather" + SEPERATOR;

    @RequestMapping("/kasp/get.do")
    public String selectJnitFsn(
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
	    	
    		String returnval = "";
			Calendar cal = Calendar.getInstance();
			
			String latestDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + WEATHER_PATH; 
			File latestDir = new File(latestDirPath);
			String latestPath =  latestDir + SEPERATOR + "Fkasp.txt"; 
			if(!latestDir.exists()){
				latestDir.mkdir();
			}
			if("true".equals(deDug)) System.out.println(latestPath);
			File dataFile = new File(latestPath);
			Boolean hasFile = false;
			Boolean equalData = false;
			if(!dataFile.exists()){
				hasFile = false;
			}else{
				hasFile = true;
			}
			
			if(hasFile){
				String Str = FileUtils.readFileToString(dataFile, "UTF-8");
				//1분이 지난 데이터는 새로 로드한다.
				if( (cal.getTimeInMillis() - dataFile.lastModified()) < 60000 * 1){
					returnval = Str;
					
				}else{
					equalData = false;
				}
				
			}else{
				
			}
			if(equalData){
				
			}else{
				
				String addr = "http://asp1.krx.co.kr/servlet/krx.asp.XMLText?code=032190";
				
				URL url = new URL(addr);
				InputStream in = url.openStream(); 
				CachedOutputStream bos = new CachedOutputStream();
				IOUtils.copy(in, bos);
				in.close();
				bos.close();
				
				
				FileWriter latestFileW = new FileWriter(latestPath);
				latestFileW.write(bos.getOut().toString());
				latestFileW.flush();
				latestFileW.close();
				
				returnval = bos.getOut().toString();
				
			}
			
			 /*
			 JSONObject jsonObj = (JSONObject)new XMLSerializer().read(bos.getOut().toString());
			 
			 System.out.println(jsonObj);
			 */
			 
			 
			
			JSONObject jsonObjSet = new JSONObject();
			jsonObjSet.put("val",returnval);
			model.addAttribute("json",jsonObjSet);
			return "/jnit/util/json";
		}
}


