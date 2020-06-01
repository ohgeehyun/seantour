/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jnit.rsc.page.JnitrscpageController;
import net.sf.json.JSONObject;

import org.apache.commons.collections.map.CaseInsensitiveMap;

/**
 * @Class Name : JnitcmsmenuService.java
 * @Description : Jnitcmsmenu Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.08
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmenuService {

	/**
	 * JNITCMSMENU을 등록한다.
	 * @param request
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmenu(JnitcmsmenuVO vo) throws Exception;

    /**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSelect(JnitcmsmenuVO vo) throws Exception;
    /**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmenuCopy(JnitcmsmenuVO vo) throws Exception;
    /**
	 * JNITCMSMENU을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmenu(JnitcmsmenuVO vo) throws Exception;

    /**
	 * JNITCMSMENU Method를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmenuMethod(JnitcmsmenuVO vo) throws Exception;

    /**
	 * JNITCMSMENU MenuNm을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmenuTitle(JnitcmsmenuVO vo) throws Exception;

    /**
	 * JNITCMSMENU Method을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmenuChMethod(JnitcmsmenuChMethodVO vo) throws Exception;

    /**
	 * JNITCMSMENU을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    void deleteJnitcmsmenu(JnitcmsmenuVO vo) throws Exception;

    /**
	 * JNITCMSMENU을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenuVO
	 * @return 조회한 JNITCMSMENU
	 * @see JnitrscpageController
	 * <code>{@link jnit.rsc.page.JnitrscpageController# addJnitrscpageView }</code>
	 * @exception Exception
	 */
    JnitcmsmenuVO selectJnitcmsmenu(JnitcmsmenuVO vo) throws Exception;

    /**
	 * JNITCMSMENU 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 목록
	 * @exception Exception
	 */
    List selectJnitcmsmenuList(JnitcmsmenuDefaultVO searchVO) throws Exception;

    /**
	 * JNITCMSMENU 전체 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 목록
	 * @exception Exception
	 */
    List selectJnitcmsmenuListAll(JnitcmsmenuDefaultVO searchVO) throws Exception;

    /**
	 * JNITCMSMENU 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    int selectJnitcmsmenuListTotCnt(JnitcmsmenuDefaultVO searchVO);

    /**
	 * JNITCMSMENU 다음 Method를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    int selectJnitcmsmenuNextMethod(JnitcmsmenuVO vo);

    /**
	 * JNITCMSMENU Max Method를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    int selectJnitcmsmenuMaxMethod(JnitcmsmenuVO vo);

    /**
     * JNITCMSMENU 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmenu() throws Exception;

    /**
     * 메뉴경로를 생성한다. 생성 후 경로 리턴
     * @param vo
     * @param sitePath
     * @return 생성한 경로
     * @throws Exception
     */
	String makeMenuDirectory(JnitcmsmenuVO vo, String sitePath, HttpServletRequest request) throws Exception;

	/**
	 * 메뉴 redirect 경로를 생성한다.
	 * @param vo
	 * @param sitePath
	 * @param request
	 * @return menuPath
	 * @throws Exception
	 */
	String makeMenuRedirect(JnitcmsmenuVO vo, String sitePath, HttpServletRequest request) throws Exception;

	/**
     * 메뉴경로명을 생성한다. 생성 후 경로명 리턴
     * @param vo
     * @param sitePath
     * @return 경로명
     * @throws Exception
     */
	String makeMenuDirectoryName(JnitcmsmenuVO vo, String sitePath) throws Exception;

    /**
     * 메뉴명 전체Depth 생성.
     * @param vo
     * @param menuPath
     * @return 메뉴명
     * @throws Exception
     */
	String makeMenuNames(JnitcmsmenuVO vo, String siteNm) throws Exception;

	/**
     * 메뉴명 전체Depth Link포함 생성.
     * @param vo
     * @param menuPath
     * @return 메뉴명
     * @throws Exception
     */
	String makeMenuLinkNames(JnitcmsmenuVO vo, String siteNm, String sitePath) throws Exception;

	/**
     * 메뉴명 전체Depth Title 생성.
     * @param vo
     * @param menuPath
     * @return 메뉴명
     * @throws Exception
     */
	String makeMenuNavTitleNames(JnitcmsmenuVO vo, String siteNm, String sitePath) throws Exception;

	/**
     * 메뉴명 전체 pid 생성.
     *
     * @param vo
     * @param menuPath
     * @param type - return 이면 역순정렬
     * @return pidList
     * @throws Exception
     */
	String makeMenuPid(JnitcmsmenuVO vo, String siteNm, String sitePath, String tyoe, HttpServletRequest request) throws Exception;

	/**
	 * 해당 메뉴의 기본 하위메뉴 Path를 생성
	 * @param vo
	 * @param defMenu
	 * @return
	 * @throws Exception
	 */
	String getDefMenuPath(JnitcmsmenuVO vo, Object defMenu) throws Exception;

	/** SITE_ID, MENU_ID GET */
	CaseInsensitiveMap getSiteAndMenuInfo(CaseInsensitiveMap cimap) throws Exception;

	/**
     * JNITCMSMENU 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    int getDuplicationCount(JnitcmsmenuVO vo) throws Exception;

    /**
     * 메뉴/콘텐츠 DB에 메뉴 복사를 실행한다.
     * @param siteId - 사이트 ID
     * @param isDepth - 현재 뎁스
     * @param addDepth - 현재 뎁스에 더할 값
     * @param JSON - 복사된 MENU_ID 를 JSON으로 이용하여 치환한다.
     * @throws Exception
     */
    public void makeMenuCopy(String siteId, int isDepth, int addDepth, net.sf.json.JSONObject JSON)throws Exception;

    /**
     * 사이트별 메뉴 실제 파일을 원하는 위치에 복사한다.
     * @param request
     * @param siteId - 사이트 ID
     * @param menuId - 현재 메뉴 ID
     * @param targetMenuId - 복사될 메뉴 ID
     * @param targetNm - 복사될 메뉴 이름
     * @return JSONObject 에러시 에러코드 반환
     * @throws Exception
     */
    public JSONObject makeMenuFileCopy(HttpServletRequest request, String siteId, String menuId, String targetMenuId, String targetNm)throws Exception;

    /**
     * 사이트별 메뉴/콘텐츠 권한을 설정하여 생성하거나 권한정보를 조회한다.
     * @param request
     * @param siteId - 사이트 ID
     * @param type - menuPremVO 컬럼
     * @param data - 비교 또는 생성될 데이터
     * @param create - 생성 여부
     * @return menuPremVO 컬럼 정보
     * @throws Exception
     */
    public String menuPremJSON(HttpServletRequest request, String siteId, String type, String data, String create)throws Exception;

    /**
     * 현재 메뉴 위치에서 상위 뎁스에 해당 컬럼 데이터 값이 있는지 확인하여 리턴한다.
     * @param vo - menuVO
     * @param type - menuVO 컬럼조건문
     * @param data - 비교할 데이터
     * @return  Boolean
     * @throws Exception
     */
    String isMenuExistsData(JnitcmsmenuVO vo, String type, String data) throws Exception;

	String insertJnitcmsmenu(JnitcmsmenuVO menuVO, String sitePath, HttpServletRequest request) throws Exception;
}
