package jnit.board.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.WeakHashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.board.info.JnitboardinfoDefaultVO;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.com.excp.JnitDefaultException;
import jnit.com.web.JnitDefaultController;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class JnitBoardDataController extends JnitDefaultController{

	private Logger log	= Logger.getLogger(this.getClass());

	private final String PKG = "boardData";

	@Resource(name = "jnitBoardDataService")
	private JnitBoardDataService jnitBoardDataService;

	@Resource(name = "jnitboardinfoService")
    private JnitboardinfoService jnitboardinfoService;

	/**
	 * 분기문
	 */
	@RequestMapping(value="/jnit/boardData/index.do")
	public String index(
			@ModelAttribute	JnitBoardDataVO searchVO,
			HttpServletRequest request,
			ModelMap model) throws Exception{

		//공통 처리부
		request.setAttribute(PKG, PKG);//각 메소드 직접호출을 막기위한 셋팅.
		//로그인체크 등.
		String loginId = getLoginId(request);
		if("".equals(loginId)){
			model.addAttribute("alert","로그인 후에 이용하실 수 있습니다.");
			return "jnit/util/alertBack";
		}

		//기본 list로 포워딩
		if("".equals(NullUtil.nullString(searchVO.getSaMode())))searchVO.setSaMode("list");

		StringBuilder sb = new StringBuilder("forward:");
		sb.append("/jnit/boardData/" + searchVO.getSaMode() + ".do");

		return sb.toString();
	}


	/**
	 * 리스트
	 */
	@RequestMapping(value="/jnit/boardData/list.do")
	public String list(
			@ModelAttribute	JnitBoardDataVO searchVO,
			HttpServletRequest request,
			ModelMap model) throws Exception{
		if(request.getAttribute(PKG) == null)throw new JnitDefaultException("정상적인 경로로 접근해 주세요.");

		//기본값으로 스프링빈에 설정된 값 로드
		if(searchVO.getPageUnit() == 0)searchVO.setPageUnit(10);
		if(searchVO.getPageSize() == 0)searchVO.setPageSize(10);

		//총갯수
		int totalRecordCount = jnitBoardDataService.selectJnitBoardDataTot(searchVO);

    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
    	paginationInfo.setTotalRecordCount(totalRecordCount);

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//전체가져올때
		if(searchVO.getPageUnit() == -1)searchVO.setRecordCountPerPage(0);

		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultCnt",totalRecordCount);
		model.addAttribute("resultList",jnitBoardDataService.selectJnitBoardDataList(searchVO));

		return "jnit/board/data/list";
	}

	/**
	 * 뷰
	 */
	@RequestMapping(value="/jnit/boardData/view.do")
	public String view(
			JnitBoardDataVO searchVO,
			HttpServletRequest request,
			ModelMap model) throws Exception{
		if(request.getAttribute(PKG) == null)throw new JnitDefaultException("정상적인 경로로 접근해 주세요.");

		JnitBoardDataVO result = jnitBoardDataService.selectJnitBoardData(searchVO);

		model.addAttribute("result",result);
		model.addAttribute("isAdmin", "isadmin");
		return "jnit/board/data/view";
	}


	/**
	 * 삭제
	 */
	@RequestMapping(value="/jnit/boardData/deleteAction.do")
	public String deleteAction(
			JnitBoardDataVO searchVO,
			HttpServletRequest request,
			ModelMap model) throws Exception{
		if(request.getAttribute(PKG) == null)throw new JnitDefaultException("정상적인 경로로 접근해 주세요.");

		boolean isSuccess = false;
		String msg = "";
		try{
			jnitBoardDataService.deleteJnitBoardData(searchVO);
			isSuccess = true;
		}catch(EgovBizException e){
			msg = e.getMessage();
		}
		JSONObject json = new JSONObject();

		json.put("isSuccess", isSuccess);
		json.put("msg", msg);

		model.addAttribute("json",json.toString());

		return "jnit/util/json";
	}





	/**
	 * 추가 / 수정
	 */
	@RequestMapping(value="/jnit/boardData/write.do")
	public String write(
			JnitBoardDataVO searchVO,
			HttpServletRequest request,
			ModelMap model) throws Exception{
		if(request.getAttribute(PKG) == null)throw new JnitDefaultException("정상적인 경로로 접근해 주세요.");

		if(!"".equals(NullUtil.nullString(searchVO.getDataId()))){
			JnitBoardDataVO result = jnitBoardDataService.selectJnitBoardData(searchVO);
			model.addAttribute("result",result);
			if(result != null){
				ArrayList<String> selectList = new ArrayList();
				Collections.addAll(selectList,  result.getDataBoardIds().split(","));
				JnitboardinfoDefaultVO infodefVO = new JnitboardinfoDefaultVO();
				infodefVO.setSearchCondition("boardIds");
				infodefVO.setSelectList(selectList);
				infodefVO.setFirstIndex(0);
				infodefVO.setLastIndex(10000);
				List infoList = jnitboardinfoService.selectJnitboardArticleList(infodefVO);
				model.addAttribute("infoList",infoList);

			}
		}

		return "jnit/board/data/write";
	}


	/**
	 * 추가 / 수정 처리
	 */
	@RequestMapping(value="/jnit/boardData/writeAction.do")
	public String writeAction(
			JnitBoardDataVO searchVO,
			HttpServletRequest request,
			ModelMap model) throws Exception{
		if(request.getAttribute(PKG) == null)throw new JnitDefaultException("정상적인 경로로 접근해 주세요.");

		String[] boardIds =request.getParameterValues("dataBoardIds");
		String dataBoardIds = "";
		if(boardIds != null){
			Arrays.sort(boardIds);
			for(int i=0; i<boardIds.length; i++){
				dataBoardIds += (!"".equals(boardIds) ? "," : "")+boardIds[i];
			}

			if(dataBoardIds.indexOf(",") == 0){
				dataBoardIds = dataBoardIds.substring(1);
			}
			searchVO.setDataBoardIds(dataBoardIds);
		}

		boolean isSuccess = false;
		String msg = "";
		try{
			searchVO.setSearchCondition("boardIdsChk");
			searchVO.setSearchKeyword(dataBoardIds);
			boolean equalData = false;

			searchVO.setRecordCountPerPage(0);
			List idchkList = jnitBoardDataService.selectJnitBoardDataList(searchVO);
			Iterator boarditr = idchkList.iterator();
			while(boarditr.hasNext()){
				JnitBoardDataVO resultMap = (JnitBoardDataVO)boarditr.next();
				String dataNm = resultMap.getDataNm();
				msg = "중복된 게시판 데이터가 존재합니다. : "+dataNm;
				isSuccess = false;
				equalData = true;
			}

			if(!equalData){
				jnitBoardDataService.writeJnitBoardData(request,searchVO);
				isSuccess = true;
			}
		}catch(JnitDefaultException e){
			msg = e.getMessage();
			isSuccess = false;
		}catch(Exception e){
			log.error(e.getMessage());
			msg = "알 수 없는 에러";
			isSuccess = false;
		}

		model.addAttribute("isSuccess",isSuccess);
		model.addAttribute("msg",msg);
		model.addAttribute("retUrl", NullUtil.nullString(searchVO.getRetUrl()));

		return "jnit/board/data/writeAction";
	}

}
