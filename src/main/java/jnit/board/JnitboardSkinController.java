package jnit.board;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.AdminUtil;
import jnit.cms.handler.CmsHandler;
import jnit.com.util.FileCopy;
import jnit.com.util.FileStream;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class JnitboardSkinController {

	private Log log = LogFactory.getLog(getClass());
	
	public static final String SEPERATOR = File.separator;
	public static final String BOARD_PATH = "board" + SEPERATOR;
	
	@RequestMapping("/cms/board/skinList.do")
	public String boardSkinList(HttpServletRequest request, Model model) throws Exception{
		
		AdminUtil.setMenuId("m06010300");
		
		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
		String fileNm = NullUtil.nullString(request.getParameter("fileNm"));
		String folderPath = NullUtil.nullString(request.getParameter("folderPath"));
		
		String contextPath = PathUtil.getRealPath(request);
		
		String filePath = "";
		String fileSourcePath = "";
		
		if(fileNm.equals("")) fileNm = "list.jsp";
		if(folderPath.equals("")) folderPath = "empty";
		String basePath = contextPath+"/board/skin/"+folderPath;
		
		JSONObject fileObj = new JSONObject();
		JSONArray skinJArr = JSONArray.fromObject(FileCopy.getDirectoryNm(basePath));
		
		if(skinNm.equals("")){
			try{
				skinNm = skinJArr.get(0).toString();
			}catch(java.lang.IndexOutOfBoundsException e){//하위 폴더가 존재하지 않을경우
				/*
				model.addAttribute("alert", folderPath+" 게시판 스킨에 파일이 존재하지 않습니다.");
				model.addAttribute("path", "/cms/");
				return "/jnit/util/alertMove";
				*/
			}
		}
		
		
		for(int i=0; i<skinJArr.size(); i++){
			filePath = basePath + File.separator + skinJArr.get(i);
			fileObj.put(skinJArr.get(i), FileCopy.getFileNm(filePath));
		}
		
		fileSourcePath = basePath + File.separator + skinNm + File.separator + fileNm;
		String fileSource = "";
		try{
			fileSource = FileStream.readFileToString(new File(fileSourcePath), "utf-8");
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
			/*
			model.addAttribute("alert", skinNm+" 게시판 스킨에는 " + fileNm + " 파일이 존재하지 않습니다.");
			model.addAttribute("path", "/cms/board/skinList.do?skinNm="+skinJArr.get(0)+"&fileNm=list.jsp&folderPath="+folderPath);
			model.addAttribute("path", "/cms/");
			return "/jnit/util/alertMove";
			*/
		}
		model.addAttribute("skinList",getSkinList(request));
		model.addAttribute("skinNm", skinNm);
		model.addAttribute("fileNm", fileNm);
		model.addAttribute("fileObj", fileObj);
		model.addAttribute("folderPath",folderPath);
		model.addAttribute("skinJArr", skinJArr);
		model.addAttribute("fileSource", fileSource);
		
		
		return "/jnit/cms/board/skin/list";
	}
	
	@RequestMapping("/cms/board/skinDelete.do")
	public String boardSkinDelete(HttpServletRequest request, Model model) throws Exception{
		
		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
		String fileNm = NullUtil.nullString(request.getParameter("fileNm"));
		String folderPath = NullUtil.nullString(request.getParameter("folderPath"));
		
		String contextPath = PathUtil.getRealPath(request);
		String basePath = contextPath+"/board/skin/"+folderPath;
		String filePath = basePath + File.separator + skinNm;
		
		FileCopy.deleteFolder(filePath);
		
		JSONArray skinJArr = JSONArray.fromObject(FileCopy.getDirectoryNm(basePath));
		try{
			skinNm = skinJArr.get(0).toString();
		}catch(java.lang.IndexOutOfBoundsException e){//하위 폴더가 존재하지 않을경우
			folderPath = "";
		}
		fileNm = "list.jsp";
		
		return "redirect:/cms/board/skinList.do?skinNm="+skinNm+"&fileNm="+fileNm+"&folderPath="+folderPath;
	}
	
	@RequestMapping("/cms/board/skinCopy.do")
	public String boardSkinCopy(HttpServletRequest request, Model model) throws Exception{
		
		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
		String fileNm = NullUtil.nullString(request.getParameter("fileNm"));
		String replaceNm = NullUtil.nullString(request.getParameter("replaceNm"));
		String folderPath = NullUtil.nullString(request.getParameter("folderPath"));
		
		String contextPath = PathUtil.getRealPath(request);
		String basePath = contextPath+"/board/skin/"+folderPath;
		String fileOriginPath = basePath + File.separator + skinNm;
		String fileChangePath = basePath + File.separator + replaceNm;
		
		if(new File(fileChangePath).exists()){
			model.addAttribute("alert", "이미 존재하는 스킨입니다.");
			model.addAttribute("path", "/cms/board/skinList.do?skinNm="+skinNm+"&fileNm="+fileNm);
			return "/jnit/util/alertMove";
		}else{
			FileCopy.copyDirectoryReplace(new File(fileOriginPath), new File(fileChangePath), replaceNm);
		}
		
		return "redirect:/cms/board/skinList.do?skinNm="+skinNm+"&fileNm="+fileNm+"&folderPath="+folderPath;
	}
	
	@RequestMapping("/cms/board/fileSave.do")
	public String boardSkinFileSave(HttpServletRequest request, Model model) throws Exception{
		
		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
		String fileNm = NullUtil.nullString(request.getParameter("fileNm"));
		String fileSource = NullUtil.nullString(request.getParameter("fileSource"));
		String folderPath = NullUtil.nullString(request.getParameter("folderPath"));
		
		String contextPath = PathUtil.getRealPath(request);
		String basePath = contextPath+"/board/skin/"+folderPath+File.separator+skinNm+File.separator+fileNm;
		
		CmsHandler.writeFile(basePath, fileSource);
		
		return "redirect:/cms/board/skinList.do?skinNm="+skinNm+"&fileNm="+fileNm+"&folderPath="+folderPath;
	}
	
	@RequestMapping("/cms/board/fileReset.do")
	public String boardSkinFileReset(HttpServletRequest request, Model model) throws Exception{
		
		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
		String fileNm = NullUtil.nullString(request.getParameter("fileNm"));
		String folderPath = NullUtil.nullString(request.getParameter("folderPath"));
		String contextPath = PathUtil.getRealPath(request);
		String basePath = contextPath+"/board/skin/"+folderPath;
		String filePath = basePath+File.separator+skinNm+File.separator+fileNm;
		String fileSourcePath = basePath + File.separator+skinNm+File.separator+"origin"+File.separator+fileNm;
		String fileOriginSource = FileStream.readFileToString(new File(fileSourcePath), "utf-8");
		
		CmsHandler.writeFile(filePath, fileOriginSource);
		
		return "redirect:/cms/board/skinList.do?skinNm="+skinNm+"&fileNm="+fileNm+"&folderPath="+folderPath;
	}
	
	public static String getBoardPath(HttpServletRequest request){
    	String boardPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_PATH;
    	return boardPath;
    }
	public List<String> getSkinList(HttpServletRequest request) throws Exception{

		String boardPathStr = getBoardPath(request)+ SEPERATOR +"skin";
		File boardDirLst = new File(boardPathStr);
		FilenameFilter filter = new FilenameFilter() {
			
			public boolean accept(File f, String name) {
				if(f.isDirectory() && ! "_".equals(name.substring(0, 1)) && !".svn".equals(name) ){
					return true;
				}else{
					return false;	
				}
				
			}
		};
		String[] dirList = boardDirLst.list(filter);
		if(dirList == null) dirList = new String[0];
		List<String> skinList = Arrays.asList(dirList);
		return skinList;
	}
	
}
