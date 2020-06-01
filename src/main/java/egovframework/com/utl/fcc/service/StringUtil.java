/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	/**
	 * List&lt;String&gt; 안에 스트링있는지 여부 체크
	 * @param list
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static boolean isExistInList(List<String> list,String str) throws Exception{
		boolean bl = false;
		for(int i = 0; i < list.size(); i++){
			if(list.get(i).toLowerCase().equals(str.toLowerCase()))bl = true;
		}
		return bl;
	}
	 /**
     * String[]에서 str값이 있는지 체크
     * @param strArr
     * @param str
     * @return
     */
    public static boolean isExistArray(String[] strArr,String str){
    	boolean bl = false;
    	if(strArr != null){
	    	for(int i = 0; i < strArr.length; i ++){
	    		if(strArr[i] != null && strArr[i].equals(str))bl = true;
	    	}
    	}
    	return bl;
    }
    
    /**
     * String[]에서 str값이 있는지 체크
     * @param strArr
     * @param str
     * @return
     */
    public static boolean isExistArrayIndexOf(String[] strArr,String str){
    	boolean bl = false;
    	str = NullUtil.nullString(str);    	
    	if(strArr != null){
	    	for(int i = 0; i < strArr.length; i ++){	    		
	    		if(strArr[i] != null && !"".equals(strArr[i]) && !"".equals(str) && str.indexOf(strArr[i]) > -1)bl = true;
	    	}
    	}
    	return bl;
    }
    
    /**
     * String에서 str값이 있는지 체크
     * @param chkStr
     * @param str
     * @return
     */
    public static boolean isExistString(String chkStr,String str){
    	boolean bl = false;
    	if(chkStr != null){
	    	if(chkStr.indexOf(str) > -1)bl = true;
    	}
    	return bl;
    }
    
    /**
     * str 문자열을 strSplit으로 잘라서 ArrayList로 반환
     * @param strArr
     * @param str
     * @return
     */
    public static List stringToArray(String str, String strSplit){
    	List retList = new ArrayList();
    	if(str != null){
	    	String[] tmp = str.split(strSplit);
    		for(int i = 0; i < tmp.length; i ++){
	    		retList.add(tmp[i]);
	    	}
    	}
    	return retList;
    }
    /**
     * 정규식에 의한 문자열 치환.
     * @param str 기존 문자열
     * @param chStr 치환할 문자열
     * @param regExp 치환 정규식
     * @return
     */
    public static String replaceAllRegExp(String str,String chStr,String regExp){
    	String retStr = "";//Pattern.CASE_INSENSITIVE | 
    	Pattern p = Pattern.compile(regExp, Pattern.MULTILINE | Pattern.DOTALL);
		Matcher m = p.matcher(str);
		StringBuffer result = new StringBuffer();
		while(m.find()) {
		    m.appendReplacement(result,  chStr);
		}

		m.appendTail(result);
		retStr = result.toString();
    	return retStr;
    }
    
	/**
	 * 태그없애기.
	 * @param content
	 * @return
	 */
	public static String removeHtml(String content) {   
	    Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>",Pattern.DOTALL);   
	    Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);   
	    Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");   
	    Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");   
	    Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");   
	    Pattern WHITESPACE = Pattern.compile("\\s\\s+");   
	       
	    Matcher m;   
	       
	    m = SCRIPTS.matcher(content);   
	    content = m.replaceAll("");   
	    m = STYLE.matcher(content);   
	    content = m.replaceAll("");   
	    m = TAGS.matcher(content);   
	    content = m.replaceAll("");   
	    m = ENTITY_REFS.matcher(content);   
	    content = m.replaceAll("");   
	    m = WHITESPACE.matcher(content);   
	    content = m.replaceAll(" ");  
	    return content;   
	}
	/**
	 * 3자리마다 콤마찍기.
	 * @param str
	 * @return
	 */
	public static String setComma(String str){
		if(str == null) return "0";
		if(str.length() <= 3)return str;
		
		double dbStr = Double.parseDouble(str);
		DecimalFormat df = new DecimalFormat();
		return df.format(dbStr);
	}
	/**
	 * 한글(2byte)과 영문(1byte)의 출력크기가 다름으로 문자열을 바이트로 체크하여 byteCount로 자르고, 해당 카운트보다 클때는 addString을 붙여서 리턴
	 * @param str 문자열
	 * @param byteCount 자를 문자바이트수
	 * @param addString byteCount보다 클때 뒤에 붙을 문자.
	 * @return (str | 잘린str + addStr)
	 */
	public static String cutStringByByte(String str, int byteCount, String addString){
		if(str.getBytes().length <= byteCount) return str;
		
		StringBuffer sb = new StringBuffer();
		int strTotal = 0;
		for(char c: str.toCharArray()){
			strTotal += String.valueOf(c).getBytes().length;
			if(strTotal > byteCount) break;
			sb.append(c);
		}
		sb.append(addString);
		return sb.toString();
	}
	/**
	 * 글자수에 의한 글자 자르기
	 * @param str 문자열
	 * @param cutCount 자를 문자수
	 * @param addString cutCount보다 클때 뒤에 붙을 문자.
	 * @return (str | 잘린str + addStr)
	 */
	public static String cutString(String str, int cutCount, String addString){
		if(str.length() <= cutCount) return str;
		
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < str.length(); i++){
			if(i >= cutCount)break;
			sb.append(str.charAt(i));
		}
		sb.append(addString);
		return sb.toString();
	}
}
