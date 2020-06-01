/**
 * @version 3.2.0.1
 */
package jnit.allim.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.allim.group.JnitallimGroupService;
import jnit.allim.group.JnitallimGroupVO;
import jnit.allim.item.JnitallimItemService;
import jnit.allim.item.JnitallimItemVO;
import jnit.com.util.DBType;
import oracle.sql.CLOB;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class JnitAllimiController {
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");

	//GROUP SERVICE
	@Resource(name = "jnitallimGroupService")
    private JnitallimGroupService jnitallimGroupService;

	//ITEM SERVICE
	@Resource(name = "jnitallimItemService")
    private JnitallimItemService jnitallimItemService;

	@RequestMapping(value="/cms/allim/controllerCode.do")
	public String htmlCode(HttpServletRequest request, Model model)throws Exception{

		String groupId = NullUtil.nullString(request.getParameter("groupId"));
		String type = NullUtil.nullString(request.getParameter("type"));
		String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
		String bannerMore =  "bannerMore";
		if(!"bannerRolling".equals(groupCategory)) bannerMore = groupCategory+"_bannerMore";

		model.addAttribute("bannerMore", bannerMore);
		model.addAttribute("groupCategory", groupCategory);
		model.addAttribute("groupId", groupId);
		model.addAttribute("type", type);

		return "jnit/allim/importCode";
	}
	@RequestMapping(value="/jnitallim/JnitOpenPopup.do")
	public String openPopup(Model model, HttpServletRequest request) throws Exception{

		String itemId = NullUtil.nullString(request.getParameter("itemId"));

		JnitallimItemVO jnitallimItemVO = new JnitallimItemVO();
		jnitallimItemVO.setItemId(itemId);
		jnitallimItemVO = jnitallimItemService.selectJnitallimItem(jnitallimItemVO);

		model.addAttribute("popup",jnitallimItemVO);
		return "/jnit/allim/openPopupView";
	}

	@RequestMapping("/jnitallim/allimSkinImport.do")
	public String allimSeo(HttpServletRequest request, ModelMap model)throws Exception{

    	Enumeration<String> parameter = request.getParameterNames();
		while(parameter.hasMoreElements()){
			String param = (String) parameter.nextElement();
			String value = request.getParameter(param);
			if("true".equals(deDug)) System.out.println("ALLIM param : " + param + " / value : " + value);
		}

		String groupId = NullUtil.nullString(request.getParameter("groupId"));
		String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
		JnitallimGroupVO groupVO = new JnitallimGroupVO();
		groupVO.setSearchCondition("3");
		groupVO.setSearchKeyword(groupId);

		List grpResult = jnitallimGroupService.selectGroupList(groupVO);
		int grpResultSize = grpResult.size();

		Iterator resultIterator = grpResult.iterator();
		HashMap<String, String> itemHtmlcodeMap = new HashMap<String, String>();
		HashMap<String, String> itemAltMap = new HashMap<String, String>();

		for(int i=0; i<grpResult.size(); i++){
			EgovMap resultEgovMap = (EgovMap) resultIterator.next();
			String itemId = String.valueOf(resultEgovMap.get("itemId"));

			if(DBType.getDbTypeBoolean("cubrid") || DBType.getDbTypeBoolean("mysql")){
				String itemHtmlcode = String.valueOf(resultEgovMap.get("itemHtmlcode"));
				String itemAlt = String.valueOf(resultEgovMap.get("itemAlt"));
				if(!"null".equals(itemHtmlcode)) itemHtmlcodeMap.put(itemId, itemHtmlcode);
				itemAltMap.put(itemId, itemAlt);
			}else if(DBType.getDbTypeBoolean("oracle")){
				CLOB resultSet = (CLOB) resultEgovMap.get("itemHtmlcode");
				CLOB itemAlt = (CLOB) resultEgovMap.get("itemAlt");
				if(resultSet != null){
					StringBuilder sb = new StringBuilder();
					BufferedReader br = null;
					Reader reader = null;
					try {
				        reader = resultSet.getCharacterStream();
				        br = new BufferedReader(reader);
				        String line = "";
				        while(null != (line = br.readLine())) {
				            sb.append(line+"\r\n");
				        }

				    } catch (SQLException e) {
				        // handle this exception
				    } catch (IOException e) {
				        // handle this exception
				    }finally{
				    	if(br != null)br.close();
				    	if(reader != null)reader.close();
				    }
				    itemHtmlcodeMap.put(itemId, sb.toString());
				}

				if(itemAlt != null){
					StringBuilder sb = new StringBuilder();
					BufferedReader br = null;
					Reader reader = null;
				    try {
				        reader = itemAlt.getCharacterStream();
				        br = new BufferedReader(reader);

				        String line = "";
				        while(null != (line = br.readLine())) {
				            sb.append(line+"\r\n");
				        }
				    } catch (SQLException e) {
				        // handle this exception
				    } catch (IOException e) {
				        // handle this exception
				    }finally{
				    	if(br != null)br.close();
				    	if(reader != null)reader.close();

				    }
				    itemAltMap.put(itemId, sb.toString());
				}
			}else if(DBType.getDbTypeBoolean("tibero")){
				com.tmax.tibero.jdbc.TbClob resultSet = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("itemHtmlcode");
				com.tmax.tibero.jdbc.TbClob itemAlt = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("itemAlt");
				if(resultSet != null){
					StringBuilder sb = new StringBuilder();
					BufferedReader br = null;
					Reader reader = null;
					try {
				        reader = resultSet.getCharacterStream();
				        br = new BufferedReader(reader);
				        String line = "";
				        while(null != (line = br.readLine())) {
				            sb.append(line+"\r\n");
				        }

				    } catch (SQLException e) {
				        // handle this exception
				    } catch (IOException e) {
				        // handle this exception
				    }finally{
				    	if(br != null)br.close();
				    	if(reader != null)reader.close();
				    }
				    itemHtmlcodeMap.put(itemId, sb.toString());
				}

				if(itemAlt != null){
					StringBuilder sb = new StringBuilder();
					BufferedReader br = null;
					Reader reader = null;
				    try {
				        reader = itemAlt.getCharacterStream();
				        br = new BufferedReader(reader);

				        String line = "";
				        while(null != (line = br.readLine())) {
				            sb.append(line+"\r\n");
				        }
				    } catch (SQLException e) {
				        // handle this exception
				    } catch (IOException e) {
				        // handle this exception
				    }finally{
				    	if(br != null)br.close();
				    	if(reader != null)reader.close();

				    }
				    itemAltMap.put(itemId, sb.toString());
				}
			}
		}

		JnitallimGroupVO grpVO = new JnitallimGroupVO();
		grpVO.setGroupId(groupId);
		JnitallimGroupVO grpValue = jnitallimGroupService.selectJnitallimGroup(grpVO);

		model.addAttribute("itemAltMap", itemAltMap);
		model.addAttribute("itemHtmlcodeMap", itemHtmlcodeMap);
		model.addAttribute("groupId", groupId);
		model.addAttribute("grpResultSize", grpResultSize);
		model.addAttribute("grpValue", grpValue);
		model.addAttribute("grpResult", grpResult);
		model.addAttribute("DBType", DBType.getDbTypeString());
		if(!groupCategory.equals("")){
			return "/jnit/allim/skin/"+grpValue.getGroupType()+"/"+groupCategory;
		}else{
			return "/jnit/allim/skin/allim/allimView";
		}
	}
	/*
	@RequestMapping("/jnit/allim/make/html/cron.do")
	public String makehtmlCron(HttpServletRequest request, ModelMap model)throws Exception{
		allimUtil.makeAllimListHtml(request, null, "allim", "cron");
		allimUtil.makeAllimListHtml(request, null, "banner", "cron");
		allimUtil.makeAllimListHtml(request, null, "popup", "cron");
		System.out.println("allim init!!!");
		model.addAttribute("json", "success");
		return "/jnit/util/json";
	}
	*/
}
