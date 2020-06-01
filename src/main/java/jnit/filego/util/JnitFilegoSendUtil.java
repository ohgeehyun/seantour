package jnit.filego.util;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.response.vo.JnitFilegoResponseVO;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import com.sun.star.io.ConnectException;

import egovframework.com.cmm.service.Globals;


public class JnitFilegoSendUtil {

	private static Log log = LogFactory.getLog(JnitFilegoSendUtil.class);
	
	private final static String MEDIA_TYPE = "application";
	private final static String MEDIA_SUB_TYPE = "json";
	private final static String MEDIA_CHARSET = "UTF-8";
	
	/**
	 * 파일 배포 요청
	 * @throws Exception 
	 * @type
	 * @fileName
	 */
	public static void sendFile(JnitFilegoFileType type, String fileName){
		String active = Globals.FILEGO_ACTIVE;
		if(!active.toLowerCase().equals("on")) return;			//배포모듈 사용여부중 on이 아니면 전송하지 않고 return
		if(!type.getIsSend()) return;							//배포 허용유형이 아니면 전송하지 않고 return
		
		try{
			RestTemplate restTemplate = initRestTemplate(MEDIA_TYPE, MEDIA_SUB_TYPE, MEDIA_CHARSET);
			String url = Globals.FILEGO_URL;
			
			//setProxy(restTemplate);							//개발단계 확인
			
			JSONObject reqData = new JSONObject();			//요청 데이터
			reqData.put("type", type.getFileType());
			reqData.put("fileName", fileName);
			
			/*JnitFilegoResponseVO filegoResponseVO = restTemplate.postForObject(url, reqData, JnitFilegoResponseVO.class); */
			restTemplate.postForObject(url, reqData, JnitFilegoResponseVO.class);
		}catch(ConnectException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}
	}
	
	/**
	 * resttemplate 설정
	 * @param restTemplate
	 * @return
	 * @throws Exception
	 */
	private static RestTemplate initRestTemplate(String mediaType, String mediaSubType, String mediaCharset) throws Exception{
		/* TODO : 실행시 오류 발생으로 인한 주석처리
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		factory.setConnectTimeout(1000);		//연결시간초과 1초
		factory.setReadTimeout(1000);			//읽기시간초과 1초
		*/
		RestTemplate restTemplate = new RestTemplate(/*factory*/);
    	List<MediaType> supportedMediaTypes = new ArrayList<MediaType>();
    	supportedMediaTypes.add(new MediaType(mediaType, mediaSubType, Charset.forName(mediaCharset)));
    	
    	List<HttpMessageConverter<?>> list = new ArrayList<HttpMessageConverter<?>>();
    	list.add(new MappingJackson2HttpMessageConverter());		//json-type
    	restTemplate.setMessageConverters(list);
    	return restTemplate;
	}
	
	/**
	 * 프록시 설정
	 * @rt
	 */
	/*
	@SuppressWarnings("unused")
	private static void setProxy(RestTemplate rt){
         SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();
          Proxy proxy = new Proxy(Type.HTTP, new InetSocketAddress("localhost", NullUtil.nullInt("8888")));
          requestFactory.setProxy(proxy);
          rt.setRequestFactory(requestFactory);
   }
   */
}
