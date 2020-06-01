/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminate;

import java.util.List;
import java.util.Properties;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import jnit.cms.cntvt.JnitcmscntvtVO;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteVO;

/**
 * @Class Name : JnitcmsdisseminateService.java
 * @Description : Jnitcmsdisseminate Business class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATE
 * @since 2013.11.05
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsdisseminateService {

	/**
	 * jnitcmsdisseminate을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception;

    /**
	 * jnitcmsdisseminate을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception;

    /**
	 * jnitcmsdisseminate을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    void updateNextdisseminate(JnitcmsdisseminateVO vo) throws Exception;

    /**
	 * jnitcmsdisseminate을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    void deleteJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception;

    /**
	 * jnitcmsdisseminate을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 조회한 jnitcmsdisseminate
	 * @exception Exception
	 */
    JnitcmsdisseminateVO selectJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception;

    /**
	 * jnitcmsdisseminate을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 조회한 jnitcmsdisseminate
	 * @exception Exception
	 */
    JnitcmsdisseminateVO selectdisseminate(JnitcmsdisseminateVO vo) throws Exception;

    /**
	 * jnitcmsdisseminate 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 목록
	 * @exception Exception
	 */
    List selectJnitcmsdisseminateList(JnitcmsdisseminateDefaultVO searchVO) throws Exception;

    /**
	 * jnitcmsdisseminate a jnitcmsmbr b 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 목록
	 * @exception Exception
	 */
    List selectdisseminateList(JnitcmsdisseminateDefaultVO searchVO) throws Exception;

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    int selectJnitcmsdisseminateListTotCnt(JnitcmsdisseminateDefaultVO searchVO);

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    int selectdisseminateListTotCnt(JnitcmsdisseminateDefaultVO searchVO);

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    int maxTotCnt(JnitcmsdisseminateDefaultVO searchVO);

    /**
     * jnitcmsdisseminate 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsdisseminate() throws Exception;

    /**
     * 예약저장된 컨텐츠를 정해진 시간에 돌려 업데이트 한다.
     * @param void
     * @exception Exception
     */
    public void cronDisseminate() throws Exception;

    /**
     * 컨텐츠를 파일을 생성한다.
     * @exception Exception
     */
    public boolean cntWriteDissmeniate(Properties props, JnitcmscntvtVO jnitcmscntvtVO, JnitcmssiteVO siteVO, JnitcmsmenuVO pmenuVO,JnitcmsmenuVO menuVO,String indexGet )throws Exception;

}
