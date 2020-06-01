/**
 * @version 3.2.0.1
 */
package jnit.com.service;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * JNIT 기본 DAO 클래스
 * @author JNIT
 * @since 2012.06.22
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2012.06.22  JNIT          최초 생성
 *
 * </pre>
 */
public class JnitDefaultDAO extends EgovComAbstractDAO{

	/**
	 * 전자정부프레임워크3에서 selectByPk가 deprecate되었으므로 3에서는 overide가 되고 이하버전에서는 일반 메소드로 됨.
	 */
	public Object select(String queryId, Object parameterObject) {
		return getSqlMapClientTemplate().queryForObject(queryId, parameterObject);
	}
}
