/**
 * @version 3.2.0.1
 */
package jnit.board.info;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import jnit.cms.AdminUtil;
import jnit.cms.handler.CmsHandler;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;

@Controller
public class JnitBoardPageView {

	private final static String SEPARATOR = File.separator;
	
	@RequestMapping("/cms/board/pageView.do")
	public String pageView(HttpServletRequest request, Model model) throws IOException{
		
		AdminUtil.setMenuId("m06010200");
		
		HashMap resultMap = new HashMap(); 
		
		String realPath = PathUtil.getRealPath(request);
		String boardJsPath = realPath + "board" + SEPARATOR + "_common" + SEPARATOR + "js" + SEPARATOR + "board.js";
		
		File file = new File(boardJsPath);
		resultMap.put("size", file.length() / 1000);
		resultMap.put("date", new Date(file.lastModified()));
		
		String tplSrc = CmsHandler.readFile(boardJsPath);
		
		model.addAttribute("file", resultMap);
		model.addAttribute("tplSrc", tplSrc);
		
		return "/jnit/cms/board/textview";
	}
	
	@RequestMapping("/cms/board/pageSave.do")
	public String pageSave(HttpServletRequest request, Model model) throws IOException{
		
		String tplSrc = NullUtil.nullString(request.getParameter("tplSrc"));
		
		String realPath = PathUtil.getRealPath(request);
		String boardJsPath = realPath + "board" + SEPARATOR + "_common" + SEPARATOR + "js" + SEPARATOR + "board.js";
		
		File file = new File(boardJsPath);
		FileOutputStream fos = new FileOutputStream(file);
		OutputStreamWriter osw = new OutputStreamWriter(fos);
		
		osw.write(tplSrc);
		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, file);		//Filego 배포
		osw.close();
		fos.close();
		
		return "redirect:/cms/board/pageView.do";
	}	
	
}
