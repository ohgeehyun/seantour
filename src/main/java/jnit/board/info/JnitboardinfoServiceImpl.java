/**
 * @version 3.2.0.1
 */
package jnit.board.info;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;
import jnit.cms.handler.CmsHandler;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @Class Name : JnitboardinfoServiceImpl.java
 * @Description : Jnitboardinfo Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitboardinfoService")
public class JnitboardinfoServiceImpl extends EgovAbstractServiceImpl implements
        JnitboardinfoService {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name="jnitboardinfoDAO")
    private JnitboardinfoDAO jnitboardinfoDAO;
    
    /** ID Generation */
    @Resource(name="jnitBOARDINFOIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitboardinfo을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardinfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardinfo(JnitboardinfoVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String boardId = egovIdGnrService.getNextStringId();
    	vo.setBoardId(boardId);
    	
    	jnitboardinfoDAO.insertJnitboardinfo(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return boardId;
    }

    /**
	 * jnitboardinfo을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardinfoVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        jnitboardinfoDAO.updateJnitboardinfo(vo);
    }

    /**
	 * jnitboardinfo을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        jnitboardinfoDAO.deleteJnitboardinfo(vo);
    }
    
    /**
	 * jnitboardinfo을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardinfoIsdel(JnitboardinfoVO vo) throws Exception {
        jnitboardinfoDAO.deleteJnitboardinfoIsdel(vo);
    }

    /**
	 * jnitboardinfo을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardinfoVO
	 * @return 조회한 jnitboardinfo
	 * @exception Exception
	 */
    public JnitboardinfoVO selectJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        JnitboardinfoVO resultVO = jnitboardinfoDAO.selectJnitboardinfo(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    /**
	 * jnitboardinfo 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardinfo 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardArticleList(JnitboardinfoDefaultVO searchVO) throws Exception {
        return jnitboardinfoDAO.selectJnitboardArticleList(searchVO);
    }
    /**
	 * jnitboardinfo 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardinfo 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardinfoList(JnitboardinfoDefaultVO searchVO) throws Exception {
        return jnitboardinfoDAO.selectJnitboardinfoList(searchVO);
    }

    /**
	 * jnitboardinfo 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardinfo 총 갯수
	 * @exception
	 */
    public int selectJnitboardinfoListTotCnt(JnitboardinfoDefaultVO searchVO) {
		return jnitboardinfoDAO.selectJnitboardinfoListTotCnt(searchVO);
	}
    
    /**
     * jnitboardinfo 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitboardinfo() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("BBS_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(16);
    	
        return egovIdGnrStrategy.makeId( (String)jnitboardinfoDAO.getLastIdJnitboardinfo() );
    }

    /**
	 * 게시판 그룹 목록을 조회한다.
	 * @param searchMap
	 * @return BOARD_GROUP LIST
	 * @exception
	 */
	public List<?> selectJnitboardinfoGroupList(JnitboardinfoDefaultVO searchVO)
		throws Exception {
		return jnitboardinfoDAO.selectJnitboardinfoGroupList(searchVO);
	}

	/**
	 * 게시판을 생성한다
	 * @param type - 게시판타입, id - 게시판 아이디
	 * @return void
	 * @exception
	 */
    public void createNewBoard(String type, String id) throws Exception {
		jnitboardinfoDAO.craeteNewBoard(type, id);		
	}
	
    /**
	 * 게시판에 INDEX를 추가한다
	 * @param id - 게시판 아이디
	 * @return void
	 * @exception
	 */
	public void alterPrimaryKey(String id) throws Exception {
		jnitboardinfoDAO.alterPrimaryKey(id);		
	}

	/**
	 * 게시판 관리 icon 설정 JSON을 리턴한다
	 * @param request
	 * @return JSON
	 * @throws Exception
	 */
	public JSONObject makeIconJSON(HttpServletRequest request) throws Exception {
		String iconlist = NullUtil.nullString(request.getParameter("iconlist"));
		JSONObject JSON = new JSONObject();
		JSONArray array = new JSONArray();
		if(!"".equals(iconlist)){
			try {
				String[] list = iconlist.split(",");
				for(int i=0; i<list.length; i++){
					JSONObject elmentJSON = new JSONObject();
					elmentJSON.put("type", NullUtil.nullString(request.getParameter(list[i])));
					elmentJSON.put("value", NullUtil.nullString(request.getParameter(list[i]+"_value")));
					elmentJSON.put("imgType", NullUtil.nullString(request.getParameter(list[i]+"_imgType")));
					elmentJSON.put("typeFileNm", NullUtil.nullString(request.getParameter(list[i]+"_typeFileNm")));
					elmentJSON.put("nm", NullUtil.nullString(request.getParameter(list[i]+"_nm")));
					JSON.put(list[i], elmentJSON);
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return JSON;
	}
	
	/**
	 * 게시판 관리 upload을 관리한다.
	 * @param request
	 * @param boardId
	 * @param fileNm
	 * @param JSON
	 * @throws Exception
	 */
	public void uploadFormWorkFiles(HttpServletRequest request, String boardId, String fileNm, JSONObject JSON)throws Exception{
		String root = PathUtil.getRealPath(request);
		String path = root + "board/_info/_iconImg/"+boardId+"/";
		JnitboardUtil.uploadFormWorkFiles(request,path,fileNm,JSON);
	}

	/**
	 * 게시글 등록 수정시 json 데이터를 관리한다.
	 * @param request
	 * @param jnitboardinfoVO
	 * @return JSON
	 * @throws Exception
	 */
	public JSONObject makeTmp4JSON(HttpServletRequest request,
			JnitboardinfoVO jnitboardinfoVO) throws Exception {
		JSONObject JSON = new JSONObject();
		try {
			JSONObject iconJSON = new JSONObject().fromObject(jnitboardinfoVO.getTmp1());
			Iterator itr = iconJSON.keys();
			while (itr.hasNext()) {
				String key = (String) itr.next();
				String value = NullUtil.nullString(request.getParameter(key+"_tmp4"));
				JSON.put(key, value);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return JSON;
	}

	/**
	 * 멀티 게시판 hashmap을 저장한다.
	 * @param request
	 * @param boardIds
	 * @return HashMap<boardId, JnitboardInfoVO>
	 * @throws Exception
	 */
	public HashMap<String, JnitboardinfoVO> makeBoardInfoMap(HttpServletRequest request,String boardIds)
			throws Exception {
		HashMap<String, JnitboardinfoVO> boardInfoMap = new HashMap<String, JnitboardinfoVO>();
		JnitboardinfoVO jnitboardinfoVO = null;
		boardIds = NullUtil.nullString(boardIds);
		if(!"".equals(boardIds)){
			String root = PathUtil.getRealPath(request);
			try {
				String[] boardId = boardIds.split(",");
				for(int i=0; i<boardId.length; i++){
					jnitboardinfoVO = new JnitboardinfoVO();
					try {
						String path = root+"board/_info/"+boardId[i]+".json";
						jnitboardinfoVO = (JnitboardinfoVO) JSONObject.toBean(JSONObject.fromObject(CmsHandler.readFile(path)), JnitboardinfoVO.class);
						
					} catch(FileNotFoundException e){
						jnitboardinfoVO.setBoardId(boardId[i]);
						jnitboardinfoVO = selectJnitboardinfo(jnitboardinfoVO);
					} catch (Exception e) {
						//log.error(e.getMessage());
					}
					boardInfoMap.put(boardId[i], jnitboardinfoVO);
				}
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return boardInfoMap;
	}

	/**
	 * icon설정의 파일존재 여부를 확인하여 리턴한다.
	 * @param request
	 * @param boardId
	 * @param iconJSON
	 * @return JSON
	 * @throws Exception
	 */
	public JSONObject isIconFileExists(HttpServletRequest request, String boardId, JSONObject iconJSON)
			throws Exception {		
		if(iconJSON.isEmpty()) iconJSON = new JSONObject();
		String root = PathUtil.getRealPath(request);
		String path = root+"board/_info/_iconImg/"+ boardId +"/";
		Iterator itr = iconJSON.keys();
		while (itr.hasNext()) {
			String key = (String) itr.next();
			try {
				JSONObject elmentJSON = (JSONObject) iconJSON.get(key);
				String imgType = elmentJSON.get("imgType").toString();
				if(!JnitboardUtil.isFileExists(path+key+"."+imgType)){
					elmentJSON.put("exists", "N");
				}else{
					elmentJSON.put("exists", "Y");
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}		
		return iconJSON;
	}
}
