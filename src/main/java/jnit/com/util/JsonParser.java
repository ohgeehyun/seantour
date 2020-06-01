/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import net.sf.json.JSONObject;

public class JsonParser {
	
	public static JSONObject toJson(String str){
		String jsonStr = str.replace("\'", "&#39;");
		return JSONObject.fromObject(jsonStr);
	}
}
