/**
 * @version 3.2.0.1
 */
package jnit.allim.item;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;
import jnit.cms.site.JnitcmssiteVO;

/**
 * @Class Name : JnitallimItemService.java
 * @Description : JnitallimItem Business class
 * @Modification Information
 *
 * @author JNITALLIMITEM
 * @since 2012.04.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public interface JnitallimItemService {

	/**
	 * jnitallim_item을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitallimItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitallimItem(JnitallimItemVO vo) throws Exception;

    /**
	 * jnitallim_item을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitallimItemVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitallimItem(JnitallimItemVO vo) throws Exception;

    void updateSort(JnitallimItemVO vo) throws Exception;
    /**
	 * jnitallim_item을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitallimItemVO
	 * @return void형
	 * @exception Exception
	 */
    void deleteJnitallimItem(JnitallimItemVO vo) throws Exception;

    /**
	 * jnitallim_item을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitallimItemVO
	 * @return 조회한 jnitallim_item
	 * @exception Exception
	 */
    JnitallimItemVO selectJnitallimItem(JnitallimItemVO vo) throws Exception;

    /**
	 * jnitallim_item 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_item 목록
	 * @exception Exception
	 */
    List selectJnitallimItemList(JnitallimItemDefaultVO searchVO) throws Exception;

    /**
	 * jnitallim_item 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_item 목록
	 * @exception Exception
	 */
    List selectSortMax(JnitallimItemDefaultVO searchVO) throws Exception;

    /**
	 * jnitallim_item 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_item 총 갯수
	 * @exception
	 */
    int selectJnitallimItemListTotCnt(JnitallimItemDefaultVO searchVO);

    /**
     * jnitallim_item 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitallimItem() throws Exception;

    void insertAllim(HttpServletRequest request,JnitcmssiteVO jnitcmssiteVO, String mgmtType, String fileCopyType)throws Exception;

    Boolean makeAllimJSP(HttpServletRequest request, String grpId, String groupCategory, String type)throws Exception;

    ArrayList allimFileNameList(HttpServletRequest request, String type, String condition)throws Exception;

    JSONObject allimFileMake(HttpServletRequest request, String useSkinDir, String readDir, int isFile)throws Exception;
}
