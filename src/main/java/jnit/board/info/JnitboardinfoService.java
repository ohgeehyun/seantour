/**
 * @version 3.2.0.1
 */
package jnit.board.info;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

/**
 * @Class Name : JnitboardinfoService.java
 * @Description : Jnitboardinfo Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitboardinfoService {
	
	/**
	 * jnitboardinfo을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardinfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitboardinfo(JnitboardinfoVO vo) throws Exception;
    
    /**
	 * jnitboardinfo을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardinfoVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitboardinfo(JnitboardinfoVO vo) throws Exception;
    
    /**
	 * jnitboardinfo을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitboardinfo(JnitboardinfoVO vo) throws Exception;
    
    /**
	 * jnitboardinfo을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitboardinfoIsdel(JnitboardinfoVO vo) throws Exception;
    /**
	 * jnitboardinfo을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardinfoVO
	 * @return 조회한 jnitboardinfo
	 * @exception Exception
	 */
    JnitboardinfoVO selectJnitboardinfo(JnitboardinfoVO vo) throws Exception;
    /**
	 * jnitboardinfo 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardinfo 목록
	 * @exception Exception
	 */
    List selectJnitboardArticleList(JnitboardinfoDefaultVO searchVO) throws Exception;
    /**
	 * jnitboardinfo 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardinfo 목록
	 * @exception Exception
	 */
    List selectJnitboardinfoList(JnitboardinfoDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitboardinfo 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardinfo 총 갯수
	 * @exception
	 */
    int selectJnitboardinfoListTotCnt(JnitboardinfoDefaultVO searchVO);
    
    /**
     * jnitboardinfo 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitboardinfo() throws Exception;
    
    /**
	 * 게시판 그룹 목록을 조회한다.
	 * @param searchMap
	 * @return BOARD_GROUP LIST
	 * @exception
	 */
	List selectJnitboardinfoGroupList(JnitboardinfoDefaultVO searchVO) throws Exception;
	
	/**
	 * 게시판을 생성한다
	 * @param type - 게시판타입, id - 게시판 아이디
	 * @return void
	 * @exception
	 */
	void createNewBoard(String type, String id) throws Exception;
	
    /**
	 * 게시판에 INDEX를 추가한다
	 * @param id - 게시판 아이디
	 * @return void
	 * @exception
	 */
	void alterPrimaryKey(String id) throws Exception;
	
	/**
	 * 게시판 관리 icon 설정 JSON을 리턴한다
	 * @param request
	 * @return JSON
	 * @throws Exception
	 */
	JSONObject makeIconJSON(HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 관리 upload을 관리한다.
	 * @param request
	 * @param boardId
	 * @param fileNm
	 * @param JSON
	 * @throws Exception
	 */
	void uploadFormWorkFiles(HttpServletRequest request, String boardId, String fileNm, JSONObject JSON) throws Exception;
	
	/**
	 * 게시글 등록 수정시 json 데이터를 관리한다.
	 * @param request
	 * @param jnitboardinfoVO
	 * @return JSON
	 * @throws Exception
	 */
	JSONObject makeTmp4JSON(HttpServletRequest request, JnitboardinfoVO jnitboardinfoVO) throws Exception;
	
	/**
	 * 멀티 게시판 hashmap을 저장한다.
	 * @param request
	 * @param boardIds
	 * @return HashMap<boardId, JnitboardInfoVO>
	 * @throws Exception
	 */
	HashMap<String, JnitboardinfoVO> makeBoardInfoMap(HttpServletRequest request, String boardIds)throws Exception;
	
	/**
	 * icon설정의 파일존재 여부를 확인하여 리턴한다.
	 * @param request
	 * @param boardId
	 * @param iconJSON
	 * @return JSON
	 * @throws Exception
	 */
	JSONObject isIconFileExists(HttpServletRequest request, String boardId, JSONObject iconJSON)throws Exception;
}
