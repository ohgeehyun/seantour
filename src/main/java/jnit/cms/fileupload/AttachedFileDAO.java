package jnit.cms.fileupload;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import jnit.util.StringUtil;

/**
 * @Class Name : AttachedFileDAO.java
 * @Description : AttachedFile DAO Class
 * @Modification Information
 *
 * @author YDH
 * @since 2016-08-12
 * @version 1.0
 * @see Copyright (C) All right reserved.
 */

@Repository("attachedFileDAO")
public class AttachedFileDAO extends EgovComAbstractDAO {
	/**
	 * 파일을 등록한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 AttachedFileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public synchronized int insertAttachedFile(AttachedFileVO vo) throws Exception {
		return (Integer) insert("attachedFileDAO.insertAttachedFile", vo);
	}

	/**
	 * 파일 정보를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 정보가 담긴 AttachedFileVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateAttachedFile(AttachedFileVO vo) throws Exception {
		update("attachedFileDAO.updateAttachedFile", vo);
	}

	/**
	 * 파일정보를 삭제한다.
	 * 
	 * @param vo
	 *            - 삭제할 정보가 담긴 AttachedFileVO
	 * @return void형
	 * @exception Exception
	 */
	public void deleteAttachedFile(AttachedFileVO vo) throws Exception {
		update("attachedFileDAO.deleteAttachedFile", vo);
	}

	/**
	 * AttachedFileVO을 1건 조회한다.
	 * 
	 * @param vo
	 *            - 조회할 정보가 담긴 AttachedFileVO
	 * @return 조회한 AttachedFileVO
	 * @exception Exception
	 */
	public AttachedFileVO getAttachedFile(AttachedFileVO vo) throws Exception {
		if (vo.getSearchFileId() != null
				&& !StringUtil.equals(vo.getSearchFileId(), ""))
			return (AttachedFileVO) select("attachedFileDAO.getAttachedFile", vo);
		else
			return new AttachedFileVO();
	}

	/**
	 * AttachedFileVO을 여러건 조회한다.
	 * 
	 * @param vo
	 *            - 조회할 정보가 담긴 AttachedFileVO
	 * @return 조회한 AttachedFileVO List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AttachedFileVO> getAttachedFileList(AttachedFileVO vo) throws Exception {
		if (vo.getSearchFileId() != null
				&& !StringUtil.equals(vo.getSearchFileId(), ""))
			return (List<AttachedFileVO>) list("attachedFileDAO.getAttachedFileList", vo);
		else
			return new ArrayList<AttachedFileVO>();
	}
}
