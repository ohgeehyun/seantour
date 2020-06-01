/**
 * @version 3.2.0.1
 */
package jnit.edit;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.imageio.IIOException;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import jnit.com.service.JnitComService;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
@Controller
public class eidtController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name ="editService")
	private editService editService;
	
	@Resource(name="jnitComService")
	private JnitComService jnitComService;
	
	final static String[] fileList = {"jpg","png","bmp","gif"};
	
	@RequestMapping("/edit/img/upload/popup.do")
	public String editPupup(HttpServletRequest request)throws Exception{
		if(!jnitComService.isCmsAccess()) throw new EgovBizException("접근권한이 없습니다.");
		
		return "/jnit/edit/tinymce/imgupload";
	}
	
	@RequestMapping("/edit/img/upload.do")
	public String imgUpload(HttpServletRequest request, ModelMap model)throws Exception{
		if(!jnitComService.isCmsAccess()) throw new EgovBizException("접근권한이 없습니다.");
		
		String root = PathUtil.getRealPath(request);		
		String uploadDir = EgovProperties.getProperty("Globals.fileStorePath")+"editUpload/";		
		
		if(StringUtil.isExistString(request.getRequestURL().toString(), "local")){
			uploadDir = root +"upload/editUpload/";
		}		
		File file = new File(uploadDir);
		if(!file.exists()){
			file.mkdirs();
		}
		
		int maxFileSize = 1024 * 1024 * 100;
		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
		
		JSONObject JSON = new JSONObject();
		if(list.get("imgFile") != null){			
			EgovFormBasedFileVo vo = list.get("imgFile");
			
			JSON.put("src", "upload/editUpload/"+vo.getServerSubPath()+"/"+vo.getPhysicalName());
			JSON.put("width", NullUtil.nullString(request.getParameter("imgWidth")));
			JSON.put("height", NullUtil.nullString(request.getParameter("imgHeight")));		
			JSON.put("alt", NullUtil.nullString(request.getParameter("imgalt")));	
			String imgDir = uploadDir + vo.getServerSubPath()+"/"+vo.getPhysicalName();			
			try {
				BufferedImage image = ImageIO.read(new File(imgDir));				
				if("".equals(JSON.get("width"))) JSON.put("width", image.getWidth());
				if("".equals(JSON.get("height"))) JSON.put("height", image.getHeight());
			} catch (IIOException e) { //not read file
				log.error(e.getMessage());
			}
		}
		
		model.addAttribute("json", JSON.toString());
		return "/jnit/util/json";
	}
	
	@RequestMapping("/edit/tinymce/popupView.do")
	public String editTinymcePopup(HttpServletRequest request)throws Exception{
		if(!jnitComService.isCmsAccess()) throw new EgovBizException("접근권한이 없습니다.");
		return "/jnit/edit/tinymce/pupup";
	}
	
	@RequestMapping("/edit/smartEditor/popupView.do")
	public String editSmartEditorPopup()throws Exception{
		if(!jnitComService.isCmsAccess()) throw new EgovBizException("접근권한이 없습니다.");
		return "/jnit/edit/smartEditor/popup";
	}
	
	@RequestMapping("/edit/smartEdit/img/multi/upload.do")
	public String editSmartEditImgMultiUpload(HttpServletRequest request, ModelMap model)throws Exception{
		if(!jnitComService.isCmsAccess()) throw new EgovBizException("접근권한이 없습니다.");
		JSONObject JSON = new JSONObject();
		try {
			String filename = request.getHeader("file-name");
			String filesize = request.getHeader("file-size");
			String count = request.getHeader("file-count");
			if(!StringUtil.isExistArrayIndexOf(fileList, filename.substring(filename.lastIndexOf(".")+1).toLowerCase())){
				JSON.put("massage", "FAIL 1");
			}else{
				JSON = editService.makeEditFileHTML5(request, filename, filesize, count);
				JSON.put("status", "success");
				JSON.put("fileNm", filename);
				JSON.put("fileUrl", "/upload/editUpload/"+JSON.get("serverSubPath")+"/"+JSON.get("physicalName"));
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			JSON.put("massgae", e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			JSON.put("massgae", e.getMessage());
		}
		model.addAttribute("json", JSON);
		return "/jnit/util/json";
	}
	
	@RequestMapping("/edit/smartEdit/img/upload.do")
	public String editSmartEditImgUpload(@RequestParam MultipartFile Filedata, HttpServletRequest request,ModelMap model)throws Exception{
		if(!jnitComService.isCmsAccess()) throw new EgovBizException("접근권한이 없습니다.");
		JSONObject JSON = new JSONObject();
		String return1 = NullUtil.nullString(request.getParameter("callback"));
		String return2 = "?callback_func="+NullUtil.nullString(request.getParameter("callback_func"));
		String return3 = "";
		try {
			String filename = Filedata.getOriginalFilename();
			if(!StringUtil.isExistArrayIndexOf(fileList, filename.substring(filename.lastIndexOf(".")+1).toLowerCase())){
				return3 = "&errstr=FAIL 1";
			}else{
				JSON = editService.makeEditFile(request);
				return3 += "&bNewLine=true";
				return3 += "&sFileName="+ JSON.get("fileNm");
				return3 += "&sFileURL="+JSON.get("fileUrl");
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			return3 = "&errstr="+e.getMessage();
		} catch (Exception e) {
			log.error(e.getMessage());
			return3 = "&errstr="+e.getMessage();
		}
		return "redirect:"+return1+return2+return3;
	}
}
