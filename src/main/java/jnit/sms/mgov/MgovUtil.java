/**
 * @version 3.2.0.1
 */
package jnit.sms.mgov;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.terracotta.agent.repkg.de.schlichtherle.io.FileInputStream;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;

public class MgovUtil {

	public static Log log = LogFactory.getLog(MgovUtil.class);
	
	/** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    private static final int BUFFER_SIZE = 8192;
	
	/* upload function */
    public static void uploadFormWorkFiles(String where, HttpServletRequest request) throws Exception {
    	
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
	
		final Map<String, MultipartFile> files = mptRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
		    MultipartFile mFile = entry.getValue(); // mptRequest.getFile((String)fileIter.next());
	
		    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();
	
		    String tmp = mFile.getOriginalFilename();
	
	            if (tmp.lastIndexOf("\\") >= 0) {
	        	tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
	            }
	
	            vo.setFileName(tmp);
	            vo.setSize(mFile.getSize());
	
	            if (tmp.lastIndexOf(".") >= 0) {
	       	 	vo.setPhysicalName(vo.getPhysicalName() + tmp.substring(tmp.lastIndexOf(".")));
	            }
	
	            if (mFile.getSize() > 0) {
	            	saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where)));
	            }
		}
    }
    
    public static long saveFile(InputStream is, File file) throws IOException {
    	// 디렉토리 생성
    	File parentFile = file.getParentFile();
    	if (parentFile != null && ! parentFile.exists()) {
    		parentFile.mkdirs();
    	}

    	OutputStream os = null;
    	long size = 0L;

    	try {
    	    os = new FileOutputStream(file);

    	    int bytesRead = 0;
    	    byte[] buffer = new byte[BUFFER_SIZE];

    	    while ((bytesRead = is.read(buffer, 0, BUFFER_SIZE)) != -1) {
    		size += bytesRead;
    		os.write(buffer, 0, bytesRead);
    	    }
    	} finally {
    	    if (os != null) {
    		os.close();
    	    }
    	}

    	return size;
    }
    
    public static HashMap<String,List<String>> fileToMap(String path) throws FileNotFoundException, IOException{
    	List<String> nameList = new ArrayList<String>();
    	List<String> phoneList = new ArrayList<String>();
    	
    	HashMap<String,List<String>> resultMap = new HashMap<String,List<String>>();
    	File filePath = new File(path);
    	FileInputStream fis = null;
    	try {
    		fis = new FileInputStream(filePath);
        	XSSFWorkbook workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt(0);
        	
        	int rows = sheet.getPhysicalNumberOfRows();
        	int cells = sheet.getRow(0).getPhysicalNumberOfCells();
        	
        	String value = "";
        	
        	if(rows >= 2){
        		for(int i=1; i<rows; i++){
        			XSSFRow row = sheet.getRow(i);
        			if(row != null || !"".equals(row.getCell(0).getStringCellValue())){
        				for(int c=0; c<cells; c++){
        					XSSFCell cell = row.getCell(c);
        					if(cell != null){
    							switch(cell.getCellType()){
    							case XSSFCell.CELL_TYPE_FORMULA:
    	                            value=cell.getCellFormula();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_NUMERIC:
    	                            value=""+cell.getNumericCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_STRING:
    	                            value=""+cell.getStringCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_BLANK:
    	                            value=""+cell.getBooleanCellValue();
    	                            //value="";
    	                            break;
    	                        case XSSFCell.CELL_TYPE_ERROR:
    	                            value=""+cell.getErrorCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_BOOLEAN:
    	                        	value=""+cell.getBooleanCellValue();
    	                        	break;
    	                        default:
    							}
        					}
        					if(c == 0){
        						nameList.add(value);
        					}else if(c == 1){
        						phoneList.add(value);
        					}
        				}
        			}
        		}
        	}
    	} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			if(fis != null){
				fis.close();
			}
		}
    	
    	resultMap.put("nameList", nameList);
    	resultMap.put("phoneList", phoneList);
    	return resultMap;
    }
    
}
