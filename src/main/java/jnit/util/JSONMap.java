/**
 * @version 3.2.0.1
 */
package jnit.util;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;

public class JSONMap extends JSONObject implements Map{
	
	private Log log = LogFactory.getLog(getClass());
	
	@Override
	public Object get(Object key) {
		// TODO Auto-generated method stub
		try {
			return super.get(key.toString());
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return null;
	}
	@Override
	public Object put(Object key, Object value) {
		// TODO Auto-generated method stub
		try {
			return super.put(key.toString(), value);
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return null;
	}
	@Override
	public Object remove(Object key) {
		// TODO Auto-generated method stub
		return super.remove(key.toString());
	}
	@Override
	public void putAll(Map m) {
		// TODO Auto-generated method stub  ;
		Set set = m.keySet();
		if(set == null) set = new HashSet();
		Iterator it = set.iterator();
		while(it.hasNext()){
			String key = it.next().toString();
			try {
				super.put(key, m.get(key));
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}  
		}
	}
	@Override
	public Set keySet() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Collection values() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Set entrySet() {
		// TODO Auto-generated method stub
		return null;
	}
}
