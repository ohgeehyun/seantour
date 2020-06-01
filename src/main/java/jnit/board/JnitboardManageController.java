/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.board.db.JnitboarddbDefaultVO;
import jnit.board.db.JnitboarddbService;
import jnit.board.db.JnitboarddbVO;
import jnit.board.file.JnitboardfileService;
import jnit.board.file.JnitboardfileVO;
import jnit.board.info.JnitboardinfoController;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.handler.CmsProperty;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.DBType;
import jnit.db.JnitdbService;
import jnit.db.JnitdbVO;
import jnit.sms.JnitSmsService;

@Controller
public class JnitboardManageController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitcmsmbrService")
	private JnitcmsmbrService jnitcmsmbrService;

	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;

	@Resource(name = "jnitdbService")
	private JnitdbService dbService;
	
	@Resource(name = "cmsProperty")
    private CmsProperty cmsProperty;
	
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_INFO_PATH = "board" + SEPERATOR + "_info" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    public static final String debug = EgovProperties.getProperty("Globals.Debug");
    
    @RequestMapping(value = "/board/manage/article.do")
	public String article(@RequestParam("boardId") java.lang.String boardId,
			@RequestParam("cntId") int cntId,
			HttpServletRequest request,
			ModelMap model) throws Exception{
    	
    	String targetUrl = NullUtil.nullString(request.getParameter("targetUrl"));
    	String comment = NullUtil.nullString(request.getParameter("comment"));
    	
    	boolean isAdmin = false;

		JnitboardinfoVO boardinfoVO = new JnitboardinfoVO();
		boardinfoVO.setBoardId(boardId);
		boardinfoVO = infoService.selectJnitboardinfo(boardinfoVO);
		model.addAttribute("boardinfoVO",boardinfoVO);
		model.addAttribute("f",JnitboardinfoController.getFieldInfo(boardinfoVO));
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		
		model.addAttribute("sitePath",AdminUtil.getSitePath(request));
		
		String[] admExt = null;
		//if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
		if(!NullUtil.nullString(boardinfoVO.getAdmExt()).equals("")){
			admExt = boardinfoVO.getAdmExt().split(",");
		}
		
		if(StringUtil.isExistArray(admExt,loginVO.getMbrId())){
			isAdmin = true;
		}
		String[] adminLVs = boardinfoVO.getAdmList().toUpperCase().replaceAll("'", "").split(",");
		String adminLV = "";
		for (int i = 0; i < adminLVs.length; i++) {
			if (!adminLVs[i].isEmpty()) {
				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
			}
		}
		adminLV = adminLV.replaceFirst(",", "");
		JnitdbVO jnitdbVO = new JnitdbVO();
		jnitdbVO.setQuery("SELECT COUNT(*) FROM JNITCMSMBRTYPE WHERE TYPE_LV IN ("+adminLV+") AND TYPE_ID='"+loginVO.getTypeId()+"'");
		
		if(dbService.selectCnt(jnitdbVO) != 0) {
			isAdmin = true;
		}

		model.addAttribute("isAdmin", isAdmin);
		if(!isAdmin){
			model.addAttribute("alert", "권한이 없습니다.");
			return "/jnit/util/alertOpenerReload";
		}
		
		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(cntId);
		dbVO = jnitboarddbService.selectAnonymous(dbVO);
		String writer = NullUtil.nullString(dbVO.getWriter());
		model.addAttribute("result",dbVO);
		
		String mode = NullUtil.nullString(request.getParameter("mode"));
		String action = NullUtil.nullString(request.getParameter("action"));

		List boardGroupList = infoService.selectJnitboardinfoGroupList(boardinfoVO);
		model.addAttribute("boardGroupList", boardGroupList);
		String originBoardId = boardId;
		int originCntId = cntId;
		int originGrp = dbVO.getGrp(); 
		String[] targetBoard = NullUtil.nullString(request.getParameter("boardResult")).split(",");
		
		if("manage".equals(mode)){
			try{
				/**
				 * TODO : 첨부파일 처리.
				 */
				
				List fileList = fileService.selectFileList(boardId, dbVO.getId());
				
				for(String tgBoardId : targetBoard){
					if(!NullUtil.nullString(tgBoardId).equals("")){
						dbVO.setBoardId(boardId);
						dbVO.setId(cntId);
						dbVO = jnitboarddbService.selectAnonymous(dbVO);//vo 초기화
						
						dbVO.setBoardId(tgBoardId);
						dbVO.setGrp(0);
						dbVO.setId(jnitboarddbService.insert(dbVO));
						
						Iterator it = fileList.iterator();
						while (it.hasNext()) {
							EgovMap fileMap = (EgovMap) it.next();
							JnitboardfileVO fileVO = new JnitboardfileVO();
						    fileVO.setFileId((String) fileMap.get("fileId"));
						    fileVO.setBoardId(dbVO.getBoardId());
						    fileVO.setBoardCntId(dbVO.getId());
						    fileVO.setFileUrl((String) fileMap.get("fileUrl"));
						    fileVO.setFilePath((String) fileMap.get("filePath"));
						    fileVO.setFileNm((String) fileMap.get("fileNm"));
						    fileVO.setFileOnm((String) fileMap.get("fileOnm"));
						    if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
						    	fileVO.setIsmain(Integer.parseInt(fileMap.get("ismain").toString()));
						    	fileVO.setIsdel(Integer.parseInt(fileMap.get("isdel").toString()));
						    }else{
						    	fileVO.setIsmain((Integer)fileMap.get("ismain"));
						    	fileVO.setIsdel((Integer)fileMap.get("isdel"));
						    }
						    fileVO.setExt01((String) fileMap.get("ext01"));
						    fileVO.setExt02((String) fileMap.get("ext02"));
						    fileService.insertJnitboardfileMove(fileVO);
						}
					}
				}
				if("move".equals(action)){
					dbVO.setBoardId(originBoardId);
					dbVO.setId(originCntId);
					jnitboarddbService.delete(dbVO);
					
				}else if("move_with_tracks".equals(action)){
					
					JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
					searchVO.setBoardId(targetBoard[0]);
					int maxId = jnitboarddbService.getLastId(searchVO);
					maxId = maxId - 1;
					
					dbVO.setBoardId(originBoardId);
					dbVO.setId(originCntId);
					dbVO.setGrp(originGrp);
					dbVO.setWriter(writer);
					dbVO.setTitle(comment+" (으)로 이동된 게시물 입니다.");
					dbVO.setContent("<a href=\""+targetUrl+"?boardId="+targetBoard[0]+"&mode=view&cntId="+maxId+"&category="+"\" target=\"_black\" title=\"새창\">"+comment+" (으)로 이동된 게시물</a>");
					dbVO.setIsdel(2);
					jnitboarddbService.update(dbVO);
					
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
				model.addAttribute("alert", "적용 실패");
				return "/jnit/util/alertOpenerReload";
			}catch(Exception e){
				log.error(e.getMessage());
				model.addAttribute("alert", "적용 실패");
				return "/jnit/util/alertOpenerReload";
			}

			model.addAttribute("alert", "적용되었습니다.");
			return "/jnit/util/alertOpenerReload";
			
		}
		return "/jnit/board/manage/article";
	}

    @RequestMapping(value = "/board/manage/minwon.do")
	public String minwon(@RequestParam("boardId") java.lang.String boardId,
			@RequestParam("cntId") int cntId,
			HttpServletRequest request,
			ModelMap model) throws Exception{
    	
    	boolean isAdmin = false;

		JnitboardinfoVO boardinfoVO = new JnitboardinfoVO();
		boardinfoVO.setBoardId(boardId);
		boardinfoVO = infoService.selectJnitboardinfo(boardinfoVO);
		model.addAttribute("boardinfoVO",boardinfoVO);
		model.addAttribute("f",JnitboardinfoController.getFieldInfo(boardinfoVO));
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		String[] admExt = boardinfoVO.getAdmExt().split(",");
		if(StringUtil.isExistArray(admExt,loginVO.getMbrId())){
			isAdmin = true;
		}
		String[] adminLVs = boardinfoVO.getAdmList().toUpperCase().replaceAll("'", "").split(",");
		String adminLV = "";
		for (int i = 0; i < adminLVs.length; i++) {
			if (!adminLVs[i].isEmpty()) {
				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
			}
		}
		adminLV = adminLV.replaceFirst(",", "");
		JnitdbVO jnitdbVO = new JnitdbVO();
		jnitdbVO.setQuery("SELECT COUNT(*) FROM JNITCMSMBRTYPE WHERE TYPE_LV IN ("+adminLV+") AND TYPE_ID='"+loginVO.getTypeId()+"'");
		
		if(dbService.selectCnt(jnitdbVO) != 0) {
			isAdmin = true;
		}

		model.addAttribute("isAdmin", isAdmin);
		if(!isAdmin){
			model.addAttribute("alert", "권한이 없습니다.");
			return "/jnit/util/alertOpenerReload";
		}
		
		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(cntId);
		dbVO = jnitboarddbService.select(dbVO);
		model.addAttribute("result",dbVO);
		
		String mode = NullUtil.nullString(request.getParameter("mode"));
		String ext01 = NullUtil.nullString(request.getParameter("ext01"));
		String ext02 = NullUtil.nullString(request.getParameter("ext02"));
		String ext05 = NullUtil.nullString(request.getParameter("ext05"));

		if("manage".equals(mode)){
			if(ext01.equals("담당자지정")){
				JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
				jnitcmsmbrVO.setMbrId(ext05);
				try{
					JnitcmsmbrVO mbrVO = jnitcmsmbrService.selectJnitcmsmbr(jnitcmsmbrVO);
					String phoneTo = "";
					phoneTo = mbrVO.getMobile();
					String phoneFrom = NullUtil.nullString(boardinfoVO.getSmsNum());
					String smsMsg = boardinfoVO.getBoardTitle() + "에 새 민원이 등록되었습니다.";
					if(!"".equals(phoneTo)){
						JnitSmsService smsSvc = new JnitSmsService();
						smsSvc.init();
						smsSvc.sendMsg(phoneTo, phoneFrom, smsMsg);
					}
				} catch (NullPointerException e){
					log.error(e.getMessage());
				}catch(Exception e){
					log.error(e.getMessage());
				}
			}
		
			dbVO.setExt01(ext01);
			dbVO.setExt02(ext02);
			dbVO.setExt05(ext05);
			try{
				jnitboarddbService.update(dbVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
				model.addAttribute("alert", "적용 실패");
				return "/jnit/util/alertOpenerReload";
			}catch(Exception e){
				log.error(e.getMessage());
				model.addAttribute("alert", "적용 실패");
				return "/jnit/util/alertOpenerReload";
			}
			model.addAttribute("alert", "적용되었습니다.");
			return "/jnit/util/alertOpenerReload";
			
		}
		return "/jnit/board/manage/minwon";
	}


}