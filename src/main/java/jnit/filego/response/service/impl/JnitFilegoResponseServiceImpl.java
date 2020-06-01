package jnit.filego.response.service.impl;

import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.Proxy.Type;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import jnit.filego.response.vo.JnitFilegoResponseVO;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.NullUtil;

@Service("JnitFilegoResponseService")
public class JnitFilegoResponseServiceImpl {

	private Log log = LogFactory.getLog(getClass());
	
	private final static String MEDIA_TYPE = "application";
	private final static String MEDIA_SUB_TYPE = "json";
	private final static String MEDIA_CHARSET = "UTF-8";
	
	/**
	 * 파일 배포 요청
	 * @throws Exception 
	 * @type
	 * @fileName
	 */
	public void sendFile(String type, String fileName) throws Exception{
		RestTemplate restTemplate = this.initRestTemplate(MEDIA_TYPE, MEDIA_SUB_TYPE, MEDIA_CHARSET);
		String url = Globals.FILEGO_URL;
		//String url = "http://172.30.1.11:18001/api/sendFile";
		
		setProxy(restTemplate);							//개발단계 확인
		
		JSONObject reqData = new JSONObject();			//요청 데이터
		reqData.put("type", type);
		reqData.put("fileName", fileName);
		
		JnitFilegoResponseVO filegoResponseVO = restTemplate.postForObject(url, reqData, JnitFilegoResponseVO.class);
		log.debug("=======filegoResponseVO : " + filegoResponseVO.getCode());
		log.debug("=======filegoResponseVO : " + filegoResponseVO.getMsg());
	}
	
	/**
	 * resttemplate 설정
	 * @param restTemplate
	 * @return
	 * @throws Exception
	 */
	private RestTemplate initRestTemplate(String mediaType, String mediaSubType, String mediaCharset) throws Exception{
		RestTemplate restTemplate = new RestTemplate();
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
	private void setProxy(RestTemplate rt){
         SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();
          Proxy proxy = new Proxy(Type.HTTP, new InetSocketAddress("localhost", NullUtil.nullInt("8888")));
          requestFactory.setProxy(proxy);
          rt.setRequestFactory(requestFactory);   
   }
	
	/**
	 * 개발 테스트
	 */
	public static void main(String[] args) throws Exception{
		JnitFilegoResponseServiceImpl filegoResponseServiceImpl = new JnitFilegoResponseServiceImpl();
		
		filegoResponseServiceImpl.initRestTemplate(MEDIA_TYPE, MEDIA_SUB_TYPE, MEDIA_CHARSET);
		filegoResponseServiceImpl.sendFile("testType", "testFile.txt");
	}
	
}
