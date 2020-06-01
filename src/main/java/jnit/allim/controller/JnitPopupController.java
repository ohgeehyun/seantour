/**
 * @version 3.2.0.1
 */
package jnit.allim.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.allim.group.JnitallimGroupDefaultVO;
import jnit.allim.group.JnitallimGroupService;
import jnit.allim.group.JnitallimGroupVO;
import jnit.allim.item.JnitallimItemService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;

@Controller
public class JnitPopupController {

	//GROUP SERVICE
	@Resource(name = "jnitallimGroupService")
    private JnitallimGroupService jnitallimGroupService;
	
	//ITEM SERVICE
	@Resource(name = "jnitallimItemService")
    private JnitallimItemService jnitallimItemService;
	
	@RequestMapping(value="/jnitallim/JnitPopUpTestView.do")
	public String testView(Model model, HttpServletRequest request) throws Exception{
		
		String groupId = NullUtil.nullString(request.getParameter("groupId"));
		
		JnitallimGroupDefaultVO groupDefaultVO = new JnitallimGroupDefaultVO();
			groupDefaultVO.setSearchCondition("3");
			groupDefaultVO.setSearchKeyword(groupId);
			
		List grpResult = jnitallimGroupService.selectGroupList(groupDefaultVO);
		int grpResultSize = grpResult.size();
		
		JnitallimGroupVO grpVO = new JnitallimGroupVO();
			grpVO.setGroupId(groupId);
		
		JnitallimGroupVO grpValue = jnitallimGroupService.selectJnitallimGroup(grpVO);
		
		model.addAttribute("grpResult", grpResult);
		model.addAttribute("grpResultSize", grpResultSize);
		model.addAttribute("grpValue", grpValue);
		
		return "/jnit/allim/testView";
	}
}
