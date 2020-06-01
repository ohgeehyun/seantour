/**
 * @version 3.2.0.1
 */
package jnit.cms.handler;

import org.springframework.stereotype.Service;

@Service("cmsProperty")
public class CmsPropertyImpl implements CmsProperty {
	private CmsClientProperty cmsClientProperty;
	
	public CmsClientProperty getClientProperty() throws Exception { 
		return cmsClientProperty;
	}
	
	public void setClientProperty(CmsClientProperty cmsClientProperty) throws Exception { 
		this.cmsClientProperty = cmsClientProperty;
	}
}
