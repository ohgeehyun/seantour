package jnit.cms.fileupload;

import java.util.List;

/**
 * @Class Name : AttachedFileService.java
 * @Description : AttachedFile Business class
 * @Modification Information
 *
 * @author YDH
 * @since 2016-08-12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface AttachedFileService {
	/**
	 * 파일을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AttachedFileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    int insertAttachedFile(AttachedFileVO vo) throws Exception;
    
    /**
	 * 파일 정보를 수정한다.
	 * @param vo - 수정할 정보가 담긴 AttachedFileVO
	 * @return void형
	 * @exception Exception
	 */
    void updateAttachedFile(AttachedFileVO vo) throws Exception;

    /**
	 * 파일정보를 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AttachedFileVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteAttachedFile(AttachedFileVO vo) throws Exception;

    /**
	 * AttachedFileVO을 1건 조회한다.
	 * @param vo - 조회할 정보가 담긴 AttachedFileVO
	 * @return 조회한 AttachedFileVO
	 * @exception Exception
	 */
    AttachedFileVO getAttachedFile(AttachedFileVO vo) throws Exception;

    /**
	 * AttachedFileVO을 여러건 조회한다.
	 * @param vo - 조회할 정보가 담긴 AttachedFileVO
	 * @return 조회한 AttachedFileVO List
	 * @exception Exception
	 */
    List<AttachedFileVO> getAttachedFileList(AttachedFileVO vo) throws Exception;
}
