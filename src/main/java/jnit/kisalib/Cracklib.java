/**
 * @version 3.2.0.1
 */
package jnit.kisalib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Cracklib {

	public static Log log = LogFactory.getLog(Cracklib.class);
	
	private String LEVEL_SCORE;
	private String RANGE_SCORE;
	private String ADD_CHAR;
	private String EXCEPT_CHAR;
	private int	 MIN_LEN;
	private int	 MIN_DIFF;
	private int	 MIN_STEP;
	
	// 원시 메소드 선언 (Native method declaration) - 함수앞에 native 키워드 명시
	public native int Check_Func_DICT(String strPasswd, String strDictPath);
	public native int Check_Func_DB(String strPasswd, int dictFind, int RdictFind);
	
	public native void SetLevelScore(int nLevel, int nScore);	
	public native void SetAddChar(String czChar);			
	public native void SetExceptChar(String czChar);		
	public native void SetLevelRange(int nScoreRange, int nStart, int nEnd);	

	public native void SetPwdMinLen(int nLen);
	public native void SetPwdMInDiff(int nDiff);
	public native void SetPwdMinStep(int nStep);
	
	public native String DBForwardCheck(String strPasswd, int nStart);
	public native String DBBackwardCheck(String strPasswd, int nStart);
	
	private static final String jdbcClass = "oracle.jdbc.driver.OracleDriver";
	private static final String jdbcUrl = "jdbc:oracle:thin:@192.168.0.27:1521:dmsdb2";
	private static final String jdbcId = "nygpa2013";
	private static final String jdbcPw = "passionysbgha11$";
	
	public native void SetDBConfig(String LevelScore, String RangeScore, String AddChar, String ExceptChar, int MinLen, int MinDiff, int MinStep);
	
	// 호출할 라이브러리 위치
	private static String DllPath = "/usr/local/lib/libCracklib.so";
	// 사전파일이 존재하는 디렉토리 경로
	private static String DicPath = "";	
	
	static
	{
		// Load library - 호출할 dll 파일명 명시
		try{
			System.load(DllPath);
		}catch(UnsatisfiedLinkError e){
			log.debug(e.getMessage());
		}
		
	}

/*
함수명 : PassCheck_DICT
변수    : 체크할 패스워드 스트링 입력
기능    : 사전파일에서 패스워드 검색하여 존재여부 검사
*/	
	public int PassCheck_DICT(String CheckString)
	{
		Cracklib lib = new Cracklib();
		
		// Check_Func_DICT 호출하며, 입력받은 스트링과, 사전파일명을 변수로 넣어준다
		return lib.Check_Func_DICT(CheckString, DicPath +"dicts/cracklib_dict");		
	}

/*
함수명 : PassCheck_DB
변수    : 체크할 패스워드, DB에서 찾은 결과값 (순행, 역행)
기능    : 사전파일에서 패스워드 검색하여 존재여부 검사
*/	
	public int PassCheck_DB(String CheckString, int dictFind, int RdictFind)
	{
		Cracklib lib = new Cracklib();
		
		// Check_Func_DB 호출하며, 입력받은 스트링과, 사전DB에서 검색 결과값을 넣어준다
		return lib.Check_Func_DB(CheckString, dictFind, RdictFind);
	}
	
/*
함수명 : DBForwardSearch
변수    : DB연결 커넥션과 체크할 패스워드
기능    : 사전DB에서 패스워드 검색하여 존재여부 검사
*/		
	public int DBForwardSearch(Connection conn, String password) throws Exception
	{
		Cracklib lib = new Cracklib();	
		
		int nPos = 0;
		int nFind = 0;
		String result = lib.DBForwardCheck(password, nPos);
		while (result.length() > 0) {			
			int nSplit = result.indexOf("|");
			String strPos = result.substring(0, nSplit);			
			String strContent = result.substring(nSplit+1,  result.length());
			
			nPos = Integer.parseInt(strPos);
								
			if (nPos == -1)		// 마지막 조건까지 사전에서 발견되지 않음
				break;
				
			nFind = doSearch(conn, strContent);
			
			if (nFind == 1)		// 사전에서 발견됨
				break;
				
			nPos++;
			result = lib.DBForwardCheck(password, nPos);				
		}
		
		return nFind;		
	}	
	
	public int DBBackwardSearch(Connection conn, String password) throws Exception
	{
		Cracklib lib = new Cracklib();	
		
		int nPos = 0;
		String result = lib.DBBackwardCheck(password, nPos);
		
		int nFind = 0;
		
		while (result.length() > 0) {
			int nSplit = result.indexOf("|");
			String strPos = result.substring(0, nSplit);			
			String strContent = result.substring(nSplit+1,  result.length());
				
			nPos = Integer.parseInt(strPos);
								
			if (nPos == -1)		// 마지막 조건까지 사전에서 발견되지 않음
				break;
				
			nFind = doSearch(conn, strContent);
			
			if (nFind == 1)		// 사전에서 발견됨
				break;
				
			nPos++;	
			result = lib.DBBackwardCheck(password, nPos);				
		}
		
		return nFind;		
	}		
	
/*********************************************************************
###################   DBCP INTERFACE   #######################
**********************************************************************/
/*
기능 : 소스상에 설정된 Resource Ref 를 이용하여 Connection 을 리턴
*/
	public static Connection getConnection() throws Exception 
	{
	   /*
		Connection conn = null;
    
    	// JNIDI에서 등록된 객체(kisaoracle)를 이름으로 가져옴
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/kisaoracle");
   
		conn = ds.getConnection();		
	   	return conn;
	   	*/
        Connection DBcon = null;
    	try
    	{
			Class.forName(jdbcClass);
			DBcon = DriverManager.getConnection(jdbcUrl  , jdbcId , jdbcPw);
    	} catch (SQLException e){
			log.error(e.getMessage());
		}
    	catch(Exception e){
			log.debug(e.getMessage());
			log.error(e.getMessage());
    	}
    	return DBcon;

	}

/*
기능 : 커넥션 객체와 패스워드를 넘겨받아 사전 DB에 존재여부 리턴
*/
	public static int doSearch (Connection conn, String password)
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int nCount = 0;
		String query = "select count(*) from PASSWORD_DICT where REG_WORD = ? ";
		
		try
		{			
			pstmt = conn.prepareStatement(query);
			pstmt.clearParameters(); 
			pstmt.setString(1, password);
			
			rs = pstmt.executeQuery();

		    if(rs.next()){              
				nCount = rs.getInt(1);
		    }
		} catch (SQLException e){
			nCount = -1;	// 사전DB에서 발견 실패
		}catch (Exception ex)	{
			nCount = -1;	// 사전DB에서 발견 실패
		} finally {
			try { if (rs != null) rs.close();
			} catch (SQLException e){
				log.error(e.getMessage());
			} catch (Exception e) {log.error(e.getMessage());}
			try { if (pstmt != null) pstmt.close();
			} catch (SQLException e){
				log.error(e.getMessage());
			} catch (Exception e) {log.error(e.getMessage());}
		}
		return nCount;
	}

/*
	기능 : 사용이 끝난 커넥션을 닫고 DB풀로 반환함
*/
	public static void close(Connection conn) 
	{ 
		try { if (conn != null) conn.close();
		} catch (SQLException e){
			log.error(e.getMessage());
		} catch (Exception e) {log.error(e.getMessage());} 
	} 	

/*********************************************************************
############   PASSWORD_CONFIG 연동   #######################
**********************************************************************/
	public String getLevelScore()
	{
		return LEVEL_SCORE;
	}
	
	public String getRangeScore()
	{
		return RANGE_SCORE;
	}
	
	public String getAddChar()
	{
		if (ADD_CHAR == null)
			ADD_CHAR = "";
			
		return ADD_CHAR;
	}
	
	public String getExceptChar()
	{
		if (EXCEPT_CHAR == null)
			EXCEPT_CHAR = "";

		return EXCEPT_CHAR;
	}
	
	public int getMinLen()
	{
		return MIN_LEN;
	}
	
	public int getMinDiff()
	{
		return MIN_DIFF;
	}
	
	public int getMinStep()
	{
		return MIN_STEP;
	}
	
	public int doUpdateCheck(Connection conn)
	{
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;

		int nCount = 0;
		String query = "SELECT * FROM PASSWORD_CONFIG WHERE CONFIG_UPDATE = 'Y'";

		try
		{			
			conn.setAutoCommit(false);	// 트랜젝션 설정
			pstmt1 = conn.prepareStatement(query);
			rs = pstmt1.executeQuery();

		    if(rs.next()) {              
				nCount = 1;
	
				LEVEL_SCORE = rs.getString("LEVEL_SCORE");
				RANGE_SCORE = rs.getString("RANGE_SCORE");
				ADD_CHAR = rs.getString("ADD_CHAR");
				EXCEPT_CHAR  = rs.getString("EXCEPT_CHAR");
				
				MIN_LEN = rs.getInt("MIN_LEN");
				MIN_DIFF = rs.getInt("MIN_DIFF");
				MIN_STEP = rs.getInt("MIN_STEP");				
		    }
		    
		    if (nCount == 1) {		    	
		    	query = "UPDATE PASSWORD_CONFIG SET CONFIG_UPDATE = 'N'";
		    	pstmt2 = conn.prepareStatement(query);
		    	pstmt2.executeUpdate();		    			    			    	
		    }

		    conn.commit();
		} catch (SQLException e){
			log.error(e.getMessage());
		}catch (Exception ex)	{
			log.error(ex.getMessage());
			nCount = 0;
		} finally {
			try { if (rs != null) rs.close(); 
			} catch (SQLException e){
				log.error(e.getMessage());
			} catch (Exception e) {log.error(e.getMessage());}
			try { if (pstmt1 != null) pstmt1.close(); 
			} catch (SQLException e){
				log.error(e.getMessage());
			} catch (Exception e) {log.error(e.getMessage());}
			try { if (pstmt2 != null) pstmt2.close(); 
			} catch (SQLException e){
				log.error(e.getMessage());
			} catch (Exception e) {log.error(e.getMessage());}
		}
		
		// return 값이 1일 경우만 업데이트
		return nCount;
	}
}