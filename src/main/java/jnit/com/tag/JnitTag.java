/**
 * @version 3.2.0.1
 */
package jnit.com.tag;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import jnit.cms.mbrpackage.JnitcmsmbrpackageController;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.fcc.service.UrlUtil;
import egovframework.com.utl.fcc.service.WebUtil;

public class JnitTag{

    public JnitTag()
    {
    }

    private static final long serialVersionUID = 1L;
    
    /**
     * 태그 없애기
     * @param html
     * @return
     */
    public static String removeHtmlTag(String html){
    	return WebUtil.removeTag(html);
    }

    /**
     * 태그를 HTML형태로 그대로 출력할때 변환
     * @param txtValue
     * @return
     */
    public static String dbToHtml(String txtValue){
    	return WebUtil.DbToHtml(txtValue, "");
    }
    /**
     * 태그를 HTML형태로 그대로 출력할때 엔터값을 제외하고 변환
     * @param txtValue
     * @return
     */
    public static String dbToHtmlExceptEnter(String txtValue){
    	return WebUtil.DbToHtmlExceptEnter(txtValue, "");
    }
    
    /**
     * 오늘날짜와 해당날짜의 차이 일수.
     * @param d 해당일
     * @return 차이 날짜수.
     */
    public static long getDayFromToday(Date d){
    	Date today = new Date();
	    long diff = today.getTime() - d.getTime();
	    long diffDays = diff / (24 * 60 * 60 * 1000);
    	return diffDays;
    }
    
    /**
     * 글자수로 문자열을 체크하여 글자 자르기.
     * @param str
     * @param cutCount
     * @param addString
     * @return
     */
    public static String cutString(String str, int cutCount,String addString){
    	return StringUtil.cutString(str, cutCount, addString);
    }
    /**
     * Byte크기로 문자열을 체크하여 글자 자르기.
     * @param str
     * @param byteCount
     * @param addString
     * @return
     */
    public static String cutStringByByte(String str, int byteCount,String addString){
    	return StringUtil.cutStringByByte(str, byteCount, addString);
    }
    /**
     * url인코딩
     * @param url
     * @return
     */
    public static String encodeUrl(String url){
    	return UrlUtil.encodeUrl(url);
    }
    /**
     * 현재url인코딩
     * @param request
     * @return
     */
    public static String encodeCurrentUrl(HttpServletRequest request){
    	return UrlUtil.encodeCurrentUrl(request);
    }
    /**
     * 전체 URL가져오기.
     * @param request
     * @return
     */
    public static String currentAllUrl(HttpServletRequest request){
    	return UrlUtil.currentAllUrl(request);
    }
}
