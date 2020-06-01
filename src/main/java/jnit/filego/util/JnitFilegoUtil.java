package jnit.filego.util;

import java.io.File;

import jnit.filego.enums.JnitFilegoFileType;


public class JnitFilegoUtil {

	/**
	 * 파일명으로 배포
	 * @param fileType
	 * @param file
	 */
	public static void transferFile(JnitFilegoFileType fileType, File file) {
		transferFile(fileType, file.getPath());
	}

	/**
	 * 파일명으로 배포
	 * @param fileType
	 * @param path
	 */
	public static void transferFile(JnitFilegoFileType fileType, String path) {
		JnitFilegoSendUtil.sendFile(fileType, path);
	}
	
	/**
	 * 폴더명으로 배포
	 * @param fileType
	 * @param folder
	 */
	public static void transferDirectory(JnitFilegoFileType fileType, File folder) {
		transferDirectory(fileType, folder.getPath());
	}
	
	/**
	 * 폴더명으로 배포
	 * @param fileType
	 * @param path
	 */
	public static void transferDirectory(JnitFilegoFileType fileType, String path) {
		JnitFilegoSendUtil.sendFile(fileType, path);
	}
	
	/**
	 * 파일명으로 삭제
	 * @param fileType
	 * @param file
	 */
	public static void deleteFile(JnitFilegoFileType fileType, File file) {
		deleteFile(fileType, file.getPath());
	}
	
	/**
	 * 파일명으로 삭제
	 * @param fileType
	 * @param path
	 */
	public static void deleteFile(JnitFilegoFileType fileType, String path) {
		JnitFilegoSendUtil.sendFile(fileType, path);
	}
	
	/**
	 * 폴더명으로 삭제
	 * @param fileType
	 * @param folder
	 */
	public static void deleteDirectory(JnitFilegoFileType fileType, File folder) {
		deleteDirectory(fileType, folder.getPath());
	}
	
	/**
	 * 폴더명으로 삭제
	 * @param fileType
	 * @param path
	 */
	public static void deleteDirectory(JnitFilegoFileType fileType, String path) {
		JnitFilegoSendUtil.sendFile(fileType, path);
	}
	/**
	 * ======파일이 수정 및 추가되는 메뉴 정리======
	 * 환경설정 > 기본설정 > 일반설정 : 								/cms/config/default.do
	 * 환경설정 > 기본설정 > 주소 API 설정 : 							/cms/config/apiKey.do
	 * 환경설정 > 기본설정 > 회원가입항목설정 : 						/cms/config/item.do
	 * 환경설정 > 기본설정 > 사이트통계설정 : 							/cms/config/analytics.do
	 * 환경설정 > 보안설정 : 											/cms/config/secure.do
	 * 
	 * 템플릿관리 > 템플릿관리 > 메인템플릿 : 							/cms/sub4/0101.do
	 * 템플릿관리 > 템플릿관리 > 서브템플릿 : 							/cms/sub4/0102.do
	 * 템플릿관리 > 템플릿관리 > 로그인템플릿 : 						/cms/sub4/0104.do
	 * 템플릿관리 > 템플릿관리 > 회원템플릿 : 							/cms/sub4/0104.do
	 * 템플릿관리 > 템플릿관리 > 페이지평가템플릿 > 평가페이지디자인 : 	/cms/rsc/jspPage.do?bindType=addPage
	 * 템플릿관리 > 템플릿관리 > 페이지평가템플릿 > 결과페이지디자인 : 	/cms/rsc/jspPage.do?bindType=upPage
	 * 템플릿관리 > 템플릿관리 > 좌측메뉴 : 							/cms/page/view.do?bindType=leftMenu
	 * 템플릿관리 > 템플릿관리 > 상단메뉴 : 							/cms/page/view.do?bindType=topMenu
	 * 템플릿관리 > 템플릿관리 > 콘텐츠담당표시 : 						/cms/page/view.do?bindType=contentAdmin
	 * 템플릿관리 > 템플릿관리 > 수정버튼표시 : 						/cms/page/view.do?bindType=updateButton
	 * 템플릿관리 > 템플릿관리 > 사이트맵디자인 : 						/cms/page/view.do?bindType=sitemap
	 * 
	 * 콘텐츠관리 > 메뉴/콘텐츠관리 : 									/cms/sub10/0101.do
	 * 콘텐츠관리 > CSS관리 : 											/cms/mgmt/list.do?mgmtType=cssa
	 * 콘텐츠관리 > 스크립트관리 : 										/cms/mgmt/list.do?mgmtType=js
	 * 콘텐츠관리 > 이미지관리 : 										/cms/mgmt/list.do?mgmtType=img
	 * 콘텐츠관리 > 동영상관리 : 										/cms/mgmt/list.do?mgmtType=video
	 * 콘텐츠관리 > 첨부파일관리 : 										/cms/mgmt/list.do?mgmtType=file
	 * Ps. =====================================================================================================파일 삭제시 어떻게 할지 확인.
	 * 
	 * 컴포넌트관리 > 게시판관리 > 게시판공통스크립트 : 				/cms/board/pageView.do
	 * 컴포넌트관리 > 게시판관리 > 게시판 디자인 : 						/cms/board/skinList.do
	 * 컴포넌트관리 > 게시판관리 > 최근게시물 관리 > 최근게시물디자인 : /cms/mgmt/list.do?mgmtType=boardLatest
	 * 컴포넌트관리 > 배너관리 > 배너설정 : 							/cms/allim/groupList.do?type=banner
	 * 컴포넌트관리 > 배너관리 > 배너디자인 > 배너메인 : 				/cms/page/view.do?bindType=bannerRolling
	 * 컴포넌트관리 > 배너관리 > 배너디자인 > 배너더보기 : 				/cms/page/view.do?bindType=bannerMore
	 * 컴포넌트관리 > 알리미관리 > 알리미설정 : 						/cms/allim/groupList.do?type=allim
	 * 컴포넌트관리 > 알리미관리 > 알리미디자인 : 						/cms/page/view.do?bindType=allimView
	 * 컴포넌트관리 > 팝업관리 > 팝업설정 : 							/cms/allim/groupList.do?type=popup
	 * 컴포넌트관리 > 팝업관리 > 팝업디자인 : 							/cms/page/view.do?bindType=PopupView
	 * 컴포넌트관리 > SMS관리 > SMS 설정 : 								/cms/config/sms.do
	 */
	
}
