/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.list.TreeList;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.sun.star.io.IOException;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import jnit.cms.handler.CmsHandler;
import jnit.com.util.FileCopy;
import jnit.util.PathUtil;

@Controller
public class JnitcmsmenuController {

	public static Log log = LogFactory.getLog(JnitcmsmenuController.class);
	
	private static final String SEPARATOR = File.separator;
	
    @RequestMapping(value="/menu/getTopMenu.do")
    public String getTopMenu(final HttpServletRequest request, ModelMap model) throws Exception {

    	String siteNm = "";
    	String pagePath = "";
    	String menuNm = NullUtil.nullString(request.getParameter("menuNm"));
    	String depth = NullUtil.nullString(request.getParameter("depth"));
    	String target = NullUtil.nullString(request.getParameter("target"));
    	String order = NullUtil.nullString(request.getParameter("order"));
    	String menuId = NullUtil.nullString(request.getParameter("menuId"));
    	
    	String mode = "nomal";
    	if(!menuId.equals("")){
    		mode = "id";
    	}
    	
    	int depthInt = 0;
    	int minDepth = 1;
    	int maxDepth = 5;
    	
    	String CtxRoot = request.getSession().getServletContext().getContextPath();
    	String uri = NullUtil.nullString(request.getRequestURI());
    	if(uri.equals("/menu/getTopMenu.do")) {
    		uri = NullUtil.nullString(request.getParameter("uri"));    		
    	}
    	uri = uri.replace(CtxRoot, ""); // Ctx Clear
    	siteNm = uri.substring(1, uri.indexOf("/",1));
    	pagePath = uri.replace(".demo", "");
    	pagePath = pagePath.replace("index.jsp", "");
    	
    	if(pagePath.lastIndexOf("/") == pagePath.length()-1) {
    		pagePath = pagePath.substring(0, pagePath.length()-1);
    	}
    	
    	try{
    		
    		if(depth.equals("")){
    			depth = "2";
    		}
    		
    		depthInt = Integer.parseInt(depth);
    		
    		if(depthInt > maxDepth){
    			depthInt = maxDepth;
    		}else if(depthInt <= minDepth){
    			depthInt = minDepth;
    		}
    	} catch (IllegalArgumentException e){
    		log.error(e.getMessage());
    		depthInt = 2;
    	}catch(Exception e){
    		log.error(e.getMessage());
    		depthInt = 2;
    	}
    	
    	TreeList menuTree = new TreeList();
    	File menuFile = new File(PathUtil.getRealPath(request) + SEPARATOR + siteNm + SEPARATOR + "_etc/menu.json");
    	
	    if(menuFile.exists() == false) {
	    	model.addAttribute("msg", "정의된 메뉴가 없습니다.");
	    }else {
	    	String result = CmsHandler.readFile(menuFile.getPath());
	    	JsonParser json = new JsonParser();
	    	JsonElement jsonEl = json.parse(result);
	    	JsonArray jsonArr = jsonEl.getAsJsonArray();
	    	
	    	// 1depth
	    	for(int i=0; i<jsonArr.size(); i++) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		String title = jsonArr.get(i).getAsJsonObject().get("title").getAsString();
	    		String link = jsonArr.get(i).getAsJsonObject().get("menupath").getAsString();	    		
	    		String defaultmenu = jsonArr.get(i).getAsJsonObject().get("defaultmenu").getAsString();
	    		int isexlink = jsonArr.get(i).getAsJsonObject().get("menuislink").getAsInt();	    		
	    		String hDel = jsonArr.get(i).getAsJsonObject().get("hDel").getAsString();	    		
	    		String exlink = "";
	    		String extgt = "";
	    		String pageLinkNav = "";
	    		String pageNavTitle = "";
	    		if(mode.equals("id")){
	    			title = jsonArr.get(i).getAsJsonObject().get("menuid").getAsString();
	    			menuNm = menuId;
	    		}
	    		
	    		try {
					pageLinkNav = jsonArr.get(i).getAsJsonObject().get("pageLinkNav").getAsString();
					pageNavTitle = jsonArr.get(i).getAsJsonObject().get("pageNavTitle").getAsString();
				} catch (NullPointerException e) {
					
				}
	    			 
	    		if(pagePath.equals(link) && !"".equals(pageLinkNav)){
	    			model.addAttribute("pageLinkNav", pageLinkNav);			    	    			
	    		}	    		
	    		
	    		if(pagePath.equals(link) && !"".equals(pageNavTitle)){
	    			model.addAttribute("pageNavTitle", pageNavTitle);
	    		}
	    			 
	    		if(isexlink == 1) {
	    			exlink = jsonArr.get(i).getAsJsonObject().get("menulinkurl").getAsString();
		    		extgt = jsonArr.get(i).getAsJsonObject().get("menulinktgt").getAsString();
	    		}			
				
	    		if(title.equals(menuNm)){
	    		
		    		if(hDel.equals("Y") && depthInt >= 1) {
		    			map.put("title", jsonArr.get(i).getAsJsonObject().get("title").getAsString());
		    			map.put("link", link);
		    			map.put("exlink", exlink);
		    			map.put("extgt", extgt);
		    			map.put("isexlink", isexlink);
		    			map.put("defaultmenu", defaultmenu);
		    			map.put("over", "on");
		    			menuTree.add(map);
		    			
		    			if(pagePath.indexOf(link) > -1) {
		    				map.put("over", "on");
		    			}
		    				// 2depth
				    		if(jsonArr.get(i).getAsJsonObject().has("children")) {
					    		if(jsonArr.get(i).getAsJsonObject().get("children").isJsonArray()) {
					    			TreeList menuTree2 = new TreeList();
					    			JsonArray jsonArr2 = jsonArr.get(i).getAsJsonObject().get("children").getAsJsonArray();
			
				    				for(int j=0; j<jsonArr2.size(); j++) {
				    					
					    	    		HashMap<String, Object> map2 = new HashMap<String, Object>();
					    	    		String title2 = jsonArr2.get(j).getAsJsonObject().get("title").getAsString();
					    	    		String link2 = jsonArr2.get(j).getAsJsonObject().get("menupath").getAsString();
					    	    		String defaultmenu2 = jsonArr2.get(j).getAsJsonObject().get("defaultmenu").getAsString();
					    	    		int isexlink2 = jsonArr2.get(j).getAsJsonObject().get("menuislink").getAsInt();
					    	    		String exlink2 = "";
					    	    		String extgt2 = "";
					    	    		String hDel2 = jsonArr2.get(j).getAsJsonObject().get("hDel").getAsString();
					    	    		String pageLinkNav2 = "";
					    	    		String pageNavTitle2 = "";
					    	    		
					    	    		try {
											pageLinkNav2 = jsonArr2.get(j).getAsJsonObject().get("pageLinkNav").getAsString();
											pageNavTitle2 = jsonArr2.get(j).getAsJsonObject().get("pageNavTitle").getAsString();
										} catch (NullPointerException e) {
											
										}
					    	    			 
					    	    		if(pagePath.equals(link2) && !"".equals(pageLinkNav2)){
					    	    			model.addAttribute("pageLinkNav", pageLinkNav2);			    	    			
					    	    		}
					    	    		
					    	    		if(pagePath.equals(link2) && !"".equals(pageNavTitle2)){
					    	    			model.addAttribute("pageNavTitle", pageNavTitle2);
					    	    		}
					    	    		
					    	    		if(isexlink2 == 1) {
					    	    			exlink2 = NullUtil.nullString(jsonArr2.get(j).getAsJsonObject().get("menulinkurl").getAsString());
					    	    			
					    	    			try {
						    	    			extgt2 = jsonArr2.get(j).getAsJsonObject().get("menulinktgt").getAsString();
											} catch (UnsupportedOperationException e) {
											
											} catch (NullPointerException e) {
											
											}
					    	    		}			    	    		
					    	    		
					    	    		if(hDel2.equals("Y") && depthInt >= 2) {
						    	    		map2.put("title", title2);
							    			map2.put("link", link2);
							    			map2.put("exlink", exlink2);
							    			map2.put("extgt", extgt2);
							    			map2.put("isexlink", isexlink2);
							    			map2.put("defaultmenu", defaultmenu2);
							    			
							    			map.put("childCount", menuTree2.size());
							    			map.put("childTree", menuTree2);
							    			menuTree2.add(map2);
							    			
							    			if(pagePath.indexOf(link2) > -1) {
							    				map2.put("over", "on");
							    			}
							    				
							    				if(jsonArr2.get(j).getAsJsonObject().has("children")) {
									    			if(jsonArr2.get(j).getAsJsonObject().get("children").isJsonArray()) {
									    				TreeList menuTree3 = new TreeList();
									    				JsonArray jsonArr3 = jsonArr2.get(j).getAsJsonObject().get("children").getAsJsonArray();
			
									    				for(int k=0; k<jsonArr3.size(); k++) {
										    	    		HashMap<String, Object> map3 = new HashMap<String, Object>();
										    	    		String title3 = jsonArr3.get(k).getAsJsonObject().get("title").getAsString();
										    	    		String link3 = jsonArr3.get(k).getAsJsonObject().get("menupath").getAsString();
										    	    		String defaultmenu3 = jsonArr3.get(k).getAsJsonObject().get("defaultmenu").getAsString();
										    	    		int isexlink3 = jsonArr3.get(k).getAsJsonObject().get("menuislink").getAsInt();
										    	    		String exlink3 = "";
										    	    		String extgt3 = "";								    	    		
										    	    		String hDel3 = jsonArr3.get(k).getAsJsonObject().get("hDel").getAsString();
										    	    		String pageLinkNav3 = "";
										    	    		String pageNavTitle3 = "";
										    	    		try {
																pageLinkNav3 = jsonArr3.get(k).getAsJsonObject().get("pageLinkNav").getAsString();
																pageNavTitle3 = jsonArr3.get(k).getAsJsonObject().get("pageNavTitle").getAsString();
															} catch (NullPointerException e) {
																
															}
															
										    	    		if(pagePath.equals(link3) && !"".equals(pageLinkNav3)){
										    	    			model.addAttribute("pageLinkNav", pageLinkNav3);			    	    			
										    	    		}
										    	    		
										    	    		if(pagePath.equals(link3) && !"".equals(pageNavTitle3)){
										    	    			model.addAttribute("pageNavTitle", pageNavTitle3);			    	    			
										    	    		}
										    	    		
										    	    		if(isexlink3 == 1) {
											    	    		exlink3 = NullUtil.nullString(jsonArr3.get(k).getAsJsonObject().get("menulinkurl").getAsString());
											    	    		try {
											    	    			extgt3 = jsonArr3.get(k).getAsJsonObject().get("menulinktgt").getAsString();
																} catch (UnsupportedOperationException e) {
																
																} catch (NullPointerException e) {
																
																}
											    	    	}	
										    	    		
										    	    		if(hDel3.equals("Y") && depthInt >= 3) {
											    	    		map3.put("title", title3);
												    			map3.put("link", link3);
												    			map3.put("exlink", exlink3);
												    			map3.put("extgt", extgt3);
												    			map3.put("isexlink", isexlink3);
												    			map3.put("defaultmenu", defaultmenu3);
												    			
												    			map2.put("childCount", menuTree3.size());
												    			map2.put("childTree", menuTree3);
												    			menuTree3.add(map3);
												    			
												    			if(pagePath.indexOf(link3) > -1) {
												    				map3.put("over", "on");
												    			}
												    				
												    				//Depth4 Start
												    				if(jsonArr3.get(k).getAsJsonObject().has("children")) {
													    				
														    			if(jsonArr3.get(k).getAsJsonObject().get("children").isJsonArray()) {
														    				TreeList menuTree4 = new TreeList();
														    				JsonArray jsonArr4 = jsonArr3.get(k).getAsJsonObject().get("children").getAsJsonArray();
								
														    				for(int l=0; l<jsonArr4.size(); l++) {
															    	    		HashMap<String, Object> map4 = new HashMap<String, Object>();
															    	    		String title4 = jsonArr4.get(l).getAsJsonObject().get("title").getAsString();													    	    		
															    	    		String link4 = jsonArr4.get(l).getAsJsonObject().get("menupath").getAsString();
															    	    		String defaultmenu4 = jsonArr4.get(l).getAsJsonObject().get("defaultmenu").getAsString();
															    	    		int isexlink4 = jsonArr4.get(l).getAsJsonObject().get("menuislink").getAsInt();
															    	    		String exlink4 = "";
															    	    		String extgt4 = "";
															    	    		String hDel4 = jsonArr4.get(l).getAsJsonObject().get("hDel").getAsString();
															    	    		String pageLinkNav4 = "";
															    	    		String pageNavTitle4 = "";
															    	    		
															    	    		try {
																					pageLinkNav4 = jsonArr4.get(l).getAsJsonObject().get("pageLinkNav").getAsString();
																					pageNavTitle4 = jsonArr4.get(l).getAsJsonObject().get("pageNavTitle").getAsString();
																				} catch (NullPointerException e) {
																					
																				}
																				
															    	    		if(pagePath.equals(link4) && !"".equals(pageLinkNav4)){
															    	    			model.addAttribute("pageLinkNav", pageLinkNav4);
															    	    		}
															    	    		
															    	    		if(pagePath.equals(link4) && !"".equals(pageNavTitle4)){
															    	    			model.addAttribute("pageNavTitle", pageNavTitle4);			    	    			
															    	    		}
															    	    		
															    	    		if(isexlink4 == 1) {
																    	    		exlink4 = NullUtil.nullString(jsonArr4.get(l).getAsJsonObject().get("menulinkurl").getAsString());
																    	    		try {
																    	    			extgt4 = jsonArr4.get(l).getAsJsonObject().get("menulinktgt").getAsString();
																					} catch (UnsupportedOperationException e) {
																					
																					} catch (NullPointerException e) {
																					
																					}
																    	    	}
															    	    		
															    	    		if(hDel4.equals("Y") && depthInt >= 4) {
																    	    		map4.put("title", title4);
																	    			map4.put("link", link4);
																	    			map4.put("exlink", exlink4);
																	    			map4.put("extgt", extgt4);
																	    			map4.put("isexlink", isexlink4);
																	    			map4.put("defaultmenu", defaultmenu4);
																	    			
																	    			map3.put("childCount", menuTree4.size());
																	    			map3.put("childTree", menuTree4);
																	    			menuTree4.add(map4);
																	    			
																	    			if(pagePath.indexOf(link4) > -1) {
																	    				map4.put("over", "on");
																	    			}
																	    				
																	    				//Depth5 Start
																	    				if(jsonArr4.get(l).getAsJsonObject().has("children")) {
																		    				
																			    			if(jsonArr4.get(l).getAsJsonObject().get("children").isJsonArray()) {
																			    				TreeList menuTree5 = new TreeList();
																			    				JsonArray jsonArr5 = jsonArr4.get(l).getAsJsonObject().get("children").getAsJsonArray();
													
																			    				for(int m=0; m<jsonArr5.size(); m++) {
																				    	    		HashMap<String, Object> map5 = new HashMap<String, Object>();
																				    	    		String title5 = jsonArr5.get(m).getAsJsonObject().get("title").getAsString();
																				    	    		String link5 = jsonArr5.get(m).getAsJsonObject().get("menupath").getAsString();
																				    	    		String defaultmenu5 = jsonArr5.get(m).getAsJsonObject().get("defaultmenu").getAsString();
																				    	    		int isexlink5 = jsonArr5.get(m).getAsJsonObject().get("menuislink").getAsInt();
																				    	    		String exlink5 = "";
																				    	    		String extgt5 = "";
																				    	    		String hDel5 = jsonArr5.get(m).getAsJsonObject().get("hDel").getAsString();
																				    	    		String pageLinkNav5 = "";
																				    	    		String pageNavTitle5 = "";
																				    	    		
																				    	    		try {
																										pageLinkNav5 = jsonArr5.get(m).getAsJsonObject().get("pageLinkNav").getAsString();
																										pageNavTitle5 = jsonArr5.get(m).getAsJsonObject().get("pageNavTitle").getAsString();
																									} catch (NullPointerException e) {
																										
																									}		
																									
																				    	    		if(pagePath.equals(link5) && !"".equals(pageLinkNav5)){																		    	    			
																				    	    			model.addAttribute("pageLinkNav", pageLinkNav5);			    	    			
																				    	    		}
																				    	    		
																				    	    		if(pagePath.equals(link5) && !"".equals(pageNavTitle5)){
																				    	    			model.addAttribute("pageNavTitle", pageNavTitle5);			    	    			
																				    	    		}
																				    	    		
																				    	    		if(isexlink5 == 1) {
																					    	    		exlink5 = NullUtil.nullString(jsonArr5.get(m).getAsJsonObject().get("menulinkurl").getAsString());
																					    	    		try {
																					    	    			extgt5 = jsonArr5.get(m).getAsJsonObject().get("menulinktgt").getAsString();
																										} catch (UnsupportedOperationException e) {
																										
																										} catch (NullPointerException e) {
																										
																										}
																					    	    	}	
																				    	    		
																				    	    		if(hDel5.equals("Y") && depthInt >= 5) {
																					    	    		map5.put("title", title5);
																						    			map5.put("link", link5);
																						    			map5.put("exlink", exlink5);
																						    			map5.put("extgt", extgt5);
																						    			map5.put("isexlink", isexlink5);
																						    			map5.put("defaultmenu", defaultmenu5);
																						    			
																						    			map4.put("childCount", menuTree5.size());																	    				
																						    			map4.put("childTree", menuTree5);
																						    			menuTree5.add(map5);
																						    			
																						    			if(pagePath.indexOf(link5) > -1) {
																						    				map5.put("over", "on");
																						    			}
																						    			
																						    				if(jsonArr5.get(m).getAsJsonObject().has("children")){
																						    					if(jsonArr5.get(m).getAsJsonObject().get("children").isJsonArray()){
																						    						TreeList menuTree6 = new TreeList();
																						    						JsonArray jsonArr6 = jsonArr5.get(m).getAsJsonObject().get("children").getAsJsonArray();
																						    						
																						    						for(int n=0; n<jsonArr6.size(); n++){
																						    							HashMap<String, Object> map6 = new HashMap<String, Object>();
																									    	    		String title6 = jsonArr6.get(n).getAsJsonObject().get("title").getAsString();
																									    	    		String link6 = jsonArr6.get(n).getAsJsonObject().get("menupath").getAsString();																							    	    		
																									    	    		String defaultmenu6 = jsonArr6.get(n).getAsJsonObject().get("defaultmenu").getAsString();
																									    	    		int isexlink6 = jsonArr6.get(n).getAsJsonObject().get("menuislink").getAsInt();
																									    	    		String exlink6 = "";
																									    	    		String extgt6 = "";
																									    	    		String hDel6 = jsonArr6.get(n).getAsJsonObject().get("hDel").getAsString();
																									    	    		String pageLinkNav6 = "";
																									    	    		String pageNavTitle6 = "";
																									    	    		
																									    	    		try {
																															pageLinkNav6 = jsonArr6.get(n).getAsJsonObject().get("pageLinkNav").getAsString();
																															pageNavTitle6 = jsonArr6.get(n).getAsJsonObject().get("pageNavTitle").getAsString();
																														} catch (NullPointerException e) {
																															
																														}													    	    		
																														
																									    	    		if(pagePath.equals(link6) && !"".equals(pageLinkNav6)){
																									    	    			model.addAttribute("pageLinkNav", pageLinkNav6);
																									    	    		}
																									    	    		
																									    	    		if(pagePath.equals(link6) && !"".equals(pageNavTitle6)){
																									    	    			model.addAttribute("pageNavTitle", pageNavTitle6);			    	    			
																									    	    		}
																									    	    		
																									    	    		if(isexlink6 == 1) {
																									    	    			
																										    	    		exlink6 = jsonArr6.get(n).getAsJsonObject().get("menulinkurl").getAsString();
																										    	    		try {
																										    	    			extgt6 = jsonArr6.get(n).getAsJsonObject().get("menulinktgt").getAsString();
																															} catch (UnsupportedOperationException e) {
																																
																															} catch (NullPointerException e) {
																																
																															}
																										    	    	}
																									    	    		
																									    	    		if(hDel6.equals("Y")) {
																									    	    			map6.put("title", title6);
																											    			map6.put("link", link6);
																											    			map6.put("exlink", exlink6);
																											    			map6.put("extgt", extgt6);
																											    			map6.put("isexlink", isexlink6);
																											    			map6.put("defaultmenu", defaultmenu6);
																											    			
																											    			map5.put("childCount", menuTree6.size());
																											    			map5.put("childTree", menuTree6);
																											    			menuTree6.add(map6);
																											    			
																											    			if(pagePath.indexOf(link6) > -1) {
																											    				map6.put("over", "on");
																											    			}
																									    	    		}																							    	    		
																						    						}
																						    					}
																						    				}
																						    			}
																				    	    		//menuTree5.add(map5);
																			    				}
																			    			}
																	    				}
																	    			}
															    	    		//menuTree4.add(map4);
														    				}
														    			}
												    				}										    				
												    			}
										    	    		//menuTree3.add(map3);
									    				}							    				
									    			}
							    				}
						    				//menuTree2.add(map2);
					    	    		}
					    			}	    				
					    		}
				    		}
			    		//menuTree.add(map);
		    		}
		    		break;
	    		}
	    	}
	    	model.addAttribute("menuTree", menuTree);    	
	    }
	    model.addAttribute("order", order);
	    
	    /* 파일이 없으면 샘플파일 가져와서 복사 */
	    String root = PathUtil.getRealPath(request);
	    String defaultPath = root + "WEB-INF/jsp/jnit/cms/menu";
	    
	    File existCheck = new File(defaultPath + SEPARATOR + "topmenu/" + target + File.separator + depth + SEPARATOR +target+"_topMenu.jsp");
	    if(existCheck.exists()){
	    	return "jnit/cms/menu/topmenu/" + target + File.separator + depth + SEPARATOR +target+"_topMenu";
	    }else{
	    	//지정된 파일 생성
	    	FileCopy.makeTopMenuSampleFile(defaultPath, target, depth);
			model.addAttribute("msg", "파일이 생성되어 다시한번 접속하시기 바랍니다.");
	    	return "jnit/cms/menu/null";
	    }	    
    }
    
    @RequestMapping(value="/menu/getSubMenu.do")
    public String getSubMenu(
            final HttpServletRequest request,
            ModelMap model)
            throws Exception {

    	String CtxRoot = request.getSession().getServletContext().getContextPath();
    	String uri = NullUtil.nullString(request.getRequestURI());
    	if(uri.equals("/menu/getSubMenu.do")) {
    		uri = NullUtil.nullString(request.getParameter("uri"));    		
    	}
    	uri = uri.replace(CtxRoot, ""); // Ctx Clear
    	
    	
    	String siteNm = "";
    	String pagePath = "";
    	siteNm = uri.substring(1, uri.indexOf("/",1));
    	pagePath = uri.replace(".demo", "");
    	pagePath = pagePath.replace("index.jsp", "");
    	
    	if(pagePath.lastIndexOf("/") == pagePath.length()-1) {
    		pagePath = pagePath.substring(0, pagePath.length()-1);
    	}   	
    	
    	TreeList menuTree = new TreeList();
    	
    	File menuFile = new File(PathUtil.getRealPath(request) + "/" + siteNm + "/_etc/menu.json");
	    if(menuFile.exists() == false) {
	    	model.addAttribute("msg", "정의된 메뉴가 없습니다.");
	    }else {
	    	String result = CmsHandler.readFile(menuFile.getPath());
	    	JsonParser json = new JsonParser();
	    	JsonElement jsonEl = json.parse(result);
	    	JsonArray jsonArr = jsonEl.getAsJsonArray();
	    	
	    	// 1depth
	    	for(int i=0; i<jsonArr.size(); i++) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		String title = jsonArr.get(i).getAsJsonObject().get("title").getAsString();
	    		String link = jsonArr.get(i).getAsJsonObject().get("menupath").getAsString();
	    		String defaultmenu = jsonArr.get(i).getAsJsonObject().get("defaultmenu").getAsString();
	    		int isexlink = jsonArr.get(i).getAsJsonObject().get("menuislink").getAsInt();	    		
	    		String lDel = jsonArr.get(i).getAsJsonObject().get("lDel").getAsString();	    		
	    		String exlink = "";
	    		String extgt = "";
	    		String pageLinkNav = "";
	    		String pageNavTitle = "";
	    		
	    		try {
					pageLinkNav = jsonArr.get(i).getAsJsonObject().get("pageLinkNav").getAsString();
					pageNavTitle = jsonArr.get(i).getAsJsonObject().get("pageNavTitle").getAsString();
				} catch (NullPointerException e) {
					
				}
	    			 
	    		if(pagePath.equals(link) && !"".equals(pageLinkNav)){
	    			model.addAttribute("pageLinkNav", pageLinkNav);			    	    			
	    		}	    		
	    		
	    		if(pagePath.equals(link) && !"".equals(pageNavTitle)){
	    			model.addAttribute("pageNavTitle", pageNavTitle);
	    		}
	    		
	    		if(isexlink == 1) {
	    			exlink = jsonArr.get(i).getAsJsonObject().get("menulinkurl").getAsString();
	    			try {
	    				extgt = jsonArr.get(i).getAsJsonObject().get("menulinktgt").getAsString();
					} catch (UnsupportedOperationException e) {
					
					} catch (NullPointerException e) {
					
					}
	    		}			
				
	    		//if(title.indexOf("#") != 0 && pagePath.indexOf(link) > -1) {
	    		if(pagePath.indexOf(link) > -1 && lDel.equals("Y")) {
	    			map.put("title", title);
	    			map.put("link", link);
	    			map.put("exlink", exlink);
	    			map.put("extgt", extgt);
	    			map.put("isexlink", isexlink);
	    			map.put("defaultmenu", defaultmenu);
	    			map.put("over", "over");
	    			menuTree.add(map);	    			
		    		// 2depth
		    		if(jsonArr.get(i).getAsJsonObject().has("children")) {
			    		if(jsonArr.get(i).getAsJsonObject().get("children").isJsonArray()) {
			    			TreeList menuTree2 = new TreeList();
			    			JsonArray jsonArr2 = jsonArr.get(i).getAsJsonObject().get("children").getAsJsonArray();
	
		    				for(int j=0; j<jsonArr2.size(); j++) {
		    					
			    	    		HashMap<String, Object> map2 = new HashMap<String, Object>();
			    	    		String title2 = jsonArr2.get(j).getAsJsonObject().get("title").getAsString();
			    	    		String link2 = jsonArr2.get(j).getAsJsonObject().get("menupath").getAsString();
			    	    		String defaultmenu2 = jsonArr2.get(j).getAsJsonObject().get("defaultmenu").getAsString();
			    	    		int isexlink2 = jsonArr2.get(j).getAsJsonObject().get("menuislink").getAsInt();
			    	    		String exlink2 = "";
			    	    		String extgt2 = "";
			    	    		String lDel2 = jsonArr2.get(j).getAsJsonObject().get("lDel").getAsString();
			    	    		String pageLinkNav2 = "";
			    	    		String pageNavTitle2 = "";
			    	    		
			    	    		try {
									pageLinkNav2 = jsonArr2.get(j).getAsJsonObject().get("pageLinkNav").getAsString();
									pageNavTitle2 = jsonArr2.get(j).getAsJsonObject().get("pageNavTitle").getAsString();
								} catch (NullPointerException e) {
									
								}
			    	    			 
			    	    		if(pagePath.equals(link2) && !"".equals(pageLinkNav2)){
			    	    			model.addAttribute("pageLinkNav", pageLinkNav2);			    	    			
			    	    		}
			    	    		
			    	    		if(pagePath.equals(link2) && !"".equals(pageNavTitle2)){
			    	    			model.addAttribute("pageNavTitle", pageNavTitle2);
			    	    		}
			    	    		
			    	    		if(isexlink2 == 1) {
			    	    			exlink2 = jsonArr2.get(j).getAsJsonObject().get("menulinkurl").getAsString();
			    	    			try {
			    	    				extgt2 = jsonArr2.get(j).getAsJsonObject().get("menulinktgt").getAsString();
									} catch (UnsupportedOperationException e) {
									
									} catch (NullPointerException e) {
									
									}
			    	    		}
			    	    		
			    	    		//if(title2.indexOf("#") != 0) {
			    	    		if(lDel2.equals("Y")) {
				    	    		map2.put("title", title2);
					    			map2.put("link", link2);
					    			map2.put("exlink", exlink2);
					    			map2.put("extgt", extgt2);
					    			map2.put("isexlink", isexlink2);
					    			map2.put("defaultmenu", defaultmenu2);
					    			
					    			menuTree2.add(map2);
					    			
					    			map.put("childCount", menuTree2.size());
					    			map.put("childTree", menuTree2);
					    			
					    			if(pagePath.indexOf(link2) > -1) {
					    				map2.put("over", "on");					    				
					    				
					    				if(jsonArr2.get(j).getAsJsonObject().has("children")) {
						    				
							    			if(jsonArr2.get(j).getAsJsonObject().get("children").isJsonArray()) {
							    				TreeList menuTree3 = new TreeList();
							    				JsonArray jsonArr3 = jsonArr2.get(j).getAsJsonObject().get("children").getAsJsonArray();
	
							    				for(int k=0; k<jsonArr3.size(); k++) {
								    	    		HashMap<String, Object> map3 = new HashMap<String, Object>();
								    	    		String title3 = jsonArr3.get(k).getAsJsonObject().get("title").getAsString();
								    	    		String link3 = jsonArr3.get(k).getAsJsonObject().get("menupath").getAsString();
								    	    		String defaultmenu3 = jsonArr3.get(k).getAsJsonObject().get("defaultmenu").getAsString();
								    	    		int isexlink3 = jsonArr3.get(k).getAsJsonObject().get("menuislink").getAsInt();
								    	    		String exlink3 = "";
								    	    		String extgt3 = "";								    	    		
								    	    		String lDel3 = jsonArr3.get(k).getAsJsonObject().get("lDel").getAsString();
								    	    		String pageLinkNav3 = "";
								    	    		String pageNavTitle3 = "";
								    	    		try {
														pageLinkNav3 = jsonArr3.get(k).getAsJsonObject().get("pageLinkNav").getAsString();
														pageNavTitle3 = jsonArr3.get(k).getAsJsonObject().get("pageNavTitle").getAsString();
													} catch (NullPointerException e) {
														
													}
													
								    	    		if(pagePath.equals(link3) && !"".equals(pageLinkNav3)){
								    	    			model.addAttribute("pageLinkNav", pageLinkNav3);			    	    			
								    	    		}
								    	    		
								    	    		if(pagePath.equals(link3) && !"".equals(pageNavTitle3)){
								    	    			model.addAttribute("pageNavTitle", pageNavTitle3);			    	    			
								    	    		}
								    	    		
								    	    		if(isexlink3 == 1) {
									    	    		exlink3 = jsonArr3.get(k).getAsJsonObject().get("menulinkurl").getAsString();
									    	    		try {
									    	    			extgt3 = jsonArr3.get(k).getAsJsonObject().get("menulinktgt").getAsString();
														} catch (UnsupportedOperationException e) {
														
														} catch (NullPointerException e) {
														
														}
									    	    	}	
								    				
								    	    		//if(title3.indexOf("#") != 0) {
								    	    		if(lDel3.equals("Y")) {
									    	    		map3.put("title", title3);
										    			map3.put("link", link3);
										    			map3.put("exlink", exlink3);
										    			map3.put("extgt", extgt3);
										    			map3.put("isexlink", isexlink3);
										    			map3.put("defaultmenu", defaultmenu3);
										    			
										    			menuTree3.add(map3);
										    			map2.put("childCount", menuTree3.size());
										    			map2.put("childTree", menuTree3);
										    			
										    			if(pagePath.indexOf(link3) > -1) {
										    				map3.put("over", "on");
										    				
										    				//Depth4 Start
										    				if(jsonArr3.get(k).getAsJsonObject().has("children")) {
											    				
												    			if(jsonArr3.get(k).getAsJsonObject().get("children").isJsonArray()) {
												    				TreeList menuTree4 = new TreeList();
												    				JsonArray jsonArr4 = jsonArr3.get(k).getAsJsonObject().get("children").getAsJsonArray();
						
												    				for(int l=0; l<jsonArr4.size(); l++) {
													    	    		HashMap<String, Object> map4 = new HashMap<String, Object>();
													    	    		String title4 = jsonArr4.get(l).getAsJsonObject().get("title").getAsString();													    	    		
													    	    		String link4 = jsonArr4.get(l).getAsJsonObject().get("menupath").getAsString();
													    	    		String defaultmenu4 = jsonArr4.get(l).getAsJsonObject().get("defaultmenu").getAsString();
													    	    		int isexlink4 = jsonArr4.get(l).getAsJsonObject().get("menuislink").getAsInt();
													    	    		String exlink4 = "";
													    	    		String extgt4 = "";
													    	    		String pageLinkNav4 = "";
													    	    		String pageNavTitle4 = "";													    	    		
													    	    		String lDel4 = jsonArr4.get(l).getAsJsonObject().get("lDel").getAsString();
													    	    		
													    	    		try {
																			pageLinkNav4 = jsonArr4.get(l).getAsJsonObject().get("pageLinkNav").getAsString();
																			pageNavTitle4 = jsonArr4.get(l).getAsJsonObject().get("pageNavTitle").getAsString();
																		} catch (NullPointerException e) {
																			
																		}
																		
													    	    		if(pagePath.equals(link4) && !"".equals(pageLinkNav4)){
													    	    			model.addAttribute("pageLinkNav", pageLinkNav4);
													    	    		}
													    	    		
													    	    		if(pagePath.equals(link4) && !"".equals(pageNavTitle4)){
													    	    			model.addAttribute("pageNavTitle", pageNavTitle4);			    	    			
													    	    		}
													    	    		
													    	    		if(isexlink4 == 1) {
														    	    		exlink4 = jsonArr4.get(l).getAsJsonObject().get("menulinkurl").getAsString();
														    	    		try {
														    	    			extgt4 = jsonArr4.get(l).getAsJsonObject().get("menulinktgt").getAsString();
																			} catch (UnsupportedOperationException e) {
																			
																			} catch (NullPointerException e) {
																			
																			}
														    	    	}
													    	    		
													    	    		//if(title4.indexOf("#") != 0) {
													    	    		if(lDel4.equals("Y")) {
														    	    		map4.put("title", title4);
															    			map4.put("link", link4);
															    			map4.put("exlink", exlink4);
															    			map4.put("extgt", extgt4);
															    			map4.put("isexlink", isexlink4);
															    			map4.put("defaultmenu", defaultmenu4);
															    			
															    			menuTree4.add(map4);
															    			map3.put("childCount", menuTree4.size());
															    			map3.put("childTree", menuTree4);
															    			
															    			if(pagePath.indexOf(link4) > -1) {
															    				map4.put("over", "on");
															    				
															    				//Depth5 Start
															    				if(jsonArr4.get(l).getAsJsonObject().has("children")) {
																    				
																	    			if(jsonArr4.get(l).getAsJsonObject().get("children").isJsonArray()) {
																	    				TreeList menuTree5 = new TreeList();
																	    				JsonArray jsonArr5 = jsonArr4.get(l).getAsJsonObject().get("children").getAsJsonArray();
											
																	    				for(int m=0; m<jsonArr5.size(); m++) {
																		    	    		HashMap<String, Object> map5 = new HashMap<String, Object>();
																		    	    		String title5 = jsonArr5.get(m).getAsJsonObject().get("title").getAsString();
																		    	    		String link5 = jsonArr5.get(m).getAsJsonObject().get("menupath").getAsString();
																		    	    		String defaultmenu5 = jsonArr5.get(m).getAsJsonObject().get("defaultmenu").getAsString();
																		    	    		int isexlink5 = jsonArr5.get(m).getAsJsonObject().get("menuislink").getAsInt();
																		    	    		String exlink5 = "";
																		    	    		String extgt5 = "";
																		    	    		String pageLinkNav5 = "";
																		    	    		String pageNavTitle5 = "";
																		    	    		String lDel5 = jsonArr5.get(m).getAsJsonObject().get("lDel").getAsString();
																		    	    		
																		    	    		try {
																								pageLinkNav5 = jsonArr5.get(m).getAsJsonObject().get("pageLinkNav").getAsString();
																								pageNavTitle5 = jsonArr5.get(m).getAsJsonObject().get("pageNavTitle").getAsString();
																							} catch (NullPointerException e) {
																								
																							}		
																							
																		    	    		if(pagePath.equals(link5) && !"".equals(pageLinkNav5)){																		    	    			
																		    	    			model.addAttribute("pageLinkNav", pageLinkNav5);			    	    			
																		    	    		}
																		    	    		
																		    	    		if(pagePath.equals(link5) && !"".equals(pageNavTitle5)){
																		    	    			model.addAttribute("pageNavTitle", pageNavTitle5);			    	    			
																		    	    		}
																		    	    		
																		    	    		if(isexlink5 == 1) {
																			    	    		exlink5 = jsonArr5.get(m).getAsJsonObject().get("menulinkurl").getAsString();
																			    	    		try {
																			    	    			extgt5 = jsonArr5.get(m).getAsJsonObject().get("menulinktgt").getAsString();
																								} catch (UnsupportedOperationException e) {
																								
																								} catch (NullPointerException e) {
																								
																								}
																			    	    	}	
																		    	    		
																		    	    		//if(title5.indexOf("#") != 0) {
																		    	    		if(lDel5.equals("Y")) {
																			    	    		map5.put("title", title5);
																				    			map5.put("link", link5);
																				    			map5.put("exlink", exlink5);
																				    			map5.put("extgt", extgt5);
																				    			map5.put("isexlink", isexlink5);
																				    			map5.put("defaultmenu", defaultmenu5);
																				    			
																				    			menuTree5.add(map5);
																				    			map4.put("childCount", menuTree5.size());																	    				
																				    			map4.put("childTree", menuTree5);
																				    			
																				    			if(pagePath.indexOf(link5) > -1) {
																				    				map5.put("over", "on");														    				
																				    				if(jsonArr5.get(m).getAsJsonObject().has("children")){
																				    					if(jsonArr5.get(m).getAsJsonObject().get("children").isJsonArray()){
																				    						TreeList menuTree6 = new TreeList();
																				    						JsonArray jsonArr6 = jsonArr5.get(m).getAsJsonObject().get("children").getAsJsonArray();
																				    						
																				    						for(int n=0; n<jsonArr6.size(); n++){
																				    							HashMap<String, Object> map6 = new HashMap<String, Object>();
																							    	    		String title6 = jsonArr6.get(n).getAsJsonObject().get("title").getAsString();
																							    	    		String link6 = jsonArr6.get(n).getAsJsonObject().get("menupath").getAsString();																							    	    		
																							    	    		String defaultmenu6 = jsonArr6.get(n).getAsJsonObject().get("defaultmenu").getAsString();
																							    	    		int isexlink6 = jsonArr6.get(n).getAsJsonObject().get("menuislink").getAsInt();
																							    	    		String exlink6 = "";
																							    	    		String extgt6 = "";
																							    	    		String pageLinkNav6 = "";
																							    	    		String pageNavTitle6 = "";
																							    	    		String lDel6 = jsonArr6.get(n).getAsJsonObject().get("lDel").getAsString();
																							    	    		
																							    	    		try {
																													pageLinkNav6 = jsonArr6.get(n).getAsJsonObject().get("pageLinkNav").getAsString();
																													pageNavTitle6 = jsonArr6.get(n).getAsJsonObject().get("pageNavTitle").getAsString();
																												} catch (NullPointerException e) {
																													
																												}													    	    		
																												
																							    	    		if(pagePath.equals(link6) && !"".equals(pageLinkNav6)){
																							    	    			model.addAttribute("pageLinkNav", pageLinkNav6);
																							    	    		}
																							    	    		
																							    	    		if(pagePath.equals(link6) && !"".equals(pageNavTitle6)){
																							    	    			model.addAttribute("pageNavTitle", pageNavTitle6);			    	    			
																							    	    		}
																							    	    		
																							    	    		if(isexlink6 == 1) {
																							    	    			
																								    	    		exlink6 = jsonArr6.get(n).getAsJsonObject().get("menulinkurl").getAsString();
																								    	    		try {
																								    	    			extgt6 = jsonArr6.get(n).getAsJsonObject().get("menulinktgt").getAsString();
																													} catch (UnsupportedOperationException e) {
																														
																													} catch (NullPointerException e) {
																														
																													}
																								    	    	}	
																							    	    		
																							    	    		if(lDel6.equals("Y")) {
																							    	    			map6.put("title", title6);
																									    			map6.put("link", link6);
																									    			map6.put("exlink", exlink6);
																									    			map6.put("extgt", extgt6);
																									    			map6.put("isexlink", isexlink6);
																									    			map6.put("defaultmenu", defaultmenu6);
																									    			
																									    			menuTree6.add(map6);
																									    			map5.put("childCount", menuTree6.size());
																									    			map5.put("childTree", menuTree6);
																									    			
																							    	    		}																							    	    		
																				    						}
																				    					}
																				    				}
																				    			}
																		    	    		}
																		    	    		//menuTree5.add(map5);
																	    				}
																	    			}
															    				}
															    			}
													    	    		}
													    	    		//menuTree4.add(map4);
												    				}
												    			}
										    				}										    				
										    			}
								    	    		}								    	    		
								    	    		//menuTree3.add(map3);
							    				}							    				
							    			}
					    				}
					    			}
				    				//menuTree2.add(map2);
			    	    		}
			    			}	    				
			    		}
		    		}
		    		//menuTree.add(map);
	    		}
	    	}
	    	model.addAttribute("menuTree", menuTree);
	    }
	    
	    String returnFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sitemenu";
    	File chekFileDir = new File(returnFileDir);
    	if(chekFileDir.exists()){ 
    		chekFileDir.mkdirs();
    	}
    	
    	String returnSubFile = returnFileDir+"/"+siteNm+"_sub.jsp";
    	String returnPath = "jnit/cms/menu/sitemenu/"+siteNm+"_sub";
    	FileInputStream isr = null;
    	try {
    		//CmsHandler.readFile(returnFile);
    		isr = new FileInputStream(new File(returnSubFile));
    	} catch (java.io.IOException e){
    		String setFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub.jsp";
			String setFileSrc = CmsHandler.readFile(setFileDir);
			
			String mkFileDir = returnFileDir+"/"+siteNm+"_sub.jsp";			
			CmsHandler.writeFile(mkFileDir, setFileSrc);
		} catch (Exception e) {
			String setFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub.jsp";
			String setFileSrc = CmsHandler.readFile(setFileDir);
			
			String mkFileDir = returnFileDir+"/"+siteNm+"_sub.jsp";			
			CmsHandler.writeFile(mkFileDir, setFileSrc);			
		} finally {
			isr.close();
		}
		
		String returnSubCodeFile = returnFileDir+"/"+siteNm+"_sub_code.jsp";
		try {
			isr = new FileInputStream(new File(returnSubCodeFile));
		} catch (java.io.IOException e){
			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
			String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);
			
			String mkSubCodeDir = returnFileDir + "/"+siteNm+"_sub_code.jsp";
			CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
		} catch (Exception e) {
			//TODO: handle exception
			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
			String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);
			
			String mkSubCodeDir = returnFileDir + "/"+siteNm+"_sub_code.jsp";
			CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
		} finally {
			isr.close();
		}
		
		String returnOriginSubCode = returnFileDir+"/"+siteNm+"_original_sub_code.jsp";
		try {
			isr = new FileInputStream(new File(returnOriginSubCode));
		} catch (java.io.IOException e){
			String setSubOriginCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/original_sub_code.jsp";
			String setSubOriginCodeSrc = CmsHandler.readFile(setSubOriginCodeDir);
			
			String mkOriginSubCodeDir = returnFileDir + "/"+siteNm+"_original_sub_code.jsp";
			CmsHandler.writeFile(mkOriginSubCodeDir, setSubOriginCodeSrc);
		} catch (Exception e) {
			// TODO: handle exception
			String setSubOriginCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/original_sub_code.jsp";
			String setSubOriginCodeSrc = CmsHandler.readFile(setSubOriginCodeDir);
			
			String mkOriginSubCodeDir = returnFileDir + "/"+siteNm+"_original_sub_code.jsp";
			CmsHandler.writeFile(mkOriginSubCodeDir, setSubOriginCodeSrc);
		} finally {
			isr.close();
		}
		
    	return returnPath; //"jnit/cms/menu/sub"
    }  
    
    @RequestMapping(value="/menu/getSiteMap.do")
    public String getSiteMap(
            HttpServletRequest request,
            Model model)
            throws Exception {
    	String root = PathUtil.getRealPath(request);
    	String siteNm = NullUtil.nullString(request.getParameter("siteNm"));;
    	String titles = NullUtil.nullString(request.getParameter("titles"));
    	
    	String[] titleSplit = null;
    	String getTitle = "";
    	
    	if(!"".equals(titles)){
    		titleSplit = titles.split(",");
    	}
    	
    	siteNm = siteNm.substring(1, siteNm.indexOf("/",1));
    	
    	TreeList menuTree = new TreeList();
    	
    	File menuFile = new File(PathUtil.getRealPath(request) + "/" + siteNm + "/_etc/menu.json");
	    if(menuFile.exists() == false) {
	    	model.addAttribute("msg", "정의된 메뉴가 없습니다.");
	    }else {
	    	String result = CmsHandler.readFile(menuFile.getPath());
	    	JsonParser json = new JsonParser();
	    	JsonElement jsonEl = json.parse(result);
	    	JsonArray jsonArr = jsonEl.getAsJsonArray();
	    	
	    	// 1depth
	    	for(int i=0; i<jsonArr.size(); i++) {
	    		
	    		getTitle = jsonArr.get(i).getAsJsonObject().get("title").getAsString();	    		
	    		if(!StringUtil.isExistArray(titleSplit, getTitle)){
	    			continue;
	    		}
	    		
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		String title = jsonArr.get(i).getAsJsonObject().get("title").getAsString();
	    		String link = jsonArr.get(i).getAsJsonObject().get("menupath").getAsString();
	    		String defaultmenu = jsonArr.get(i).getAsJsonObject().get("defaultmenu").getAsString();
	    		int isexlink = jsonArr.get(i).getAsJsonObject().get("menuislink").getAsInt();	    		
	    		String sDel = jsonArr.get(i).getAsJsonObject().get("sDel").getAsString();	    		
	    		String exlink = "";
	    		String extgt = "";
	    		
	    		
	    		if(isexlink == 1) {
	    			exlink = jsonArr.get(i).getAsJsonObject().get("menulinkurl").getAsString();
	    			try {
	    				extgt = jsonArr.get(i).getAsJsonObject().get("menulinktgt").getAsString();
					} catch (UnsupportedOperationException e) {
						log.error(e.getMessage());
					} catch (NullPointerException e) {
						log.error(e.getMessage());
					}
	    		}			
	    		
	    		if(sDel.equals("Y")) {
	    			map.put("title", title);
	    			map.put("link", link);
	    			map.put("exlink", exlink);
	    			map.put("extgt", extgt);
	    			map.put("isexlink", isexlink);
	    			map.put("defaultmenu", defaultmenu);	    			
	    			menuTree.add(map);	    			
		    		// 2depth
		    		if(jsonArr.get(i).getAsJsonObject().has("children")) {
			    		if(jsonArr.get(i).getAsJsonObject().get("children").isJsonArray()) {
			    			TreeList menuTree2 = new TreeList();
			    			JsonArray jsonArr2 = jsonArr.get(i).getAsJsonObject().get("children").getAsJsonArray();
	
		    				for(int j=0; j<jsonArr2.size(); j++) {
		    					
			    	    		HashMap<String, Object> map2 = new HashMap<String, Object>();
			    	    		String title2 = jsonArr2.get(j).getAsJsonObject().get("title").getAsString();
			    	    		String link2 = jsonArr2.get(j).getAsJsonObject().get("menupath").getAsString();
			    	    		String defaultmenu2 = jsonArr2.get(j).getAsJsonObject().get("defaultmenu").getAsString();
			    	    		int isexlink2 = jsonArr2.get(j).getAsJsonObject().get("menuislink").getAsInt();
			    	    		String exlink2 = "";
			    	    		String extgt2 = "";
			    	    		String sDel2 = jsonArr2.get(j).getAsJsonObject().get("sDel").getAsString();
			    	    		
			    	    		if(isexlink2 == 1) {
			    	    			exlink2 = jsonArr2.get(j).getAsJsonObject().get("menulinkurl").getAsString();
			    	    			try {
			    	    				extgt2 = jsonArr2.get(j).getAsJsonObject().get("menulinktgt").getAsString();
									} catch (UnsupportedOperationException e) {
										log.error(e.getMessage());
									} catch (NullPointerException e) {
										log.error(e.getMessage());
									}
			    	    		}
			    	    		
			    	    		if(sDel2.equals("Y")) {
				    	    		map2.put("title", title2);
					    			map2.put("link", link2);
					    			map2.put("exlink", exlink2);
					    			map2.put("extgt", extgt2);
					    			map2.put("isexlink", isexlink2);
					    			map2.put("defaultmenu", defaultmenu2);
					    			
					    			menuTree2.add(map2);
					    			
					    			map.put("childCount", menuTree2.size());
					    			map.put("childTree", menuTree2);
					    				
				    				if(jsonArr2.get(j).getAsJsonObject().has("children")) {
					    				
						    			if(jsonArr2.get(j).getAsJsonObject().get("children").isJsonArray()) {
						    				TreeList menuTree3 = new TreeList();
						    				JsonArray jsonArr3 = jsonArr2.get(j).getAsJsonObject().get("children").getAsJsonArray();

						    				for(int k=0; k<jsonArr3.size(); k++) {
							    	    		HashMap<String, Object> map3 = new HashMap<String, Object>();
							    	    		String title3 = jsonArr3.get(k).getAsJsonObject().get("title").getAsString();
							    	    		String link3 = jsonArr3.get(k).getAsJsonObject().get("menupath").getAsString();
							    	    		String defaultmenu3 = jsonArr3.get(k).getAsJsonObject().get("defaultmenu").getAsString();
							    	    		int isexlink3 = jsonArr3.get(k).getAsJsonObject().get("menuislink").getAsInt();
							    	    		String exlink3 = "";
							    	    		String extgt3 = "";								    	    		
							    	    		String sDel3 = jsonArr3.get(k).getAsJsonObject().get("sDel").getAsString();
							    	    		
							    	    		if(isexlink3 == 1) {
								    	    		exlink3 = jsonArr3.get(k).getAsJsonObject().get("menulinkurl").getAsString();
								    	    		try {
								    	    			extgt3 = jsonArr3.get(k).getAsJsonObject().get("menulinktgt").getAsString();
													} catch (UnsupportedOperationException e) {
														log.error(e.getMessage());
													} catch (NullPointerException e) {
														log.error(e.getMessage());
													}
								    	    	}	
							    				
							    	    		if(sDel3.equals("Y")) {
								    	    		map3.put("title", title3);
									    			map3.put("link", link3);
									    			map3.put("exlink", exlink3);
									    			map3.put("extgt", extgt3);
									    			map3.put("isexlink", isexlink3);
									    			map3.put("defaultmenu", defaultmenu3);
									    			
									    			menuTree3.add(map3);
									    			map2.put("childCount", menuTree3.size());
									    			map2.put("childTree", menuTree3);
									    				
								    				//Depth4 Start
								    				if(jsonArr3.get(k).getAsJsonObject().has("children")) {
									    				
										    			if(jsonArr3.get(k).getAsJsonObject().get("children").isJsonArray()) {
										    				TreeList menuTree4 = new TreeList();
										    				JsonArray jsonArr4 = jsonArr3.get(k).getAsJsonObject().get("children").getAsJsonArray();
				
										    				for(int l=0; l<jsonArr4.size(); l++) {
											    	    		HashMap<String, Object> map4 = new HashMap<String, Object>();
											    	    		String title4 = jsonArr4.get(l).getAsJsonObject().get("title").getAsString();													    	    		
											    	    		String link4 = jsonArr4.get(l).getAsJsonObject().get("menupath").getAsString();
											    	    		String defaultmenu4 = jsonArr4.get(l).getAsJsonObject().get("defaultmenu").getAsString();
											    	    		int isexlink4 = jsonArr4.get(l).getAsJsonObject().get("menuislink").getAsInt();
											    	    		String exlink4 = "";
											    	    		String extgt4 = "";													    	    													    	    		
											    	    		String sDel4 = jsonArr4.get(l).getAsJsonObject().get("sDel").getAsString();
											    	    		
											    	    		
											    	    		if(isexlink4 == 1) {
												    	    		exlink4 = jsonArr4.get(l).getAsJsonObject().get("menulinkurl").getAsString();
												    	    		try {
												    	    			extgt4 = jsonArr4.get(l).getAsJsonObject().get("menulinktgt").getAsString();
																	} catch (UnsupportedOperationException e) {
																		log.error(e.getMessage());
																	} catch (NullPointerException e) {
																		log.error(e.getMessage());
																	}
												    	    	}
											    	    		
											    	    		if(sDel4.equals("Y")) {
												    	    		map4.put("title", title4);
													    			map4.put("link", link4);
													    			map4.put("exlink", exlink4);
													    			map4.put("extgt", extgt4);
													    			map4.put("isexlink", isexlink4);
													    			map4.put("defaultmenu", defaultmenu4);
													    			
													    			menuTree4.add(map4);
													    			map3.put("childCount", menuTree4.size());
													    			map3.put("childTree", menuTree4);
													    			
													    			
													    				
												    				//Depth5 Start
												    				if(jsonArr4.get(l).getAsJsonObject().has("children")) {
													    				
														    			if(jsonArr4.get(l).getAsJsonObject().get("children").isJsonArray()) {
														    				TreeList menuTree5 = new TreeList();
														    				JsonArray jsonArr5 = jsonArr4.get(l).getAsJsonObject().get("children").getAsJsonArray();
								
														    				for(int m=0; m<jsonArr5.size(); m++) {
															    	    		HashMap<String, Object> map5 = new HashMap<String, Object>();
															    	    		String title5 = jsonArr5.get(m).getAsJsonObject().get("title").getAsString();
															    	    		String link5 = jsonArr5.get(m).getAsJsonObject().get("menupath").getAsString();
															    	    		String defaultmenu5 = jsonArr5.get(m).getAsJsonObject().get("defaultmenu").getAsString();
															    	    		int isexlink5 = jsonArr5.get(m).getAsJsonObject().get("menuislink").getAsInt();
															    	    		String exlink5 = "";
															    	    		String extgt5 = "";																		    	    		
															    	    		String sDel5 = jsonArr5.get(m).getAsJsonObject().get("sDel").getAsString();
															    	    		
															    	    		if(isexlink5 == 1) {
																    	    		exlink5 = jsonArr5.get(m).getAsJsonObject().get("menulinkurl").getAsString();
																    	    		try {
																    	    			extgt5 = jsonArr5.get(m).getAsJsonObject().get("menulinktgt").getAsString();
																					} catch (UnsupportedOperationException e) {
																						log.error(e.getMessage());
																					} catch (NullPointerException e) {
																						log.error(e.getMessage());
																					}
																    	    	}	
															    	    		
															    	    		//if(title5.indexOf("#") != 0) {
															    	    		if(sDel5.equals("Y")) {
																    	    		map5.put("title", title5);
																	    			map5.put("link", link5);
																	    			map5.put("exlink", exlink5);
																	    			map5.put("extgt", extgt5);
																	    			map5.put("isexlink", isexlink5);
																	    			map5.put("defaultmenu", defaultmenu5);
																	    			
																	    			menuTree5.add(map5);
																	    			map4.put("childCount", menuTree5.size());																	    				
																	    			map4.put("childTree", menuTree5);
																	    																		    				
																    				if(jsonArr5.get(m).getAsJsonObject().has("children")){
																    					if(jsonArr5.get(m).getAsJsonObject().get("children").isJsonArray()){
																    						TreeList menuTree6 = new TreeList();
																    						JsonArray jsonArr6 = jsonArr5.get(m).getAsJsonObject().get("children").getAsJsonArray();
																    						
																    						for(int n=0; n<jsonArr6.size(); n++){
																    							HashMap<String, Object> map6 = new HashMap<String, Object>();
																			    	    		String title6 = jsonArr6.get(n).getAsJsonObject().get("title").getAsString();
																			    	    		String link6 = jsonArr6.get(n).getAsJsonObject().get("menupath").getAsString();																							    	    		
																			    	    		String defaultmenu6 = jsonArr6.get(n).getAsJsonObject().get("defaultmenu").getAsString();
																			    	    		int isexlink6 = jsonArr6.get(n).getAsJsonObject().get("menuislink").getAsInt();
																			    	    		String exlink6 = "";
																			    	    		String extgt6 = "";																							    	    	
																			    	    		String sDel6 = jsonArr6.get(n).getAsJsonObject().get("sDel").getAsString();
																			    	    		
																			    	    		if(isexlink6 == 1) {
																			    	    			
																				    	    		exlink6 = jsonArr6.get(n).getAsJsonObject().get("menulinkurl").getAsString();
																				    	    		try {
																				    	    			extgt6 = jsonArr6.get(n).getAsJsonObject().get("menulinktgt").getAsString();
																									} catch (UnsupportedOperationException e) {
																										log.error(e.getMessage());
																									} catch (NullPointerException e) {
																										log.error(e.getMessage());
																									}
																				    	    	}	
																			    	    		
																			    	    		if(sDel6.equals("Y")) {
																			    	    			map6.put("title", title6);
																					    			map6.put("link", link6);
																					    			map6.put("exlink", exlink6);
																					    			map6.put("extgt", extgt6);
																					    			map6.put("isexlink", isexlink6);
																					    			map6.put("defaultmenu", defaultmenu6);
																					    			
																					    			menuTree6.add(map6);
																					    			map5.put("childCount", menuTree6.size());
																					    			map5.put("childTree", menuTree6);
																					    			
																			    	    		}																							    	    		
																    						}
																    					}
																    				}
															    	    		}
															    	    		//menuTree5.add(map5);
														    				}
														    			}
												    				}
											    	    		}
											    	    		//menuTree4.add(map4);
										    				}
										    			}
								    				}										    				
							    	    		}								    	    		
							    	    		//menuTree3.add(map3);
						    				}							    				
						    			}
				    				}
				    				//menuTree2.add(map2);
			    	    		}
			    			}	    				
			    		}
		    		}
		    		//menuTree.add(map);
	    		}
	    	}
	    	model.addAttribute("menuTree", menuTree);
	    }
	    
	    String cmsmenu = root +"WEB-INF/jsp/jnit/cms/menu";
	    String sitemapDir = cmsmenu+"/sitemap/"+siteNm+"_sitemap.jsp";
	    String sitemapCodeDir = cmsmenu+"/sitemap/"+siteNm+"_sitemap_code.jsp";
	    try {
	    	String sitemapSrc = CmsHandler.readFile(cmsmenu+"/sitemap.jsp");
	    	String sitemapCodeSrc = CmsHandler.readFile(cmsmenu +"/sitemap_code.jsp");
	    	FileCopy.isFileExists(sitemapDir, sitemapSrc);
	    	FileCopy.isFileExists(sitemapCodeDir, sitemapCodeSrc);
	    } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		if(!"".equals(siteNm)){
			return "jnit/cms/menu/sitemap/"+siteNm+"_sitemap";
		}else{
			return "jnit/cms/menu/sitemap";
		}
    }
    
    /**
     * 
     * @param type - pageNavTitle , pageLinkNav
     * @return type
     * @throws Exception
     */
    public static String getMenuJSON(String type)throws Exception {
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	ModelMap model = new ModelMap();
    	
    	type = NullUtil.nullString(type);
    	String CtxRoot = request.getSession().getServletContext().getContextPath();
    	String uri = NullUtil.nullString(request.getRequestURI());
    	
    	if(uri.equals("/menu/getSubMenu.do")) {
    		uri = NullUtil.nullString(request.getParameter("uri"));
    	}
    	uri = uri.replace(CtxRoot, ""); // Ctx Clear
    	String siteNm = "";
    	String pagePath = "";
    	siteNm = uri.substring(1, uri.indexOf("/",1));
    	pagePath = uri.replace(".demo", "");
    	pagePath = pagePath.replace("index.jsp", "");
    	
    	if(pagePath.lastIndexOf("/") == pagePath.length()-1) {
    		pagePath = pagePath.substring(0, pagePath.length()-1);
    	}   	
    	
    	TreeList menuTree = new TreeList();    	
    	File menuFile = new File(PathUtil.getRealPath(request) + "/" + siteNm + "/_etc/menu.json");
	    if(menuFile.exists() == false) {	    	
	    	type = "빌드를 해주시기 바랍니다.";
	    	return type;
	    }else {
	    	String result = CmsHandler.readFile(menuFile.getPath());
	    	JsonParser json = new JsonParser();
	    	JsonElement jsonEl = json.parse(result);
	    	JsonArray jsonArr = jsonEl.getAsJsonArray();
	    	
	    	// 1depth
	    	for(int i=0; i<jsonArr.size(); i++) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		String title = jsonArr.get(i).getAsJsonObject().get("title").getAsString();
	    		String link = jsonArr.get(i).getAsJsonObject().get("menupath").getAsString();
	    		String defaultmenu = jsonArr.get(i).getAsJsonObject().get("defaultmenu").getAsString();
	    		int isexlink = jsonArr.get(i).getAsJsonObject().get("menuislink").getAsInt();	    		
	    		String lDel = jsonArr.get(i).getAsJsonObject().get("lDel").getAsString();	    		
	    		String exlink = "";
	    		String extgt = "";
	    		String pageLinkNav = "";
	    		String pageNavTitle = "";
	    		try {
					pageLinkNav = jsonArr.get(i).getAsJsonObject().get("pageLinkNav").getAsString();
					pageNavTitle = jsonArr.get(i).getAsJsonObject().get("pageNavTitle").getAsString();
				} catch (NullPointerException e) {
					log.error(e.getMessage());
				}
	    			 
	    		if(pagePath.equals(link) && !"".equals(pageLinkNav)){
	    			model.addAttribute("pageLinkNav", pageLinkNav);			    	    			
	    		}	    		
	    		
	    		if(pagePath.equals(link) && !"".equals(pageNavTitle)){
	    			model.addAttribute("pageNavTitle", pageNavTitle);
	    		}
	    		
	    		if(isexlink == 1) {
	    			exlink = jsonArr.get(i).getAsJsonObject().get("menulinkurl").getAsString();
	    			try {
	    				extgt = jsonArr.get(i).getAsJsonObject().get("menulinktgt").getAsString();
					} catch (UnsupportedOperationException e) {
						log.error(e.getMessage());
					} catch (NullPointerException e) {
						log.error(e.getMessage());
					}
	    		}			
				
	    		//if(title.indexOf("#") != 0 && pagePath.indexOf(link) > -1) {
	    		if(pagePath.indexOf(link) > -1) {
	    			map.put("title", title);
	    			map.put("link", link);
	    			map.put("exlink", exlink);
	    			map.put("extgt", extgt);
	    			map.put("isexlink", isexlink);
	    			map.put("defaultmenu", defaultmenu);
	    			map.put("over", "over");
	    			menuTree.add(map);	    			
		    		// 2depth
		    		if(jsonArr.get(i).getAsJsonObject().has("children")) {
			    		if(jsonArr.get(i).getAsJsonObject().get("children").isJsonArray()) {
			    			TreeList menuTree2 = new TreeList();
			    			JsonArray jsonArr2 = jsonArr.get(i).getAsJsonObject().get("children").getAsJsonArray();
	
		    				for(int j=0; j<jsonArr2.size(); j++) {
		    					
			    	    		HashMap<String, Object> map2 = new HashMap<String, Object>();
			    	    		String title2 = jsonArr2.get(j).getAsJsonObject().get("title").getAsString();
			    	    		String link2 = jsonArr2.get(j).getAsJsonObject().get("menupath").getAsString();
			    	    		String defaultmenu2 = jsonArr2.get(j).getAsJsonObject().get("defaultmenu").getAsString();
			    	    		int isexlink2 = jsonArr2.get(j).getAsJsonObject().get("menuislink").getAsInt();
			    	    		String exlink2 = "";
			    	    		String extgt2 = "";
			    	    		String lDel2 = jsonArr2.get(j).getAsJsonObject().get("lDel").getAsString();
			    	    		String pageLinkNav2 = "";
			    	    		String pageNavTitle2 = "";
			    	    		try {
									pageLinkNav2 = jsonArr2.get(j).getAsJsonObject().get("pageLinkNav").getAsString();
									pageNavTitle2 = jsonArr2.get(j).getAsJsonObject().get("pageNavTitle").getAsString();
								} catch (NullPointerException e) {
									log.error(e.getMessage());
								}
			    	    			 
			    	    		if(pagePath.equals(link2) && !"".equals(pageLinkNav2)){
			    	    			model.addAttribute("pageLinkNav", pageLinkNav2);			    	    			
			    	    		}
			    	    		
			    	    		if(pagePath.equals(link2) && !"".equals(pageNavTitle2)){
			    	    			model.addAttribute("pageNavTitle", pageNavTitle2);
			    	    		}
			    	    		
			    	    		if(isexlink2 == 1) {
			    	    			exlink2 = jsonArr2.get(j).getAsJsonObject().get("menulinkurl").getAsString();
			    	    			try {
			    	    				extgt2 = jsonArr2.get(j).getAsJsonObject().get("menulinktgt").getAsString();
									} catch (UnsupportedOperationException e) {
										log.error(e.getMessage());
									} catch (NullPointerException e) {
										log.error(e.getMessage());
									}
			    	    		}
			    	    		
			    	    		//if(title2.indexOf("#") != 0) {
			    	    		//if(lDel2.equals("Y")) {
				    	    		map2.put("title", title2);
					    			map2.put("link", link2);
					    			map2.put("exlink", exlink2);
					    			map2.put("extgt", extgt2);
					    			map2.put("isexlink", isexlink2);
					    			map2.put("defaultmenu", defaultmenu2);
					    			
					    			menuTree2.add(map2);
					    			
					    			map.put("childCount", menuTree2.size());
					    			map.put("childTree", menuTree2);
					    			
					    			if(pagePath.indexOf(link2) > -1) {
					    				map2.put("over", "on");					    				
					    				
					    				if(jsonArr2.get(j).getAsJsonObject().has("children")) {
						    				
							    			if(jsonArr2.get(j).getAsJsonObject().get("children").isJsonArray()) {
							    				TreeList menuTree3 = new TreeList();
							    				JsonArray jsonArr3 = jsonArr2.get(j).getAsJsonObject().get("children").getAsJsonArray();
	
							    				for(int k=0; k<jsonArr3.size(); k++) {
								    	    		HashMap<String, Object> map3 = new HashMap<String, Object>();
								    	    		String title3 = jsonArr3.get(k).getAsJsonObject().get("title").getAsString();
								    	    		String link3 = jsonArr3.get(k).getAsJsonObject().get("menupath").getAsString();
								    	    		String defaultmenu3 = jsonArr3.get(k).getAsJsonObject().get("defaultmenu").getAsString();
								    	    		int isexlink3 = jsonArr3.get(k).getAsJsonObject().get("menuislink").getAsInt();
								    	    		String exlink3 = "";
								    	    		String extgt3 = "";								    	    		
								    	    		String lDel3 = jsonArr3.get(k).getAsJsonObject().get("lDel").getAsString();
								    	    		String pageLinkNav3 = "";
								    	    		String pageNavTitle3 = "";
								    	    		try {
														pageLinkNav3 = jsonArr3.get(k).getAsJsonObject().get("pageLinkNav").getAsString();
														pageNavTitle3 = jsonArr3.get(k).getAsJsonObject().get("pageNavTitle").getAsString();
													} catch (NullPointerException e) {
														
													}
													
								    	    		if(pagePath.equals(link3) && !"".equals(pageLinkNav3)){
								    	    			model.addAttribute("pageLinkNav", pageLinkNav3);			    	    			
								    	    		}
								    	    		
								    	    		if(pagePath.equals(link3) && !"".equals(pageNavTitle3)){
								    	    			model.addAttribute("pageNavTitle", pageNavTitle3);			    	    			
								    	    		}
								    	    		
								    	    		if(isexlink3 == 1) {
									    	    		exlink3 = jsonArr3.get(k).getAsJsonObject().get("menulinkurl").getAsString();
									    	    		try {
									    	    			extgt3 = jsonArr3.get(k).getAsJsonObject().get("menulinktgt").getAsString();
														} catch (UnsupportedOperationException e) {
														
														} catch (NullPointerException e) {
														
														}
									    	    	}	
								    				
								    	    		//if(title3.indexOf("#") != 0) {
								    	    		//if(lDel3.equals("Y")) {
									    	    		map3.put("title", title3);
										    			map3.put("link", link3);
										    			map3.put("exlink", exlink3);
										    			map3.put("extgt", extgt3);
										    			map3.put("isexlink", isexlink3);
										    			map3.put("defaultmenu", defaultmenu3);
										    			
										    			menuTree3.add(map3);
										    			map2.put("childCount", menuTree3.size());
										    			map2.put("childTree", menuTree3);
										    			
										    			if(pagePath.indexOf(link3) > -1) {
										    				map3.put("over", "on");
										    				
										    				//Depth4 Start
										    				if(jsonArr3.get(k).getAsJsonObject().has("children")) {
											    				
												    			if(jsonArr3.get(k).getAsJsonObject().get("children").isJsonArray()) {
												    				TreeList menuTree4 = new TreeList();
												    				JsonArray jsonArr4 = jsonArr3.get(k).getAsJsonObject().get("children").getAsJsonArray();
						
												    				for(int l=0; l<jsonArr4.size(); l++) {
													    	    		HashMap<String, Object> map4 = new HashMap<String, Object>();
													    	    		String title4 = jsonArr4.get(l).getAsJsonObject().get("title").getAsString();													    	    		
													    	    		String link4 = jsonArr4.get(l).getAsJsonObject().get("menupath").getAsString();
													    	    		String defaultmenu4 = jsonArr4.get(l).getAsJsonObject().get("defaultmenu").getAsString();
													    	    		int isexlink4 = jsonArr4.get(l).getAsJsonObject().get("menuislink").getAsInt();
													    	    		String exlink4 = "";
													    	    		String extgt4 = "";
													    	    		String pageLinkNav4 = "";
													    	    		String pageNavTitle4 = "";													    	    		
													    	    		String lDel4 = jsonArr4.get(l).getAsJsonObject().get("lDel").getAsString();
													    	    		try {
																			pageLinkNav4 = jsonArr4.get(l).getAsJsonObject().get("pageLinkNav").getAsString();
																			pageNavTitle4 = jsonArr4.get(l).getAsJsonObject().get("pageNavTitle").getAsString();
																		} catch (NullPointerException e) {
																			
																		}
																		
													    	    		if(pagePath.equals(link4) && !"".equals(pageLinkNav4)){
													    	    			model.addAttribute("pageLinkNav", pageLinkNav4);
													    	    		}
													    	    		
													    	    		if(pagePath.equals(link4) && !"".equals(pageNavTitle4)){
													    	    			model.addAttribute("pageNavTitle", pageNavTitle4);			    	    			
													    	    		}
													    	    		
													    	    		if(isexlink4 == 1) {
														    	    		exlink4 = jsonArr4.get(l).getAsJsonObject().get("menulinkurl").getAsString();
														    	    		try {
														    	    			extgt4 = jsonArr4.get(l).getAsJsonObject().get("menulinktgt").getAsString();
																			} catch (UnsupportedOperationException e) {
																				log.error(e.getMessage());
																			} catch (NullPointerException e) {
																				log.error(e.getMessage());
																			}
														    	    	}
													    	    		
													    	    		//if(title4.indexOf("#") != 0) {
													    	    		//if(lDel4.equals("Y")) {
														    	    		map4.put("title", title4);
															    			map4.put("link", link4);
															    			map4.put("exlink", exlink4);
															    			map4.put("extgt", extgt4);
															    			map4.put("isexlink", isexlink4);
															    			map4.put("defaultmenu", defaultmenu4);
															    			
															    			menuTree4.add(map4);
															    			map3.put("childCount", menuTree4.size());
															    			map3.put("childTree", menuTree4);
															    			
															    			if(pagePath.indexOf(link4) > -1) {
															    				map4.put("over", "on");
															    				
															    				//Depth5 Start
															    				if(jsonArr4.get(l).getAsJsonObject().has("children")) {
																    				
																	    			if(jsonArr4.get(l).getAsJsonObject().get("children").isJsonArray()) {
																	    				TreeList menuTree5 = new TreeList();
																	    				JsonArray jsonArr5 = jsonArr4.get(l).getAsJsonObject().get("children").getAsJsonArray();
											
																	    				for(int m=0; m<jsonArr5.size(); m++) {
																		    	    		HashMap<String, Object> map5 = new HashMap<String, Object>();
																		    	    		String title5 = jsonArr5.get(m).getAsJsonObject().get("title").getAsString();
																		    	    		String link5 = jsonArr5.get(m).getAsJsonObject().get("menupath").getAsString();
																		    	    		String defaultmenu5 = jsonArr5.get(m).getAsJsonObject().get("defaultmenu").getAsString();
																		    	    		int isexlink5 = jsonArr5.get(m).getAsJsonObject().get("menuislink").getAsInt();
																		    	    		String exlink5 = "";
																		    	    		String extgt5 = "";
																		    	    		String pageLinkNav5 = "";
																		    	    		String pageNavTitle5 = "";
																		    	    		String lDel5 = jsonArr5.get(m).getAsJsonObject().get("lDel").getAsString();
																		    	    		
																		    	    		try {
																								pageLinkNav5 = jsonArr5.get(m).getAsJsonObject().get("pageLinkNav").getAsString();
																								pageNavTitle5 = jsonArr5.get(m).getAsJsonObject().get("pageNavTitle").getAsString();
																							} catch (NullPointerException e) {
																								
																							}		
																							
																		    	    		if(pagePath.equals(link5) && !"".equals(pageLinkNav5)){																		    	    			
																		    	    			model.addAttribute("pageLinkNav", pageLinkNav5);			    	    			
																		    	    		}
																		    	    		
																		    	    		if(pagePath.equals(link5) && !"".equals(pageNavTitle5)){
																		    	    			model.addAttribute("pageNavTitle", pageNavTitle5);			    	    			
																		    	    		}
																		    	    		
																		    	    		if(isexlink5 == 1) {
																			    	    		exlink5 = jsonArr5.get(m).getAsJsonObject().get("menulinkurl").getAsString();
																			    	    		try {
																			    	    			extgt5 = jsonArr5.get(m).getAsJsonObject().get("menulinktgt").getAsString();
																								} catch (UnsupportedOperationException e) {
																								
																								} catch (NullPointerException e) {
																								
																								}
																			    	    	}	
																		    	    		
																		    	    		//if(title5.indexOf("#") != 0) {
																		    	    		//if(lDel5.equals("Y")) {
																			    	    		map5.put("title", title5);
																				    			map5.put("link", link5);
																				    			map5.put("exlink", exlink5);
																				    			map5.put("extgt", extgt5);
																				    			map5.put("isexlink", isexlink5);
																				    			map5.put("defaultmenu", defaultmenu5);
																				    			
																				    			menuTree5.add(map5);
																				    			map4.put("childCount", menuTree5.size());																	    				
																				    			map4.put("childTree", menuTree5);
																				    			
																				    			if(pagePath.indexOf(link5) > -1) {
																				    				map5.put("over", "on");														    				
																				    				if(jsonArr5.get(m).getAsJsonObject().has("children")){
																				    					if(jsonArr5.get(m).getAsJsonObject().get("children").isJsonArray()){
																				    						TreeList menuTree6 = new TreeList();
																				    						JsonArray jsonArr6 = jsonArr5.get(m).getAsJsonObject().get("children").getAsJsonArray();
																				    						
																				    						for(int n=0; n<jsonArr6.size(); n++){
																				    							HashMap<String, Object> map6 = new HashMap<String, Object>();
																							    	    		String title6 = jsonArr6.get(n).getAsJsonObject().get("title").getAsString();
																							    	    		String link6 = jsonArr6.get(n).getAsJsonObject().get("menupath").getAsString();																							    	    		
																							    	    		String defaultmenu6 = jsonArr6.get(n).getAsJsonObject().get("defaultmenu").getAsString();
																							    	    		int isexlink6 = jsonArr6.get(n).getAsJsonObject().get("menuislink").getAsInt();
																							    	    		String exlink6 = "";
																							    	    		String extgt6 = "";
																							    	    		String pageLinkNav6 = "";
																							    	    		String pageNavTitle6 = "";
																							    	    		String lDel6 = jsonArr6.get(n).getAsJsonObject().get("lDel").getAsString();
																							    	    		
																							    	    		try {
																													pageLinkNav6 = jsonArr6.get(n).getAsJsonObject().get("pageLinkNav").getAsString();
																													pageNavTitle6 = jsonArr6.get(n).getAsJsonObject().get("pageNavTitle").getAsString();
																												} catch (NullPointerException e) {
																													
																												}													    	    		
																												
																							    	    		if(pagePath.equals(link6) && !"".equals(pageLinkNav6)){
																							    	    			model.addAttribute("pageLinkNav", pageLinkNav6);
																							    	    		}
																							    	    		
																							    	    		if(pagePath.equals(link6) && !"".equals(pageNavTitle6)){
																							    	    			model.addAttribute("pageNavTitle", pageNavTitle6);			    	    			
																							    	    		}
																							    	    		
																							    	    		if(isexlink6 == 1) {
																							    	    			
																								    	    		exlink6 = jsonArr6.get(n).getAsJsonObject().get("menulinkurl").getAsString();
																								    	    		try {
																								    	    			extgt6 = jsonArr6.get(n).getAsJsonObject().get("menulinktgt").getAsString();
																													} catch (UnsupportedOperationException e) {
																														
																													} catch (NullPointerException e) {
																														
																													}
																								    	    	}	
																							    	    		
																							    	    		//if(lDel6.equals("Y")) {
																							    	    			map6.put("title", title6);
																									    			map6.put("link", link6);
																									    			map6.put("exlink", exlink6);
																									    			map6.put("extgt", extgt6);
																									    			map6.put("isexlink", isexlink6);
																									    			map6.put("defaultmenu", defaultmenu6);
																									    			
																									    			menuTree6.add(map6);
																									    			map5.put("childCount", menuTree6.size());
																									    			map5.put("childTree", menuTree6);
																									    			
																							    	    		//}																							    	    		
																				    						}
																				    					}
																				    				}
																				    			}
																		    	    		//}
																		    	    		//menuTree5.add(map5);
																	    				}
																	    			}
															    				}
															    			}
													    	    		//}
													    	    		//menuTree4.add(map4);
												    				}
												    			}
										    				}										    				
										    			}
								    	    		//}								    	    		
								    	    		//menuTree3.add(map3);
							    				}							    				
							    			}
					    				}
					    			}
			    	    		//}
					    		//menuTree2.add(map2);
			    			}	    				
			    		}
		    		}
		    		//menuTree.add(map);
	    		}
	    	}
	    	//model.addAttribute("menuTree", menuTree);
	    }
	    String msg = " 빌드를 해주시기 바랍니다.";
	    try {
	    	if("pageNavTitle".equals(type)) type = NullUtil.nullString(model.get("pageNavTitle").toString());
		} catch (NullPointerException e) {
			type += msg;
		}
	    try {
	    	if("pageLinkNav".equals(type)) type = NullUtil.nullString(model.get("pageLinkNav").toString());
		} catch (NullPointerException e) {
			type += msg;
		}
	    return type;
    }
    
    
    /**
     * 
     * @param type - pageNavTitle , pageLinkNav
     * @return type
     * @throws Exception
     */
    public static String getMenuJSON(String type, String siteNm, String pagePath)throws Exception {
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	ModelMap model = new ModelMap();
    	
    	pagePath = pagePath.replace("/index.jsp", "");
    	
    	TreeList menuTree = new TreeList();    	
    	File menuFile = new File(PathUtil.getRealPath(request) + "/" + siteNm + "/_etc/menu.json");
	    if(menuFile.exists() == false) {	    	
	    	type = "빌드를 해주시기 바랍니다.";
	    	return type;
	    }else {
	    	String result = CmsHandler.readFile(menuFile.getPath());
	    	JsonParser json = new JsonParser();
	    	JsonElement jsonEl = json.parse(result);
	    	JsonArray jsonArr = jsonEl.getAsJsonArray();
	    	
	    	// 1depth
	    	for(int i=0; i<jsonArr.size(); i++) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		String title = jsonArr.get(i).getAsJsonObject().get("title").getAsString();
	    		String link = jsonArr.get(i).getAsJsonObject().get("menupath").getAsString();
	    		String defaultmenu = jsonArr.get(i).getAsJsonObject().get("defaultmenu").getAsString();
	    		int isexlink = jsonArr.get(i).getAsJsonObject().get("menuislink").getAsInt();	    		
	    		String lDel = jsonArr.get(i).getAsJsonObject().get("lDel").getAsString();	    		
	    		String exlink = "";
	    		String extgt = "";
	    		String pageLinkNav = "";
	    		String pageNavTitle = "";
	    		try {
					pageLinkNav = jsonArr.get(i).getAsJsonObject().get("pageLinkNav").getAsString();
					pageNavTitle = jsonArr.get(i).getAsJsonObject().get("pageNavTitle").getAsString();
				} catch (NullPointerException e) {
					log.error(e.getMessage());
				}
	    		
	    		if(pagePath.equals(link) && !"".equals(pageLinkNav)){
	    			model.addAttribute("pageLinkNav", pageLinkNav);			    	    			
	    		}	    		
	    		
	    		if(pagePath.equals(link) && !"".equals(pageNavTitle)){
	    			model.addAttribute("pageNavTitle", pageNavTitle);
	    		}
	    		
	    		if(isexlink == 1) {
	    			exlink = jsonArr.get(i).getAsJsonObject().get("menulinkurl").getAsString();
	    			try {
	    				extgt = jsonArr.get(i).getAsJsonObject().get("menulinktgt").getAsString();
					} catch (UnsupportedOperationException e) {
						log.error(e.getMessage());
					} catch (NullPointerException e) {
						log.error(e.getMessage());
					}
	    		}			
				
	    		//if(title.indexOf("#") != 0 && pagePath.indexOf(link) > -1) {
	    		if(pagePath.indexOf(link) > -1 && lDel.equals("Y")) {
	    			map.put("title", title);
	    			map.put("link", link);
	    			map.put("exlink", exlink);
	    			map.put("extgt", extgt);
	    			map.put("isexlink", isexlink);
	    			map.put("defaultmenu", defaultmenu);
	    			map.put("over", "over");
	    			menuTree.add(map);	    			
		    		// 2depth
		    		if(jsonArr.get(i).getAsJsonObject().has("children")) {
			    		if(jsonArr.get(i).getAsJsonObject().get("children").isJsonArray()) {
			    			TreeList menuTree2 = new TreeList();
			    			JsonArray jsonArr2 = jsonArr.get(i).getAsJsonObject().get("children").getAsJsonArray();
	
		    				for(int j=0; j<jsonArr2.size(); j++) {
		    					
			    	    		HashMap<String, Object> map2 = new HashMap<String, Object>();
			    	    		String title2 = jsonArr2.get(j).getAsJsonObject().get("title").getAsString();
			    	    		String link2 = jsonArr2.get(j).getAsJsonObject().get("menupath").getAsString();
			    	    		String defaultmenu2 = jsonArr2.get(j).getAsJsonObject().get("defaultmenu").getAsString();
			    	    		int isexlink2 = jsonArr2.get(j).getAsJsonObject().get("menuislink").getAsInt();
			    	    		String exlink2 = "";
			    	    		String extgt2 = "";
			    	    		String lDel2 = jsonArr2.get(j).getAsJsonObject().get("lDel").getAsString();
			    	    		String pageLinkNav2 = "";
			    	    		String pageNavTitle2 = "";
			    	    		try {
									pageLinkNav2 = jsonArr2.get(j).getAsJsonObject().get("pageLinkNav").getAsString();
									pageNavTitle2 = jsonArr2.get(j).getAsJsonObject().get("pageNavTitle").getAsString();
								} catch (NullPointerException e) {
									log.error(e.getMessage());
								}
			    	    		
			    	    		if(pagePath.equals(link2) && !"".equals(pageLinkNav2)){
			    	    			model.addAttribute("pageLinkNav", pageLinkNav2);			    	    			
			    	    		}
			    	    		
			    	    		if(pagePath.equals(link2) && !"".equals(pageNavTitle2)){
			    	    			model.addAttribute("pageNavTitle", pageNavTitle2);
			    	    		}
			    	    		
			    	    		if(isexlink2 == 1) {
			    	    			exlink2 = jsonArr2.get(j).getAsJsonObject().get("menulinkurl").getAsString();
			    	    			try {
			    	    				extgt2 = jsonArr2.get(j).getAsJsonObject().get("menulinktgt").getAsString();
									} catch (UnsupportedOperationException e) {
										log.error(e.getMessage());
									} catch (NullPointerException e) {
										log.error(e.getMessage());
									}
			    	    		}
			    	    		
			    	    		//if(title2.indexOf("#") != 0) {
			    	    		if(lDel2.equals("Y")) {
				    	    		map2.put("title", title2);
					    			map2.put("link", link2);
					    			map2.put("exlink", exlink2);
					    			map2.put("extgt", extgt2);
					    			map2.put("isexlink", isexlink2);
					    			map2.put("defaultmenu", defaultmenu2);
					    			
					    			menuTree2.add(map2);
					    			
					    			map.put("childCount", menuTree2.size());
					    			map.put("childTree", menuTree2);
					    			
					    			if(pagePath.indexOf(link2) > -1) {
					    				map2.put("over", "on");					    				
					    				
					    				if(jsonArr2.get(j).getAsJsonObject().has("children")) {
						    				
							    			if(jsonArr2.get(j).getAsJsonObject().get("children").isJsonArray()) {
							    				TreeList menuTree3 = new TreeList();
							    				JsonArray jsonArr3 = jsonArr2.get(j).getAsJsonObject().get("children").getAsJsonArray();
	
							    				for(int k=0; k<jsonArr3.size(); k++) {
								    	    		HashMap<String, Object> map3 = new HashMap<String, Object>();
								    	    		String title3 = jsonArr3.get(k).getAsJsonObject().get("title").getAsString();
								    	    		String link3 = jsonArr3.get(k).getAsJsonObject().get("menupath").getAsString();
								    	    		String defaultmenu3 = jsonArr3.get(k).getAsJsonObject().get("defaultmenu").getAsString();
								    	    		int isexlink3 = jsonArr3.get(k).getAsJsonObject().get("menuislink").getAsInt();
								    	    		String exlink3 = "";
								    	    		String extgt3 = "";								    	    		
								    	    		String lDel3 = jsonArr3.get(k).getAsJsonObject().get("lDel").getAsString();
								    	    		String pageLinkNav3 = "";
								    	    		String pageNavTitle3 = "";
								    	    		try {
														pageLinkNav3 = jsonArr3.get(k).getAsJsonObject().get("pageLinkNav").getAsString();
														pageNavTitle3 = jsonArr3.get(k).getAsJsonObject().get("pageNavTitle").getAsString();
													} catch (NullPointerException e) {
														
													}
													
								    	    		if(pagePath.equals(link3) && !"".equals(pageLinkNav3)){
								    	    			model.addAttribute("pageLinkNav", pageLinkNav3);			    	    			
								    	    		}
								    	    		
								    	    		if(pagePath.equals(link3) && !"".equals(pageNavTitle3)){
								    	    			model.addAttribute("pageNavTitle", pageNavTitle3);			    	    			
								    	    		}
								    	    		
								    	    		if(isexlink3 == 1) {
									    	    		exlink3 = jsonArr3.get(k).getAsJsonObject().get("menulinkurl").getAsString();
									    	    		try {
									    	    			extgt3 = jsonArr3.get(k).getAsJsonObject().get("menulinktgt").getAsString();
														} catch (UnsupportedOperationException e) {
														
														} catch (NullPointerException e) {
														
														}
									    	    	}	
								    				
								    	    		//if(title3.indexOf("#") != 0) {
								    	    		if(lDel3.equals("Y")) {
									    	    		map3.put("title", title3);
										    			map3.put("link", link3);
										    			map3.put("exlink", exlink3);
										    			map3.put("extgt", extgt3);
										    			map3.put("isexlink", isexlink3);
										    			map3.put("defaultmenu", defaultmenu3);
										    			
										    			menuTree3.add(map3);
										    			map2.put("childCount", menuTree3.size());
										    			map2.put("childTree", menuTree3);
										    			
										    			if(pagePath.indexOf(link3) > -1) {
										    				map3.put("over", "on");
										    				
										    				//Depth4 Start
										    				if(jsonArr3.get(k).getAsJsonObject().has("children")) {
											    				
												    			if(jsonArr3.get(k).getAsJsonObject().get("children").isJsonArray()) {
												    				TreeList menuTree4 = new TreeList();
												    				JsonArray jsonArr4 = jsonArr3.get(k).getAsJsonObject().get("children").getAsJsonArray();
						
												    				for(int l=0; l<jsonArr4.size(); l++) {
													    	    		HashMap<String, Object> map4 = new HashMap<String, Object>();
													    	    		String title4 = jsonArr4.get(l).getAsJsonObject().get("title").getAsString();													    	    		
													    	    		String link4 = jsonArr4.get(l).getAsJsonObject().get("menupath").getAsString();
													    	    		String defaultmenu4 = jsonArr4.get(l).getAsJsonObject().get("defaultmenu").getAsString();
													    	    		int isexlink4 = jsonArr4.get(l).getAsJsonObject().get("menuislink").getAsInt();
													    	    		String exlink4 = "";
													    	    		String extgt4 = "";
													    	    		String pageLinkNav4 = "";
													    	    		String pageNavTitle4 = "";													    	    		
													    	    		String lDel4 = jsonArr4.get(l).getAsJsonObject().get("lDel").getAsString();
													    	    		try {
																			pageLinkNav4 = jsonArr4.get(l).getAsJsonObject().get("pageLinkNav").getAsString();
																			pageNavTitle4 = jsonArr4.get(l).getAsJsonObject().get("pageNavTitle").getAsString();
																		} catch (NullPointerException e) {
																			
																		}
																		
													    	    		if(pagePath.equals(link4) && !"".equals(pageLinkNav4)){
													    	    			model.addAttribute("pageLinkNav", pageLinkNav4);
													    	    		}
													    	    		
													    	    		if(pagePath.equals(link4) && !"".equals(pageNavTitle4)){
													    	    			model.addAttribute("pageNavTitle", pageNavTitle4);			    	    			
													    	    		}
													    	    		
													    	    		if(isexlink4 == 1) {
														    	    		exlink4 = jsonArr4.get(l).getAsJsonObject().get("menulinkurl").getAsString();
														    	    		try {
														    	    			extgt4 = jsonArr4.get(l).getAsJsonObject().get("menulinktgt").getAsString();
																			} catch (UnsupportedOperationException e) {
																				log.error(e.getMessage());
																			} catch (NullPointerException e) {
																				log.error(e.getMessage());
																			}
														    	    	}
													    	    		
													    	    		//if(title4.indexOf("#") != 0) {
													    	    		if(lDel4.equals("Y")) {
														    	    		map4.put("title", title4);
															    			map4.put("link", link4);
															    			map4.put("exlink", exlink4);
															    			map4.put("extgt", extgt4);
															    			map4.put("isexlink", isexlink4);
															    			map4.put("defaultmenu", defaultmenu4);
															    			
															    			menuTree4.add(map4);
															    			map3.put("childCount", menuTree4.size());
															    			map3.put("childTree", menuTree4);
															    			
															    			if(pagePath.indexOf(link4) > -1) {
															    				map4.put("over", "on");
															    				
															    				//Depth5 Start
															    				if(jsonArr4.get(l).getAsJsonObject().has("children")) {
																    				
																	    			if(jsonArr4.get(l).getAsJsonObject().get("children").isJsonArray()) {
																	    				TreeList menuTree5 = new TreeList();
																	    				JsonArray jsonArr5 = jsonArr4.get(l).getAsJsonObject().get("children").getAsJsonArray();
											
																	    				for(int m=0; m<jsonArr5.size(); m++) {
																		    	    		HashMap<String, Object> map5 = new HashMap<String, Object>();
																		    	    		String title5 = jsonArr5.get(m).getAsJsonObject().get("title").getAsString();
																		    	    		String link5 = jsonArr5.get(m).getAsJsonObject().get("menupath").getAsString();
																		    	    		String defaultmenu5 = jsonArr5.get(m).getAsJsonObject().get("defaultmenu").getAsString();
																		    	    		int isexlink5 = jsonArr5.get(m).getAsJsonObject().get("menuislink").getAsInt();
																		    	    		String exlink5 = "";
																		    	    		String extgt5 = "";
																		    	    		String pageLinkNav5 = "";
																		    	    		String pageNavTitle5 = "";
																		    	    		String lDel5 = jsonArr5.get(m).getAsJsonObject().get("lDel").getAsString();
																		    	    		
																		    	    		try {
																								pageLinkNav5 = jsonArr5.get(m).getAsJsonObject().get("pageLinkNav").getAsString();
																								pageNavTitle5 = jsonArr5.get(m).getAsJsonObject().get("pageNavTitle").getAsString();
																							} catch (NullPointerException e) {
																								
																							}		
																							
																		    	    		if(pagePath.equals(link5) && !"".equals(pageLinkNav5)){																		    	    			
																		    	    			model.addAttribute("pageLinkNav", pageLinkNav5);			    	    			
																		    	    		}
																		    	    		
																		    	    		if(pagePath.equals(link5) && !"".equals(pageNavTitle5)){
																		    	    			model.addAttribute("pageNavTitle", pageNavTitle5);			    	    			
																		    	    		}
																		    	    		
																		    	    		if(isexlink5 == 1) {
																			    	    		exlink5 = jsonArr5.get(m).getAsJsonObject().get("menulinkurl").getAsString();
																			    	    		try {
																			    	    			extgt5 = jsonArr5.get(m).getAsJsonObject().get("menulinktgt").getAsString();
																								} catch (UnsupportedOperationException e) {
																								
																								} catch (NullPointerException e) {
																								
																								}
																			    	    	}	
																		    	    		
																		    	    		//if(title5.indexOf("#") != 0) {
																		    	    		if(lDel5.equals("Y")) {
																			    	    		map5.put("title", title5);
																				    			map5.put("link", link5);
																				    			map5.put("exlink", exlink5);
																				    			map5.put("extgt", extgt5);
																				    			map5.put("isexlink", isexlink5);
																				    			map5.put("defaultmenu", defaultmenu5);
																				    			
																				    			menuTree5.add(map5);
																				    			map4.put("childCount", menuTree5.size());																	    				
																				    			map4.put("childTree", menuTree5);
																				    			
																				    			if(pagePath.indexOf(link5) > -1) {
																				    				map5.put("over", "on");														    				
																				    				if(jsonArr5.get(m).getAsJsonObject().has("children")){
																				    					if(jsonArr5.get(m).getAsJsonObject().get("children").isJsonArray()){
																				    						TreeList menuTree6 = new TreeList();
																				    						JsonArray jsonArr6 = jsonArr5.get(m).getAsJsonObject().get("children").getAsJsonArray();
																				    						
																				    						for(int n=0; n<jsonArr6.size(); n++){
																				    							HashMap<String, Object> map6 = new HashMap<String, Object>();
																							    	    		String title6 = jsonArr6.get(n).getAsJsonObject().get("title").getAsString();
																							    	    		String link6 = jsonArr6.get(n).getAsJsonObject().get("menupath").getAsString();																							    	    		
																							    	    		String defaultmenu6 = jsonArr6.get(n).getAsJsonObject().get("defaultmenu").getAsString();
																							    	    		int isexlink6 = jsonArr6.get(n).getAsJsonObject().get("menuislink").getAsInt();
																							    	    		String exlink6 = "";
																							    	    		String extgt6 = "";
																							    	    		String pageLinkNav6 = "";
																							    	    		String pageNavTitle6 = "";
																							    	    		String lDel6 = jsonArr6.get(n).getAsJsonObject().get("lDel").getAsString();
																							    	    		
																							    	    		try {
																													pageLinkNav6 = jsonArr6.get(n).getAsJsonObject().get("pageLinkNav").getAsString();
																													pageNavTitle6 = jsonArr6.get(n).getAsJsonObject().get("pageNavTitle").getAsString();
																												} catch (NullPointerException e) {
																													
																												}													    	    		
																												
																							    	    		if(pagePath.equals(link6) && !"".equals(pageLinkNav6)){
																							    	    			model.addAttribute("pageLinkNav", pageLinkNav6);
																							    	    		}
																							    	    		
																							    	    		if(pagePath.equals(link6) && !"".equals(pageNavTitle6)){
																							    	    			model.addAttribute("pageNavTitle", pageNavTitle6);			    	    			
																							    	    		}
																							    	    		
																							    	    		if(isexlink6 == 1) {
																							    	    			
																								    	    		exlink6 = jsonArr6.get(n).getAsJsonObject().get("menulinkurl").getAsString();
																								    	    		try {
																								    	    			extgt6 = jsonArr6.get(n).getAsJsonObject().get("menulinktgt").getAsString();
																													} catch (UnsupportedOperationException e) {
																														
																													} catch (NullPointerException e) {
																														
																													}
																								    	    	}	
																							    	    		
																							    	    		if(lDel6.equals("Y")) {
																							    	    			map6.put("title", title6);
																									    			map6.put("link", link6);
																									    			map6.put("exlink", exlink6);
																									    			map6.put("extgt", extgt6);
																									    			map6.put("isexlink", isexlink6);
																									    			map6.put("defaultmenu", defaultmenu6);
																									    			
																									    			menuTree6.add(map6);
																									    			map5.put("childCount", menuTree6.size());
																									    			map5.put("childTree", menuTree6);
																									    			
																							    	    		}																							    	    		
																				    						}
																				    					}
																				    				}
																				    			}
																		    	    		}
																		    	    		//menuTree5.add(map5);
																	    				}
																	    			}
															    				}
															    			}
													    	    		}
													    	    		//menuTree4.add(map4);
												    				}
												    			}
										    				}										    				
										    			}
								    	    		}								    	    		
								    	    		//menuTree3.add(map3);
							    				}							    				
							    			}
					    				}
					    			}
				    				//menuTree2.add(map2);
			    	    		}
			    			}	    				
			    		}
		    		}
		    		//menuTree.add(map);
	    		}
	    	}
	    	//model.addAttribute("menuTree", menuTree);
	    }
	    try {
	    	if("pageNavTitle".equals(type)) type = NullUtil.nullString(model.get("pageNavTitle").toString());
		} catch (NullPointerException e) {
			
		}
	    try {
	    	if("pageLinkNav".equals(type)) type = NullUtil.nullString(model.get("pageLinkNav").toString());
		} catch (NullPointerException e) {
			
		}
	    return type;
    }
    
    
    @RequestMapping("/cms/topMenu/add.do")
    public String topMenuAdd(
    		HttpServletRequest request,
    		Model model,
    		@RequestParam String target,
    		@RequestParam String depth) throws IOException, java.io.IOException{
    	
    	int maxDepth = 5;
    	int minDepth = 1;
    	int depthInt = Integer.parseInt(depth);
    	
    	if(depthInt < minDepth){
    		depthInt = minDepth;
    	}else if(depthInt > maxDepth){
    		depthInt = maxDepth;
    	}
    	
    	
    	
    	/* 파일이 없으면 샘플파일 가져와서 복사 */
	    String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/";
	    String baseUrl = defaultPath + "topmenu" + SEPARATOR + target + SEPARATOR + depthInt;
	    String sampleUrl = defaultPath + "topmenu_sample" + SEPARATOR + depthInt;
	    
	    File baseFileUrl = new File(baseUrl);
	    File sampleFileUrl = new File(sampleUrl);
	    
	    boolean fileChk = FileCopy.makeFileDepth(baseUrl, 3);
	    if(!fileChk){
	    	FileCopy.copyDirectoryReplace(sampleFileUrl, baseFileUrl, target);
	    }else{
	    	model.addAttribute("alert", "이미 존재합니다.");
	    	model.addAttribute("path", "/cms/page/view.do?bindType=topMenu");
	    	return "/jnit/util/alertMove";
	    }
    	
    	return "redirect:/cms/page/view.do?bindType=topMenu";
    }
    
}