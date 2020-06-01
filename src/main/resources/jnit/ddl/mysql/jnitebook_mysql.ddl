/**********************************/
/* Table Name: EBOOK 테이블 */
/**********************************/
CREATE TABLE JNITEBOOK(
		EBOOK_ID                      		VARCHAR(50)		 NOT NULL COMMENT '고유번호',
		EBOOK_TITLE                   		VARCHAR(255)		 NULL  COMMENT '제목',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		PAGE_WIDTH                    		INT(38)		 DEFAULT 0		 NULL  COMMENT '페이지 가로',
		PAGE_HEIGHT                   		INT(38)		 DEFAULT 0		 NULL  COMMENT '페이지 세로',
		THUMB_YN                      		VARCHAR(15)		 NULL  COMMENT '썸네일 여부',
		THUMB_AOTO_HIDE               		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 숨기기',
		THUMB_WIDTH                   		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 가로',
		THUMB_HEIGHT                  		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 세로',
		SHARE_LINK                    		VARCHAR(255)		 NULL  COMMENT '링크주소',
		SHARE_TEXT                    		VARCHAR(255)		 NULL  COMMENT '메세지',
		SHARE_VIA                     		VARCHAR(255)		 NULL  COMMENT '소유주',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		EXT01                         		VARCHAR(255)		 NULL  COMMENT '여분필드01',
		EXT02                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '여분필드02',
		EXT03                         		VARCHAR(255)		 NULL  COMMENT '여분필드03',
		EXT04                         		VARCHAR(255)		 NULL  COMMENT '여분필드04',
		EXT05                         		VARCHAR(255)		 NULL  COMMENT '여분필드05'
) COMMENT='EBOOK 테이블';

/**********************************/
/* Table Name: EBOOK 파일테이블 */
/**********************************/
CREATE TABLE JNITEBOOKFILE(
		EBOOK_FILE_ID                 		VARCHAR(50)		 NULL  COMMENT 'EBOOK 고유번호',
		FILE_ID                       		VARCHAR(50)		 NOT NULL COMMENT '고유번호',
		FILE_PID                      		VARCHAR(50)		 NULL  COMMENT 'FILE_PID',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일 경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일 이름',
		FILE_PATH2                    		VARCHAR(255)		 NULL  COMMENT '파일 실제이름',
		FILE_NM2                      		VARCHAR(255)		 NULL  COMMENT '파일 URL',
		FILE_HTML_PATH                		VARCHAR(255)		 NULL  COMMENT 'Html 파일 경로',
		FILE_HTML_NM                  		VARCHAR(255)		 NULL  COMMENT 'Html 파일 이름',
		FILE_NUM                      		INT(10)		 DEFAULT 0		 NULL  COMMENT '순서',
		FILE_TYPE                     		VARCHAR(30)		 NULL  COMMENT '파일설정 종류',
		FILE_CLASS                    		VARCHAR(30)		 NULL  COMMENT 'FILE_CLASS',
		HTML_FILE                     		VARCHAR(4000)		 NULL  COMMENT 'HTML_FILE',
		BACKGROUND_FILE               		VARCHAR(4000)		 NULL  COMMENT 'BACKGROUND_FILE',
		DISABLE_EMBOSSING             		VARCHAR(15)		 NULL  COMMENT 'DISABLE_EMBOSSING',
		TRANSPARENT_PAGE              		VARCHAR(15)		 NULL  COMMENT 'TRANSPARENT_PAGE',
		PAGE_NUMBER                   		VARCHAR(30)		 DEFAULT '0'		 NULL  COMMENT 'PAGE_NUMBER',
		PAGE_NAME                     		VARCHAR(100)		 NULL  COMMENT 'PAGE_NAME',
		PAGE_LABEL                    		VARCHAR(100)		 NULL  COMMENT 'PAGE_LABEL',
		DATA                          		VARCHAR(15)		 NULL  COMMENT 'DATA',
		THUMBNAIL_IMAGE               		VARCHAR(4000)		 NULL  COMMENT 'THUMBNAIL_IMAGE',
		DATA_UNLOAD                   		VARCHAR(15)		 NULL  COMMENT 'DATA_UNLOAD',
		UPLOAD_FILE                   		VARCHAR(4000)		 NULL  COMMENT 'UPLOAD_FILE',
		CONTENT                       		TEXT		 NULL  COMMENT '내용',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='EBOOK 파일테이블';


ALTER TABLE JNITEBOOK ADD CONSTRAINT IDX_JNITEBOOK_PK PRIMARY KEY (EBOOK_ID);

ALTER TABLE JNITEBOOKFILE ADD CONSTRAINT IDX_JNITEBOOKFILE_PK PRIMARY KEY (FILE_ID);

