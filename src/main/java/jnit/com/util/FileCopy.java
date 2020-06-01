/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import jnit.cms.CmsPageViewController;
import jnit.cms.handler.CmsHandler;
import jnit.cms.menu.JnitcmsmenuController;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sun.star.io.IOException;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;

public class FileCopy {
	
	public static Log log = LogFactory.getLog(FileCopy.class);
	
	public static String type;
	private final static String deDug = EgovProperties.getProperty("Globals.Debug"); 
	public static void copyDirectory(File sourceLocation , File targetLocation) throws IOException, java.io.IOException {
	    
		//소스가 디렉토리인 경우
		// --> 해당 디렉토리의 모든 파일을 타겟 디렉토리에 복사
		if (sourceLocation.isDirectory()) {
		    if (!targetLocation.exists()) {
		        targetLocation.mkdirs();
		    }
		   
			String[] children = sourceLocation.list();
			if(children == null) children = new String[0];
		    for (int i=0; i<children.length; i++) {
				copyDirectory(new File(sourceLocation, children[i]),new File(targetLocation, children[i]));
		    }
		} else {// 소스가 파일 인경우 --> 해당 파일을 타겟 디렉토리로 이동
			if("exists".equals(type)){	
				if(!targetLocation.exists()){
					InputStream in = new FileInputStream(sourceLocation);
				    OutputStream out = new FileOutputStream(targetLocation);
				    
				    // Copy the bits from instream to outstream
			        byte[] buf = new byte[1024];
			        int len;
					while ((len = in.read(buf)) > 0) {
			            out.write(buf, 0, len);
			        }
					JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, targetLocation);		//Filego 배포
					 if(in != null){
			        	in.close();
					 }
					 if(out != null){
			        	out.close();
					 }
				}
			}else{
				InputStream in = new FileInputStream(sourceLocation);
			    OutputStream out = new FileOutputStream(targetLocation);
			    
			    // Copy the bits from instream to outstream
				byte[] buf = new byte[1024];
				int len;				
		    	while ((len = in.read(buf)) > 0) {
		            out.write(buf, 0, len);
		        }
		    	JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, targetLocation);		//Filego 배포
		    	 if(in != null){
		        	in.close();
		    	 }
		    	 if(out != null){
		        	out.close();
		    	 }
		    }
	    }
	}
	
	public static void copyDirectoryReplace(File sourceLocation , File targetLocation, String replaceNm) throws IOException, java.io.IOException {
        
        //소스가 디렉토리인 경우
        // --> 해당 디렉토리의 모든 파일을 타겟 디렉토리에 복사
	    if (sourceLocation.isDirectory()) {
	        if (!targetLocation.exists()) {
	            targetLocation.mkdir();
	        }
	        
	        String[] children = sourceLocation.list();
	        if(children == null) children = new String[0];
	        for (int i=0; i<children.length; i++) {
	        	copyDirectoryReplace(new File(sourceLocation, children[i]),
        					  new File(targetLocation, children[i].replace("siteNm", replaceNm)),
        					  replaceNm
        		);
	        }
	    } 
	    // 소스가 파일 인경우 --> 해당 파일을 타겟 디렉토리로 이동
	    else {

	        InputStream in = new FileInputStream(sourceLocation);
	        OutputStream out = new FileOutputStream(targetLocation);
	        
	        // Copy the bits from instream to outstream
	        byte[] buf = new byte[1024];
	        int len;
	        while ((len = in.read(buf)) > 0) {
	            out.write(buf, 0, len);
	        }
	        JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, targetLocation);		//Filego 배포
	        if(in != null){
	        	in.close();
	        }
	        if(out != null){
	        	out.close();
	        }
	    }
    }
	
	public static void deleteFolder(String parentPath) {
	    File file = new File(parentPath);
	    String[] fnameList = file.list();
	    if(fnameList == null) fnameList = new String[0];
	    int fCnt = fnameList.length;
	    String childPath = "";
	    
	    for(int i = 0; i < fCnt; i++) {
	      childPath = parentPath+"/"+fnameList[i];
	      File f = new File(childPath);
	      if( ! f.isDirectory()) {
	        f.delete();   //파일이면 바로 삭제
	      }
	      else {
	        deleteFolder(childPath);
	        JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, file);		//Filego 배포
	      }
	    }
	    
	    File f = new File(parentPath);
	    f.delete();   //폴더는 맨 나중에 삭제
	    
	  }
	
	public static List<String> getDirectoryNm(String filePath){
		
		List<String> result = new ArrayList<String>();
		
		String path = filePath;
		File file = new File(path);
		File isDirectory = new File("");
		
		try{
			File[] list = file.listFiles();
			if(list == null) list = new File[0];
			
			for(int i=0; i<list.length; i++){
				String fullName = list[i].toString();
				isDirectory = new File(fullName);
				if(fullName.indexOf(".svn") == -1 && isDirectory.isDirectory()){
					String fileName = fullName.replace("\\", "/").split("/")[fullName.replace("\\", "/").split("/").length-1];
					String filterName = fileName;
					
					if(fileName.indexOf(".") != -1){
						filterName = fileName.substring(0,fileName.lastIndexOf("."));
					}
					result.add(filterName);
				}
			}
		} catch (NullPointerException e){
			if("true".equals(deDug)) log.debug("Err. FilePath Problem");
			log.error(e.getMessage());
			result = null;
		}catch(Exception e){
			if("true".equals(deDug)) log.debug("Err. FilePath Problem");
			log.error(e.getMessage());
			result = null;
		}
		return result;
	}
	
	public static List<String> getFileNm(String filePath){
		
		List result = new ArrayList();
		
		String path = filePath;
		File file = new File(path);
		File isFile = new File("");
		
		try{
			/* 2014-07-14 by.나성재 수정 파일이름 가져오는 부분처리를 바꿈
			File[] list = file.listFiles();
			
			for(int i=0; i<list.length; i++){
				String fullName = list[i].toString();
				isFile = new File(fullName);
				if(fullName.indexOf(".svn") == -1 && isFile.isFile()){
					String fileName = fullName.replace("\\", "/").split("/")[fullName.replace("\\", "/").split("/").length-1];
					String filterName = fileName;
					
					if(fileName.indexOf(".") != -1){
						filterName = fileName.substring(0,fileName.lastIndexOf("."));
					}
					result.add(filterName);
				}
			}
			*/
			if(file.exists()){
				FilenameFilter filenameFilter = new FilenameFilter() {					
					public boolean accept(File dir, String name) {
			
						if(!".svn".equals(name)){
							return true;
						}else{
							return false;
						}
					}
				};
				String[] list = file.list(filenameFilter);
				for(int i=0; i<list.length; i++){
					result.add(list[i]);
				}
			}
		} catch (NullPointerException e){
			if("true".equals(deDug)) log.debug("Err. FilePath Problem");
			log.error(e.getMessage());
			result = null;
		}catch(Exception e){
			if("true".equals(deDug)) log.debug("Err. FilePath Problem");
			log.error(e.getMessage());
			result = null;
		}
		return result;
	}
	
	/**
	 * 지정된 샘플파일 생성
	 * @param defaultPath - /jnit/cms/menu
	 * @param target - 폴더명
	 * @param depth
	 * @return Boolean
	 * @throws Exception
	 * {@link JnitcmsmenuController#getTopMenu}
	 * {@link CmsPageViewController#fileView}
	 */
	public static Boolean makeTopMenuSampleFile(String defaultPath, String target, String depth)throws Exception{
		try {
			String topmenuDir = defaultPath+"/topmenu";
			File topmenu = new File(topmenuDir);
			FilenameFilter filenameFilter = new FilenameFilter() {
				public boolean accept(File dir, String name) {
					if(!".svn".equals(name)){
						return true;
					}else{
						return false;
					}
				}
			};
			String[] targetList = topmenu.list(filenameFilter);
			if(targetList == null) targetList = new String[0];
			
			target = "".equals(NullUtil.nullString(target)) ? (targetList.length == 0 ? "sample": targetList[0])  : target ;
			depth = "".equals(NullUtil.nullString(depth)) ? "1" : depth;
			
	    	String targetFileDir = defaultPath+"/topmenu/"+target+"/"+depth;
	    	String sampleDir = defaultPath+"/topmenu_sample/"+depth;
	    	File targetFile = new File(targetFileDir);
	    	if(!targetFile.exists()) targetFile.mkdirs();
	    	
	    	String fileDir =  targetFileDir+"/"+target+"_topMenu.jsp";
	    	isFileExists(fileDir, CmsHandler.readFile(sampleDir+"/siteNm_topMenu.jsp"));
	    	
	    	String filecodeDir = targetFileDir+"/"+target+"_topMenu_code.jsp";
	    	isFileExists(filecodeDir, CmsHandler.readFile(sampleDir+"/siteNm_topMenu_code.jsp"));
	    	
	    	String siteNmDir = targetFileDir+"/siteNm_topMenu.jsp";
	    	String siteNmCodeDir = targetFileDir+"/siteNm_topMenu_code.jsp";
	    	
	    	File smapleFile = new File(siteNmDir);
	    	if(smapleFile.exists()){
	    		File file = new File(fileDir);
	    		smapleFile.renameTo(file);
	    	}
	    	
	    	File smapleCodeFile = new File(siteNmCodeDir);
	    	if(smapleCodeFile.exists()){
	    		File file = new File(filecodeDir);
	    		smapleCodeFile.renameTo(file);
	    	}
		} catch (java.io.IOException e){
			log.error(e.getMessage());
			return false;
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}
		return true;
	}
	
	public static List<String> getFileNmReplace(String filePath, String replaceNm){
		
		List<String> result = new ArrayList<String>();
		
		String path = filePath;
		File file = new File(path);
		
		try{
			File[] list = file.listFiles();
			if(list == null) list = new File[0];
			for(int i=0; i<list.length; i++){
				String fullName = list[i].toString();
				String fileName = fullName.split("\\\\")[fullName.split("\\\\").length-1];
				String filterName = fileName;
				
				if(fileName.indexOf(".") != -1){
					filterName = fileName.substring(0,fileName.lastIndexOf("."));
				}
				result.add(filterName.replace(replaceNm, ""));
			}
		} catch (NullPointerException e){
			if("true".equals(deDug)) log.debug("Err. FilePath Problem");
			//log.error(e.getMessage());
			result = null;
		}catch(Exception e){
			if("true".equals(deDug)) log.debug("Err. FilePath Problem");
			//log.error(e.getMessage());
			result = null;
		}
		return result;
	}
	
	
	public static boolean makeFileDepth(String path, int depth){

		boolean result = true;
		path = path.replace("\\", "/");
		String[] split = path.split("/");
		String mkFilePath = "";
		int count = (split.length+1) - depth;
		File mkFile = null;
		
		for(int i=0; i<depth; i++, count++){
			mkFilePath = "";
			for(int j=0; j<count; j++){
				mkFilePath += "/" + split[j];
			}
			mkFilePath = mkFilePath.replaceFirst("/", "");
			mkFile = new File(mkFilePath);
			if(!mkFile.exists()){
				mkFile.mkdir();
				result = false;
			}
		}
		
		return result;
		
	}
	
	public static boolean ValidateFileDepth(String path, int depth){

		boolean result = true;
		path = path.replace("\\", "/");
		String[] split = path.split("/");
		String mkFilePath = "";
		int count = (split.length+1) - depth;
		File mkFile = null;
		
		for(int i=0; i<depth; i++, count++){
			mkFilePath = "";
			for(int j=0; j<count; j++){
				mkFilePath += "/" + split[j];
			}
			mkFilePath = mkFilePath.replaceFirst("/", "");
			mkFile = new File(mkFilePath);
			if(!mkFile.exists()){
				result = false;
			}
		}
		
		return result;
		
	}
	
	/**
     * 해당경로에 파일있는지 체크한다.
     * @param where - 지정경로
     * @param src - 문자열
     * @throws Exception
     * {@link CmsPageViewController#allimSkinModelMap}
     * {@link CmsPageViewController#fileSave}
     */
    public static void isFileExists(String where, String src)throws Exception{    	
		File file = new File(where);
		if(!file.exists()){			
			CmsHandler.writeFile(where, src);
		}
    }
    
    public static void copyTargetExcludeDirectory(File sourceLocation , File targetLocation, String excludeLocation) throws IOException, java.io.IOException {
        
		//소스가 디렉토리인 경우
		// --> 해당 디렉토리의 모든 파일을 타겟 디렉토리에 복사
		if (sourceLocation.isDirectory()) {
		    if (!targetLocation.exists()) {
		        targetLocation.mkdir();
		        JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, targetLocation);		//Filego 배포
		    }
			String[] children = sourceLocation.list();
			if(children == null) children = new String[0];
		    for (int i=0; i<children.length; i++) {
		    	if(!(sourceLocation.getPath().replace("\\", "/")+"/"+children[i]).equals(excludeLocation)){
		    		copyTargetExcludeDirectory(new File(sourceLocation, children[i]),new File(targetLocation, children[i]), excludeLocation);
		    	}
		    }
		} else {// 소스가 파일 인경우 --> 해당 파일을 타겟 디렉토리로 이동
			if("exists".equals(type)){
				if(!targetLocation.exists()){
					InputStream in = new FileInputStream(sourceLocation);
				    OutputStream out = new FileOutputStream(targetLocation);
				    
				    // Copy the bits from instream to outstream
			        byte[] buf = new byte[1024];
			        int len;
					while ((len = in.read(buf)) > 0) {
			            out.write(buf, 0, len);
			        }
					JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, targetLocation);		//Filego 배포
			        if(in != null){
			        	in.close();
			        }
			        if(out != null){
			        	out.close();
			        }
				}
			}else{
				InputStream in = new FileInputStream(sourceLocation);
			    OutputStream out = new FileOutputStream(targetLocation);
			    
			    // Copy the bits from instream to outstream
				byte[] buf = new byte[1024];
				int len;
		    	while ((len = in.read(buf)) > 0) {
		            out.write(buf, 0, len);
		        }
		    	JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, targetLocation);		//Filego 배포
		    	 if(in != null){
		        	in.close();
		         }
		    	 if(out != null){
		        	out.close();
		    	 }
		    }
	    }
    }
}
