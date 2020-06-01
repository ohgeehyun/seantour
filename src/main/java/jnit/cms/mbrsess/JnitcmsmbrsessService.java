/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrsess;


/**
 * @Class Name : JnitcmsmbrsessService.java
 * @Description : Jnitcmsmbrsess Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmbrsessService {
	
	/**
	 * JNITCMSMBRSESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrsessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRSESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrsessVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRSESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrsessVO
	 * @return 조회한 JNITCMSMBRSESS
	 * @exception Exception
	 */
    JnitcmsmbrsessVO selectJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRSESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRSESS 총 갯수
	 * @exception
	 */
    int selectJnitcmsmbrsessListTotCnt(JnitcmsmbrsessDefaultVO searchVO);
}
