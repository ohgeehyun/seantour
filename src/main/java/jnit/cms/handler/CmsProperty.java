/**
 * @version 3.2.0.1
 */
package jnit.cms.handler;

public interface CmsProperty {
	CmsClientProperty getClientProperty() throws Exception;
	
	void setClientProperty(CmsClientProperty cmsClientProperty) throws Exception;
}