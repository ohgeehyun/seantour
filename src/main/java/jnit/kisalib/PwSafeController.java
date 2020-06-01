/**
 * @version 3.2.0.1
 */
package jnit.kisalib;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;

@Controller
public class PwSafeController {

	private Log log = LogFactory.getLog(getClass());
	
	@RequestMapping("/jnit/kisalib/pwSafe.do")
	public String pwSafe(HttpServletRequest request, Model model){
		
		 String password = NullUtil.nullString(request.getParameter("passwd"));
	        JSONObject pwObj = new JSONObject();

	        if (password.length() >  0)
	        {
	                Cracklib clib = new Cracklib();
	                int nReturn = 0;

	                java.sql.Connection conn = null;
	                int nFSearch = 0;
	                int nBSearch = 0;

	                try {
	                        // DB 풀에서 DB연결 가능한 커넥션을 얻어옴
	                conn = clib.getConnection();
	                if (conn != null) {
	                        // 입력된 패스워드를 사전DB에서 검색
	                                nFSearch = clib.DBForwardSearch(conn, password);
	                                // 입력된 패스워드를 역순으로 바꾼후 사전DB에서 검색
	                                nBSearch = clib.DBBackwardSearch(conn, password);

	                                int nUpdate = clib.doUpdateCheck(conn);
	                                if (nUpdate == 1) {
	                                        clib.SetDBConfig(clib.getLevelScore(), clib.getRangeScore(), clib.getAddChar(), clib.getExceptChar(), clib.getMinLen(), clib.getMinDiff(), clib.getMinStep());
	                                }

	                                // 패스워드와 사전DB결과를 입력하여 최종 결과값을 리턴 받음
	                                nReturn = clib.PassCheck_DB(password, nFSearch, nBSearch);
//	                              log.debug(nReturn);
	                        }
	                } catch (NullPointerException e){
	        			log.error(e.getMessage());
	                }
	                catch(Exception e) {
	                        log.error(e.getMessage());
	                }finally {
	                        // 사용이 끝난 커넥션을 DB 풀로 반환
	                        clib.close(conn);
	                }
		
	                if (nReturn > 0)
	                {
//	                strOut = "[검증 결과]";

	                        int Chars = (nReturn >> 28) & 0x0f;
	                        int Lenght = (nReturn >> 20) & 0xff;
	                        int Level = (nReturn >> 16) & 0x0f;
	                        int Etc = nReturn & 0xffff;

//	                      log.debug("level" + Level);
	                if (Level == 0x01)  pwObj.put("level", "하");
	                if (Level == 0x02)  pwObj.put("level", "중");
	                if (Level == 0x03)  pwObj.put("level", "상");
	                if (Level == 0x04)  pwObj.put("level", "최상");
	                //pwObj += "";

	              /*
	              strOut += "[패스워드 상태]";
	              strOut += "길이 : ";
	              strOut += Lenght;
	              strOut += "";
	              strOut += "문자열 : ";
	              strOut += Chars;
	              strOut += "";

	              strOut += "[검증 결과 분석]";
	              */

                    if ((Etc & 0x0001) == 0x0001) {
                    	pwObj.put("info01", "사전에 있는 단어가 포함된 패스워드 입니다.");
                    }

	                if ((Etc & 0x0010) == 0x0010) {
	                	pwObj.put("info02", "충분한 크기의 패스워드가 아닙니다.");
	                }

	                if ((Etc & 0x0100) == 0x0100) {
	                	pwObj.put("info03", "패스워드 반복되는 문자열을 포함합니다.");
	                }

	                if ((Etc & 0x1000) == 0x1000) {
	                	pwObj.put("info04", "패스워드에 사용된 문자의 개수가 적습니다.");
	                }
	                }
	        }
	        else
	        {
	        	pwObj.put("valNull", "패스워드를 입력하세요.");
	        }
	        
	        model.addAttribute("json", pwObj);
		return "/jnit/util/json";
	}
}
