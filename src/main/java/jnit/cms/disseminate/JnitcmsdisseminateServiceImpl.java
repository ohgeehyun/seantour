/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminate;

import java.io.File;
import java.io.FileOutputStream;
import java.security.MessageDigest;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cntvt.JnitcmscntvtService;
import jnit.cms.cntvt.JnitcmscntvtVO;
import jnit.cms.disseminatehisotry.JnitcmsdisseminatehistoryService;
import jnit.cms.handler.CmsHandler;
import jnit.cms.hist.JnitcmshistService;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.org.JnitcmsorgService;
import jnit.cms.org.JnitcmsorgVO;
import jnit.cms.pos.JnitcmsposService;
import jnit.cms.pos.JnitcmsposVO;
import jnit.cms.rank.JnitcmsrankService;
import jnit.cms.rank.JnitcmsrankVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;

/**
 * @Class Name : JnitcmsdisseminateServiceImpl.java
 * @Description : Jnitcmsdisseminate Business Implement class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATE
 * @since 2013.11.05
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsdisseminateService")
public class JnitcmsdisseminateServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsdisseminateService {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name="jnitcmsdisseminateDAO")
    private JnitcmsdisseminateDAO jnitcmsdisseminateDAO;

    @Resource(name = "jnitcmsdisseminateService")
    private JnitcmsdisseminateService jnitcmsdisseminateService;

    @Resource(name = "jnitcmscntService")
    private JnitcmscntService jnitcmscntService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "jnitcmscntvtService")
    private JnitcmscntvtService jnitcmscntvtService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name="jnitcmstplService")
    private JnitcmstplService jnitcmstplService;

    @Resource(name = "jnitcmshistService")
    private JnitcmshistService jnitcmshistService;

    @Resource(name="jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name="jnitcmsmbrtypeService")
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;

    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

    @Resource(name = "jnitcmsdisseminatehistoryService")
    private JnitcmsdisseminatehistoryService jnitcmsdisseminatehistoryService;

    @Resource(name = "jnitcmsorgService")
    private JnitcmsorgService jnitcmsorgService;

    @Resource(name = "jnitcmsrankService")
    private JnitcmsrankService jnitcmsrankService;

    @Resource(name = "jnitcmsposService")
    private JnitcmsposService jnitcmsposService;

    /** ID Generation */
    @Resource(name="jnitCMSDISSEMINATEIdGnrService")
    private EgovIdGnrService egovIdGnrService;

    public static final String realPath = EgovProperties.getProperty("Globals.REAL.PATH");

	/**
	 * jnitcmsdisseminate을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {

    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setDisseminateId(id);

    	jnitcmsdisseminateDAO.insertJnitcmsdisseminate(vo);
    	//TODO 해당 테이블 정보에 맞게 수정
        return id;
    }

    /**
	 * jnitcmsdisseminate을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        jnitcmsdisseminateDAO.updateJnitcmsdisseminate(vo);
    }

    /**
	 * jnitcmsdisseminate을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateNextdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        jnitcmsdisseminateDAO.updateNextdisseminate(vo);
    }

    /**
	 * jnitcmsdisseminate을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    public void deleteJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        jnitcmsdisseminateDAO.deleteJnitcmsdisseminate(vo);
    }

    /**
	 * jnitcmsdisseminate을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 조회한 jnitcmsdisseminate
	 * @exception Exception
	 */
    public JnitcmsdisseminateVO selectJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        JnitcmsdisseminateVO resultVO = jnitcmsdisseminateDAO.selectJnitcmsdisseminate(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitcmsdisseminate을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 조회한 jnitcmsdisseminate
	 * @exception Exception
	 */
    public JnitcmsdisseminateVO selectdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        JnitcmsdisseminateVO resultVO = jnitcmsdisseminateDAO.selectdisseminate(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitcmsdisseminate 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsdisseminateList(JnitcmsdisseminateDefaultVO searchVO) throws Exception {
        return jnitcmsdisseminateDAO.selectJnitcmsdisseminateList(searchVO);
    }

    /**
	 * jnitcmsdisseminate a jnitcmsmbr b 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 목록
	 * @exception Exception
	 */
    public List<?> selectdisseminateList(JnitcmsdisseminateDefaultVO searchVO) throws Exception {
        return jnitcmsdisseminateDAO.selectdisseminateList(searchVO);
    }

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    public int selectJnitcmsdisseminateListTotCnt(JnitcmsdisseminateDefaultVO searchVO) {
		return jnitcmsdisseminateDAO.selectJnitcmsdisseminateListTotCnt(searchVO);
	}

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    public int selectdisseminateListTotCnt(JnitcmsdisseminateDefaultVO searchVO) {
		return jnitcmsdisseminateDAO.selectdisseminateListTotCnt(searchVO);
	}

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    public int maxTotCnt(JnitcmsdisseminateDefaultVO searchVO) {
		return jnitcmsdisseminateDAO.maxTotCnt(searchVO);
	}

    /**
     * jnitcmsdisseminate 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsdisseminate() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();

    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);

        return egovIdGnrStrategy.makeId( (String)jnitcmsdisseminateDAO.getLastIdJnitcmsdisseminate() );
    }

    
    /**
     * 예약저장된 컨텐츠를 정해진 시간에 돌려 업데이트 한다.
     * @param void
     * @exception Exception
     */
    public void cronDisseminate()throws Exception{
    	Date date = new Date();
    	long time = date.getTime();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	String toDay = dateFormat.format(time);
    	Date toDate = dateFormat.parse(toDay);
    	JnitcmsdisseminateDefaultVO searchVO = new JnitcmsdisseminateDefaultVO();
    	searchVO.setToDay(toDate);
    	searchVO.setSearchCondition("4");
    	searchVO.setPageYn("N");
    	List cntList = jnitcmsdisseminateService.selectJnitcmsdisseminateList(searchVO);
    	if(cntList.size() > 0){
    		Iterator cntIterator = cntList.iterator();
        	for(int i=0; i<cntList.size(); i++){
        		EgovMap cntEgovMap = (EgovMap) cntIterator.next();
        		String cntId = String.valueOf(cntEgovMap.get("cntId"));
        		String menuId = String.valueOf(cntEgovMap.get("menuId"));
        		String siteId = String.valueOf(cntEgovMap.get("siteId"));

        		Properties props = new Properties();

        		JnitcmssiteVO siteVO = new JnitcmssiteVO();
        		siteVO.setSiteId(siteId);
        		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

        		JnitcmscntvtVO jnitcmscntvtVO = new JnitcmscntvtVO();
        		jnitcmscntvtVO.setCntId(cntId);
        		jnitcmscntvtVO.setSiteId(siteId);
        		jnitcmscntvtVO = jnitcmscntvtService.selectJnitcmscntvt(jnitcmscntvtVO);

        		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
        		menuVO.setMenuId(menuId);
        		menuVO.setSiteId(siteId);
        		menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);

        		JnitcmsmenuVO pmenuVO = new JnitcmsmenuVO();
        		pmenuVO.setMenuId(menuVO.getPid());
        		pmenuVO.setSiteId(siteId);
        		pmenuVO = jnitcmsmenuService.selectJnitcmsmenu(pmenuVO);

        		if(cntWriteDissmeniate(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, "Y")){
        			String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
        			String encodeDirName = EgovFileScrty.encode(dirName);

        			String encodeCtxRoot = realPath+
        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/"+encodeDirName+".jsp";

        			File encodeCtxFile = new File(encodeCtxRoot);
        			if(encodeCtxFile.exists()){
        				String str = CmsHandler.readFile(encodeCtxRoot);

        				String ctxRoot = realPath+
        				jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";

        				CmsHandler.writeFile(ctxRoot, str);

        				File ctxFile = new File(ctxRoot);
        				if(ctxFile.exists()){
        					String bakDir = realPath+
        					jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/bak";

        					File bakDirFile = new File(bakDir);
        					if(!bakDirFile.exists()){
        						bakDirFile.mkdirs();
        					}

        					String bakRoot = bakDir+"/index_bak.jsp";

        					String bak_str = CmsHandler.readFile(ctxRoot);

        					CmsHandler.writeCronFile(bakRoot, bak_str);

        					//상태처리
        					JnitcmsdisseminateVO disseminateVO = new JnitcmsdisseminateVO();
        					disseminateVO.setCntId(cntId);
        					disseminateVO = jnitcmsdisseminateService.selectJnitcmsdisseminate(disseminateVO);

        					disseminateVO.setDisseminateId(disseminateVO.getDisseminateId());
        					disseminateVO.setContentConfirm(1);
        					disseminateVO.setDisseminateConfirm(1);

        					jnitcmsdisseminateService.updateJnitcmsdisseminate(disseminateVO);

        				}
        			}
        		}
        	}
    	}
    }
    /**
     * 컨텐츠를 파일을 생성한다. 
     * @exception Exception
     */
    public boolean cntWriteDissmeniate(Properties props, JnitcmscntvtVO jnitcmscntvtVO, JnitcmssiteVO siteVO, JnitcmsmenuVO pmenuVO,JnitcmsmenuVO menuVO,String indexGet )throws Exception{

    	String pCid = "";
        String vCid = "";

        if(pmenuVO.getCntId() != null) {
        	pCid = pmenuVO.getCntId();
        }

        if(menuVO.getCntId() != null) {
        	vCid = menuVO.getCntId();
        }

        boolean isDefaultPage = false;
        if(pCid.equals(vCid)) {
        	// 기본페이지
        	isDefaultPage = true;
        }
        String makDir = realPath+
        (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());

        File makDirFile = new File(makDir);
        if(!makDirFile.exists()){
        	makDirFile.mkdirs();
        }

        String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
        String encodeDirName = EgovFileScrty.encode(dirName);

		String cntFile = realPath
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) +"/"+encodeDirName+".jsp";

    	CmsHandler cmsHdr = new CmsHandler(cntFile, jnitcmscntvtVO.getTplId());
    	cmsHdr.setSiteDir("/"+ siteVO.getSitePath());
		String tempContent = "";
		tempContent = jnitcmscntvtVO.getCntSrc();




		String admMbrId = NullUtil.nullString(menuVO.getAdmMbrId());
		HashMap<String, String> admMbrIdMap = new HashMap<String, String>();
		HashMap<String, String> admMap = new HashMap<String, String>();
		HashMap<String, String> admTelMap = new HashMap<String, String>();

		if(!admMbrId.equals("")) {
    		String[] admId = admMbrId.split(",");
    		for(int i=0; i<admId.length; i++){
    			admMbrIdMap.put(Integer.toString(i), admId[i]);
    		}


    		//담당자 1지정
			JnitcmsmbrVO mbrVO1 = new JnitcmsmbrVO();
			if(admMbrIdMap.get("0") != null){
				mbrVO1.setMbrId(admMbrIdMap.get("0"));
				try {
					mbrVO1 = jnitcmsmbrService.selectJnitcmsmbr(mbrVO1);
				} catch (Exception e) {

				}
				if(mbrVO1.getMbrId() != null){
					String mbrNm = NullUtil.nullString(mbrVO1.getMbrNm());
					String mbrTel = NullUtil.nullString(mbrVO1.getTel());
					String orgNm = "";
					String posNm = "";
					String rankNm = "";
					String adm01 = "";

					//부서
					String orgId = NullUtil.nullString(mbrVO1.getOrgId());
					JnitcmsorgVO orgVO = new JnitcmsorgVO();
					orgVO.setOrgId(orgId);
					try {
						orgVO = jnitcmsorgService.selectJnitcmsorg(orgVO);
					} catch (Exception e) {

					}
					if(orgVO.getOrgId() != null){
						orgNm = NullUtil.nullString(orgVO.getOrgNm());
					}

					//팀
					String rankId = NullUtil.nullString(mbrVO1.getRankId());
					JnitcmsrankVO rankVO = new JnitcmsrankVO();
					rankVO.setRankId(rankId);
					try {
						rankVO = jnitcmsrankService.selectJnitcmsrank(rankVO);
					} catch (Exception e) {

					}
					if(rankVO.getRankId() != null){
						rankNm = NullUtil.nullString(rankVO.getRankName());
					}

					//직급
					String posId = NullUtil.nullString(mbrVO1.getPosId());
					JnitcmsposVO posVO = new JnitcmsposVO();
					posVO.setPosId(posId);
					try {
						posVO = jnitcmsposService.selectJnitcmspos(posVO);
					} catch (Exception e) {

					}
					if(posVO.getPosId() != null){
						posNm = NullUtil.nullString(posVO.getPosNm());
					}


					if(!orgNm.equals("")){
	    				adm01 = orgNm+" "+mbrNm;
	    			}else{
	    				adm01 = mbrNm;
	    			}

					admMap.put("0", adm01);
					admTelMap.put("0", mbrTel);
				}
			}

			//담당자 2지정
			JnitcmsmbrVO mbrVO2 = new JnitcmsmbrVO();
			if(admMbrIdMap.get("1") != null){
				mbrVO2.setMbrId(admMbrIdMap.get("1"));
				try {
					mbrVO2 = jnitcmsmbrService.selectJnitcmsmbr(mbrVO2);
				} catch (Exception e) {

				}
				if(mbrVO2.getMbrId() != null){
					String mbrNm = NullUtil.nullString(mbrVO2.getMbrNm());
					String mbrTel = NullUtil.nullString(mbrVO2.getTel());
					String orgNm = "";
					String posNm = "";
					String rankNm = "";
					String adm02 = "";

					//부서
					String orgId = NullUtil.nullString(mbrVO2.getOrgId());
					JnitcmsorgVO orgVO = new JnitcmsorgVO();
					orgVO.setOrgId(orgId);
					try {
						orgVO = jnitcmsorgService.selectJnitcmsorg(orgVO);
					} catch (Exception e) {

					}
					if(orgVO.getOrgId() != null){
						orgNm = NullUtil.nullString(orgVO.getOrgNm());
					}

					//팀
					String rankId = NullUtil.nullString(mbrVO2.getRankId());
					JnitcmsrankVO rankVO = new JnitcmsrankVO();
					rankVO.setRankId(rankId);
					try {
						rankVO = jnitcmsrankService.selectJnitcmsrank(rankVO);
					} catch (Exception e) {

					}
					if(rankVO.getRankId() != null){
						rankNm = NullUtil.nullString(rankVO.getRankName());
					}

					//직급
					String posId = NullUtil.nullString(mbrVO2.getPosId());
					JnitcmsposVO posVO = new JnitcmsposVO();
					posVO.setPosId(posId);
					try {
						posVO = jnitcmsposService.selectJnitcmspos(posVO);
					} catch (Exception e) {

					}
					if(posVO.getPosId() != null){
						posNm = NullUtil.nullString(posVO.getPosNm());
					}

					if(!orgNm.equals("")){
	    				adm02 = orgNm+" "+mbrNm;
	    			}else{
	    				adm02 = mbrNm;
	    			}

					admMap.put("1", adm02);
					admTelMap.put("1", mbrTel);
				}
			}
    	}

		//수정일
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String cntModified = format.format(menuVO.getModified());

		//로봇검색여부
		int robotYn = menuVO.getRobotYn();

		// 페이지 Property 세팅
    	props.setProperty("siteId", NullUtil.nullString(jnitcmscntvtVO.getSiteId()));
    	props.setProperty("menuId", NullUtil.nullString(jnitcmscntvtVO.getMenuId()));
    	props.setProperty("cntId", NullUtil.nullString(jnitcmscntvtVO.getCntId()));
    	props.setProperty("tplId", NullUtil.nullString(jnitcmscntvtVO.getTplId()));

    	//담당자1
    	props.setProperty("admId", admMbrIdMap.get("0") == null ? "" : admMbrIdMap.get("0"));
    	props.setProperty("admNm", admMap.get("0") == null ? "" : admMap.get("0"));
    	props.setProperty("admTel", admTelMap.get("0") == null ? "" : admTelMap.get("0"));

    	//담당자2
    	props.setProperty("admId2", admMbrIdMap.get("1") == null ? "" : admMbrIdMap.get("1"));
    	props.setProperty("admNm2", admMap.get("1") == null ? "" : admMap.get("1"));
    	props.setProperty("admTel2", admTelMap.get("1") == null ? "" : admTelMap.get("1"));

    	//수정일
    	props.setProperty("cntModified", cntModified);

    	//로봇검색 여부
    	props.setProperty("robotYn", Integer.toString(robotYn));

    	cmsHdr.addPatchCode("SITEID", "<%=cmsClientProperty.siteId%>");
    	cmsHdr.addPatchCode("MENUID", "<%=cmsClientProperty.menuId%>");
    	cmsHdr.addPatchCode("CNTID", "<%=cmsClientProperty.cntId%>");
    	cmsHdr.addPatchCode("TPLID", "<%=cmsClientProperty.tplId%>");

		// 페이지 타이틀 키워드 치환
		String pageTitleKeyword = "";
		if(isDefaultPage == true) {
			pageTitleKeyword = pmenuVO.getMenuNm();
		}else {
			pageTitleKeyword = menuVO.getMenuNm();
		}
		props.setProperty("pageTitle", pageTitleKeyword);
		//log.debug("tempContent : " + tempContent);
		tempContent = tempContent.replaceAll("\\{\\-PAGETITLE\\-\\}", pageTitleKeyword);
		cmsHdr.addPatchCode("PAGETITLE", "<%=cmsClientProperty.pageTitle%>");

		// 페이지 CCL
		String pageCcl = "";
		if(isDefaultPage == true) {
			pageCcl = pmenuVO.getCcl();
		}else {
			pageCcl = menuVO.getCcl();
		}
		props.setProperty("pageCcl", pageCcl);

		cmsHdr.addPatchCode("PAGECCL", "<%=cmsClientProperty.pageCcl%>");

		// 페이지 이미지 타이틀 치환
		if(menuVO.getMenuImgUrl() != null && !menuVO.getMenuImgUrl().equals("")) {
			// 이미지 타이틀
			pageTitleKeyword = "<img src='"+menuVO.getMenuImgUrl()+"' border='0' alt='"+menuVO.getMenuNm()+"' />";
		}
		props.setProperty("pageImgTitle", pageTitleKeyword);
		//tempContent = tempContent.replaceAll("\\{\\-PAGEIMGTITLE\\-\\}", pageTitleKeyword);
		cmsHdr.addPatchCode("PAGEIMGTITLE", "<%=cmsClientProperty.pageImgTitle%>");


		// 페이지 네비
		String menuNames = "";
		if(isDefaultPage == true) {
			menuNames = (String)jnitcmsmenuService.makeMenuNames(pmenuVO, "Home");
		}else {
			menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, "Home");
		}
		props.setProperty("pageNav", menuNames);
		//tempContent = tempContent.replaceAll("\\{\\-PAGENAV\\-\\}", menuNames);
		cmsHdr.addPatchCode("PAGENAV", "<%=cmsClientProperty.pageNav%>");


		// 페이지 링크 네비
		String menuLinkNames = "";
		if(isDefaultPage == true) {
			menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(pmenuVO, "Home", siteVO.getSitePath());
		}else {
			menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(menuVO, "Home", siteVO.getSitePath());
		}
		props.setProperty("pageLinkNav", menuLinkNames);
		//tempContent = tempContent.replaceAll("\\{\\-PAGELINKNAV\\-\\}", menuLinkNames);
		cmsHdr.addPatchCode("PAGELINKNAV", "<%=cmsClientProperty.pageLinkNav%>");

		// 페이지 네비 타이틀
		String menuNavTitle = "";
		//CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");

		if(isDefaultPage == true) {
			menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(pmenuVO, siteVO.getSiteNm(), siteVO.getSitePath());
		}else {
			menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(menuVO, siteVO.getSiteNm(), siteVO.getSitePath());
		}
    	props.setProperty("pageNavTitle", menuNavTitle);
    	tempContent = tempContent.replaceAll("\\{\\-PAGENAVTITLE\\-\\}", menuNavTitle);
    	cmsHdr.addPatchCode("PAGENAVTITLE","<%=cmsClientProperty.pageNavTitle%>");

		// 페이지 CNT_ID 를 Hash로 제공
		String pageIdHash = "";
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] bip = md.digest( jnitcmscntvtVO.getCntId().getBytes() );
		for(int i=0; i<bip.length; i++) {
			pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
		}
		props.setProperty("pageCode", pageIdHash);
		//tempContent = tempContent.replaceAll("\\{\\-PAGECODE\\-\\}", pageIdHash);
		cmsHdr.addPatchCode("PAGECODE", "<%=cmsClientProperty.pageCode%>");

		// index get 유무
		if(!indexGet.equals("")){
			props.setProperty("indexGet", indexGet);
		}

        // File 저장
        cmsHdr.setFileHeader("<% response.setHeader(\"Cache-Control\",\"no-store\"); response.setHeader(\"Pragma\",\"no-cache\"); response.setDateHeader(\"Expires\",0); if (request.getProtocol().equals(\"HTTP/1.1\")) { response.setHeader(\"Cache-Control\", \"no-cache\"); } %><%@ page contentType=\"text/html; charset=utf-8\" %><%@ include file='/_common/header.jsp' %>");
        cmsHdr.setContentHeader("<% /*<!-- [-CONTENT-] -->*/ %>");
        cmsHdr.setContentFooter("<% /*<!-- /[-CONTENT-] -->*/ %>");
        cmsHdr.setContent(jnitcmscntvtVO.getCntSrc());
        cmsHdr.saveContent();

        props.setProperty("pageHash", cmsHdr.getPageHash());
        // File.props 저장
        String propsFile = realPath
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/index.jsp.prop";

        try {
        	FileOutputStream outStream = new FileOutputStream(propsFile);
        	props.store(outStream,jnitcmscntvtVO.getMenuId()+" (by Jnitcms 3.5)");
        	if(outStream != null){
        		outStream.close();
        	}
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.getMessage());
			return false;
		}
    	return true;
    }
}
