/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class XmlUtil {

	/**
	 * 엘리먼트에서 해당하는 한개의 노드내용 가져오기.
	 * @param nl
	 * @return
	 */
	public static String getFirstElementByName(Element el, String nodeName){
		Element ele = null;
		String retStr = "";
		
        NodeList nl = el.getElementsByTagName(nodeName);
        if(nl.getLength() > 0){
			ele = (Element)nl.item(0);
			retStr = ele.getFirstChild().getNodeValue();//getTextContent();
			if(retStr == null)retStr = "";
		}
		return retStr;
	}
	/**
	 * XML 문서작성시 오류나는 리터럴 문자 치환.
	 * @param val
	 * @return
	 */
	public static String replaceXmlString(String val){
		return val.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("&","&amp;");
	}
}
