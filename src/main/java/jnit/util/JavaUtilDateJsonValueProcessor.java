/**
 * @version 3.2.0.1
 */
package jnit.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class JavaUtilDateJsonValueProcessor implements JsonValueProcessor {

	private Log log = LogFactory.getLog(getClass());
	private final DateFormat defaultDateFormat;

	public JavaUtilDateJsonValueProcessor(){
		defaultDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
	}


	public Object processArrayValue(Object arg0, JsonConfig arg1) {
		if(arg0 == null) return null;
		try {
			return defaultDateFormat.parse(String.valueOf(arg0));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			log.error(e.getMessage());
		}
		//return defaultDateFormat.format(arg0);
		return defaultDateFormat.format(arg0);
	}

	public Object processObjectValue(String arg0, Object arg1, JsonConfig arg2) {
		// TODO Auto-generated method stub
		return processArrayValue(arg1, arg2);
	}

}