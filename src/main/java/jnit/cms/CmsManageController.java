/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import jnit.cms.property.CmsPropertyController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CmsManageController {
    /** 첨부파일 위치 지정 */
    private final String uploadDir = CmsPropertyController.getCmsProperty("Globals.fileStorePath");
    
    /*
    // CMS 1.0 관리자
	// HOME
	@RequestMapping("/cms/mgrCtl.do")
    public String cmsManageMain(ModelMap model) throws Exception {

	return "jnit/cms/index";
    }
	*/
    
    // 환경설정 > 시스템설정
    @RequestMapping("/cms/sysCfg.do")
    public String cmsManageSysCfg(ModelMap model) throws Exception {

		
	return "jnit/cms/syscfg";
    }
    
    // 환경설정 > 기본설정
    @RequestMapping("/cms/defCfg.do")
    public String cmsManageDefCfg(ModelMap model) throws Exception {

		
	return "jnit/cms/defcfg";
    }
    
    
    // 메모 > 로딩
    @RequestMapping(value="/cms/memo/get.do", method=RequestMethod.POST)
    public String cmsMemoGet(ModelMap model) throws Exception {
		
        String tplFile = uploadDir + "memo.txt";
        String memo = "";
        String thisline = "";
        FileInputStream fis = null;
        InputStreamReader isr = null;
        
        File file = new File(tplFile);
        if(!file.exists())
        {
          //System.out.println("File does not exist");
          //System.exit(0);
          memo = "";
        }
        else
        {
          try{
        	fis = new FileInputStream(file);
        	isr = new InputStreamReader(fis,"UTF-8");
            BufferedReader i = new BufferedReader(isr);
            
            while((thisline = i.readLine()) != null){
            	memo += thisline + "\n";
            };
          }
          catch(UnsupportedEncodingException ue){
            //System.out.println("Not supported : ");
          } finally {
        	  if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
          }
        }
        
    	model.addAttribute("result", memo);
    	
    	return "jnit/cms/memo";
    }
    
    // 메모 > 저장일시
    @SuppressWarnings("deprecation")
	@RequestMapping(value="/cms/memo/gettime.do", method=RequestMethod.POST)
    public String cmsMemoGetTime(ModelMap model) throws Exception {
		
        String tplFile = uploadDir + "memo.txt";
        String strDate = "";
        Date lastModified = new Date();
        
        
        File file = new File(tplFile);
        if(!file.exists())
        {
          //System.out.println("File does not exist");
          //System.exit(0);
        	
          strDate = "";
        }else {
        	lastModified.setTime(file.lastModified());
        	
        	strDate = String.valueOf( lastModified.getTime() );
        }
        
    	model.addAttribute("result", strDate);
    	
    	return "jnit/cms/memo";
    }
    
    // 메모 > 지우기
    @RequestMapping(value="/cms/memo/clear.do", method=RequestMethod.POST)
    public String cmsMemoClear(ModelMap model) throws Exception {
		
        String tplFile = uploadDir + "memo.txt";
        
        FileOutputStream fos = new FileOutputStream(new File(tplFile));
        OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
        osw.write("");
        osw.close();
        if(fos != null) try{fos.close();}catch(IOException e){}
    	model.addAttribute("result", "");
    	
    	return "jnit/cms/memo";
    }
    
    // 메모 > 저장
    @RequestMapping(value="/cms/memo/save.do", method=RequestMethod.POST)
    public String cmsMemoSave(
    		@RequestParam("memo") java.lang.String memo,
    		ModelMap model) throws Exception {
		
        String tplFile = uploadDir + "memo.txt";
        
        FileOutputStream fos = new FileOutputStream(new File(tplFile));
        OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
        osw.write(memo.trim());
        osw.close();
        if(fos != null) try{fos.close();}catch(IOException e){}
    	model.addAttribute("result", memo.trim());
    	    	
    	return "jnit/cms/memo";
    }
}