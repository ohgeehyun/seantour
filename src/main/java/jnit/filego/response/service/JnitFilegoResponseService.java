package jnit.filego.response.service;


public interface JnitFilegoResponseService {

	/**
	 * 파일 배포 요청
	 * @type
	 * @fileName
	 */
	void sendFile(String type, String fileName) throws Exception;
	
}
