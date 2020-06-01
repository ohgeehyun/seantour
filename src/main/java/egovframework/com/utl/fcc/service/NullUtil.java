/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.util.Map;

public class NullUtil {
	
	public static boolean isEmpty(String str){
		boolean flag = true;
		
		try {
			if( str != null){
				if( !"".equals(str.trim())) flag = false;
			}
		}
		catch (Exception e ){
			flag = true;
		}
		return flag;
	}
	
	public static boolean isEmpty(Object obj){
		boolean flag = true;
		
		try {
			if(obj != null){
				flag = isEmpty(obj.toString());
			}	
		}
		catch (Exception e ){
			flag = true;
		}
		return flag;
	}
	
	public static String nullString( String val ) {

		String res = "";

        if ( val == null ) return "";
        if ( val == "null") return "";
        try{
        	res = val.trim();
        }catch ( Exception ex ) {
        	res = "";
        }
    	return res;
    }

	public static int nullInt( String num ) {
		if(nullString(num).equals("")){
			num="0";
		}
		int res = 0;
		try{
        	res = Integer.parseInt( num.trim() );
        } catch ( Exception ex ) {
        	res = 0;
        } 
    	return res;
    }


	public static long nullLong( String num ) {

		long res = 0;
        try{
        	res = Long.parseLong( num.trim() );
        } catch ( Exception ex ) {
	        res = 0;
        }
    	return res;

	}

	public static float nullFloat( String num ) {

        float res = 0;

        try{
        	res = Float.parseFloat( num.trim() );
        } catch ( Exception ex ) {
        	res = 0;
        }
        return res;
	}


	public static double nullDouble( String num ) {

		double res = 0;

		try{
			res = Double.parseDouble( num.trim() );
		} catch ( Exception ex ) {
			res = 0;
		}
		return res;
	}

	public static String nullMap(Map m,String str){
		String res = (String)m.get(str);
		try{
			if(res == null)res = ""; 
		}catch (Exception e) {
			res = "";
		}
		return res;
	}
}
