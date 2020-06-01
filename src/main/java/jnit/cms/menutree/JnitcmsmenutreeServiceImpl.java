package jnit.cms.menutree;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : JnitcmsmenutreeServiceImpl.java
 * @Description : Jnitcmsmenutree Business Implement class
 * @Modification Information
 *
 * @author jnitcmsmenutree
 * @since 2018.01.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmenutreeService")
public class JnitcmsmenutreeServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmenutreeService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(JnitcmsmenutreeServiceImpl.class);

    @Resource(name="jnitcmsmenutreeDAO")
    private JnitcmsmenutreeDAO jnitcmsmenutreeDAO;
    
    /** ID Generation */
    @Resource(name="JnitcmsmenutreeIdGnrService")    
    private EgovIdGnrService egovIdGnrService;
    
    @Resource(name="jnitcmsmbrtypeService")    
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;
    
    

	/**
	 * jnitcmsmenutree을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenutreeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMenuCodeId(id);
    	LOGGER.debug(vo.toString());
    	
    	jnitcmsmenutreeDAO.insertJnitcmsmenutree(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitcmsmenutree을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenutreeVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        jnitcmsmenutreeDAO.updateJnitcmsmenutree(vo);
    }

    /**
	 * jnitcmsmenutree을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenutreeVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        jnitcmsmenutreeDAO.deleteJnitcmsmenutree(vo);
    }

    /**
	 * jnitcmsmenutree을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenutreeVO
	 * @return 조회한 jnitcmsmenutree
	 * @exception Exception
	 */
    public JnitcmsmenutreeVO selectJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        JnitcmsmenutreeVO resultVO = jnitcmsmenutreeDAO.selectJnitcmsmenutree(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitcmsmenutree 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsmenutree 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenutreeList(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        return jnitcmsmenutreeDAO.selectJnitcmsmenutreeList(searchVO);
    }

    /**
	 * jnitcmsmenutree 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsmenutree 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenutreeListTotCnt(JnitcmsmenutreeDefaultVO searchVO) {
		return jnitcmsmenutreeDAO.selectJnitcmsmenutreeListTotCnt(searchVO);
	}

	/**
	 * 링크 기준 ID가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	public String linkselect(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
		//System.out.println("searchVOImpl : " + searchVO);
		JnitcmsmenutreeVO result = jnitcmsmenutreeDAO.linkselect(searchVO);
		if(result==null){
			result = new JnitcmsmenutreeVO();
		}
		String menuId = NullUtil.nullString(result.getMenuId()); 
		return menuId;
	}

	/**
	 * 뎁스별 메뉴 리스트 조회
	 * @param codeValue
	 * @return json
	 */
	public JSONArray subset(String codeValue)throws Exception{
		JnitcmsmenutreeVO searchVO = new JnitcmsmenutreeVO();
		List resultList;
		JSONArray menuList = new JSONArray();
		String searchStr = null;
		
		//1Depth 조회
		if(codeValue.equals("")){
			searchStr = "000000";
			searchVO.setSearchCondition("0");
			searchVO.setSearchKeyword(searchStr);
		}
		if(!codeValue.equals("")){
			//2Depth 조회
			if(codeValue.substring(3).equals("000000")){
				searchStr = codeValue.substring(0,3);
				searchVO.setSearchCondition("1");
				searchVO.setSearchKeyword(searchStr);
			}
			
			//3Depth
			if(codeValue.substring(5).equals("0000") && !codeValue.substring(3).equals("000000")){
				searchStr = codeValue.substring(0,5);
				searchVO.setSearchCondition("2");
				searchVO.setSearchKeyword(searchStr);
			}
			
			//3Depth
			if(codeValue.substring(7).equals("00") && !codeValue.substring(5).equals("0000") && !codeValue.substring(3).equals("000000")){
				searchStr = codeValue.substring(0,7);
				searchVO.setSearchCondition("3");
				searchVO.setSearchKeyword(searchStr);
			}
		}
		
		resultList = jnitcmsmenutreeDAO.selectsubset(searchVO);
		menuList.add(resultList);
		
		return menuList;
	}
	
	public int getlastId(JnitcmsmenutreeVO searchVO) {
		return jnitcmsmenutreeDAO.getlastId(searchVO);
	}
	
	public List selectupdatedList(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        return jnitcmsmenutreeDAO.selectupdatedList(searchVO);
    }
	
	public void updatedmenu(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        jnitcmsmenutreeDAO.updatedmenu(searchVO);
    }
	

	/**
	 * jnitcmsmenutree 회원유형별 모든 활성화된 관리메뉴 목록을 조회한 후 트리구조의 json 형태로 리턴한다.
	 * @param typeId
	 * @return
	 * @throws Exception
	 */
    public String selectListAllActiveToJson(String typeId) throws Exception {
    	List<JnitcmsmenutreeVO> resultList = selectListAllActive(typeId);
    	if(resultList == null)return "nodata";
	    
	    //기존 변환된 json형태가 각 타이틀을 변환하게 되어있어 변경.

		org.json.simple.JSONObject depth1 = new org.json.simple.JSONObject();
    	org.json.simple.JSONObject depth2 = new org.json.simple.JSONObject();
    	org.json.simple.JSONObject depth3 = new org.json.simple.JSONObject();
    	org.json.simple.JSONObject depth4 = new org.json.simple.JSONObject();
    	org.json.simple.JSONObject menuObject = new org.json.simple.JSONObject();
    	
    	for(JnitcmsmenutreeVO depth1VO:resultList){
    		
    		if(depth1VO.getChild() != null){
    			for(JnitcmsmenutreeVO depth2VO:depth1VO.getChild()){
    		    		
		    		if(depth2VO.getChild() != null){
		    			for(JnitcmsmenutreeVO depth3VO:depth2VO.getChild()){
		    				

				    		if(depth3VO.getChild() != null){
				    			for(JnitcmsmenutreeVO depth4VO:depth3VO.getChild()){
				    				
				    				

				    		    	menuObject = new org.json.simple.JSONObject();
				    				menuObject.put("icon", depth4VO.getMenuIcon());
				    				menuObject.put("link", depth4VO.getMenuLink());
				    				menuObject.put("name", depth4VO.getMenuName());
				    				menuObject.put("active", depth4VO.getMenuActive());
				    				menuObject.put("codeId", depth4VO.getMenuCodeId());
				    				menuObject.put("child", null);
				    				depth4.put(depth4VO.getMenuId(), menuObject);
				    			}
				    		}
		    		    	

		    		    	menuObject = new org.json.simple.JSONObject();
		    				menuObject.put("icon", depth3VO.getMenuIcon());
		    				menuObject.put("link", depth3VO.getMenuLink());
		    				menuObject.put("name", depth3VO.getMenuName());
		    				menuObject.put("active", depth3VO.getMenuActive());
		    				menuObject.put("codeId", depth3VO.getMenuCodeId());
		    				if(!depth4.isEmpty())menuObject.put("child", depth4);
		    				depth3.put(depth3VO.getMenuId(), menuObject);
		    				depth4 = new org.json.simple.JSONObject();
		    			}
		    		}
    		    	
    		    	
    		    	menuObject = new org.json.simple.JSONObject();
    				menuObject.put("icon", depth2VO.getMenuIcon());
    				menuObject.put("link", depth2VO.getMenuLink());
    				menuObject.put("name", depth2VO.getMenuName());
    				menuObject.put("active", depth2VO.getMenuActive());
    				menuObject.put("codeId", depth2VO.getMenuCodeId());
    				if(!depth3.isEmpty())menuObject.put("child", depth3);
    				depth2.put(depth2VO.getMenuId(), menuObject);
    				depth3 = new org.json.simple.JSONObject();
    			}
    		}

	    	menuObject = new org.json.simple.JSONObject();
			menuObject.put("icon", depth1VO.getMenuIcon());
			menuObject.put("link", depth1VO.getMenuLink());
			menuObject.put("name", depth1VO.getMenuName());
			menuObject.put("active", depth1VO.getMenuActive());
			menuObject.put("codeId", depth1VO.getMenuCodeId());
			if(!depth2.isEmpty())menuObject.put("child", depth2);
			depth1.put(depth1VO.getMenuId(), menuObject);
			depth2 = new org.json.simple.JSONObject();
    	}
	    
    	return depth1.toJSONString();
    }
    
    /**
	 * jnitcmsmenutree 회원유형별 모든 활성화된 관리메뉴 목록을 조회한 후 트리구조 형태로 리턴한다.
	 * @param typeId - 회원 typeId
	 * @return jnitcmsmenutree 목록
	 * @exception Exception
	 */
    public List<JnitcmsmenutreeVO> selectListAllActive(String typeId) throws Exception {
    	List<JnitcmsmenutreeVO> ret = null;
    	if(NullUtil.nullString(typeId).equals("")){
    		typeId = "30020";
    	}

    	String menuactive ="";
    	//관리자유형이 아닐때는 해당 회원유형의 최상위메뉴리스트를 가져온다. 
    	if(!typeId.equals("30020")){
	    	JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
	    	typeVO.setTypeId(typeId);
	    	JnitcmsmbrtypeVO typeresult = jnitcmsmbrtypeService.selectJnitcmsmbrtype(typeVO);
	    	
	    	if(NullUtil.nullString(typeresult.getMenuActive()).equals(""))return ret;
	      	menuactive = typeresult.getMenuActive();
    	}
        
    	JnitcmsmenutreeVO searchVO = new JnitcmsmenutreeVO();
    	List<JnitcmsmenutreeVO> resultList = (List<JnitcmsmenutreeVO>)jnitcmsmenutreeDAO.selectListAllActive(searchVO);
    	if(resultList == null)return null;
    	//최상위 메뉴 셋팅
    	ret = new ArrayList<JnitcmsmenutreeVO>();
    	for(JnitcmsmenutreeVO vo:resultList){
    		if((vo.getMenuDepth()+"").equals("1")){
//    			System.out.println("menuactive.indexOf(vo.getMenuCodeId() : "+menuactive.indexOf(vo.getMenuCodeId()));
    			if("".equals(menuactive) || menuactive.indexOf(vo.getMenuCodeId()) >= 0){
//    	    		System.out.println("vo : "+vo.getMenuName());
    				vo.setChild(getChildList(resultList, vo, menuactive));
    				ret.add(vo);
//    				System.out.println("");
    			}
    		}
    	}
        return ret;
    }

    
    /**
     * 하위 메뉴 구조 가져오기
     * @param dataList
     * @param parentVO
     * @param menuactive
     * @return
     */
    private List<JnitcmsmenutreeVO> getChildList(List<JnitcmsmenutreeVO> dataList, JnitcmsmenutreeVO parentVO, String menuactive){
    	if(dataList == null)return null;
    	List<JnitcmsmenutreeVO> ret = new ArrayList<JnitcmsmenutreeVO>();
    	
    	for(JnitcmsmenutreeVO vo:dataList){
    		if("".equals(menuactive) || menuactive.indexOf(vo.getMenuCodeId()) >= 0){
	    		if(vo.getMenuDepth() == parentVO.getMenuDepth() + 1 && parentVO.getMenuId().equals(vo.getMenuParent())){
//	    			System.out.println("child vo : "+vo.getMenuName());
//	    			System.out.println("vo.getMenuParent() : " + vo.getMenuParent());
	    			//최대 4뎁스까지만 하위메뉴를 가져옴
	    			if(vo.getMenuDepth() < 4)vo.setChild(getChildList(dataList, vo, menuactive));
	    			ret.add(vo);
	    		}
    		}
    	}
    	
    	return ret;
    }
}
