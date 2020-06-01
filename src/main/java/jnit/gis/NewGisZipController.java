/**
 * @version 3.2.0.1
 */
package jnit.gis;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.util.PathUtil;

@Controller
public class NewGisZipController {

	private Log log = LogFactory.getLog(getClass());
	
	//지번 검색
	@RequestMapping("/gis/zip.do")
	public String newaddrJibun(HttpServletRequest request, Model model) throws IOException{
		
		String apiKeyPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/apiKey" + ".prop";
    	Properties prop = new Properties();
    	File propFile = new File(apiKeyPath);
    	InputStreamReader isr = null;
    	FileInputStream fis = null;
    	if(propFile.exists()){
    		try {
    			fis = new FileInputStream(propFile);
				isr = new InputStreamReader(fis, "UTF-8");
				try {
					prop.load(isr);
				} catch (IOException e) {
					log.error(e.getMessage());
				}
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			model.addAttribute("mapApi",prop);
    	}
		//return "jnit/gis/newZip/jibun";
		return "jnit/gis/latest/jusoPopup";
	}
	
	//도로명 검색
	@RequestMapping("/gis/newGisZip/road.do")
	public String newaddrRoad(){
		
		return "jnit/gis/newZip/road";
	}
	
	//건물명 검색
	@RequestMapping("/gis/newGisZip/sangho.do")
	public String newaddrsangho(){

		return "jnit/gis/newZip/sangho";
	}
	
	//주소 카테고리(ajax)
	@RequestMapping("/gis/newGisZip/ajax.do")
	public String newaddrAjax(HttpServletRequest request, Model model){
		
		return "jnit/gis/newZip/AjaxRequestXML";
	}
	
	//다음 좌표변환
	@RequestMapping("/gis/newGisZip/lngLat.do")
	public String latLng(HttpServletRequest request, Model model) throws UnsupportedEncodingException{
		
		String address = NullUtil.nullString(request.getParameter("address")).replaceAll(" ", "");
		address = URLEncoder.encode(address, "UTF-8");
		
		String apiKey = "d7bbf856ace8c4d9de700f131ed0d2a4baccb760";
		String key = EgovProperties.getPropertyData("DaumSearchKey", apiKey);
		
		String url = "";
		url = "http://apis.daum.net/local/geo/addr2coord?apikey="+key+"&q="+address+"&output=xml";
		
		NewGisZipController addrChange = new NewGisZipController();
		
		HashMap<String, String> addr = addrChange.content(url);
		String data = addr.get("lat") + "," + addr.get("lng");
		data = data.replaceAll("<b>", "").replaceAll("</b>", "");
		model.addAttribute("json", data);
		
		return "jnit/util/json";
	}
	
	
	//주소->좌표 lngLat 변환(XML Parsing)
	public HashMap<String, String> content(String url) {
		
		try{
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = factory.newDocumentBuilder();
			Document doc = build.parse(url);
			doc.getDocumentElement().normalize();
			
			NodeList headNodeList = doc.getElementsByTagName("item");
			
			for(int i=0;i<headNodeList.getLength(); i++){
				Node headNode = headNodeList.item(i);
				
				if(headNode.getNodeType() == Node.ELEMENT_NODE){
					Element headLineElement = (Element)headNode;
					
					NodeList localNm1 = headLineElement.getElementsByTagName("localName_1");
					Element subItem = (Element)localNm1.item(0);
					NodeList subElement1 = subItem.getChildNodes();
					
					NodeList localNm2 = headLineElement.getElementsByTagName("localName_2");
					subItem = (Element)localNm2.item(0);
					NodeList subElement2 = subItem.getChildNodes();
					
					NodeList localNm3 = headLineElement.getElementsByTagName("localName_3");
					subItem = (Element)localNm3.item(0);
					NodeList subElement3 = subItem.getChildNodes();
					
					NodeList mainAddress = headLineElement.getElementsByTagName("mainAddress");
					subItem = (Element)mainAddress.item(0);
					NodeList mainAddressResult = subItem.getChildNodes();
					
					NodeList lng = headLineElement.getElementsByTagName("lng");
					subItem = (Element)lng.item(0);
					NodeList lngResult = subItem.getChildNodes();
					
					NodeList lat = headLineElement.getElementsByTagName("lat");
					subItem = (Element)lat.item(0);
					NodeList latResult = subItem.getChildNodes();
					
					NodeList pointWX = headLineElement.getElementsByTagName("point_wx");
					subItem = (Element)pointWX.item(0);
					NodeList pointWXResult = subItem.getChildNodes();
					
					NodeList pointWY = headLineElement.getElementsByTagName("point_wy");
					subItem = (Element)pointWY.item(0);
					NodeList pointWYResult = subItem.getChildNodes();
					
					HashMap<String, String> nodeList = new HashMap<String, String>();
					
						nodeList.put("localName_1", subElement1.item(0).getNodeValue());
						nodeList.put("localName_2", subElement2.item(0).getNodeValue());
						nodeList.put("localName_3", subElement3.item(0).getNodeValue());
						nodeList.put("mainAddressResult", mainAddressResult.item(0).getNodeValue());
						nodeList.put("lng", lngResult.item(0).getNodeValue());
						nodeList.put("lat", latResult.item(0).getNodeValue());
						nodeList.put("point_wx", pointWXResult.item(0).getNodeValue());
						nodeList.put("point_wy", pointWYResult.item(0).getNodeValue());
					
					return nodeList;
				}//if
			}//for
		
		}catch(ParserConfigurationException e){
			log.error(e.getMessage());
		}catch(SAXException e){
			log.error(e.getMessage());
		}catch(IOException e){
			log.error(e.getMessage());
		}
		return null;
				
	}
	
}
