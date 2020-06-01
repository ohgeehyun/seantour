/**
 * @version 3.2.0.1
 */
package jnit.cms;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CmsTreeController {
	  
	    @RequestMapping("/cms/menuTree.do")
	    public String menuCon(HttpServletRequest request, ModelMap model) throws Exception {

			

			return "jnit/cms/menuTree";
	    }
}