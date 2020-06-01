/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.util.Hashtable;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import egovframework.com.utl.fcc.service.NullUtil;

public class LoginManager implements HttpSessionBindingListener {

	private static LoginManager loginManager = null;
	private static Hashtable<String, String> loginUsers = new Hashtable<String, String>();
	
	private LoginManager(){
		      super();
	}
	
	public synchronized LoginManager getInstance(){
		if(loginManager == null){
			loginManager = new LoginManager();
		}
		return loginManager;
	}

	//중복 로그인이 되어있는지 확인
	public static boolean duplicationLoginCheck(String mbrLogin, String createSessinTime){
		
		boolean isDuplication = false;
		String key = NullUtil.nullString(mbrLogin);
		String staticSessionTime = NullUtil.nullString(getSession(key));
		String clientSessionTime = NullUtil.nullString(createSessinTime);
		isDuplication = (staticSessionTime.equals(clientSessionTime) || staticSessionTime.equals(""));
		
		return isDuplication;
	}
	
	//로그인 세션 생성
	public static void setSession(String mbrLogin, String createSessinTime){
	    loginUsers.put(mbrLogin, createSessinTime);
	}
	
	//세션 ID로 로긴된 ID 구분
	public static String getSession(String mbrLogin){
	    return loginUsers.get(mbrLogin);
	}

	//현재 접속자수
	public static int getUserCount(){
	    return loginUsers.size();
	}
	
	
	public void valueBound(HttpSessionBindingEvent event){
		//필요시 구현
	}
	
	//세션 끊길때
	public void valueUnbound(HttpSessionBindingEvent event){
	    //필요시 구현
	}
	
	//로그아웃 및 세션 끊길때
	public static void logout(String mbrLogin){
		loginUsers.remove(mbrLogin);
	}
}