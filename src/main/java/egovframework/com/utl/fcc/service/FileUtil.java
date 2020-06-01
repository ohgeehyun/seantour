/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class FileUtil {
	/**
	 * 해당 디렉토리에서 디렉토리 리스트 가져오기.
	 * @param f 해당 디렉토리
	 * @return
	 */
	public static List<String> getDirectoryList(File f) throws Exception{
		List<String> l = new ArrayList<String>();
		String[] fileList =  f.list();
		for(int i = 0; i < fileList.length; i++){
			if(new File(f.getAbsolutePath(),fileList[i]).isDirectory()){
				l.add(fileList[i]);
			}
		}
		return l;
	}
	
	/**
	 * 해당 디렉토리에서 파일 리스트 가져오기.
	 * @param f 해당 파일
	 * @return
	 */
	public static List<String> getFileList(File f) throws Exception{
		List<String> l = new ArrayList<String>();
		String[] fileList =  f.list();
		for(int i = 0; i < fileList.length; i++){
			if(new File(f.getAbsolutePath(),fileList[i]).isFile()){
				l.add(fileList[i]);
			}
		}
		return l;
	}
	
	/**
	 * 파일 내용 읽기
	 * @param file
	 * @return
	 */
	public static String getFileContent(File file) throws Exception{
		int b;
		StringBuffer fileContent = new StringBuffer();		
		BufferedReader buffRead = new BufferedReader(new FileReader(file));
		while ((b = buffRead.read()) != -1) {
			fileContent.append((char)b);
		}				
		buffRead.close();
		return fileContent.toString();	
	}
	/**
	 * 파일 내용 추가
	 * @param file
	 * @return
	 */
	public static void addFileContent(BufferedWriter bw,String fileFullPath,String content) throws Exception {
		bw.write(content,0,content.length());
		bw.flush();
	}
	/**
	 * 서블릿 상의 폴더 상대경로로 디렉토리 만들기.
	 * @param req
	 * @param fileFullPath 폴더 상대경로
	 * @return 폴더 서버 절대경로
	 */
	public static String makeDir(HttpServletRequest req,String folderFullPath) throws Exception{
		String str = "";
		String path = req.getSession().getServletContext().getRealPath("/") + folderFullPath;
		File dir = new File(path);
		if(!dir.exists()){
			dir.mkdirs();
		}
		str = path;
		return str;
	}
	/**
	 * 절대경로에 폴더 만들기.
	 * 
	 * @param folderFullPath 폴더 경로
	 * @return
	 * @throws Exception
	 */
	public static void makeDir(String folderFullPath) throws Exception{
		File dir = new File(folderFullPath);
		if(!dir.exists()){
			dir.mkdirs();
		}
	}
	
	
	/**
	 * 파일풀네임에서 이름과 확장자 분리.
	 * @param fileName
	 * @return
	 */
	public static String[] getSplitFileName(String fileName) {
		String[] names = new String[2];

		int pos = fileName.lastIndexOf('.');

		if (pos == -1)
		{
			names[0] = fileName;
			names[1] = "";
		}
		else
		{
			names[0] = fileName.substring(0, pos);
			names[1] = fileName.substring(pos+1);
		}

		return names;
	}
	
	/**
	 * 파일 복사
	 * @param orFile
	 * @param nextFile
	 * @return
	 */
	public static boolean fileCopy(File orFile,File nextFile) throws Exception{
		boolean bl = false;
		FileInputStream fis = null;
		FileOutputStream fos = null;
		fis = new FileInputStream(orFile);
		fos = new FileOutputStream(nextFile);
		byte[] buf = new byte[1024];
		int read = 0;
		while((read=fis.read(buf, 0, buf.length))!=-1){
			fos.write(buf,0,read);
		}
		fis.close();
		fos.close();
		bl = true;
		return bl;
	}
	
	/**
	 * 파일이 존재할 때 새 파일명 생성
	 * @param f
	 * @return
	 */
	public static File rename(File f) {

		String dirName = f.getParent();
		String[] names = getSplitFileName(f.getName());
		String baseName = names[0];
		String extName = names[1];

		int i = 1;
		if(f.exists()){
			while (f.exists()) {
				//String chnage_name = String.valueOf(System.currentTimeMillis());
				f = new File(dirName, baseName + "[" + i + "]" + extName);
				//f = new File(dirName, chnage_name + "[" + i + "]" + extName);
				i++;
			}
		}	
		return f;
	}
	/**
	 * 파일 삭제.
	 * @param req
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	public static boolean delFile(HttpServletRequest req, String filePath, String fileName) {
		boolean bl = false;
		File f = new File(req.getSession().getServletContext().getRealPath("/") + filePath, fileName);
		try{
			if(f.exists())f.delete();
			bl = true;
			f = null;
		}catch (Exception e) {
			System.out.println(e);
			f = null;
		}
		return bl;
	}
}
