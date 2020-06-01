/**
 * @version 3.2.0.1
 */
package jnit.util;

import java.util.Calendar;
import java.util.HashMap;
import java.util.TimeZone;

import uk.me.jstott.coordconv.LatitudeLongitude;
import uk.me.jstott.sun.Sun;
import egovframework.com.cmm.service.EgovProperties;

public class SunriseSunset {
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	/**
	 * 
	 * @param java.util.Calendar
	 * @param latitude
	 * @param longitude
	 * @return
	 */
	public static HashMap<String, String> get(Calendar cal, double lat, double lon) {
		LatitudeLongitude ll2 = new LatitudeLongitude(lat, lon);
		TimeZone tmz = TimeZone.getTimeZone("GMT+09:00");
		boolean dst = false;
		HashMap<String, String> suntime = new HashMap<String, String>();
		suntime.put("date", cal.get(Calendar.YEAR)+"/"+(cal.get(Calendar.MONTH) + 1)+"/"+cal.get(Calendar.DAY_OF_MONTH));
		suntime.put("latitude", String.valueOf(lat));
		suntime.put("longitude", String.valueOf(lon));
		suntime.put("sunrise", String.valueOf(Sun.sunriseTime(cal, ll2, tmz, dst)));
		suntime.put("sunset", String.valueOf(Sun.sunsetTime(cal, ll2, tmz, dst)));

		return suntime;
	}
}
