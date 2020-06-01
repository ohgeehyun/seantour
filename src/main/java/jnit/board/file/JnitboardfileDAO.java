/**
 * @version 3.2.0.1
 */
package jnit.board.file;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitboardfileDAO.java
 * @Description : Jnitboardfile DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitboardfileDAO")
public class JnitboardfileDAO extends EgovComAbstractDAO {

	/**
	 * jnitboardfile을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardfile(JnitboardfileVO vo) throws Exception {
        return (String)insert("jnitboardfileDAO.insertJnitboardfile_S", vo);
    }

    /**
	 * jnitboardfile을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardfile(JnitboardfileVO vo) throws Exception {
        update("jnitboardfileDAO.updateJnitboardfile_S", vo);
    }

    /**
	 * jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardfile(JnitboardfileVO vo) throws Exception {
        delete("jnitboardfileDAO.deleteJnitboardfile_S", vo);
    }
    
    /**
	 * 해당 게시판의 jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardfileBoard(JnitboardfileVO vo) throws Exception {
        delete("jnitboardfileDAO.deleteJnitboardfile_board", vo);
    }

    /**
	 * jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardfileWyswyg(JnitboardfileVO vo) throws Exception {
        delete("jnitboardfileDAO.deleteJnitboardfile_Wyswyg", vo);
    }

    /**
	 * jnitboardfile을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardfileVO
	 * @return 조회한 jnitboardfile
	 * @exception Exception
	 */
    public JnitboardfileVO selectJnitboardfile(JnitboardfileVO vo) throws Exception {
        return (JnitboardfileVO) select("jnitboardfileDAO.selectJnitboardfile_S", vo);
    }

    /**
	 * jnitboardfile 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardfile 목록
	 * @exception Exception
	 */
    public List selectJnitboardfileList(JnitboardfileDefaultVO searchVO) throws Exception {
        return list("jnitboardfileDAO.selectJnitboardfileList_D", searchVO);
    }
    
    /**
	 * jnitboardfile을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardfileVO
	 * @return 조회한 jnitboardfile
	 * @exception Exception
	 */
    public JnitboardfileVO selectJnitboardfileMain(JnitboardfileVO vo) throws Exception {
        return (JnitboardfileVO) select("jnitboardfileDAO.selectJnitboardfileMain_S", vo);
    }
    /**
	 * 첨부파일 목록을 조회한다.
	 * @param fileVO - 조회할 정보가 담긴 Map
	 * @return jnitboardfile 목록
	 * @exception Exception
	 */
    public List<?> selectFileList(JnitboardfileVO fileVO) throws Exception {
        return list("jnitboardfileDAO.selectfileList_D", fileVO);
    }

    /**
	 * jnitboardfile 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardfile 총 갯수
	 * @exception
	 */
    public int selectJnitboardfileListTotCnt(JnitboardfileDefaultVO searchVO) {
        return (Integer)select("jnitboardfileDAO.selectJnitboardfileListTotCnt_S", searchVO);
    }

    /**
	 * jnitboardfile 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitboardfile() {
    	return (String)select("jnitboardfileDAO.getLastIdJnitboardfile_S");
    }
}
