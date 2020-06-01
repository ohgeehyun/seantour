/**
 * @version 3.2.0.1
 */
package jnit.board.file;

import java.util.List;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * @Class Name : JnitboardfileService.java
 * @Description : Jnitboardfile Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public interface JnitboardfileService {

	/**
	 * jnitboardfile을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitboardfile(JnitboardfileVO vo) throws Exception;
    /**
    * 이동된 게시물의 jnitboardfile을 등록한다.
    * @param vo - 등록할 정보가 담긴 JnitboardfileVO
    * @return 등록 결과
    * @exception Exception
    */
    String insertJnitboardfileMove(JnitboardfileVO vo) throws Exception;
    /**
     * 이동된 게시물의 jnitboardfile을 등록한다.
     * @param vo - 등록할 정보가 담긴 JnitboardfileVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertIsboardfile(JnitboardfileVO vo) throws Exception;

    /**
	 * jnitboardfile을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitboardfile(JnitboardfileVO vo) throws Exception;

    /**
	 * jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    void deleteJnitboardfile(JnitboardfileVO vo) throws Exception;

    /**
	 * 해당 게시판의 jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    void deleteJnitboardfileBoard(JnitboardfileVO vo) throws Exception;

    /**
	 * jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    void deleteJnitboardfileWyswyg(JnitboardfileVO vo) throws Exception;

    /**
	 * jnitboardfile을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardfileVO
	 * @return 조회한 jnitboardfile
	 * @exception Exception
	 */
    JnitboardfileVO selectJnitboardfile(JnitboardfileVO vo) throws Exception;

    /**
	 * jnitboardfile을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardfileVO
	 * @return 조회한 jnitboardfile
	 * @exception Exception
	 */
    JnitboardfileVO selectJnitboardfileMain(JnitboardfileVO vo) throws Exception;
    /**
	 * 게시물의 첨부파일을 조회한다
	 * @param boardID - 조회할 게시판의 BoardId, BoardCntId - 게시물 번호
	 * @return jnitboardfile 목록
	 * @exception Exception
	 */
    List selectFileList(String boardId, int cntId) throws Exception;

    /**
	 * jnitboardfile 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardfile 목록
	 * @exception Exception
	 */
    List selectJnitboardfileList(JnitboardfileDefaultVO searchVO) throws Exception;

    /**
	 * jnitboardfile 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardfile 총 갯수
	 * @exception
	 */
    int selectJnitboardfileListTotCnt(JnitboardfileDefaultVO searchVO);

    /**
     * jnitboardfile 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitboardfile() throws Exception;

    /**
  	 * 이미지 상세보기 경로 만들기(암호화 실패시 jafId값이 "" 로 표시)
  	 * @param searchVO
  	 * @return
  	 */
    String makeViewUrl(String fileId,String filePath, String fileNm, String fileOnm,String boardId);

    /**
	 * 파일 정보 복호화
	 * @param String str
	 * @return
	 */
    JnitboardfileVO decrypt(String str)throws EgovBizException;
}
