/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

/**
 * 웹 관련 유틸 클래스
 * @author JNIT
 * @since 2012.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일		수정자		수정내용
 *  -------		--------	---------------------------
 *   2012.06.28	JNIT		최초 생성
 *
 * </pre>
 */

public class WebUtil {

    /**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    public static String unscript(String data) {
    	try{
	        if (data == null || data.trim().equals("")) {
	            return "";
	        }
    	}catch (Exception e) {
			return "";
		}
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }

	/**
	 * 숫자 형식 select box 만들기.
	 * @param name 셀렉트박스 name property
	 * @param intStart 시작번호
	 * @param intEnd 종료번호
	 * @param intSelected 선택번호.
	 * @return 셀렉트박스 문자열.
	 */
	public static String getSelBoxDate(String name,int intStart,int intEnd,int intSelected){
		StringBuffer str = new StringBuffer();
		String pr_i = "";
		
		try{
			str.append("<select name='"+name+"'>\n");
			
			for(int i = intStart; i <= intEnd; i++ ){
				//10보다 작을때는 0추가.
				pr_i = (i<10)?"0"+i:""+i;
				
				str.append("	<option value='" + pr_i + "'");
				str.append((intSelected == i)?" selected":"");
				str.append(">"+pr_i+"</option>\n");
			}
			
			str.append("</select>\n");
		}catch(Exception e){
			e.printStackTrace();
		}
		return str.toString();
	}
	/**
	 * 숫자 형식 select box 만들기.
	 * @param name 셀렉트박스 name property
	 * @param intStart 시작번호
	 * @param intEnd 종료번호
	 * @param intSelected 선택번호.
	 * @param firstOption 기본 옵션.
	 * @return 셀렉트박스 문자열.
	 */
	public static String getSelBoxDate(String name,int intStart,int intEnd,int intSelected,String firstOption){
		StringBuffer str = new StringBuffer();
		String pr_i = "";
		
		try{
			str.append("<select name='"+name+"'>\n");
			if(!firstOption.equals(""))
				str.append("	<option value=''>"+firstOption+"</option>\n");
			
			for(int i = intStart; i <= intEnd; i++ ){
				//10보다 작을때는 0추가.
				pr_i = (i<10)?"0"+i:""+i;
				
				str.append("	<option value='" + pr_i + "'");
				str.append((intSelected == i)?" selected":"");
				str.append(">"+pr_i+"</option>\n");
			}
			
			str.append("</select>\n");
		}catch(Exception e){
			e.printStackTrace();
		}
		return str.toString();
	}
	/**
	 * 거꾸로 숫자 형식 select box 만들기.
	 * @param name 셀렉트박스 name property
	 * @param intStart 시작번호
	 * @param intEnd 종료번호
	 * @param intSelected 선택번호.
	 * @param firstOption 기본 옵션.
	 * @return 셀렉트박스 문자열.
	 */
	public static String getSelBoxDateReverse(String name,int intStart,int intEnd,int intSelected,String firstOption){
		StringBuffer str = new StringBuffer();
		String pr_i = "";
		
		try{
			str.append("<select name='"+name+"'>\n");
			if(!firstOption.equals(""))
				str.append("	<option=''>"+firstOption+"</option>\n");
			
			for(int i = intEnd; i >= intStart; i-- ){
				//10보다 작을때는 0추가.
				pr_i = (i<10)?"0"+i:""+i;
				
				str.append("	<option value='" + pr_i + "'");
				str.append((intSelected == i)?" selected":"");
				str.append(">"+pr_i+"</option>\n");
			}
			
			str.append("</select>\n");
		}catch(Exception e){
			e.printStackTrace();
		}
		return str.toString();
	}
	/**
	 * 문자열을 통한 Select Box 만들기
	 * @param name 셀렉트박스 name property
	 * @param strOption 옵션 출력명 문자열
	 * @param strOptionValue 옵션 값 문자열
	 * @param strSplit 문자열 자르는 문자
	 * @param selectedValue 선택된 값
	 * @return 셀렉트박스 문자열.
	 */
	public static String getSelBox(String name,String strOption,String strOptionValue,String strSplit, String selectedValue){
		StringBuffer str = new StringBuffer();

		try{
			String[] lstOption = strOption.split(strSplit);
			String[] lstOptionValue = strOptionValue.split(strSplit);
			
			str.append("<select name='"+name+"'>\n");
			
			for(int i = 0; i < lstOption.length; i++ ){
				
				str.append("	<option value='" + lstOptionValue[i] + "'");
				str.append((lstOptionValue[i] == selectedValue)?" selected":"");
				str.append(">"+lstOption[i]+"</option>\n");
			}
			str.append("</select>\n");

		}catch(Exception e){
			e.printStackTrace();
		}

		return str.toString();
	}
	
	/**
	 * 
	 * @param str
	 * @return
	 */
	public static String htmlToDb(String str){
		String strReturn = "";

		str = str.replaceAll("\n", "");
		str = str.replaceAll("\r", "<br>");
		str = str.replaceAll("\t", "<br>");
		str = str.replaceAll("\"", "quot;");
		str = str.replaceAll("'", "#039;");
		
		strReturn = str;
		return strReturn;
	}
	/**
	 * 태그 사용여부에 따른 내용 출력시 태그 변환.
	 * @param str
	 * @param tag
	 * @return
	 */
	public static String DbToHtml(String str, String tag){
		String strReturn = "";
		str = NullUtil.nullString(str);
		//태그 사용 안함.
		if(!NullUtil.nullString(tag).equals("Y")){
			str = str.replaceAll("<", "&lt;");
			str = str.replaceAll(">", "&gt;");
			str = str.replaceAll("  ", "&nbsp;&nbsp;");
			str = str.replaceAll("\n\r", "<BR />");
			str = str.replaceAll("\n", "<BR />");
			str = str.replaceAll("\r", "<BR />");
		//기본 태그 제어.
		}else{
			str = str.replaceAll("<script", "&lt;script");
			str = str.replaceAll("</script", "&lt;/script");
		}
		
		strReturn = str;
		return strReturn;
	}
	/**
	 * 태그 사용여부에 따른 내용 출력시 태그 변환.(엔터 값만 제외하고 적용)
	 * @param str
	 * @param tag
	 * @return
	 */
	public static String DbToHtmlExceptEnter(String str, String tag){
		String strReturn = "";
		str = NullUtil.nullString(str);
		//태그 사용 안함.
		if(!NullUtil.nullString(tag).equals("Y")){
			str = str.replaceAll("<", "&lt;");
			str = str.replaceAll(">", "&gt;");
			str = str.replaceAll("\n", "");
		//기본 태그 제어.
		}else{
			str = str.replaceAll("<script", "&lt;script");
			str = str.replaceAll("</script", "&lt;/script");
		}
		
		strReturn = str;
		return strReturn;
	}
	/**
	 * 숫자 형식 select box 만들기 감소형태.
	 * @param name 셀렉트박스 name property
	 * @param intStart 시작번호
	 * @param intEnd 종료번호
	 * @param intSelected 선택번호.
	 * @return 셀렉트박스 문자열.
	 */
	public static String getSelBoxDateMinus(String name,int intStart,int intEnd,int intSelected){
		StringBuffer str = new StringBuffer();
		String pr_i = "";
		
		try{
			str.append("<select name='"+name+"'>\n");
			
			for(int i = intStart; i > intEnd; i-- ){
				//10보다 작을때는 0추가.
				pr_i = (i<10)?"0"+i:""+i;
				
				str.append("	<option value='" + pr_i + "'");
				str.append((intSelected == i)?" selected":"");
				str.append(">"+pr_i+"</option>\n");
			}
			
			str.append("</select>\n");
		}catch(Exception e){
			e.printStackTrace();
		}
		return str.toString();
	}
	
	/**
	 * 파일확장명 가져오기.
	 * @param fileName
	 * @return
	 */
	public static String getFileExt(String fileName){
		String[] names = new String[2];

		int pos = fileName.lastIndexOf('.');

		if (pos == -1){
			names[0] = fileName;
			names[1] = "";
		}else{
			names[0] = fileName.substring(0, pos);
			names[1] = fileName.substring(pos);
		}

		return names[1];
	}
	
	/**
	 * 파일명에 따른 아이콘 가져오기.
	 * @param fileName
	 * @return
	 */
	public static String getFileIcon(String fileName){
		String strReturn = "";
		String fileExt = getFileExt(fileName);
		
		if(fileExt.indexOf("bmp") > -1){
			strReturn = "bmp";
		}else if(fileExt.indexOf("doc") > -1){
			strReturn = "doc";
		}else if(fileExt.indexOf("gif") > -1){
			strReturn = "gif";
		}else if(fileExt.indexOf("hwp") > -1){
			strReturn = "hwp";
		}else if(fileExt.indexOf("jpg") > -1){
			strReturn = "jpg";
		}else if(fileExt.indexOf("pdf") > -1){
			strReturn = "pdf";
		}else if(fileExt.indexOf("ppt") > -1){
			strReturn = "ppt";
		}else if(fileExt.indexOf("txt") > -1){
			strReturn = "txt";
		}else if(fileExt.indexOf("xls") > -1){
			strReturn = "xls";
		}else{
			strReturn = "disk";
		}
		
		return strReturn;
	}
	
	/**
	 * 숫자 형태 바꾸기.
	 * @param value
	 * @return
	 */
	public static String addComma(Object value) {
		DecimalFormat format = new DecimalFormat("###,###");
		return format.format(value);
    }


	
	/**
	 * 해당 URL을 읽어와서 String 으로 전달.
	 * @param strURL
	 * @return
	 */
	public static String getUrlContent(String strURL){
		URL myURL;
		InputStream is;
		BufferedReader br;
		String data;
		StringBuilder sb = new StringBuilder();

		try
		{
			myURL = new URL(strURL); //URL을 표시하는 스트링으로 URL클래스 객체생성
			is= myURL.openStream(); //생성된 URL클래스로 URL이 지시하는 서버와 접속을한 후
	//		해당 입력 스트림을 넘겨준다.
			br=new BufferedReader(new InputStreamReader(is));
	//		입력 스트림을 이용하여 클래스 객체생성
			while((data = br.readLine() ) !=null)
			{ //입력 스트림에서 데이터가 완료될 때까지 데이터를 한줄씩 읽어서 
				sb.append(data);
			}
		}catch(MalformedURLException e){
			System.out.println(e);
		}catch(IOException e){
			System.out.println(e);
		}catch(Exception e){
			System.out.println(e);
		}
		
		return sb.toString();
	}
	
	/**
	 * 숫자 리스트 형식 반환 HashMap<key, value>
	 * @param name
	 * @param intStart
	 * @param intEnd
	 * @param intSelected
	 * @return
	 */
	public static List<HashMap<String, String>> getListCount(int intStart,int intEnd, int intSelected){
		List<HashMap<String, String>> retList = new ArrayList<HashMap<String, String>>();
		String pr_i = "";
		
		try{
			for(int i = intStart; i <= intEnd; i++ ){
				String selected = "";
				//10보다 작을때는 0추가.
				pr_i = (i<10)?"0"+i:""+i;
				HashMap<String, String> hm = new HashMap<String, String>();
				hm.put("key", pr_i);
				hm.put("value", pr_i);
				if(intSelected == i)selected = "selected";
				hm.put("selected", "selected");
				retList.add(hm);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return retList;
	}

	/**
	 * 태그 없애기.
	 * @param s
	 * @return
	 */
	public static String removeTag(String s){
        if(s == null)
            return "";
        int state = 0;
        int oldState = 0;
        char chars[] = s.toCharArray();
        StringBuffer sb = new StringBuffer();
        for(int i = 0; i < chars.length; i++)
        {
            char a = chars[i];
            switch(state)
            {
            default:
                break;

            case 0: // '\0'
                if(a == '<')
                    state = 1;
                else
                    sb.append(a);
                break;

            case 1: // '\001'
                if(a == '>')
                {
                    state = 0;
                    break;
                }
                if(a == '"')
                {
                    oldState = state;
                    state = 5;
                    break;
                }
                if(a == '\'')
                {
                    oldState = state;
                    state = 4;
                    break;
                }
                if(a == '/')
                {
                    state = 3;
                    break;
                }
                if(a != ' ' && a != '\t' && a != '\n' && a != '\r' && a != '\f')
                    state = 2;
                break;

            case 2: // '\002'
            case 3: // '\003'
                if(a == '>')
                {
                    state = 0;
                    break;
                }
                if(a == '"')
                {
                    oldState = state;
                    state = 5;
                    break;
                }
                if(a == '\'')
                {
                    oldState = state;
                    state = 4;
                    break;
                }
                if(a == '"')
                {
                    state = 5;
                    break;
                }
                if(a == '\'')
                    state = 4;
                break;

            case 5: // '\005'
                if(a == '"')
                    state = oldState;
                break;

            case 4: // '\004'
                if(a == '\'')
                    state = oldState;
                break;
            }
        }

        String result = sb.toString();
        result = result.replaceAll("&quot;", "\"");
        result = result.replaceAll("&lt;", "<");
        result = result.replaceAll("&gt;", ">");
        result = result.replaceAll("&middot;", "\267");
        result = result.replaceAll("&lsquo;", "\u2018");
        result = result.replaceAll("&rsquo;", "\u2019");
        result = result.replaceAll("\n", "");
        return result;
    }
	
/*==================================================
 * 스크립트 관련.
 ==================================================*/
	/**
	 * 자바 스크립트 -경고창 또는 바로 뒤로 가기.
	 * @param str Alert 메세지 
	 * @param back 돌아갈 단계
	 * @return
	 */
	public static String getScriptBack(String str, String back){
		StringBuilder sb = new StringBuilder();
		
		sb.append("<script language=\"javascript\">\");");
		if(!str.equals("")){
			sb.append("alert(\"");
			sb.append(str);
			sb.append("\");");
		}
		sb.append("history.back(");
		if(!back.equals(""))sb.append(back);
		sb.append(");");
		sb.append("</script>");
		return sb.toString();
	}
	/**
	 * 자바 스크립트 -경고창 또는 바로 정해진 URL가기.
	 * @param str Alert 메세지 
	 * @param location redirect시킬 URL
	 * @return
	 */
	public static String getScriptLocation(String str, String location){
		StringBuilder sb = new StringBuilder();
		
		sb.append("<script language=\"javascript\">\");");
		if(!str.equals("")){
			sb.append("alert(\"");
			sb.append(str);
			sb.append("\");");
		}
		sb.append("location.href=\"");
		sb.append(location);
		sb.append("\";");
		sb.append("</script>");
		return sb.toString();
	}
	/**
	 * 웹 루트 절대경로가져오기.
	 * @param request
	 * @return
	 */
	public static String getWebRootAbsolutePath(HttpServletRequest request){
		return request.getSession().getServletContext().getRealPath("/");
	}
}
