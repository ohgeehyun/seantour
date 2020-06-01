/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.Reader;
import java.io.StringWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.abdera.Abdera;
import org.apache.abdera.factory.Factory;
import org.apache.abdera.model.Entry;
import org.apache.abdera.model.Feed;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.board.cmt.JnitboardcmtService;
import jnit.board.db.JnitboarddbDefaultVO;
import jnit.board.db.JnitboarddbService;
import jnit.board.file.JnitboardfileService;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.handler.CmsClientProperty;
import jnit.cms.handler.CmsProperty;
import jnit.com.util.DBType;
import jnit.db.JnitdbService;
import oracle.sql.CLOB;

@Controller
public class JnitboardRssController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitboardcmtService")
	private JnitboardcmtService jnitboardcmtService;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;

	@Resource(name = "jnitdbService")
	private JnitdbService dbService;	
	
	@Resource(name = "cmsProperty")
    private CmsProperty cmsProperty;
	
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_INFO_PATH = "board" + SEPERATOR + "_info" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    public static final String debug = EgovProperties.getProperty("Globals.Debug");
   
	@RequestMapping(value = "/board/rss.do")
	public String board(
			@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest oriRequest,
			ModelMap model)
	throws Exception {
		
		CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
		try{
			if(debug.equals("true")) log.debug("=================================== Board Debug ============================");
			if(debug.equals("true")) log.debug("cmsClientProperty.multipartRequest:"+ cmsClientProperty.multipartRequest );
			if(debug.equals("true")) log.debug("sess id : "+ oriRequest.getRequestedSessionId() );
			if(debug.equals("true")) log.debug("cmsClientProperty : "+ cmsClientProperty );
			if(debug.equals("true")) log.debug("cmsClientProperty Title : "+ cmsClientProperty.pageTitle );
			if(debug.equals("true")) log.debug("org request : "+ oriRequest );
			if(debug.equals("true")) log.debug("session cmsClientProperty : "+ oriRequest.getSession().getAttribute("cmsClientProperty") );
			//if(debug.equals("true")) log.debug("sess id multipart : "+ cmsClientProperty.multipartRequest.get(oriRequest.getRequestedSessionId()) );
			if(debug.equals("true")) log.debug("sess id multipartsingle : "+ (HttpServletRequest)oriRequest.getSession().getAttribute("multipart") );
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}
		HttpServletRequest request = (oriRequest.getSession().getAttribute("multipart") != null ? (HttpServletRequest)oriRequest.getSession().getAttribute("multipart") : oriRequest);
		
		String mode = request.getParameter("mode") == null ? "list" : request.getParameter("mode");
		String[] modes = mode.split(",");
		mode = modes[0];
		
		if("fed".equals(mode)){
			String proc = request.getParameter("proc") == null ? "rss" : request.getParameter("proc");
			String result = makeXml(request, boardId, proc);
			model.addAttribute("xml",result);
			return "jnit/util/xml";
		}
		
		return "jnit/board/board";
	}
	
	private String makeXml(HttpServletRequest request, String boardId, String proc) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		String yearStr = sdfYear.format(new java.util.Date());

		int maxEntry = NullUtil.nullInt(NullUtil.nullString(request.getParameter("max-entry")));
		maxEntry = (maxEntry == 0) ? 100 : maxEntry;
		int page = NullUtil.nullInt(NullUtil.nullString(request.getParameter("page")));
		page = (page == 0) ? 1 : page;

		String siteName = "";
		String siteUrl = "";

		
		JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
		searchVO.setRecordCountPerPage(maxEntry);
		searchVO.setFirstIndex(0);
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setCurrentPageNo(page);
		pageInfo.setRecordCountPerPage(maxEntry);
		
		StringWriter sw = new StringWriter();
		sw.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		
		Abdera abdera = new Abdera();
		Factory factory = abdera.getFactory();
		    
		Entry entry = factory.newEntry();
		Feed feed = abdera.newFeed();
		
	    
		/**
		 * 특정 채널의 문서 목록
		 */
			JnitboardinfoVO boardVO = new JnitboardinfoVO();
			boardVO.setBoardId(boardId);
			boardVO = infoService.selectJnitboardinfo(boardVO);
			
			JnitboarddbDefaultVO boardSearchVO = new JnitboarddbDefaultVO();
			boardSearchVO.setBoardId(boardId);
			boardSearchVO.setWithContent("1");
			boardSearchVO.setRecordCountPerPage(pageInfo.getRecordCountPerPage());
			boardSearchVO.setFirstIndex(pageInfo.getFirstRecordIndex());
			boardSearchVO.setLastIndex(pageInfo.getLastRecordIndex());
			
			Element root = new Element("rss");
			Attribute version = new Attribute("version", "2.0");
		    //Attribute xmlns = new Attribute("xmlns:dc", "http://purl.org/dc/elements/1.1/");
			root.setAttribute(version);
			
			String url = request.getRequestURL().toString();
			url = url.substring(0,url.indexOf("/", 8));
			Element channel = new Element("channel");
		    Element title = new Element("title");
		    title.setText(boardVO.getBoardTitle());
		    Element link = new Element("link");
		    link.setText(url + "/board/board.do?boardId="+boardId+"&mode=list");
		    Element description = new Element("description");
		    description.setText(boardVO.getBoardTitle()+" board list");
		    Element language = new Element("language");
		    language.setText("ko");
		    channel.addContent(title);
		    channel.addContent(link);
		    channel.addContent(description);
		    channel.addContent(language);  
		    
			
			feed.setTitle(boardVO.getBoardTitle());
			feed.addLink(url + "/board/board.do?boardId="+boardId+"&mode=list", "self");
			//feed.addLink("http://" + siteUrl + "/api/syndication/echo.do?id=tag:" + siteUrl + ","+yearStr+":" + dtype + ":" + channelId+ "&amp;type=" + type, "self");
			
			feed.setUpdated(sdf.format(new java.util.Date()));
			
			List boardList = jnitboarddbService.selectList(boardSearchVO);
			Iterator<EgovMap> itr = boardList.iterator();
			while(itr.hasNext()){
				Entry boardEntry = feed.addEntry();
				EgovMap entryMap = itr.next();
				
				Element item = new Element("item");
				Element ititle = new Element("title");
				String entryId = String.valueOf(entryMap.get("id"));
				String entryWriter = String.valueOf(entryMap.get("writer"));
				String entryTitle = String.valueOf(entryMap.get("title"));
				String entryContent = StringUtil.removeHtml(String.valueOf(entryMap.get("content")));
				DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
				Date entryPublished = sdfDate.parse(String.valueOf(entryMap.get("created")));
				Date entryUpdated = sdfDate.parse(String.valueOf(entryMap.get("modified")));
				
				
			 	ititle.setText(entryTitle);
			    Element ilink = new Element("link");
			    ilink.setText(url + "/board/board.do?boardId="+boardId+"&mode=view&cntId=" + entryId);
			    Element idescription = new Element("description");
				if(DBType.getDbTypeBoolean("oracle")){
					CLOB content = (CLOB) entryMap.get("content");				
					if(content != null){
						StringBuffer sb = new StringBuffer();				
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);
							
							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						entryContent = StringUtil.removeHtml(sb.toString());
					}
				}else if(DBType.getDbTypeBoolean("tibero")){
					com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) entryMap.get("content");				
					if(content != null){
						StringBuffer sb = new StringBuffer();				
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);
							
							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						entryContent = StringUtil.removeHtml(sb.toString());
					}
				}
			    
			    idescription.setText(entryContent);
			    Element writer = new Element("writer");
			    writer.setText(entryWriter);

			    Element pubDate = new Element("pubDate");
			    pubDate.setText(sdf.format(entryPublished));
			    
			    item.addContent(ititle);
			    item.addContent(writer);
			    item.addContent(ilink);
			    item.addContent(idescription);
			    item.addContent(pubDate);
			    
			    channel.addContent(item);
				
				boardEntry.addAuthor(entryWriter);
				boardEntry.setTitle(entryTitle);
				boardEntry.setContentAsHtml(entryContent);
				boardEntry.setPublished(entryPublished);
				boardEntry.setUpdated(entryUpdated);
				
				boardEntry.addLink(url + "/board/board.do?boardId="+boardId+"&mode=view&cntId=" + entryId, "alternative");
				

				/*
				boardEntry.addLink("http://" + siteUrl + boardVO.getPageUrl() + "?mode=view&cntId=" + entryId, "alternative");
				boardEntry.addLink("tag:" + siteUrl + "," + yearStr + ":article:" + channelId + "-" + entryId, "channel");
				boardEntry.addLink("http://" + siteUrl + boardVO.getPageUrl(), "channel-alternative");
				 */
				
				
			}
			
			feed.writeTo(sw);
			
			
		    root.setContent(channel);
		    Document doc = new Document();
		    doc.setRootElement(root);  
		    XMLOutputter outputter = new XMLOutputter();  
		      Format f = outputter.getFormat();
		      f.setEncoding("utf-8");
		      f.setIndent(" ");
		      f.setLineSeparator("\r\n");
		      f.setTextMode(Format.TextMode.TRIM);
		      outputter.setFormat(f);
		      FileWriter writer;
		      /*
		      String upPath = BOARD_UPLOAD_PATH+SEPERATOR+boardId+".xml";
		      try {
		    	    writer = new FileWriter(upPath);
		    	    outputter.output(doc, writer);
		    	    log.debug("write?");
		    	    writer.close();  
		    	   } catch (IOException e) {
		    		   log.debug("error?");
		    	    // TODO Auto-generated catch block
		    	    log.error(e.getMessage());
		    	   }
		       */
		    if(proc.equals("rss")){
		    	return outputter.outputString(doc);	
			}else if(proc.equals("atom")){
				return sw.toString();
			}
		    return "";
	}

}