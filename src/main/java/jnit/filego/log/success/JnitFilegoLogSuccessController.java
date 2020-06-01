package jnit.filego.log.success;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class JnitFilegoLogSuccessController {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name="jnitFilegoLogSuccessService")
	JnitFilegoLogSuccessService jnitFilegoLogSuccessService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	/**
	 * 파일고 배포 성공목록
	 * @request
	 * @model
	 */
	@RequestMapping("/cms/filego/log/success/list.do")
	public String list(HttpServletRequest request, Model model,
			@ModelAttribute("searchVO") JnitFilegoLogSuccessDefaultVO searchVO) throws Exception{
		
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
		
		List<Object> resultList = jnitFilegoLogSuccessService.selectListJnitFilegoLogSuccess(searchVO);
		model.addAttribute("resultList", resultList);
		
		int totCnt = jnitFilegoLogSuccessService.selectListTotJnitFilegoLogSuccess(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
		return "/jnit/filego/log/success/list";
	}
}
