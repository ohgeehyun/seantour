package jnit.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FileListUtil {

	public static Log log = LogFactory.getLog(FileListUtil.class);
	
	/**
	 * 해당 경로의 파일 목록 확인
	 * @param path
	 */
	public static List<String> FileList(String path){
		
		List<String> fileList = new ArrayList<String>();
		File file = new File(path);
		File isFile;
		String isPath = "";
		
		if(!file.exists()){
			log.error("Not exists path : " + path);
			return new ArrayList<String>();
			
		}else if(!file.isDirectory()){
			log.error("Not exists directory : " + path);
			return new ArrayList<String>();
		}else{
			String[] fileArray = file.list();
			for(String fa : fileArray){
				isPath = path+File.separator+fa;
				isFile = new File(isPath);
				if(isFile.isFile()){
					fileList.add(fa);
				}
			}
			int fileSize = fileList.size();
			if(fileSize == 0){
				fileList = null;
				log.error("Not found data");
			}
		}
		return fileList;
	}
	
	/**
	 * 해당 경로의 파일 목록 확인
	 * @param path
	 */
	public static List<String> FileList(File path){
		
		List<String> fileList = new ArrayList<String>();
		File isFile;
		String isPath = "";
		
		if(!path.exists()){
			log.error("Not exists path : " + path);
			return new ArrayList<String>();
			
		}else if(!path.isDirectory()){
			log.error("Not exists directory : " + path);
			return new ArrayList<String>();
		}else{
			String[] fileArray = path.list();
			for(String fa : fileArray){
				isPath = path+File.separator+fa;
				isFile = new File(isPath);
				if(isFile.isFile()){
					fileList.add(fa);
				}
			}
			int fileSize = fileList.size();
			if(fileSize == 0){
				fileList = new ArrayList<String>();
				log.error("Not found data");
			}
		}
		return fileList;
	}
	
	/**
	 * 해당 경로의 디렉토리 목록 확인
	 * @param path
	 */
	public static List<String> DirectoryList(String path){
		
		List<String> fileList = new ArrayList<String>();
		File file = new File(path);
		File isFile;
		String isPath = "";
		
		if(!file.exists()){
			log.error("Not exists path : " + path);
			return new ArrayList<String>();
			
		}else if(!file.isDirectory()){
			log.error("Not exists directory : " + path);
			return new ArrayList<String>();
		}else{
			String[] fileArray = file.list();
			for(String fa : fileArray){
				isPath = path+File.separator+fa;
				isFile = new File(isPath);
				if(isFile.isDirectory()){
					fileList.add(fa);
				}
			}
			int fileSize = fileList.size();
			if(fileSize == 0){
				fileList = new ArrayList<String>();
				log.error("Not found data");
			}
		}
		return fileList;
	}
	
	/**
	 * 해당 경로의 디렉토리 목록 확인
	 * @param path
	 */
	public static List<String> DirectoryList(File path){
		
		List<String> fileList = new ArrayList<String>();
		File isFile;
		String isPath = "";
		
		if(!path.exists()){
			log.error("Not exists path : " + path);
			return new ArrayList<String>();
			
		}else if(!path.isDirectory()){
			log.error("Not exists directory : " + path);
			return new ArrayList<String>();
		}else{
			String[] fileArray = path.list();
			for(String fa : fileArray){
				isPath = path+File.separator+fa;
				isFile = new File(isPath);
				if(isFile.isDirectory()){
					fileList.add(fa);
				}
			}
			int fileSize = fileList.size();
			if(fileSize == 0){
				fileList = new ArrayList<String>();
				log.error("Not found data");
			}
		}
		return fileList;
	}
	
	public static boolean getFileExists(String path){
		
		boolean exists = false;
		File file = new File(path);
		
		if(file.exists()){
			exists = true;
		}else{
			exists = false;
		}
		return exists;
	}
	
	public static boolean getFileExists(File file){
		
		boolean exists = false;
		
		if(file.exists()){
			exists = true;
		}else{
			exists = false;
		}
		return exists;
	}
	
	public static void deleteAllFiles(String direcotryPath){
		
		try{
			File[] listFile = new File(direcotryPath).listFiles();
			if(listFile == null) listFile = new File[0];
			
			if(listFile.length > 0){
				for(int i = 0 ; i < listFile.length ; i++){
					if(listFile[i].isFile()){
						listFile[i].delete(); 
					}else{
						deleteAllFiles(listFile[i].getPath());
					}
					listFile[i].delete();
				}
			}else if(listFile.length == 0){
				File deleteDirectory = new File(direcotryPath);
				deleteDirectory.delete();
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error("FileListUtil.deleteAllFiles()");
		}
	}
	
	public static void deleteAllFiles(String direcotryPath, String excludeExt){
		
		try{
			File[] listFile = new File(direcotryPath).listFiles();
			if(listFile == null) listFile = new File[0];
			
			if(listFile.length > 0){
				for(int i = 0 ; i < listFile.length ; i++){
					if(listFile[i].isFile()){
						if(listFile[i].getName().indexOf(excludeExt) == -1){
							listFile[i].delete();
						}else{
							
						}
					}else{
						deleteAllFiles(listFile[i].getPath(), excludeExt);
					}
					if(listFile[i].getName().indexOf(excludeExt) == -1){
						listFile[i].delete();
					}else{
						
					}
				}
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error("FileListUtil Error");
		}
	}
}
