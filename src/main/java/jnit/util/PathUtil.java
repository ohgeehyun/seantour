package jnit.util;

import java.io.File;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;

public class PathUtil {

	final static String SEPARATOR = Matcher.quoteReplacement(File.separator);
	
	public static String getRealPath(HttpServletRequest request){
		
		String str = "";
		String regex1 = "\\/{2,}";		//연속으로 붙어있는 중복된 구분자를 제거(Linux 계열 SEPARATOR)
		String regex2 = "\\\\{2,}";		//연속으로 붙어있는 중복된 구분자를 제거(Windows 계열 SEPARATOR)
		String regex3 = "\\/{1,}";		//운영체제에 맞는 SEPARATOR로 대체(Linux 계열 SEPARATOR)
		String regex4 = "\\\\{1,}";		//운영체제에 맞는 SEPARATOR로 대체(Windows 계열 SEPARATOR)
		
		try{
			str = request.getSession().getServletContext().getRealPath("/");
			
			if(str.equals("") || str == null){
				//필요시 구현
				System.err.println("PathUtil.getRealPath request value null");
			}else{
				if(str.substring(str.length()-1).equals("/")){
					//필요시 구현
				}else{
					str += SEPARATOR;
				}
			}
		}catch(NullPointerException e){
			str = "";
			System.err.println("PathUtil.getRealPath Method NullPointerException");
		}
		str = str.replaceAll(regex1, SEPARATOR);
		str = str.replaceAll(regex2, SEPARATOR);
		str = str.replaceAll(regex3, SEPARATOR);
		str = str.replaceAll(regex4, SEPARATOR);
		return str;
	}
	
	public static String getRealPath(String str){

		String regex1 = "\\/{2,}";		//연속으로 붙어있는 중복된 구분자를 제거(Linux 계열 SEPARATOR)
		String regex2 = "\\\\{2,}";		//연속으로 붙어있는 중복된 구분자를 제거(Windows 계열 SEPARATOR)
		String regex3 = "\\/{1,}";		//운영체제에 맞는 SEPARATOR로 대체(Linux 계열 SEPARATOR)
		String regex4 = "\\\\{1,}";		//운영체제에 맞는 SEPARATOR로 대체(Windows 계열 SEPARATOR)
		
		if(str.equals("") || str == null){
			//필요시 구현
			System.err.println("PathUtil.getRealPath parameter value null");
		}else{
			if(str.substring(str.length()-1).equals("/")){
				//필요시 구현
			}else{
				str += SEPARATOR;
			}
		}
		str = str.replaceAll(regex1, SEPARATOR);
		str = str.replaceAll(regex2, SEPARATOR);
		str = str.replaceAll(regex3, SEPARATOR);
		str = str.replaceAll(regex4, SEPARATOR);
		return str;
	}
	
}