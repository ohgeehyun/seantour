/**
 * @version 3.2.0.1
 */

package jnit.cms.mbrpackage;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.DBType;

public class MbrpackageUtil {

	public static Log log = LogFactory.getLog(MbrpackageUtil.class);
	
	final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
	/**
	 * @param vo
	 * @return 쿼리문을 반환한다
	 */
	public static String getMbrpackageQuery(JnitcmsmbrpackageVO vo){
		
		String and = " AND ";
		String or = " OR ";
		String equal = " = ";
		String not = " != ";
		String open = " ( ";
		String close = " ) ";
		String mbrLogin = " MBR_LOGIN ";
		String mbrId = " MBR_ID ";
		String orgId = " ORG_ID ";
		String posId = " POS_ID ";
		String typeId = " TYPE_ID ";
		String firstWhere = " WHERE 1 = 1 ";
		String select = " SELECT * FROM ";
		String mbrTable = " JNITCMSMBR ";
		String aliasA = " A ";
		String aliasB = " B ";
		String aliasC = " C ";
		String aliasD = " D ";
		String aliasE = " E ";
		
    	String query = "";
		
		String mbrAccess = NullUtil.nullString(vo.getMbrAccess());
		String mbrDeny = NullUtil.nullString(vo.getMbrDeny());
		
		String orgAccess = NullUtil.nullString(vo.getOrgAccess());
		String orgDeny = NullUtil.nullString(vo.getOrgDeny());
		
		String posAccess = NullUtil.nullString(vo.getPosAccess());
		String posDeny = NullUtil.nullString(vo.getPosDeny());
		
		String typeAccess = NullUtil.nullString(vo.getTypeAccess());
		String typeDeny = NullUtil.nullString(vo.getTypeDeny());
		
		String baseWhere = "";
		String mbrWhere = "";
		String orgWhere = "";
		String posWhere = "";
		String typeWhere = "";
		
		if(mbrAccess.equals("") && mbrDeny.equals("") && orgAccess.equals("") && orgDeny.equals("") && posAccess.equals("") && posDeny.equals("") && typeAccess.equals("") && typeDeny.equals("")){
			if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				query = "SELECT 'Y' AS RESULT FROM DUAL";
			}else if(DBType.getDbTypeBoolean("cubrid")){
				query = "SELECT 'Y' AS RESULT";
			}else if(DBType.getDbTypeBoolean("mysql")){
				query = "SELECT 'Y' AS RESULT";
			}
			
			return query;
		}
	
		/** BASE_SELECT */
		baseWhere = select + mbrTable + firstWhere + and + mbrId + equal + "'" + "[mbrLogin]" + "'";
		
		/** MBR_SELECT */
		mbrWhere = select + open + baseWhere + close + aliasA + firstWhere;

		if(!mbrDeny.equals("")){
			
			if(mbrDeny.indexOf(",") != -1){
				
				String[] split = mbrDeny.split(",");
				for(int i=0; i<split.length; i++){
					mbrWhere += and + mbrLogin + not + "'" + split[i] + "'";
				}
				
			}else{
				mbrWhere += and + mbrLogin + not + "'" + mbrDeny + "'";
			}
		}
		
		if(!mbrAccess.equals("")){
			
			if(mbrAccess.indexOf(",") != -1){
				
				String[] split = mbrAccess.split(",");
				for(int i=0; i<split.length; i++){
					if(i == 0 && mbrDeny.equals("")){
						mbrWhere += and + mbrLogin + equal + "'" + split[i] + "'";
					}else{
						mbrWhere += or + mbrLogin + equal + "'" + split[i] + "'";
					}
				}
			}else{
				if(mbrDeny.equals("")){
					mbrWhere += and + mbrLogin + equal + "'" + mbrAccess + "'";
				}else{
					mbrWhere += or + mbrLogin + equal + "'" + mbrAccess + "'";
				}
			}
		}
		
		/** ORG_SELECT */
		orgWhere = select + open + mbrWhere + close + aliasB + firstWhere;
		
		if(!orgDeny.equals("")){
			
			if(orgDeny.indexOf(",") != -1){
				
				String[] split = orgDeny.split(",");
				for(int i=0; i<split.length; i++){
					orgWhere += and + orgId + not + "'" + split[i] + "'";
				}
				
			}else{
				orgWhere += and + orgId + not + "'" + orgDeny + "'";
			}
		}
		
		if(!orgAccess.equals("")){
			
			if(orgAccess.indexOf(",") != -1){
				
				String[] split = orgAccess.split(",");
				for(int i=0; i<split.length; i++){
					if(i == 0 && orgDeny.equals("")){
						orgWhere += and + orgId + equal + "'" + split[i] + "'";
					}else {
						orgWhere += or + orgId + equal + "'" + split[i] + "'";
					}
				}
				
			}else{
				if(orgDeny.equals("")){
					orgWhere += and + orgId + equal + "'" + orgAccess + "'";
				}else{
					orgWhere += or + orgId + equal + "'" + orgAccess + "'";
				}
			}
		}
		
		/** POS_SELECT */
		posWhere = select + open + orgWhere + close + aliasC + firstWhere;
		
		if(!posDeny.equals("")){
			
			if(posDeny.indexOf(",") != -1){
				
				String[] split = posDeny.split(",");
				for(int i=0; i<split.length; i++){
					posWhere += and + posId + not + "'" + split[i] + "'";
				}
				
			}else{
				posWhere += and + posId + not + "'" + posDeny + "'";
			}
		}
		
		if(!posAccess.equals("")){
			
			if(posAccess.indexOf(",") != -1){
				
				String[] split = posAccess.split(",");
				for(int i=0; i<split.length; i++){
					if(i == 0 && posDeny.equals("")){
						posWhere += and + posId + equal + "'" + split[i] + "'";
					}else{
						posWhere += or + posId + equal + "'" + split[i] + "'";
					}
				}
				
			}else{
				if(posDeny.equals("")){
					posWhere += and + posId + equal + "'" + posAccess + "'";
				}else{
					posWhere += or + posId + equal + "'" + posAccess + "'";
				}
			}
		}
		
		/** TYPE_SELECT */
		typeWhere = select + open + posWhere + close + aliasD + firstWhere;
		
		if(!typeDeny.equals("")){
			
			if(typeDeny.indexOf(",") != -1){
				
				String[] split = typeDeny.split(",");
				for(int i=0; i<split.length; i++){
					typeWhere += and + typeId + not + "'" + split[i] + "'";
				}
				
			}else{
				typeWhere += and + typeId + not + "'" + typeDeny + "'";
			}
		}

		if(!typeAccess.equals("")){
			
			if(typeAccess.indexOf(",") != -1){
				
				String[] split = typeAccess.split(",");
				for(int i=0; i<split.length; i++){
					if(i == 0 && typeDeny.equals("")){
						typeWhere += and + typeId + equal + "'" + split[i] + "'";
					}else{
						typeWhere += or + typeId + equal + "'" + split[i] + "'";
					}
				}
				
			}else{
				if(typeDeny.equals("")){
					typeWhere += and + typeId + equal + "'" + typeAccess + "'";
				}else{
					typeWhere += or + typeId + equal + "'" + typeAccess + "'";
				}
			}
		}
		
		query = typeWhere;
		
		if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
			query = "SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS RESULT FROM ( " + typeWhere + ")" + aliasE;
		}else if(DBType.getDbTypeBoolean("cubrid")){
			query = "SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS RESULT FROM ( " + typeWhere + ")" + aliasE;
		}else if(DBType.getDbTypeBoolean("mysql")){
			query = "SELECT IF(COUNT(*) < 1, 'N', 'Y') AS RESULT FROM ( " + typeWhere + ")" + aliasE;
		}
    	
		return query;
	}
	
	/**
	 * @param mbrpackageId(고유값 ex : PACK_00001)
	 * @return 해당 회원이 패키지에 포함되어있으면 'Y' 아니면 'N'
	 * @throws Exception
	 */
	public static String getMbrpackageResult(String mbrpackageId) throws Exception{
		
		String result = "";
		String query = "";
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		JnitcmsmbrpackageService jnitcmsmbrpackageService = (JnitcmsmbrpackageService) wContext.getBean("jnitcmsmbrpackageService");
		
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		
		if(mbrVO == null){
			result = "N";
		}else{
			JnitcmsmbrpackageVO packVO = new JnitcmsmbrpackageVO();
			packVO.setPackId(mbrpackageId);
			
			try{
				String mbrId = NullUtil.nullString(mbrVO.getMbrId());	
				packVO = jnitcmsmbrpackageService.selectJnitcmsmbrpackage(packVO);
				query = packVO.getQuery().replace("[mbrLogin]", mbrId);
				result = jnitcmsmbrpackageService.selectJnitcmsmbrpackageQuery(query);
			} catch (NullPointerException e){
				if("true".equals(deDug)) log.debug("Err. mbrpackgeUtil getQuery TryCatch");
				log.error(e.getMessage());
				result = "N";
			}catch(Exception e){
				if("true".equals(deDug)) log.debug("Err. mbrpackgeUtil getQuery TryCatch");
				log.error(e.getMessage());
				result = "N";
			}
		}
		return result;
	}
	
	/**
	 * 회원 패키지 쿼리문에 str 값이 있는지 체크한다.
	 * @param mbrpackageId - 패키지 번호
	 * @param str - 찾을 문자열
	 * @return Boolean ( 존재하면 true 아니면 false )
	 * @throws Exception
	 */
	public static Boolean getMbrpackageExist(String mbrpackageId, String str)throws Exception{
		mbrpackageId = NullUtil.nullString(mbrpackageId);
		str = NullUtil.nullString(str);
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		
		JnitcmsmbrpackageService jnitcmsmbrpackageService = (JnitcmsmbrpackageService) wContext.getBean("jnitcmsmbrpackageService");
		
		JnitcmsmbrpackageVO packageVO = new JnitcmsmbrpackageVO();
		packageVO.setPackId(mbrpackageId);
		try {
			packageVO = jnitcmsmbrpackageService.selectJnitcmsmbrpackage(packageVO);
			if(packageVO.getQuery().indexOf(str) > -1) return true;
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return false;
	}
}
