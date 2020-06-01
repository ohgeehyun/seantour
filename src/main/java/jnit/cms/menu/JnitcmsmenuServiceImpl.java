/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.hist.JnitcmshistService;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.com.util.FileCopy;
import jnit.rsc.page.JnitrscpageController;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

/**
 * @Class Name : JnitcmsmenuServiceImpl.java
 * @Description : Jnitcmsmenu Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.08
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmenuService")
public class JnitcmsmenuServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmenuService {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name="jnitcmsmenuDAO")
    private JnitcmsmenuDAO jnitcmsmenuDAO;

    @Resource(name="jnitcmscntService")
    private JnitcmscntService jnitcmscntService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name="jnitcmshistService")
    private JnitcmshistService jnitcmshistService;

    /** ID Generation */
    @Resource(name="jnitCMSMENUIdGnrService")
    private EgovIdGnrService egovIdGnrService;

    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

	/**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {

    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMenuId(id);

    	String nextPath = jnitcmsmenuDAO.selectJnitcmsmenuNextPath(vo);
    	vo.setMenuPath(nextPath);
    	jnitcmsmenuDAO.insertJnitcmsmenu(vo);
    	//TODO 해당 테이블 정보에 맞게 수정
        return id;
    }
    public String insertJnitcmsmenu(JnitcmsmenuVO vo, String SitePath, HttpServletRequest request) throws Exception {
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMenuId(id);

    	String nextPath = jnitcmsmenuDAO.selectJnitcmsmenuNextPath(vo);
    	vo.setMenuPath(nextPath);

    	String afterPath = this.makeMenuDirectoryName(vo, SitePath);
    	//menuPath = "/" + sitePath + "/" + menuPath;
    	String makeDir = PathUtil.getRealPath(request)+ afterPath;


    	boolean mkFile = false;
    	boolean fileChange = false;

    	int i = 0;
    	int j = 0;
    	while(!mkFile){
    		File af = new File(makeDir);
    		if(af.exists()) {
        		makeDir = PathUtil.getRealPath(request)+ afterPath+"-"+i;
        		j = i;
        		i++;
        		fileChange = true;
        	}else{
        		mkFile = true;
        	}

    	}
    	if(fileChange){
    		nextPath = nextPath + "-"+j;
        	vo.setMenuPath(nextPath);
    	}

    	jnitcmsmenuDAO.insertJnitcmsmenu(vo);
    	//TODO 해당 테이블 정보에 맞게 수정
        return id;
    }
    /**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSelect(JnitcmsmenuVO vo) throws Exception {

    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMenuId(id);

    	String nextPath = jnitcmsmenuDAO.selectJnitcmsmenuNextPath(vo);
    	vo.setMenuPath(nextPath);

    	jnitcmsmenuDAO.insertSelect(vo);
    	//TODO 해당 테이블 정보에 맞게 수정
        return id;
    }
    /**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenuCopy(JnitcmsmenuVO vo) throws Exception {

    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMenuId(id);

    	jnitcmsmenuDAO.insertJnitcmsmenu(vo);
    	//TODO 해당 테이블 정보에 맞게 수정
        return id;
    }

    /**
	 * JNITCMSMENU을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        jnitcmsmenuDAO.updateJnitcmsmenu(vo);
    }

    /**
	 * JNITCMSMENU Method를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenuMethod(JnitcmsmenuVO vo) throws Exception {
        jnitcmsmenuDAO.updateJnitcmsmenuMethod(vo);
    }

    /**
	 * JNITCMSMENU MenuNm을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenuTitle(JnitcmsmenuVO vo) throws Exception {
        jnitcmsmenuDAO.updateJnitcmsmenuTitle(vo);
    }

    /**
	 * JNITCMSMENU Method을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenuChMethod(JnitcmsmenuChMethodVO vo) throws Exception {
        jnitcmsmenuDAO.updateJnitcmsmenuChMethod(vo);
    }

    /**
	 * JNITCMSMENU을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void deleteJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        jnitcmsmenuDAO.deleteJnitcmsmenu(vo);
    }

    /**
	 * JNITCMSMENU을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenuVO
	 * @see JnitrscpageController
	 * <code>{@link jnit.rsc.page.JnitrscpageController# addJnitrscpageView }</code>
	 * @return 조회한 JNITCMSMENU
	 * @exception Exception
	 */
    public JnitcmsmenuVO selectJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        JnitcmsmenuVO resultVO = jnitcmsmenuDAO.selectJnitcmsmenu(vo);
        if (resultVO == null) {
            //throw processException("info.nodata.msg");
        	resultVO = new JnitcmsmenuVO();
        }
        return resultVO;
    }

    /**
	 * JNITCMSMENU 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenuList(JnitcmsmenuDefaultVO searchVO) throws Exception {
        return jnitcmsmenuDAO.selectJnitcmsmenuList(searchVO);
    }

    /**
	 * JNITCMSMENU 전체 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenuListAll(JnitcmsmenuDefaultVO searchVO) throws Exception {
        return jnitcmsmenuDAO.selectJnitcmsmenuListAll(searchVO);
    }

    /**
	 * JNITCMSMENU 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenuListTotCnt(JnitcmsmenuDefaultVO searchVO) {
		return jnitcmsmenuDAO.selectJnitcmsmenuListTotCnt(searchVO);
	}

    /**
	 * JNITCMSMENU 다음 Method를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenuNextMethod(JnitcmsmenuVO vo) {
		return jnitcmsmenuDAO.selectJnitcmsmenuNextMethod(vo);
	}

    /**
	 * JNITCMSMENU Max Method를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenuMaxMethod(JnitcmsmenuVO vo) {
		return jnitcmsmenuDAO.selectJnitcmsmenuMaxMethod(vo);
	}

    /**
     * JNITCMSMENU 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmenu() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();

    	egovIdGnrStrategy.setPrefix("MENU_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(5);

        return egovIdGnrStrategy.makeId( (String)jnitcmsmenuDAO.getLastIdJnitcmsmenu() );
    }

    /**
     * 메뉴경로를 생성한다. 생성 후 경로 리턴
     * @param vo
     * @param sitePath
     * @return 생성한 경로
     * @throws Exception
     */
	public String makeMenuDirectory(JnitcmsmenuVO vo, String sitePath, HttpServletRequest request) throws Exception {

		String menuPath = makeMenuDirectoryName(vo, sitePath);
    	if("true".equals(deDug)) log.debug("menuPath : " + menuPath);

        // 경로생성 및 기본페이지 저장
        String tplDir = PathUtil.getRealPath(request)
					+ menuPath;
        String tplFile = tplDir + "/index.jsp";

        File f = new File(tplDir);
        if(!f.exists()) f.mkdirs();

    	return menuPath;
    }

    /**
     * 메뉴경로명을 생성한다. 생성 후 경로명 리턴
     * @param vo
     * @param sitePath
     * @return 경로명
     * @throws Exception
     */
	public String makeMenuDirectoryName(JnitcmsmenuVO vo, String sitePath) throws Exception {

    	String menuPath = "";
    	menuPath = vo.getMenuPath();

    	try{

	    	if(vo.getDepth() > 0) {
	    		String pid = "";
	    		pid = NullUtil.nullString(vo.getPid());
	    		for(int i=vo.getDepth()-1; i>=0; i--) {
	    			if(!pid.equals("")) {
		    			JnitcmsmenuVO pidVO = new JnitcmsmenuVO();
		    			pidVO.setSiteId(vo.getSiteId());
		    			pidVO.setMenuId(pid);
		    			JnitcmsmenuVO parentVO = this.selectJnitcmsmenu(pidVO);
		    			pid = parentVO.getPid();
		    			menuPath = parentVO.getMenuPath() + "/" + menuPath;
	    			}
	    		}
	    	}
	    	menuPath = "/" + sitePath + "/" + menuPath;
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.debug("makeMenuDirectoryName error");
    	}


    	return menuPath;
    }

	public String makeMenuRedirect(JnitcmsmenuVO vo, String sitePath, HttpServletRequest request) throws Exception {

    	String menuPath = "";
    	vo.setSearchCondition("3");
    	vo.setPageYn("N");
    	vo.setSearchKeyword(vo.getMenuId());
    	List menuList = this.selectJnitcmsmenuList(vo);

    	Iterator menuIterator = menuList.iterator();

    	for(int i=0; i<menuList.size(); i++){
    		EgovMap menuEgovMap = (EgovMap) menuIterator.next();
    		String lDel = String.valueOf(menuEgovMap.get("lDel"));
    		int link = Integer.parseInt(String.valueOf(menuEgovMap.get("islink")));
    		String redirectUrl = NullUtil.nullString(String.valueOf(menuEgovMap.get("redirectUrl")));
    		if(!"".equals(redirectUrl)){
    			menuPath = redirectUrl;
    			break;
    		}else if("Y".equals(lDel) && link == 0){
    			menuPath = String.valueOf(menuEgovMap.get("menuPath"));
    			break;
    		}
    	}
    	if("".equals(menuPath)) menuPath = "noindex.jsp";

    	return menuPath;
    }

    /**
     * 메뉴명 전체Depth 생성.
     * @param vo
     * @param menuPath
     * @return 메뉴명
     * @throws Exception
     */
	public String makeMenuNames(JnitcmsmenuVO vo, String siteNm) throws Exception {

    	String menuName = "";
    	menuName = vo.getMenuNm();
    	menuName = "<span class='menu-active'>"+menuName+"</span>";

    	if(vo.getDepth() > 0) {
    		String pid = "";
    		pid = vo.getPid();
    		for(int i=vo.getDepth()-1; i>=0; i--) {
    			JnitcmsmenuVO pidVO = new JnitcmsmenuVO();
    			pidVO.setSiteId(vo.getSiteId());
    			pidVO.setMenuId(pid);
    			JnitcmsmenuVO parentVO = this.selectJnitcmsmenu(pidVO);
    			pid = parentVO.getPid();

    			menuName = parentVO.getMenuNm() + " <span class=\"gt\"> &gt; </span> " + menuName;
    		}
    	}
    	menuName = "<span class='menu-home'>"+siteNm+"</span>" + " <span class=\"gt\"> &gt; </span> " + menuName;

    	return menuName;
    }

    /**
     * 메뉴명 전체Depth Link포함 생성.
     * @param vo
     * @param menuPath
     * @return 메뉴명
     * @throws Exception
     */
	public String makeMenuLinkNames(JnitcmsmenuVO vo, String siteNm, String sitePath) throws Exception {

    	String menuName = "";
    	menuName = vo.getMenuNm();
    	menuName = "<span class='menu-active'>"+menuName+"</span>";

    	if(vo.getDepth() > 0) {
    		String pid = "";
    		pid = vo.getPid();
    		for(int i=vo.getDepth()-1; i>=0; i--) {
    			JnitcmsmenuVO pidVO = new JnitcmsmenuVO();
    			pidVO.setSiteId(vo.getSiteId());
    			pidVO.setMenuId(pid);
    			JnitcmsmenuVO parentVO = this.selectJnitcmsmenu(pidVO);
    			pid = parentVO.getPid();

    	    	final String pmenuLink = (String)makeMenuDirectoryName(parentVO, sitePath);
    	    	final String pmenuName = "<a href='"+pmenuLink+"'><span>"+parentVO.getMenuNm()+"</span></a>";

    			menuName = pmenuName + " <span class='gt'> &gt; </span> " + menuName;
    		}
    	}
    	menuName = "<span id='pageLinkNav'><a href='/"+sitePath+"' class='menu-home'><span>"+siteNm+"</span></a>" + " <span class='gt'> &gt; </span> " + menuName + "</span>";

    	return menuName;
    }

public String makeMenuNavTitleNames(JnitcmsmenuVO vo, String siteNm, String sitePath) throws Exception {

    	String menuName = "";
    	menuName = vo.getMenuNm();
    	if(vo.getDepth() > 0) {
    		String pid = "";
    		pid = vo.getPid();

    		for(int i=vo.getDepth()-1; i>=0; i--) {
    			JnitcmsmenuVO pidVO = new JnitcmsmenuVO();
    			pidVO.setSiteId(vo.getSiteId());
    			pidVO.setMenuId(pid);
    			JnitcmsmenuVO parentVO = this.selectJnitcmsmenu(pidVO);
    			pid = parentVO.getPid();

    			final String pmenuLink = (String)makeMenuDirectoryName(parentVO, sitePath);
    	    	final String pmenuName = parentVO.getMenuNm();

    			menuName =  menuName + "&lt; " + pmenuName; /*&#60;  = <*/
    		}
    	}
    	menuName =  menuName +"&lt; " + siteNm;
    	return menuName;
    }

	public String makeMenuPid(JnitcmsmenuVO vo, String siteNm, String sitePath, String type, HttpServletRequest request ) throws Exception {
		String pidList = "";
		if(vo.getDepth() > 0) {
			String pid = "";
			pid = vo.getPid();
			if(pid != null)pidList = pid;

			for(int i=vo.getDepth()-1; i>=0; i--) {
				JnitcmsmenuVO pidVO = new JnitcmsmenuVO();
				pidVO.setSiteId(vo.getSiteId());
				pidVO.setMenuId(pid);
				JnitcmsmenuVO parentVO = this.selectJnitcmsmenu(pidVO);
				pid = parentVO.getPid();
				if(pid != null)pidList += ","+pid;
			}
		}else{
			pidList = vo.getPid() == null ? "" : vo.getPid();
		}

		if("return".equals(type)){
			if(pidList.indexOf(",") > -1){
				String[] returnPid = pidList.split(",");
				pidList = "";
				for(int i=returnPid.length-1; i>=0; i--){
					if("".equals(pidList)){
						pidList += returnPid[i];
					}else{
						pidList += "," + returnPid[i];
					}
				}
			}
		}
		return pidList;
	}

	/**
	 * 해당 메뉴의 기본 하위메뉴 Path를 생성
	 * @param getMenuVO
	 * @param defMenu
	 * @return
	 * @throws Exception
	 */
	public String getDefMenuPath(JnitcmsmenuVO vo, Object defMenu)
			throws Exception {

		String defMenuStr = (defMenu == null ? "" : defMenu.toString() );

		if(!defMenuStr.trim().equals("")) return defMenuStr.trim();

        JnitcmsmenuVO resultVO = jnitcmsmenuDAO.selectJnitcmsmenuDef(vo);
        if(resultVO == null) return "";

		return resultVO.getMenuPath();
	}

	/** SITE_ID, MENU_ID GET */
	public CaseInsensitiveMap getSiteAndMenuInfo(CaseInsensitiveMap ciMap) throws Exception{
		CaseInsensitiveMap result = new CaseInsensitiveMap();

		try{
			result = jnitcmsmenuDAO.getSiteAndMenuInfo(ciMap);
		}catch(NullPointerException e){
			log.error(e.getMessage());
			result = null;
		}

		return result;
	}

	/**
     * JNITCMSMENU 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public int getDuplicationCount(JnitcmsmenuVO vo) throws Exception {
    	int duplicationCount = jnitcmsmenuDAO.getDuplicationCount(vo);
    	return duplicationCount;
    }

    public void makeMenuCopy(String siteId, int isDepth, int addDepth, JSONObject JSON)throws Exception{

    	JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
    	menuVO.setSiteId(siteId);
    	menuVO.setSearchCondition("4");
    	ArrayList<String> array = new ArrayList<String>();
    	Iterator keyItr = (Iterator) JSON.keys();
		while (keyItr.hasNext()) {
			String key = (String) keyItr.next();
			array.add(key);
		}
    	menuVO.setSelectList(array);
    	menuVO.setDepth(isDepth);
    	menuVO.setPageYn("N");
    	if(!JSON.isEmpty()){
    		List<?> pidList = selectJnitcmsmenuList(menuVO);
        	if(pidList.size() > 0){
        		Iterator pidItr = pidList.iterator();
        		JSONObject JSON2 = new JSONObject();
        		Boolean isMakeMenuCopy = true;
        		for(int i=0; i<pidList.size(); i++){
        			EgovMap pidEgovMap = (EgovMap) pidItr.next();
        			String menuId = (String) pidEgovMap.get("menuId");
        			try {
        				menuVO.setMenuId(menuId);
        				menuVO = selectJnitcmsmenu(menuVO);
        				menuVO.setDepth(menuVO.getDepth()+addDepth);
        			} catch (NullPointerException e){
        				break;
    				} catch (Exception e) {
    					break;
    				}
    				if(!JSON.isEmpty()){
    					String pid = (String) pidEgovMap.get("pid");
    					try { //첫번째루프 따로 셋팅
        					menuVO.setMenuNm(JSON.get("targetNm").toString());
        					JSON.put("loop", "1");
        					menuVO.setPid(JSON.get(menuId).toString());
        					menuVO.setCountCondition("2");
            				menuVO.setSearchCondition("0");
            				menuVO.setMethod(selectJnitcmsmenuListTotCnt(menuVO)+1);
        					menuVO.setMenuPath(jnitcmsmenuDAO.selectJnitcmsmenuNextPath(menuVO));
        					pid = JSON.get(menuId).toString();
    					} catch (NullPointerException e){//두번째 루프 시작
    						Iterator itr = (Iterator) JSON.keys();
        					while (itr.hasNext()) {
        						String key = (String) itr.next();
        						if(key.equals(pid)){
        							pid = JSON.get(key).toString();
        						}
        						if(JSON.get("targetMenuId").equals(menuId)){
        							isMakeMenuCopy = false;
        						}else{
        							isMakeMenuCopy = true;
        							JSON2.put("targetMenuId", JSON.get("targetMenuId"));
        						}
        					}
    					} catch (Exception e) { //두번째 루프 시작
    						Iterator itr = (Iterator) JSON.keys();
        					while (itr.hasNext()) {
        						String key = (String) itr.next();
        						if(key.equals(pid)){
        							pid = JSON.get(key).toString();
        						}
        						if(JSON.get("targetMenuId").equals(menuId)){
        							isMakeMenuCopy = false;
        						}else{
        							isMakeMenuCopy = true;
        							JSON2.put("targetMenuId", JSON.get("targetMenuId"));
        						}
        					}
    					}
    					menuVO.setPid(pid);
    				}

    				if(isMakeMenuCopy){
        				menuVO.setMethod(selectJnitcmsmenuMaxMethod(menuVO)+1);
    					String id = insertJnitcmsmenuCopy(menuVO);
            			if(menuVO.getIscnt() == 0){
            				JSON2.put(menuId, id);
            				if("1".equals(JSON.get("loop"))){
            					JSON2.put("targetMenuId", id);
							}
            			}else if(menuVO.getIscnt() == 1){
            				JnitcmscntVO cntVO = new JnitcmscntVO();
            				cntVO.setMenuId(menuId);
            				cntVO.setSiteId(siteId);
            				try {
        						cntVO = jnitcmscntService.selectJnitcmscnt(cntVO);
        						cntVO.setMenuId(id);
        						String cntId = jnitcmscntService.insertJnitcmscnt(cntVO);
        						menuVO.setCntId(cntId);
        						menuVO.setUpdateCondition("2");
        						updateJnitcmsmenu(menuVO);
            				} catch (NullPointerException e){
            					log.error(e.getMessage());
        					} catch (Exception e) {
        						log.error(e.getMessage());
        					}
            			}
    				}
        		}
        		isDepth = isDepth +1;
        		makeMenuCopy(siteId, isDepth, addDepth, JSON2);
        	}
    	}
    }

    public JSONObject makeMenuFileCopy(HttpServletRequest request, String siteId, String menuId, String targetMenuId, String targetNm)throws Exception{
    	String root = request.getSession().getServletContext().getRealPath("");
    	JSONObject codeJSON = new JSONObject();
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	try {
			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
			if("1".equals(menuPremJSON(request, siteId, "menuAll", "1", "true"))){
				codeJSON.put("message", "FAIL 3");
			}
			JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
			menuVO.setSiteId(siteId);
			menuVO.setMenuId(menuId);
			menuVO = selectJnitcmsmenu(menuVO);

			String sourceLocation = root+(String)makeMenuDirectoryName(menuVO, siteVO.getSitePath());
			menuVO.setMenuId(targetMenuId);
			menuVO = selectJnitcmsmenu(menuVO);

			File sourceFile =  new File(sourceLocation);
			if(!sourceFile.exists()){
				codeJSON.put("message", "FAIL 1");
			}
			menuVO.setSiteId(siteId);
			menuVO.setMenuId(targetMenuId);
			String targetLocation = root+(String)makeMenuDirectoryName(menuVO, siteVO.getSitePath());
			menuVO.setPid(targetMenuId);
			log.debug(targetLocation+"/"+jnitcmsmenuDAO.selectJnitcmsmenuNextPath(menuVO));
			File targetFile = new File(targetLocation+"/"+jnitcmsmenuDAO.selectJnitcmsmenuNextPath(menuVO));
			if(targetFile.exists()){
				codeJSON.put("message", "FAIL 2");
			}
			if(codeJSON.isEmpty()){
				FileCopy.copyTargetExcludeDirectory(sourceFile, targetFile, targetLocation.replace("\\", "/")+"/"+jnitcmsmenuDAO.selectJnitcmsmenuNextPath(menuVO));
			}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    	return codeJSON;
    }

    public String menuPremJSON(HttpServletRequest request, String siteId, String type, String data, String create)throws Exception{
    	String root = request.getSession().getServletContext().getRealPath("");
    	String str = "";
    	JSONObject menuPerm = new JSONObject();
    	JnitcmsmenuPremVO menuPremVO = new JnitcmsmenuPremVO();
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
    	String menuPremDir = root+"/"+siteVO.getSitePath()+"/_etc/menuPerm.json";
    	try {
    		menuPerm = new JSONObject().fromObject(CmsHandler.readFile(menuPremDir));
    		Iterator itr = menuPerm.keys();
    		while (itr.hasNext()) {
				String key = (String) itr.next();
				if(type.equals(key)){
					str = menuPerm.get(key).toString();
				}
			}
    	} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    	if("true".equals(create)){
    		if("menuAll".equals(type)){
        		menuPremVO.setMenuAll(data);
    		}else if("menuPerm".equals(type)){
    			menuPremVO.setMenuPerm(data);
    		}else if("menuCntPerm".equals(type)){
    			menuPremVO.setMenuCntPerm(data);
    		}
        	CmsHandler.writeFile(menuPremDir, menuPerm.fromObject(menuPremVO).toString());
    	}
    	return str;
    }

    public String isMenuExistsData(JnitcmsmenuVO vo, String type, String data) throws Exception{
    	String str = "";
    	String pid = "";
    	try{
    		pid = vo.getPid();
    		if("admMbrId".equals(type)){
    			if(vo.getAdmMbrId() != null && vo.getAdmMbrId().contains(data)){
    				str = "Y";
    			}
    		}
    		if(vo.getDepth() != 0){
				for(int i=vo.getDepth()-1; i>=0; i--) {
	    			JnitcmsmenuVO pidVO = new JnitcmsmenuVO();
	    			pidVO.setSiteId(vo.getSiteId());
	    			pidVO.setMenuId(pid);
	    			JnitcmsmenuVO parentVO = this.selectJnitcmsmenu(pidVO);
	    			if("admMbrId".equals(type)){
	    				if(parentVO.getAdmMbrId() != null && parentVO.getAdmMbrId().contains(data)){
	    					str = "Y";
	    				}
	    			}
	    			pid = parentVO.getPid();
    			}
    		}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    		// vo.getAdmMbrId null
    	}
    	return str;
    }
}
