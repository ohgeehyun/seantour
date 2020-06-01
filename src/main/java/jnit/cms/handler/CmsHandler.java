/**
 * @version 3.2.0.1
 */
package jnit.cms.handler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Set;

import jnit.cms.tpl.JnitcmstplVO;
import jnit.cms.tpl.tplUtil;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;

public class CmsHandler {
	
	private Log log = LogFactory.getLog(getClass());
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
	String tplId = "";
	String pagePath = "";
	String srcContent = "";
	String dstContent = "";
	String splitContentS = "";
	String splitContentE = "";
	String siteDir = "";
	
	String fileHeader = "";
	
	String contentHeader = "";
	String contentFooter = "";
	String pageHash = "";
	String splitHashS = "";
	String splitHashE = "";
	static String sitePath = "";
	static JnitcmstplVO jnitcmstplVO;
	
	HashMap<String, String> patchCodes;
	
	public CmsHandler(String pagePath, String tplId) {
		this.tplId = tplId;
		this.pagePath = pagePath;
		
		this.patchCodes = new HashMap<String,String>();
	}
	
	public void viewReport() {
		if("true".equals(deDug)){
			log.debug("--- srcContent ---");
			log.debug(this.srcContent);
			log.debug("//---");
			
			log.debug("--- dstContent ---");
			log.debug(this.dstContent);
			log.debug("//---");
			
			log.debug("--- splitContentS ---");
			log.debug(this.splitContentS);
			log.debug("//---");
			
			log.debug("--- splitContentE ---");
			log.debug(this.splitContentE);
			log.debug("//---");
			
			log.debug("--- pageHash ---");
			log.debug(this.pageHash);
			log.debug("//---");
			
			log.debug("--- splitHashS ---");
			log.debug(this.splitHashS);
			log.debug("//---");
			
			log.debug("--- splitHashE ---");
			log.debug(this.splitHashE);
			log.debug("//---");
		}
	}
	
	public String getFileHeader() {
		return fileHeader;
	}

	public JnitcmstplVO getJnitcmstplVO() {
		return jnitcmstplVO;
	}
	
	public void setJnitcmstplVO(JnitcmstplVO jnitcmstplVO) {
		this.jnitcmstplVO = jnitcmstplVO;
	}

	public String getSitePath() {
		return sitePath;
	}	
	public void setSitePath(String sitePath) {
		this.sitePath = sitePath;
	}

	public void addPatchCode(String code, String data) {
		this.patchCodes.put(code, data);
	}
	
	public HashMap<String, String> getPatchCodes() {
		return this.patchCodes;
	}
	
	public void setSiteDir(String siteDir) {
		this.siteDir = siteDir;
	}
	
	public void setContent(String content) {
		this.srcContent = content;
	}

	public void setFileHeader(String fileHeader) {
		this.fileHeader = fileHeader;
	}
	
	public void setContentHeader(String contentHeader) {
		this.contentHeader = contentHeader;
	}
	
	public void setContentFooter(String contentFooter) {
		this.contentFooter = contentFooter;
	}
	
	public String getPageHash() {		
		return this.pageHash;
	}
	
	public String getSiteDir() {
		return this.siteDir;
	}
	
	public String[] getSplitHash() {
		String[] hashes = {this.splitHashS, this.splitHashE};
		
		return hashes;
	}
	
	private void dispatch() {
		Set<String> codes = this.patchCodes.keySet();
		Object[] keys = codes.toArray();
		
		this.dstContent = this.srcContent;
		for(int i=0; i<keys.length; i++) {
			this.dstContent = this.dstContent.replaceAll("\\{\\-"+((String)keys[i]).trim()+"\\-\\}", this.patchCodes.get(((String)keys[i]).trim()));
		}
	}
	
	private void reverse() {
		Set<String> codes = this.patchCodes.keySet();
		Object[] keys = codes.toArray();
		
		this.dstContent = this.srcContent;
		
		if(!this.contentHeader.equals("")) {
			String[] tmpContents = this.dstContent.split(this.contentHeader);
			
			if(tmpContents.length < 2) {
				this.dstContent = "";
			}else {
				this.dstContent = tmpContents[1];
			}
		}
		if(!this.contentFooter.equals("")) {
			this.dstContent = this.dstContent.split(this.contentFooter)[0];
		}
		
		for(int i=0; i<keys.length; i++) {
			this.dstContent = this.dstContent.replaceAll(this.patchCodes.get(((String)keys[i]).trim()), "\\{\\-"+((String)keys[i]).trim()+"\\-\\}");
		}
		
		if(!this.fileHeader.equals("")) this.dstContent = this.dstContent.replaceAll(this.fileHeader, "");
		try {
			this.dstContent = replaceFileHeader(this.dstContent);
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	public String getContent() {
		this.dispatch();
		
		return this.dstContent;
	}
	
	public String getReverseContent() {
		this.reverse();
		
		return this.dstContent;
	}
		
	public String[] getSplitContent(String splitCode) {
		this.dispatch();
		
		return this.dstContent.split("\\{\\-"+splitCode+"\\-\\}");
	}
	
	public boolean saveContent() throws IOException, NoSuchAlgorithmException {
		String page = this.getContent();
		
        String tplFileS = this.pagePath;

        String pageContent = "";
        
        pageContent += this.fileHeader;        
        if(!NullUtil.nullString(this.tplId).equals("")) {
        	pageContent += "<%@ include file='"+this.siteDir+"/_tpls/B/"+tplId.trim()+"_S.jsp' %>";
        }
        pageContent += this.contentHeader;
        pageContent += page.trim();
        pageContent += this.contentFooter;
        if(!NullUtil.nullString(this.tplId).equals("")) {
        	pageContent += "<%@ include file='"+this.siteDir+"/_tpls/B/"+tplId.trim()+"_E.jsp' %>";
        }
        this.pageHash = CmsHandler.writeFile(tplFileS, pageContent);
        
		return true;
	}
	
	public boolean loadContent() throws IOException, NoSuchAlgorithmException {
		String tplFileS = this.pagePath;
		
        File tplFileSObj = new File(tplFileS);
        if(!tplFileSObj.exists()) {
        	return false;
        }
        
		this.srcContent = CmsHandler.readFile(tplFileS);
        this.pageHash = CmsHandler.makeHash(this.srcContent);
        
		return true;
	}
	
	public boolean saveSplitContent(String splitCode) throws IOException, NoSuchAlgorithmException {
		String[] splitPage = this.getSplitContent(splitCode);

		if(splitPage.length < 2) {
			splitPage = new String[2];
			
			if(this.dstContent.indexOf("{-"+splitCode+"-}") == -1) {
				// S에 기록
				splitPage[0] = this.dstContent;
				splitPage[1] = "";
			}else if(this.dstContent.indexOf("{-"+splitCode+"-}") > 0) {
				// S에 기록
				splitPage[0] = this.dstContent.replaceAll("\\{\\-"+splitCode+"\\-\\}", "");
				splitPage[1] = "";
			}else if(this.dstContent.indexOf("{-"+splitCode+"-}") == 0) {
				// E에 기록
				splitPage[0] = "";
				splitPage[1] = this.dstContent.replaceAll("\\{\\-"+splitCode+"\\-\\}", "");
			}
		}
		
        String tplFileS = this.pagePath + this.tplId + "_S.jsp";
        String tplFileE = this.pagePath + this.tplId + "_E.jsp";
        
        try {
        	this.splitHashS = CmsHandler.writeFile(tplFileS,
        			"<%@ page contentType=\"text/html; charset=utf-8\" %>"+
        			FileHeader(this.fileHeader)+
        			splitPage[0]);
        } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {		
			log.error(e.getMessage());
		}

        this.splitHashE = CmsHandler.writeFile(tplFileE,
        		"<%@ page contentType=\"text/html; charset=utf-8\" %>"+
        		this.fileHeader+
        		splitPage[1]);
        
		return true;
	}
	
	public boolean loadSplitContent(String splitCode) throws IOException, NoSuchAlgorithmException {
        String tplFileS = this.pagePath + this.tplId + "_S.jsp";
        String tplFileE = this.pagePath + this.tplId + "_E.jsp";

        File tplFileSObj = new File(tplFileS);
        File tplFileEObj = new File(tplFileE);
        if(!tplFileSObj.exists() || !tplFileEObj.exists()) {
        	return false;
        }
        	
        //log.debug("tplFileS:"+tplFileS);
        this.splitContentS = CmsHandler.readFile(tplFileS);
        this.splitHashS = CmsHandler.makeHash(this.splitContentS);
        this.splitContentE = CmsHandler.readFile(tplFileE);
        this.splitHashE = CmsHandler.makeHash(this.splitContentE);
        
        this.srcContent = this.splitContentS + "{-" + splitCode + "-}" + this.splitContentE;
        this.pageHash = CmsHandler.makeHash(this.srcContent);
        
		return true;
	}
	
	public static String readFile(String fileName) throws IOException {
        FileInputStream fis = new FileInputStream(new File(fileName));
        InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
        
        BufferedReader in = new BufferedReader(isr);
        String strs = "";
        while(true) {
        	String str = in.readLine();
        	if(str == null) break;
        	
        	strs += str+"\r\n";
        }
        in.close();
        if(fis != null) fis.close();
        if(isr != null) isr.close();
        
        return strs;
	}
	
	public static String writeFile(String fileName, String fileContent) throws IOException, NoSuchAlgorithmException {
		
		//log.debug("writeFile : " + fileName);
		
        FileOutputStream fosS = new FileOutputStream(new File(fileName));
        OutputStreamWriter oswS = new OutputStreamWriter(fosS, "UTF-8");
        oswS.write(fileContent);
        oswS.close();
        fosS.close();
        JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, fileName);		//Filego 배포
        return CmsHandler.makeHash(fileContent);
	}
	
	public static String writeCronFile(String fileName, String fileContent) throws IOException, NoSuchAlgorithmException {
		
		//log.debug("writeFile : " + fileName);
		
        FileOutputStream fosS = new FileOutputStream(new File(fileName));
        OutputStreamWriter oswS = new OutputStreamWriter(fosS, "UTF-8");
        oswS.write(fileContent);
        oswS.close();
        fosS.close();
        JnitFilegoUtil.transferFile(JnitFilegoFileType.CRON, fileName);		//Filego 배포
        return CmsHandler.makeHash(fileContent);
	}
	
	public static String makeHash(String plainText) throws NoSuchAlgorithmException {
        String fileHash = "";
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] bip = md.digest( plainText.getBytes() );
		for(int i=0; i<bip.length; i++) {
			fileHash += Integer.toHexString((int) bip[i] & 0x000000ff);
		}
		
        return fileHash;
	}
	
	/**
	 * 템플릿 해더부분의 정규식없이 치환하여 문자열을 반환한다.
	 * @param str - 문자열
	 * @return 치환된 문자열
	 * @throws Exception
	 */
	public static String FileHeader(String str)throws Exception{
		str = NullUtil.nullString(str);
		if(!"".equals(str)){
			String keys = "{-CONFIG_SET-}";
			//추가확장
			if("O".equals(jnitcmstplVO.getTplType())){
				keys = "{-CONFIG_SET_PRINT-}";
			}
			str = tplUtil.replaceAllTpl(sitePath, jnitcmstplVO, str+keys, null);
		}
		return str;
	}
	
	/**
	 * 템플릿 헤더부분 지우고 남은 문자열을 반환
	 * @param str
	 * @return
	 * @throws Exception
	 */
	private String replaceFileHeader(String str)throws Exception{
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){
    		str = str.replace(str.substring(str.indexOf("<% /* cset_s */ %>"), str.indexOf("<% /* cset_e */ %>")+18), "");
    	}
    	return str;
    }
}
