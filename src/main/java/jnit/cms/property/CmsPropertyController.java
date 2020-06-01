/**
 * @version 3.2.0.1
 */
package jnit.cms.property;

import javax.annotation.Resource;

import jnit.cms.config.CmsConfigController;
import jnit.cms.site.JnitcmssiteService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;

@Controller
@RequestMapping("/cms/property")
public class CmsPropertyController extends CmsConfigController{
    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
	
    public static String getCmsProperty(String propName) {
    	return EgovProperties.getProperty(propName).toString();
    }
}
