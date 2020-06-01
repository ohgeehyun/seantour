/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrtype;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;

@Controller
public class CmsMbrtypeUtilController {
	private int limitSignupAge = 19;
	
    @Resource(name = "jnitcmsmbrtypeService")
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;	 
            
    @RequestMapping("/cms/mbrtype/search.do")
    public String mbrSearchId(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	String domId = NullUtil.nullString(request.getParameter("domId"));
    	    	
    	JnitcmsmbrtypeDefaultVO searchVO = new JnitcmsmbrtypeDefaultVO();
    	searchVO.setSearchCondition("9");
    	searchVO.setFirstIndex(0);
    	searchVO.setRecordCountPerPage(1);
    	
    	model.addAttribute("domId",domId);

    	return "jnit/cms/mbrtype/search";
    }
    
    @RequestMapping("/cms/mbrtype/searchAjax.do")
    public String mbrSearchIdProc(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
    	String searchKeyword = URLDecoder.decode(NullUtil.nullString(request.getParameter("searchKeyword")),"UTF-8");
    	    	
    	JnitcmsmbrtypeDefaultVO searchVO = new JnitcmsmbrtypeDefaultVO();
    	searchVO.setSearchCondition(searchCondition);
    	searchVO.setSearchKeyword(searchKeyword);
    	searchVO.setFirstIndex(0);
    	searchVO.setLastIndex(10000);
    	searchVO.setRecordCountPerPage(1000);
    	
    	List schResult = jnitcmsmbrtypeService.selectJnitcmsmbrtypeList(searchVO);
    	JSONArray jsonArr = new JSONArray().fromObject(schResult);
    	
    	model.addAttribute("json",jsonArr);

    	return "jnit/util/json";
    }
    

    

}