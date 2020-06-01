/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.util.HashMap;

public class MenuReplacementCode {
	
	public static HashMap<String, String> TopMenuReplacementCode(){
		
		HashMap<String, String> replacementCode = new HashMap<String, String>();
		
		/* common */
		replacementCode.put("{function_a_0}", "<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		replacementCode.put("{function_a_1}", "<%@ taglib prefix=\"c\" uri=\"http://java.sun.com/jsp/jstl/core\" %>");
		replacementCode.put("{function_a_2}", "<c:set var=\"topOrder\" value=\"${order < 10 ? '0' : ''}${order}\" />");
		//replacementCode.put("{function_a_}", "");
		
		/* c:forEach */
		replacementCode.put("{function_b_0}", "</c:forEach>");
		replacementCode.put("{function_b_1}", "<c:forEach var=\"menu\" items=\"${menuTree}\" varStatus=\"st\">");
		replacementCode.put("{function_b_2}", "<c:forEach var=\"child\" items=\"${menu.childTree}\" varStatus=\"status\">");
		replacementCode.put("{function_b_3}", "<c:forEach var=\"child2\" items=\"${child.childTree}\" varStatus=\"status2\">");
		replacementCode.put("{function_b_4}", "<c:forEach var=\"child3\" items=\"${child2.childTree}\" varStatus=\"status3\">");
		replacementCode.put("{function_b_5}", "<c:forEach var=\"child4\" items=\"${child3.childTree}\" varStatus=\"status4\">");
		//replacementCode.put("{function_b_}", "");
		
		/* c:if */
		replacementCode.put("{function_c_0}", "</c:if>");
		replacementCode.put("{function_c_1}", "<c:if test=\"${menu.childCount != null}\">");
		replacementCode.put("{function_c_2}", "<c:if test=\"${child.isexlink == 0}\">");
		replacementCode.put("{function_c_3}", "<c:if test=\"${child.isexlink == 1}\">");
		replacementCode.put("{function_c_4}", "<c:if test=\"${child.extgt != 'self'}\">");
		replacementCode.put("{function_c_5}", "<c:if test=\"${child.childCount != null}\">");
		replacementCode.put("{function_c_6}", "<c:if test=\"${child2.isexlink == 0}\">");
		replacementCode.put("{function_c_7}", "<c:if test=\"${child2.isexlink == 1}\">");
		replacementCode.put("{function_c_8}", "<c:if test=\"${child2.extgt != 'self'}\">");
		replacementCode.put("{function_c_9}", "<c:if test=\"${child2.childCount != null}\">");
		replacementCode.put("{function_c_10}", "<c:if test=\"${child3.isexlink == 0}\">");
		replacementCode.put("{function_c_11}", "<c:if test=\"${child3.isexlink == 1}\">");
		replacementCode.put("{function_c_12}", "<c:if test=\"${child3.extgt != 'self'}\">");
		replacementCode.put("{function_c_13}", "<c:if test=\"${child3.childCount != null}\">");
		replacementCode.put("{function_c_14}", "<c:if test=\"${child4.isexlink == 0}\">");
		replacementCode.put("{function_c_15}", "<c:if test=\"${child4.isexlink == 1}\">");
		replacementCode.put("{function_c_16}", "<c:if test=\"${child4.extgt != 'self'}\">");
		//replacementCode.put("{function_c_}", "");
		
		/* c:url */
		replacementCode.put("{function_d_0}", "<c:url value=\"${child.link}${!empty child.defaultmenu ? '/' : ''}${child.defaultmenu}\"/>");
		replacementCode.put("{function_d_1}", "<c:url value=\"${child.exlink}\"/>");
		replacementCode.put("{function_d_2}", "<c:url value=\"${child2.link}${!empty child2.defaultmenu ? '/' : ''}${child2.defaultmenu}\"/>");
		replacementCode.put("{function_d_3}", "<c:url value=\"${child2.exlink}\"/>");
		replacementCode.put("{function_d_4}", "<c:url value=\"${child3.link}${!empty child3.defaultmenu ? '/' : ''}${child3.defaultmenu}\"/>");
		replacementCode.put("{function_d_5}", "<c:url value=\"${child3.exlink}\"/>");
		replacementCode.put("{function_d_6}", "<c:url value=\"${child4.link}${!empty child4.defaultmenu ? '/' : ''}${child4.defaultmenu}\"/>");
		replacementCode.put("{function_d_7}", "<c:url value=\"${child4.exlink}\"/>");
		//replacementCode.put("{function_d_}", "");
		
		/* orther */
		replacementCode.put("{function_z_0}", "${topOrder}");
		replacementCode.put("{function_z_1}", "${order}");
		replacementCode.put("{function_z_2}", "${status.count}");
		replacementCode.put("{function_z_3}", "${status2.count}");
		replacementCode.put("{function_z_4}", "${status3.count}");
		replacementCode.put("{function_z_5}", "${status4.count}");
		replacementCode.put("{function_z_6}", "${menu.link}");
		replacementCode.put("{function_z_7}", "${menu.title}");
		replacementCode.put("{function_z_8}", "${child.title}");
		replacementCode.put("{function_z_9}", "${child.extgt == 'self' ? '_self' : '_blank'}");
		replacementCode.put("{function_z_10}", "${child.extgt}");
		replacementCode.put("{function_z_11}", "${child2.title}");
		replacementCode.put("{function_z_12}", "${child2.extgt == 'self' ? '_self' : '_blank'}");
		replacementCode.put("{function_z_13}", "${child2.extgt}");
		replacementCode.put("{function_z_14}", "${child3.title}");
		replacementCode.put("{function_z_15}", "${child3.extgt == 'self' ? '_self' : '_blank'}");
		replacementCode.put("{function_z_16}", "${child3.extgt}");
		replacementCode.put("{function_z_17}", "${child4.title}");
		replacementCode.put("{function_z_18}", "${child4.extgt == 'self' ? '_self' : '_blank'}");
		replacementCode.put("{function_z_19}", "${child4.extgt}");
		replacementCode.put("{function_z_20}", "${menu.over}");
		replacementCode.put("{function_z_21}", "${child.over}");
		replacementCode.put("{function_z_22}", "${child2.over}");
		replacementCode.put("{function_z_23}", "${child3.over}");
		replacementCode.put("{function_z_24}", "${child4.over}");
		//replacementCode.put("{function_z_}", "");
		
		return replacementCode;
	}
	
	

}
