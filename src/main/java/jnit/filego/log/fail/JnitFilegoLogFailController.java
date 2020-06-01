package jnit.filego.log.fail;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.filego.log.failConfirm.JnitFilegoLogFailConfirmService;
import jnit.filego.log.failConfirm.JnitFilegoLogFailConfirmVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class JnitFilegoLogFailController {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name="jnitFilegoLogFailService")
	JnitFilegoLogFailService jnitFilegoLogFailService;
	
	@Resource(name="jnitFilegoLogFailConfirmService")
	JnitFilegoLogFailConfirmService jnitFilegoLogFailConfirmService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	/**
	 * 파일고 실패로그 목록
	 * @request
	 * @model
	 */
	@RequestMapping("/cms/filego/log/fail/list.do")
	public String list(HttpServletRequest request, Model model,
			@ModelAttribute("searchVO") JnitFilegoLogFailDefaultVO searchVO) throws Exception{
		
		/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<EgovMap> resultList = jnitFilegoLogFailService.selectListJnitFilegoLogFail(searchVO);
		model.addAttribute("resultList", resultList);
		
		int totCnt = jnitFilegoLogFailService.selectListTotJnitFilegoLogFail(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
		return "/jnit/filego/log/fail/list";
	}

	@RequestMapping("/cms/filego/log/failCountJson.do")
	public String failCountJson(HttpServletRequest request, Model model) throws Exception{
		//filegoMode = on이면 갯수 가져오기
		if(Globals.FILEGO_ACTIVE.toLowerCase().trim().equals("on")){
			model.addAttribute("json", jnitFilegoLogFailService.selectListTotJnitFilegoLogFail(new JnitFilegoLogFailDefaultVO()));
		}
		return "/jnit/util/json";
	}
	
	/**
	 * 파일고 실패로그 확인
	 * @request
	 * @model
	 */
	@RequestMapping("/cms/filego/log/confirm.do")
	public String confirm(HttpServletRequest request, Model model) throws Exception{
		
		String seqs = NullUtil.nullString(request.getParameter("seqs"));
		String[] seqsArr = seqs.split(",");
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);								//회원 조회
		
		for(String seq  : seqsArr){
			JnitFilegoLogFailVO jnitFilegoLogFailVO = new JnitFilegoLogFailVO();
			jnitFilegoLogFailVO.setJfflSeq(seq);
			jnitFilegoLogFailVO = jnitFilegoLogFailService.selectJnitFilegoLogFail(jnitFilegoLogFailVO);	//실패로그 조회
			if(jnitFilegoLogFailVO != null){
				
				JnitFilegoLogFailConfirmVO confirmVO = new JnitFilegoLogFailConfirmVO();
				confirmVO.setJfflSeq(seq);
				confirmVO.setConfirmUserId(mbrVO.getMbrLogin());
				
				jnitFilegoLogFailConfirmService.insertJnitFilegoLogFailConfirm(confirmVO);						//실패확인로그 추가
				jnitFilegoLogFailService.deleteFilegoLogFail(jnitFilegoLogFailVO);								//실패로그 삭제
			}
		}
		return "/jnit/util/json";
	}
}
