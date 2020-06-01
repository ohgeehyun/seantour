package jnit.cms.menutree;

import java.util.List;

import org.json.simple.JSONArray;

import jnit.cms.menutree.JnitcmsmenutreeDefaultVO;
import jnit.cms.menutree.JnitcmsmenutreeVO;

/**
 * @Class Name : JnitcmsmenutreeService.java
 * @Description : Jnitcmsmenutree Business class
 * @Modification Information
 *
 * @author jnitcmsmenutree
 * @since 2018.01.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmenutreeService {
	
	/**
	 * jnitcmsmenutree을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenutreeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception;
    
    /**
	 * jnitcmsmenutree을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenutreeVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception;
    
    /**
	 * jnitcmsmenutree을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenutreeVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception;
    
    /**
	 * jnitcmsmenutree을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenutreeVO
	 * @return 조회한 jnitcmsmenutree
	 * @exception Exception
	 */
    JnitcmsmenutreeVO selectJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception;
    
    /**
	 * jnitcmsmenutree 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsmenutree 목록
	 * @exception Exception
	 */
    List selectJnitcmsmenutreeList(JnitcmsmenutreeDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitcmsmenutree 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsmenutree 총 갯수
	 * @exception
	 */
    int selectJnitcmsmenutreeListTotCnt(JnitcmsmenutreeDefaultVO searchVO);

	/**
	 * 링크 기준 ID 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	public String linkselect(JnitcmsmenutreeDefaultVO searchVO) throws Exception;

	/**
	 * 뎁스별 메뉴 리스트 조회
	 * @param codeValue
	 * @return json
	 */
	
	JSONArray subset(String codeValue) throws Exception;
	
	int getlastId(JnitcmsmenutreeVO searchVO);

	List selectupdatedList(JnitcmsmenutreeDefaultVO searchVO) throws Exception;
	
	void updatedmenu(JnitcmsmenutreeDefaultVO searchVO) throws Exception;

	/**
	 * jnitcmsmenutree 회원유형별 모든 활성화된 관리메뉴 목록을 조회한 후 트리구조의 json 형태로 리턴한다.
	 * @param typeId
	 * @return
	 * @throws Exception
	 */
    String selectListAllActiveToJson(String typeId) throws Exception;
    
    /**
	 * jnitcmsmenutree 모든 활성화된 목록을 조회한 후 트리구조의  형태로 리턴한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsmenutree 목록
	 * @exception Exception
	 */
	List<JnitcmsmenutreeVO> selectListAllActive(String typeId) throws Exception;
    
	
}
