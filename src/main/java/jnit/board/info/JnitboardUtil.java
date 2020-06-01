package jnit.board.info;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;

public class JnitboardUtil {

	public static Log log = LogFactory.getLog(JnitboardUtil.class);
	
	private static final int BUFFER_SIZE = 8192;
	
	/**
	 * 게시판 icon 파일 업로드를 관리 한다.
	 * @param request
	 * @param path - 파일경로
	 * @param fileNm - 파일이름
	 * @param JSON - 있을시 필수 imgType(파일 이미지 확장자),typeFileNm(input type file name) 
	 * @return
	 * @throws Exception
	 */
	public static boolean uploadFormWorkFiles(HttpServletRequest request,String path,String fileNm, JSONObject JSON) throws Exception {

		boolean result = false;
		
		File file = new File(path);
		if(!file.exists()){
			file.mkdir();
		}
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;

		final Map<String, MultipartFile> files = mptRequest.getFileMap();
		Set<Entry<String, MultipartFile>> set = files.entrySet();
		if(set == null) set = new HashSet();
		Iterator<Entry<String, MultipartFile>> itr = set.iterator();

		try{
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
			    MultipartFile mFile = entry.getValue(); // mptRequest.getFile((String)fileIter.next());
			    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();
			    String tmp = fileNm;
			    if(!JSON.isEmpty()){
			    	Iterator itrJSON = JSON.keys();
			    	while (itrJSON.hasNext()) {
						String key = (String) itrJSON.next();
						JSONObject elmentJSON = (JSONObject) JSON.get(key);
						try {							
							if(mFile.getName().equals(key+"_iconFile")){
								tmp = key+"."+elmentJSON.get("imgType");
							}
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
					}
			    }			    
			    if (tmp.lastIndexOf("\\") >= 0) {
				tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
			    }
	
			    vo.setFileName(tmp);
			    vo.setSize(mFile.getSize());
	
			    if (tmp.lastIndexOf(".") >= 0) {
			    	vo.setPhysicalName(vo.getPhysicalName() + tmp.substring(tmp.lastIndexOf(".")));
			    }
	
			    if (mFile.getSize() > 0) {
			    	saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(path+tmp)));
			    }
			    result = true;
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			result = false;
		}catch(Exception e){
			log.error(e.getMessage());
			result = false;
		}
		return result;
	}
	
	
	public static long saveFile(InputStream is, File file) throws IOException {
		// 디렉토리 생성
		File parentFile = file.getParentFile();
		if (parentFile != null && ! parentFile.exists()) {
			parentFile.mkdirs();
		}

		OutputStream os = null;
		long size = 0L;

		try {
			log.debug(file);
		    os = new FileOutputStream(file);

		    int bytesRead = 0;
		    byte[] buffer = new byte[BUFFER_SIZE];

		    while ((bytesRead = is.read(buffer, 0, BUFFER_SIZE)) != -1) {
			size += bytesRead;
			os.write(buffer, 0, bytesRead);
		    }
		    JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, file);		//Filego 배포
		} finally {
		    if (os != null) {
			os.close();
		    }
		}

		return size;
	}
	
	
	public static String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

		return returnValue;
	}
	
	public static String makeIconImg(JnitboardinfoVO jnitboardinfoVO, Map<String, String> result) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String root = PathUtil.getRealPath(request);
		String ctxRoot = request.getSession().getServletContext().getContextPath();
		String str = "";
		String boardId = NullUtil.nullString(jnitboardinfoVO.getBoardId());
		if(!"".equals(boardId)){
			JSONObject JSON = new JSONObject().fromObject(jnitboardinfoVO.getTmp1());
			Iterator itr = JSON.keys();
			while (itr.hasNext()) {
				String key = (String) itr.next();
				JSONObject elmentJSON =  (JSONObject) JSON.get(key);
				try {
					String type = elmentJSON.get("type").toString();
					String value = elmentJSON.get("value").toString();
					String imgType = elmentJSON.get("imgType").toString();
					String path = "/board/_info/_iconImg/"+boardId+"/"+key+"."+imgType;
					String src = ctxRoot+path;
					if("1".equals(type)){
						int hit = Integer.parseInt(String.valueOf(result.get("hit")));
						if(hit <= Integer.parseInt(value)){
							if(!isFileExists(root+path)) src = ctxRoot+"/resources/img/new_icon.gif"; 		//파일체크
							str += "<img src=\""+src+"\" class=\"icon_board\" />";
						}
					}else if("2".equals(type)){
						Date today = new Date();
						Date created = new Date();
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(String.valueOf(result.get("created"))));												
						calendar.add(Calendar.MINUTE, Integer.parseInt(value));
						created.setTime(calendar.getTimeInMillis());
						if(today.getTime() <= created.getTime()){
							if(!isFileExists(root+path)) src = ctxRoot+"/resources/img/new_icon.gif";		//파일체크
							str += "<img src=\""+src+"\" class=\"icon_board\"/>";
						}
					}else if("3".equals(type)){
						JSONObject tmp4JSON = new JSONObject().fromObject(result.get("tmp4"));
						if("Y".equals(tmp4JSON.get(key))){
							if(!isFileExists(root+path)) src = ctxRoot+"/resources/img/new_icon.gif";		//파일체크
							str += "<img src=\""+src+"\" class=\"icon_board\"/>";
						}
					}
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
			}
		}
		return str;
	}
	
	public static Boolean isFileExists(String path)throws Exception{
		File file = new File(path);
		if(!file.exists()){
			return false;
		}
		return true;
	}
}
