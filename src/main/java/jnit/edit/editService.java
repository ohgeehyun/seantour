package jnit.edit;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

public interface editService {
	/**
	 * SmartEditor Basic 2.0 Html5 업로드 지원식 파일업로드 
	 * @param request
	 * @param filename - 파일 이름
	 * @param filesize - 파일 사이즈
	 * @param count - 보내는 갯수
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject makeEditFileHTML5(HttpServletRequest request, String filename, String filesize, String count)throws Exception;
	
	/**
	 * SmartEditor Basic 2.0 일반 업로드 지원식 파일업로드
	 * @param request
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject makeEditFile(HttpServletRequest request)throws Exception;
}
