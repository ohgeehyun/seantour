/**
 * @version 3.2.0.1
 */
package egovframework.com.cmm.service;

/**
 *  Class Name : Globals.java
 *  Description : 시스템 구동 시 프로퍼티를 통해 사용될 전역변수를 정의한다.
 *  Modification Information
 *
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.01.19    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 01. 19
 *  @version 1.0
 *  @see
 *
 */

public class Globals {
	//OS 유형
    public static final String OS_TYPE = EgovProperties.getProperty("Globals.OsType");
    //DB 유형
    public static final String DB_TYPE = EgovProperties.getProperty("Globals.DbType");
    //메인 페이지
    public static final String MAIN_PAGE = EgovProperties.getProperty("Globals.MainPage");
    //ShellFile 경로
    public static final String SHELL_FILE_PATH = EgovProperties.getPathProperty("Globals.ShellFilePath");
    //퍼로퍼티 파일 위치
    public static final String CONF_PATH = EgovProperties.getPathProperty("Globals.ConfPath");
    //Server정보 프로퍼티 위치
    public static final String SERVER_CONF_PATH = EgovProperties.getPathProperty("Globals.ServerConfPath");
    //Client정보 프로퍼티 위치
    public static final String CLIENT_CONF_PATH = EgovProperties.getPathProperty("Globals.ClientConfPath");
    //파일포맷 정보 프로퍼티 위치
    public static final String FILE_FORMAT_PATH = EgovProperties.getPathProperty("Globals.FileFormatPath");

    //파일 업로드 원 파일명
	public static final String ORIGIN_FILE_NM = "originalFileName";
	//파일 확장자
	public static final String FILE_EXT = "fileExtension";
	//파일크기
	public static final String FILE_SIZE = "fileSize";
	//업로드된 파일명
	public static final String UPLOAD_FILE_NM = "uploadFileName";
	//파일경로
	public static final String FILE_PATH = "filePath";

	//메일발송요청 XML파일경로
	public static final String MAIL_REQUEST_PATH = EgovProperties.getPathProperty("Globals.MailRequestPath");
	//메일발송응답 XML파일경로
	public static final String MAIL_RESPONSE_PATH = EgovProperties.getPathProperty("Globals.MailRResponsePath");

	// G4C 연결용 IP (localhost)
	public static final String LOCAL_IP = EgovProperties.getProperty("Globals.LocalIp");

    //기타 업로드 경로
    public static final String ETC_UPLOAD_PATH = EgovProperties.getProperty("Globals.EtcUploadPath");
    
    public static final String EXT_FILE_THUMBIMG = EgovProperties.getProperty("Globals.FILE.EXT.THUMBIMG");
    public static final String MEMBER_LOGIN_URL = EgovProperties.getProperty("Globals.MEMBER.LOGIN_URL");
    public static final String MEMBER_LOGOUT_URL = EgovProperties.getProperty("Globals.MEMBER.LOGOUT_URL");
    
    //CRON 관련
    public static final String CRON_EXCUTE_SERVER_IP = EgovProperties.getProperty("Globals.CRON.EXCUTE_SERVER_IP");
    public static final String CRON_ALIMI_URL = EgovProperties.getProperty("Globals.CRON.ALIMI_URL");
    public static final String CRON_DISSEMINATE_URL = EgovProperties.getProperty("Globals.CRON.DISSEMINATE_URL");

    //파일고 관련
    public static final String FILEGO_ACTIVE = EgovProperties.getProperty("Globals.FILEGO.ACTIVE");
    public static final String FILEGO_URL = EgovProperties.getProperty("Globals.FILEGO.URL");

    //로그인 관련
    public static final String CRON_LOGIN_UNCLOCK_ACTIVE = EgovProperties.getProperty("Globals.CRON.LOGIN.UNCLOCK.ACTIVE");		//로그인 틀린횟수 CRON 사용여부
    public static final String CRON_LOGIN_UNCLOCK_TIMER = EgovProperties.getProperty("Globals.CRON.LOGIN.UNCLOCK.TIMER");		//로그인 틀린횟수 CRON 규칙
    public static final String LOGIN_UNCLOCK_TIME = EgovProperties.getProperty("Globals.LOGIN.UNCLOCK.TIME");					//로그인 틀린횟수 초기화 시간
    public static final String LOGIN_PW_MISS_MAX_COUNT = EgovProperties.getProperty("Globals.LOGIN.PW.MISS.MAX.COUNT");			//로그인 틀린횟수 최대치
    
}
