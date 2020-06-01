package jnit.edit;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

@Service("editService")
public class editServiceImpl extends AbstractServiceImpl implements editService {
	
	private Log log = LogFactory.getLog(getClass());
	
	public JSONObject makeEditFileHTML5(HttpServletRequest request, String filename, String filesize, String count)throws Exception{
		JSONObject JSON = new JSONObject();
		JSON.put("physicalName", "");
		JSON.put("serverSubPath", "");
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String root = PathUtil.getRealPath(request);
			
			String serverSubPath = dateFormat.format(new Date());
			String physicalName = formatter.format(new Date())+"_"+ count + filename.substring(filename.lastIndexOf("."));
			
			String fileDir = root + "/upload/editUpload/"+serverSubPath+"/"+physicalName;
			File file = new File(root + "/upload/editUpload/"+serverSubPath);
			if(!file.exists()) {
				file.mkdirs();
			}
			
			InputStream is = request.getInputStream();
			OutputStream os=new FileOutputStream(fileDir);
			int numRead;
			byte b[] = new byte[Integer.parseInt(filesize)];
			while((numRead = is.read(b,0,b.length)) != -1){
				os.write(b,0,numRead);
			}
			if(is != null) {
				is.close();
			}
			os.flush();
			if(os != null) {
				os.close();
			}
			
			JSON.put("physicalName", physicalName);
			JSON.put("serverSubPath", serverSubPath);
		} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return JSON;
	}
	
	public JSONObject makeEditFile(HttpServletRequest request)throws Exception{
		String root = request.getSession().getServletContext().getRealPath("");		
		String uploadDir = EgovProperties.getProperty("Globals.fileStorePath")+"editUpload/";		
		
		if(StringUtil.isExistString(request.getRequestURL().toString(), "local")){
			uploadDir = root +"/upload/editUpload/";
		}		
		File file = new File(uploadDir);
		if(!file.exists()){
			file.mkdirs();
		}
		
		int maxFileSize = 1024 * 1024 * 100;
		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
		
		JSONObject JSON = new JSONObject();
		if(list.get("Filedata") != null){			
			EgovFormBasedFileVo vo = list.get("Filedata");
			JSON.put("status", "success");
			JSON.put("serverSubPath", vo.getServerSubPath());			
			JSON.put("physicalName", vo.getPhysicalName());
			JSON.put("fileNm", vo.getFileName());
			JSON.put("fileUrl", "/upload/editUpload/"+vo.getServerSubPath()+"/"+vo.getPhysicalName());
		}
		return JSON;
	}	
}
