/**
 * @version 3.2.0.1
 */
package jnit.board.db;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import jnit.board.file.JnitboardfileService;
import jnit.board.file.JnitboardfileVO;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : JnitboardtplServiceImpl.java
 * @Description : Jnitboardtpl Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.22
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Service("jnitboarddbService")
public class JnitboarddbServiceImpl extends EgovAbstractServiceImpl implements
        JnitboarddbService {

    @Resource(name="jnitboarddbDAO")
    private JnitboarddbDAO jnitboarddbDAO;

    @Resource(name="jnitboardfileService")
    private JnitboardfileService jnitboardfileService;

    private static final String cryptoSetting = EgovProperties.getProperty("Globals.fileCodeView.setting");//암호화세팅

    /** ID Generation */
    //@Resource(name="{egovJnitboardtplIdGnrService}")
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * 게시물을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public int insert(JnitboarddbVO vo) throws Exception {
    	/*
    	if(vo.getGrp() != 0){
    		JnitboarddbVO pVO = new JnitboarddbVO();
    		pVO.setBoardId(vo.getBoardId());
    		pVO.setId(vo.getGrp());
    		pVO = select(pVO);
    		String idx = "";
    		String pIdx = NullUtil.nullString(pVO.getIdx());
    		if(pIdx.length()==0){
    			vo.setIdx("A");
    		}else{

    		}
    	}*/

    	int nid = getLastId(vo);
    	vo.setId(nid);
    	if(vo.getGrp()==0){
    		vo.setGrp(nid);
    	}
    	jnitboarddbDAO.insertJnitboarddb(vo);
    	/*
    	 * 최근게시물을 위한 게시물 추가 삽입.
    	 * boardId = bbs_1000000000000000
    	 * 2013-11-08 허진석
    	 * */
    	vo.setWriter(vo.getSearchKeyword()+"?boardId="+vo.getBoardId()+"&amp;mode=view&amp;cntId="+nid);
    	//2014-05-22 by.나성재 수정 elsys 요청으로 여분필드 tmp1,tmp2 사용
    	vo.setTmp1(vo.getBoardId());
    	vo.setTmp2(String.valueOf(nid));
    	vo.setBoardId("bbs_1000000000000000");

    	int Allnid = getLastId(vo);
    	vo.setId(Allnid);
    	vo.setGrp(Allnid);
    	jnitboarddbDAO.insertJnitboarddb(vo);

        return nid;
    }

    /**
	 * jnitboardtpl을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    public void update(JnitboarddbVO vo) throws Exception {
        jnitboarddbDAO.updateJnitboarddb(vo);
    }

    /**
	 * jnitboardtpl의 조회수를 올린다.
	 * @param vo - 수정할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    public void hit(JnitboarddbVO vo) throws Exception {
        jnitboarddbDAO.hitJnitboarddb(vo);
    }

    /**
	 * jnitboardtpl을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    public void delete(JnitboarddbVO vo) throws Exception {
        jnitboarddbDAO.deleteJnitboarddb(vo);
    }

    /**
	 * 해당 게시판의 데이터를 전체 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    public void deleteAll(JnitboarddbVO vo) throws Exception {
        jnitboarddbDAO.deleteAll(vo);
    }

    /**
	 * jnitboardtpl을 복구한다.
	 * @param vo - 복구할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    public void recovery(JnitboarddbVO vo) throws Exception {
        jnitboarddbDAO.recoveryJnitboarddb(vo);
    }

    /**
	 * jnitboardtpl을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardtplVO
	 * @return 조회한 jnitboardtpl
	 * @exception Exception
	 */
    public JnitboarddbVO select(JnitboarddbVO vo) throws Exception {
        JnitboarddbVO resultVO = jnitboarddbDAO.selectJnitboarddb(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    /**
	 * jnitboardtpl조회 데이터중 익명의 사용자가 올린 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardtplVO
	 * @return 조회한 jnitboardtpl
	 * @exception Exception
	 */
    public JnitboarddbVO selectAnonymous(JnitboarddbVO vo) throws Exception {
        JnitboarddbVO resultVO = jnitboarddbDAO.selectJnitboarddbAnony(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }


    /**
	 * jnitboardtpl 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardtpl 목록
	 * @exception Exception
	 */
    public List<?> selectList(JnitboarddbDefaultVO searchVO) throws Exception {
    	List<?> list = jnitboarddbDAO.selectJnitboarddbList(searchVO);
    	if(list != null){
    		for(int i = 0; i < list.size(); i++) {
    			//게시판 이미지 경로 암호화 설정에 따라 게시판 썸네일 url 세팅
    			settingFileUrl((EgovMap) list.get(i));
	    	}
    	}
        return list;
    }

    /**
   	 * 암호화 세팅이 true일경우 코드로 만든 thumbUrl을 세팅한다.
   	 * 이미지를 ${result.thumbUrl}로 호출
   	 * 사용처 : 게시판 갤러리,썸네일, 최근 게시물 갤러리형
   	 * @param EgovMap
   	 */
	private void settingFileUrl(EgovMap m) throws Exception {
	    String fileId = (String) m.get("fileId");
	    String filePath = (String) m.get("filePath");
	    String fileNm = (String) m.get("fileNm");
	    String fileOnm = (String) m.get("fileOnm");
	    String boardId = (String) m.get("boardId");
	    if("true".equals(cryptoSetting)){
	    	if("bbs_1000000000000000".equalsIgnoreCase(boardId)){
	    		boardId = (String) m.get("tmp1");
	    	}
	    	String fileUrl = jnitboardfileService.makeViewUrl(fileId,filePath,fileNm,fileOnm,boardId);
		    BeanUtils.setProperty(m, "fileUrl", fileUrl);
		    BeanUtils.setProperty(m, "thumbUrl", fileUrl + "list");
	    }else{
		    String fileUrl = (String) m.get("fileUrl");
		    String[] fileUrlArr = fileUrl.split("/");
			fileUrlArr[fileUrlArr.length-1] = "list_" + fileUrlArr[fileUrlArr.length-1];
			fileUrl = StringUtils.join(fileUrlArr,"/");
		    BeanUtils.setProperty(m, "thumbUrl", fileUrl);
	    }
	}

    /**
	 * jnitboardtpl 이전글,다음글, 현재글의 답글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardtpl 목록
	 * @exception Exception
	 */
    public List<?> selectPNList(JnitboarddbDefaultVO searchVO) throws Exception {
        return jnitboarddbDAO.selectJnitboarddbPNList(searchVO);
    }

    /**
	 * jnitboardtpl 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardtpl 총 갯수
	 * @exception
	 */
    public int selectListTotCnt(JnitboarddbDefaultVO searchVO) {
		return jnitboarddbDAO.selectJnitboarddbListTotCnt(searchVO);
	}

    /**
     * jnitboard 다음 등록 SEQ를 조회한다
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public int getLastId(JnitboarddbDefaultVO searchVO) throws Exception {
    	int lastId = 0;
    	lastId = jnitboarddbDAO.getLastIdJnitboard(searchVO);
    	lastId = lastId == 0 ? 1 : lastId;
        return lastId;
    }

    /**
     * jnitboardtpl 다음 등록 IDX를 조회한다
     * @param vo - 등록할 정보가 담긴 JnitboardtplVO
     * @return 다음 등록 Idx
     * @exception Exception
     */
	public String getNextIdx(JnitboarddbVO dbVO) throws Exception {
		String nextIdx = jnitboarddbDAO.getNextIdx(dbVO);
		return nextIdx;
	}

	public void dataDeleteAll(String boardId, int id) throws Exception {
		JnitboarddbVO vo = new JnitboarddbVO();
		vo.setBoardId(boardId);
		vo.setId(id);
		vo = selectAnonymous(vo);

		if("".equals(NullUtil.nullString(vo.getIdx()))){
			vo.setSearchCondition("idxNull");
			JnitboarddbVO dbVO = new JnitboarddbVO();
			dbVO.setIsdelYn("N");
			dbVO.setBoardId("bbs_1000000000000000");
			dbVO.setTmp1(boardId);
			dbVO.setTmp2(Integer.toString(id));
			dbVO.setDeleteCondition("2");
			delete(dbVO);

			JnitboardfileVO fileVO = new JnitboardfileVO();
			fileVO.setBoardId(boardId);
			fileVO.setBoardCntId(id);
			fileVO.setIsdelYn("N");
			fileVO.setDeleteCondition("1");
			jnitboardfileService.deleteJnitboardfile(fileVO);
		}else{
			vo.setSearchCondition("idx");
		}
		vo.setPageYn("N");
		List resultList = selectList(vo);
		Iterator itr = resultList.iterator();
		for(int i=0; i<resultList.size(); i++){
			EgovMap resultMap = (EgovMap) itr.next();
			JnitboardfileVO fileVO = new JnitboardfileVO();
			fileVO.setBoardId(boardId);
			fileVO.setBoardCntId(Integer.parseInt(String.valueOf(resultMap.get("id"))));
			fileVO.setIsdelYn("N");
			fileVO.setDeleteCondition("1");
			jnitboardfileService.deleteJnitboardfile(fileVO);

			JnitboarddbVO dbVO = new JnitboarddbVO();
			dbVO.setIsdelYn("N");
			dbVO.setBoardId("bbs_1000000000000000");
			dbVO.setTmp1(boardId);
			dbVO.setTmp2(String.valueOf(resultMap.get("id")));
			dbVO.setDeleteCondition("2");
			delete(dbVO);
		}

		vo.setIsdelYn("N");
		delete(vo);
		if("".equals(NullUtil.nullString(vo.getIdx()))){
			vo.setDeleteCondition("3");
			delete(vo);
		}else{
			vo.setDeleteCondition("4");
		}
		delete(vo);
	}
}
