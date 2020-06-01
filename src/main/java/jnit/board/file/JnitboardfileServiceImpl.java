/**
 * @version 3.2.0.1
 */
package jnit.board.file;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitboardfileServiceImpl.java
 * @Description : Jnitboardfile Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Service("jnitboardfileService")
public class JnitboardfileServiceImpl extends EgovAbstractServiceImpl implements
        JnitboardfileService {

    @Resource(name="jnitboardfileDAO")
    private JnitboardfileDAO jnitboardfileDAO;

    /** ID Generation */
    @Resource(name="jnitBOARDFILEIdGnrService")
    private EgovIdGnrService egovIdGnrService;

    protected Log log = LogFactory.getLog(this.getClass());

    public static final String SEPERATOR = File.separator;
    private static final String cryptoKey = EgovProperties.getProperty("Globals.fileCodeView.key");//암호화키

	/**
	 * jnitboardfile을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardfile(JnitboardfileVO vo) throws Exception {

    	/** ID Generation Service */
    	String id = egovIdGnrService.getNextStringId();
    	vo.setFileId(id);

    	///board/file/{boardId}/{cntId}/{fileId}/{fileNm}
    	String fileExp = "";
    	try{
	    	String fileDot[] = vo.getFileOnm().split("\\.");
	    	fileExp = "."+fileDot[fileDot.length-1];
    	} catch (NullPointerException e){
    		fileExp = "";
    	}catch(Exception e){
    		fileExp = "";
    	}
    	//String fileNm = new BASE64Encoder().encode(vo.getFileOnm().getBytes());
        //String fileNm = new String(new Base64(true).encode(vo.getFileOnm().getBytes()));
    	String fileUrl = "/board/file/" + vo.getBoardId() + "/" + String.valueOf(vo.getBoardCntId()) + "/" + id + "/" + vo.getFileNm();
		//vo.setFileNm(fileNm);
    	vo.setFileUrl(fileUrl);

    	jnitboardfileDAO.insertJnitboardfile(vo);
        return id;
    }

    /**
	 * 이동된 게시물의 jnitboardfile을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardfileMove(JnitboardfileVO vo) throws Exception {

    	/** ID Generation Service */
    	String id = egovIdGnrService.getNextStringId();
    	vo.setFileId(id);

    	jnitboardfileDAO.insertJnitboardfile(vo);
        return id;
    }

    /**
	 * jnitboardfile을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertIsboardfile(JnitboardfileVO vo) throws Exception {
    	/** ID Generation Service */
    	String id = egovIdGnrService.getNextStringId();
    	vo.setFileId(id);

    	jnitboardfileDAO.insertJnitboardfile(vo);
        return id;
    }

    /**
	 * jnitboardfile을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardfile(JnitboardfileVO vo) throws Exception {
        jnitboardfileDAO.updateJnitboardfile(vo);
    }

    /**
	 * jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    public void deleteJnitboardfile(JnitboardfileVO vo) throws Exception {
        jnitboardfileDAO.deleteJnitboardfile(vo);
    }

    /**
	 * 해당 게시판의 jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO
	 * @return void형
	 * @exception Exception
	 */
    public void deleteJnitboardfileBoard(JnitboardfileVO vo) throws Exception {
        jnitboardfileDAO.deleteJnitboardfileBoard(vo);
    }

    /**
	 * 위지윅 에디터 jnitboardfile을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardfileVO (boardId,cntId)
	 * @return void형
	 * @exception Exception
	 */
    public void deleteJnitboardfileWyswyg(JnitboardfileVO vo) throws Exception {
        jnitboardfileDAO.deleteJnitboardfileWyswyg(vo);
    }

    /**
	 * jnitboardfile을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardfileVO
	 * @return 조회한 jnitboardfile
	 * @exception Exception
	 */
    public JnitboardfileVO selectJnitboardfile(JnitboardfileVO vo) throws Exception {
        JnitboardfileVO resultVO = jnitboardfileDAO.selectJnitboardfile(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitboardfile을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardfileVO
	 * @return 조회한 jnitboardfile
	 * @exception Exception
	 */
    public JnitboardfileVO selectJnitboardfileMain(JnitboardfileVO vo) throws Exception {
        JnitboardfileVO resultVO = jnitboardfileDAO.selectJnitboardfileMain(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * 게시물의 첨부파일을 조회한다
	 * @param boardID - 조회할 게시판의 BoardId, BoardCntId - 게시물 번호
	 * @return jnitboardfile 목록
	 * @exception Exception
	 */
    public List<?> selectFileList(String boardId, int cntId) throws Exception {
    	JnitboardfileVO fileVO = new JnitboardfileVO();
    	fileVO.setBoardId(boardId);
    	fileVO.setBoardCntId(cntId);
        return jnitboardfileDAO.selectFileList(fileVO);
    }

    /**
	 * jnitboardfile 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardfile 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardfileList(JnitboardfileDefaultVO searchVO) throws Exception {
        return jnitboardfileDAO.selectJnitboardfileList(searchVO);
    }

    /**
	 * jnitboardfile 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardfile 총 갯수
	 * @exception
	 */
    public int selectJnitboardfileListTotCnt(JnitboardfileDefaultVO searchVO) {
		return jnitboardfileDAO.selectJnitboardfileListTotCnt(searchVO);
	}

    /**
     * jnitboardfile 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitboardfile() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();

    	egovIdGnrStrategy.setPrefix("FILE_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(15);

        return egovIdGnrStrategy.makeId( (String)jnitboardfileDAO.getLastIdJnitboardfile() );
    }

    /**
  	 * 이미지 상세보기 경로 만들기(암호화 실패시 jafId값이 "" 로 표시)
  	 * @param searchVO
  	 * @return
  	 */
  	public String makeViewUrl(String fileId,String filePath, String fileNm, String fileOnm,String boardId){
  		JnitboardfileVO fileVO = new JnitboardfileVO();
  		fileVO.setFileId(fileId);
  		fileVO.setFilePath(EgovWebUtil.filePathBlackList(filePath));
  		fileVO.setFileNm(EgovWebUtil.filePathBlackList(fileNm));
  		fileVO.setFileOnm(EgovWebUtil.filePathBlackList(fileOnm));
  		fileVO.setBoardId(EgovWebUtil.filePathBlackList(boardId));
  		String str = encrypt(fileVO);
  		return "/board/fileCodeView.do?code=" + str + "&type=";
  	}
    /**
	 * 파일 정보 암호화
	 * @param searchVO
	 * @return
	 */
	private String encrypt(JnitboardfileVO searchVO){
		//DB조회를 없애기 위해 파일경로를 암호화해서 전송
		String str = searchVO.getFileId() +  "|" + searchVO.getFilePath() + "|" + searchVO.getFileNm()  + "|" + searchVO.getFileOnm()+ "|" + searchVO.getBoardId();
		try{
			AES256Util util = new AES256Util(cryptoKey);
			str = util.encrypt(str);
		}catch(UnsupportedEncodingException e){
			str = "";
			log.error(e.getMessage());
		}catch(GeneralSecurityException e){
			str = "";
			log.error(e.getMessage());
		}
		return str;
	}
	/**
	 * 파일 정보 복호화
	 * @param String str
	 * @return
	 */
	public JnitboardfileVO decrypt(String str)throws EgovBizException{
		String dec = "";
		try{
			AES256Util util = new AES256Util(cryptoKey);
			str = str.replaceAll(" ", "+");
			dec = util.decrypt(str);
		}catch(UnsupportedEncodingException e){
			log.error(str);
			log.error(e.getMessage());
		}catch(GeneralSecurityException e){
			log.error(str);
			log.error(e.getMessage());
		}
		if("".equals(dec))throw new EgovBizException("파일정보읽기 실패");

		String[] decrypts = dec.split("\\|");
		if(decrypts == null || decrypts.length < 5){
			log.debug("FILEINFO:"+dec);
			throw new EgovBizException("파일정보 변환 실패");
		}

		JnitboardfileVO ret = new JnitboardfileVO();
		ret.setFileId(decrypts[0]);
		ret.setFilePath(EgovWebUtil.filePathBlackList(decrypts[1]));
		ret.setFileNm(EgovWebUtil.filePathBlackList(decrypts[2]));
		ret.setFileOnm(EgovWebUtil.filePathBlackList(decrypts[3]));
		ret.setBoardId(EgovWebUtil.filePathBlackList(decrypts[4]));
		return ret;
	}

}
