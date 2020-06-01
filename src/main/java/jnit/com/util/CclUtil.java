/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;

public class CclUtil {

	private static String cclValue = "";
	private static String cclPath = EgovProperties.getProperty("Globals.ccl.path");
	private static String one = "by88x31.png";
	private static String two = "by-nd88x31.png";
	private static String three = "by-sa88x31.png";
	private static String four = "by-nc88x31.png";
	private static String five = "by-nc-nd88x31.png";
	private static String six = "by-nc-sa88x31.png";
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	/**
     * 일반 아이콘의 원본소스(TEXT포함)
     * @param key - menu ccl값
     * @return key에 맞는 일반 아이콘의 원본소스
     */
    public static String getGeneralOrigin(String key){
    	
    	cclValue = "";
    	if(!NullUtil.nullString(key).equals("")){
	        if(key.equals("111")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='"+cclPath+one+"'/></a>&nbsp;<strong>저작자표시-영리</strong><br />원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 가능,상업적으로 이용가능";
	        }else if(key.equals("101")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nd/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='"+cclPath+two+"' /></a>&nbsp;<strong>저작권표시-영리-변경금지</strong><br />원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 불가,상업적으로 이용가능";
	        }else if(key.equals("121")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-sa/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='"+cclPath+three+"' /></a>&nbsp;<strong>저작권표시-영리-동일조건변경허락</strong><br />원저작자를 밝히는 한 해당 저작물을 공유 허용, 동일한 저작권표시조건에 한하여 정보변경 가능,상업적으로 이용가능";
	        }else if(key.equals("110")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nc/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='"+cclPath+four+"' /></a>&nbsp;<strong>저작권표시-비영리</strong><br />원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 가능,상업적으로 이용불가";
	        }else if(key.equals("100")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nc-nd/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='"+cclPath+five+"' /></a>&nbsp;<strong>저작자표시-비영리-변경금지</strong><br />원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 불가, 상업적으로 이용불가";
	        }else if(key.equals("120")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='"+cclPath+six+"' /></a>&nbsp;<strong>저작권표시-비영리-동일조건변경허락</strong><br />원저작자를 밝히는 한 해당 저작물을 공유 허용, 동일한 저작권표시조건에 한하여 정보변경 가능,상업적으로 이용불가능";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	if("true".equals(deDug)) System.out.println("key에 잘못된 값이 들어왔습니다. -> " + key);
	        	cclValue = "";
	        }
    	}else{
    		if("true".equals(deDug)) System.out.println("key에 잘못된 값이 들어왔습니다. -> " + key);
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * 일반 아이콘 이미지( CCL KOREA 관련한 저작권때문에 저작권 설명글과 함께 사용 )
     * @param key - menuCcl값
     * @return key에 맞는 단축 일반 아이콘 이미지
     */
    public static String getGeneralImg(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
    			cclValue = cclPath+one;
	        }else if(key.equals("101")){
	        	cclValue = cclPath+two;
	        }else if(key.equals("121")){
	        	cclValue = cclPath+three;
	        }else if(key.equals("110")){
	        	cclValue = cclPath+four;
	        }else if(key.equals("100")){
	        	cclValue = cclPath+five;
	        }else if(key.equals("120")){
	        	cclValue = cclPath+six;
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else{
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * 단축아이콘 원본소스(TEXT포함)
     * @param key - menuCcl값
     * @return key에 맞는 단축 아이콘 원본 소스
     */
    public static String getShortOrigin(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='http://i.creativecommons.org/l/by/3.0/80x15.png' /></a>&nbsp;<strong>저작자표시</strong>";
	        }else if(key.equals("101")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nd/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='http://i.creativecommons.org/l/by-nd/3.0/80x15.png' /></a>&nbsp;<strong>저작자표시-변경금지</strong>";
	        }else if(key.equals("121")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-sa/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='http://i.creativecommons.org/l/by-sa/3.0/80x15.png' /></a>&nbsp;<strong>저작자표시-동일조건변경허락</strong>";
	        }else if(key.equals("110")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nc/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='http://i.creativecommons.org/l/by-nc/3.0/80x15.png' /></a>&nbsp;<strong>저작자표시-비영리</strong>";
	        }else if(key.equals("100")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nc-nd/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='http://i.creativecommons.org/l/by-nc-nd/3.0/80x15.png' /></a>&nbsp;<strong>저작자표시-비영리-변경금지</strong>";
	        }else if(key.equals("120")){
	        	cclValue = "<a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/3.0/deed.ko' title='새창' target='_blank'><img alt='크리에이티브 커먼즈 라이선스' style='border-width:0' src='http://i.creativecommons.org/l/by-nc-sa/3.0/80x15.png' /></a>&nbsp;<strong>저작자표시-비영리-동일조건변경허락</strong>";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else{
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * 단축아이콘 이미지 ( CCL KOREA 관련한 저작권때문에 저작권 설명글과 함께 사용 )
     * @param key - menuCcl값
     * @return key에 맞는 CCL 단축 아이콘 이미지
     */
    public static String getShortImg(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
	        	cclValue = "http://i.creativecommons.org/l/by/3.0/80x15.png";
	        }else if(key.equals("101")){
	        	cclValue = "http://i.creativecommons.org/l/by-nd/3.0/80x15.png";
	        }else if(key.equals("121")){
	        	cclValue = "http://i.creativecommons.org/l/by-sa/3.0/80x15.png";
	        }else if(key.equals("110")){
	        	cclValue = "http://i.creativecommons.org/l/by-nc/3.0/80x15.png";
	        }else if(key.equals("100")){
	        	cclValue = "http://i.creativecommons.org/l/by-nc-nd/3.0/80x15.png";
	        }else if(key.equals("120")){
	        	cclValue = "http://i.creativecommons.org/l/by-nc-sa/3.0/80x15.png";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else{
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * 저작권 정보 URL
     * @param key - key - menuCcl값
     * @return key에 맞는 ccl정보를 보여주는 url
     */
    public static String getLink(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
	        	cclValue = "http://creativecommons.org/licenses/by/3.0/deed.ko";
	        }else if(key.equals("101")){
	        	cclValue = "http://creativecommons.org/licenses/by-nd/3.0/deed.ko";
	        }else if(key.equals("121")){
	        	cclValue = "http://creativecommons.org/licenses/by-sa/3.0/deed.ko";
	        }else if(key.equals("110")){
	        	cclValue = "http://creativecommons.org/licenses/by-nc/3.0/deed.ko";
	        }else if(key.equals("100")){
	        	cclValue = "http://creativecommons.org/licenses/by-nc-nd/3.0/deed.ko";
	        }else if(key.equals("120")){
	        	cclValue = "http://creativecommons.org/licenses/by-nc-sa/3.0/deed.ko";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else {
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * 저작권 설명 TEXT
     * @param key - menuCcl값
     * @return key에 맞는 ccl 관련 설명글
     */
    public static String getText(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
	        	cclValue = "원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 가능,상업적으로 이용가능";
	        }else if(key.equals("101")){
	        	cclValue = "원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 불가,상업적으로 이용가능";
	        }else if(key.equals("121")){
	        	cclValue = "원저작자를 밝히는 한 해당 저작물을 공유 허용, 동일한 저작권표시조건에 한하여 정보변경 가능,상업적으로 이용가능";
	        }else if(key.equals("110")){
	        	cclValue = "원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 가능,상업적으로 이용불가";
	        }else if(key.equals("100")){
	        	cclValue = "원저작자를 밝히는 한 해당 저작물을 공유 허용, 정보변경 불가, 상업적으로 이용불가";
	        }else if(key.equals("120")){
	        	cclValue = "원저작자를 밝히는 한 해당 저작물을 공유 허용, 동일한 저작권표시조건에 한하여 정보변경 가능,상업적으로 이용불가능";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else{
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * 저작권 키워드 TEXT
     * @param key - menuCcl값
     * @return key에 맞는 ccl 관련 설명글
     */
    public static String getKeyword(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
	        	cclValue = "저작자표시-영리";
	        }else if(key.equals("101")){
	        	cclValue = "저작권표시-영리-변경금지";
	        }else if(key.equals("121")){
	        	cclValue = "저작권표시-영리-동일조건변경허락";
	        }else if(key.equals("110")){
	        	cclValue = "저작권표시-비영리";
	        }else if(key.equals("100")){
	        	cclValue = "저작자표시-비영리-변경금지";
	        }else if(key.equals("120")){
	        	cclValue = "저작권표시-비영리-동일조건변경허락";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else{
    		cclValue = "";
    	}
    	return cclValue;
    }
    
    /**
     * CCL 이미지 ALT
     * 
     * @return ccl 이미지 alt값 
     */
    public static String getAlt(String key){
    	if(!NullUtil.nullString(key).equals("")){
    		if(key.equals("111")){
    			cclValue = "크리에이티브 커먼즈 라이선스";
	        }else if(key.equals("101")){
	        	cclValue = "크리에이티브 커먼즈 라이선스";
	        }else if(key.equals("121")){
	        	cclValue = "크리에이티브 커먼즈 라이선스";
	        }else if(key.equals("110")){
	        	cclValue = "크리에이티브 커먼즈 라이선스";
	        }else if(key.equals("100")){
	        	cclValue = "크리에이티브 커먼즈 라이선스";
	        }else if(key.equals("120")){
	        	cclValue = "크리에이티브 커먼즈 라이선스";
	        }else if(key.equals("0")){
	        	cclValue = "";
	        }else{
	        	cclValue = "";
	        }
    	}else{
    		cclValue = "";
    	}
    	return cclValue;
    }
	
}
