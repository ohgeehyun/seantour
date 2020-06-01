package jnit.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 웹상에서 다운로드 작업을 수행하는 유틸리티
 *
 * @author 양동호
 *
 */
public class DownloadUtil {
  private static final Logger LOGGER = LoggerFactory.getLogger(DownloadUtil.class);

  /** 다운로드 버퍼 크기 */
  private static final int BUFFER_SIZE = 8192; // 8kb

  /** 문자 인코딩 */
  private static final String CHARSET = "euc-kr";

  /**
   * 생성자 - 객체 생성 불가
   */
  private DownloadUtil() {
    // do nothing;
  }

  /**
   * 지정된 파일을 다운로드 한다.
   *
   * @param request
   * @param response
   * @param file
   *            다운로드할 파일
   *
   * @throws ServletException
   * @throws IOException
   */
  public static void download(HttpServletRequest request, HttpServletResponse response, File file, String viewFileName)
      throws ServletException, IOException {

    String mimetype = request.getSession().getServletContext().getMimeType(file.getName());

    if (file == null || !file.exists() || file.length() <= 0 || file.isDirectory()) {
      throw new IOException("파일 객체가 Null 혹은 존재하지 않거나 길이가 0, 혹은 파일이 아닌 디렉토리이다.");
    }

    InputStream is = null;

    try {
      is = new FileInputStream(file);
      download(request, response, is, file.getName(), file.length(), mimetype, viewFileName);
    } catch (IOException e){
    	LOGGER.error(StringUtil.getlogText(e));
    }catch(Exception e){
    	LOGGER.error(StringUtil.getlogText(e));
    } finally {
      try {
        is.close();
      } catch (IOException e){
    	  LOGGER.error(StringUtil.getlogText(e));
      } catch (Exception ex) {
    	  LOGGER.error(StringUtil.getlogText(ex));
      }
    }
  }

  /**
   * 지정된 파일을 다운로드 한다.
   *
   * @param request
   * @param response
   * @param file
   *            다운로드할 파일
   *
   * @throws ServletException
   * @throws IOException
   */
  public static void download(HttpServletRequest request, HttpServletResponse response, List<File> files, List<String> viewFileName)
      throws ServletException, IOException {

    try {
      downloadFiles(request, response, files, viewFileName);
    } catch (IOException e){
    	LOGGER.error(StringUtil.getlogText(e));
    }catch(Exception e){
    	LOGGER.error(StringUtil.getlogText(e));
    } finally {
      try {
      } catch (NullPointerException e){
    	  LOGGER.error(StringUtil.getlogText(e));
      } catch (Exception ex) {
    	  LOGGER.error(StringUtil.getlogText(ex));
      }
    }
  }

  /**
   * 해당 입력 스트림으로부터 오는 데이터를 다운로드 한다.
   *
   * @param request
   * @param response
   * @param is
   *            입력 스트림
   * @param filename
   *            파일 이름
   * @param filesize
   *            파일 크기
   * @param mimetype
   *            MIME 타입 지정
   * @throws ServletException
   * @throws IOException
   */
  public static void downloadFiles(HttpServletRequest request, HttpServletResponse response, List<File> files, List<String> viewFileName)
      throws ServletException, IOException {

    // Set the response type and specify the boundary string
    response.setContentType("multipart/x-mixed-replace;boundary=END");

    // Set the content type based on the file type you need to download
    String contentType = "Content-type: text/rtf";

    ServletOutputStream out = response.getOutputStream();

    // Print the boundary string
    out.println();
    out.println("--END");

    for (int i=0; i<files.size(); i++){
      File file = files.get(i);

      // Get the file
      FileInputStream fis = null;
      try {
        fis = new FileInputStream(file);

      } catch (FileNotFoundException fnfe) {
        // If the file does not exists, continue with the next file
        LOGGER.error("Couldfind file " + file.getAbsolutePath());
        continue;
      }

      BufferedInputStream fif = new BufferedInputStream(fis);

      // Print the content type
      String userAgent = request.getHeader("User-Agent");
      if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    	  response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(viewFileName.get(i), "UTF-8") + ";");
      } else if (userAgent != null && userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
    	  response.setHeader("Content-Disposition", "attachment; filename="
          + java.net.URLEncoder.encode(viewFileName.get(i), "UTF-8") + ";");
      } else { // 모질라나 오페라
    	  response.setHeader("Content-Disposition", "attachment; filename="
          + new String(viewFileName.get(i).getBytes(CHARSET), "latin1") + ";");
      }

      LOGGER.error("Sending " + file.getName());

      // Write the contents of the file
      int data = 0;
      while ((data = fif.read()) != -1) {
        out.write(data);
      }
      fif.close();

      // Print the boundary string
      out.println();
      out.println("--END");
      out.flush();
      LOGGER.error("Finisheding file " + file.getName());
    }

    // Print the ending boundary string
    out.println("--END--");
    out.flush();
    out.close();
  }

  /**
   * 해당 입력 스트림으로부터 오는 데이터를 다운로드 한다.
   *
   * @param request
   * @param response
   * @param is
   *            입력 스트림
   * @param filename
   *            파일 이름
   * @param filesize
   *            파일 크기
   * @param mimetype
   *            MIME 타입 지정
   * @throws ServletException
   * @throws IOException
   */
  public static void download(HttpServletRequest request, HttpServletResponse response, InputStream is,
      String filename, long filesize, String mimetype, String viewFileName) throws ServletException, IOException {
    String mime = mimetype;

    if (mimetype == null || mimetype.length() == 0) {
      mime = "application/octet-stream;";
    }

    byte[] buffer = new byte[BUFFER_SIZE];

    response.setContentType(mime + "; charset=" + CHARSET);

    // 아래 부분에서 euc-kr 을 utf-8 로 바꾸거나 URLEncoding을 안하거나 등의 테스트를
    // 해서 한글이 정상적으로 다운로드 되는 것으로 지정한다.
    String userAgent = request.getHeader("User-Agent");

    // attachment; 가 붙으면 IE의 경우 무조건 다운로드창이 뜬다. 상황에 따라 써야한다.
    if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
      response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(viewFileName, "UTF-8") + ";");
    } else if (userAgent != null && userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
      response.setHeader("Content-Disposition", "attachment; filename="
          + java.net.URLEncoder.encode(viewFileName, "UTF-8") + ";");
    } else { // 모질라나 오페라
      response.setHeader("Content-Disposition", "attachment; filename="
          + new String(viewFileName.getBytes(CHARSET), "latin1") + ";");
    }

    // 파일 사이즈가 정확하지 않을때는 아예 지정하지 않는다.
    if (filesize > 0) {
      response.setHeader("Content-Length", "" + filesize);
    }

    BufferedInputStream fin = null;
    BufferedOutputStream outs = null;

    try {
      fin = new BufferedInputStream(is);
      outs = new BufferedOutputStream(response.getOutputStream());
      int read = 0;

      while ((read = fin.read(buffer)) != -1) {
        outs.write(buffer, 0, read);
      }
    } catch (IOException ex) {
        // Tomcat ClientAbortException을 잡아서 무시하도록 처리해주는게 좋다.
    	LOGGER.error("exception1");
    	LOGGER.error(StringUtil.getlogText(ex));
    } finally {
      try {
    	outs.flush();
        outs.close();
      } catch (IOException e){
    	  LOGGER.error("exception2");
      	LOGGER.error(StringUtil.getlogText(e));
      } catch (Exception ex1) {
    	LOGGER.error("exception2");
    	LOGGER.error(StringUtil.getlogText(ex1));
      }

      try {
        fin.close();
      } catch (IOException e){
    	  LOGGER.error("exception3");
      	LOGGER.error(StringUtil.getlogText(e));
      } catch (Exception ex2) {
    	LOGGER.error("exception3");
    	LOGGER.error(StringUtil.getlogText(ex2));
      }
    } // end of try/catch
  }

}