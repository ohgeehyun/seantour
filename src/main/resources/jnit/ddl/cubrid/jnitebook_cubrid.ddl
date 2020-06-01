/**********************************/
/* Table Name: EBOOK 테이블 */
/**********************************/
CREATE TABLE JNITEBOOK(
		EBOOK_ID                      		VARCHAR(50)		 NOT NULL,
		EBOOK_TITLE                   		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		PAGE_WIDTH                    		INT(38)		 DEFAULT 0		 NULL,
		PAGE_HEIGHT                   		INT(38)		 DEFAULT 0		 NULL,
		THUMB_YN                      		VARCHAR(15)		 NULL,
		THUMB_AOTO_HIDE               		INT(38)		 DEFAULT 0		 NULL,
		THUMB_WIDTH                   		INT(38)		 NULL,
		THUMB_HEIGHT                  		INT(38)		 DEFAULT 0		 NULL,
		SHARE_LINK                    		VARCHAR(255)		 NULL,
		SHARE_TEXT                    		VARCHAR(255)		 NULL,
		SHARE_VIA                     		VARCHAR(255)		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		EXT01                         		VARCHAR(255)		 NULL,
		EXT02                         		INT(1)		 DEFAULT 0		 NULL,
		EXT03                         		VARCHAR(255)		 NULL,
		EXT04                         		VARCHAR(255)		 NULL,
		EXT05                         		VARCHAR(255)		 NULL
);

/**********************************/
/* Table Name: EBOOK 파일테이블 */
/**********************************/
CREATE TABLE JNITEBOOKFILE(
		EBOOK_FILE_ID                 		VARCHAR(50)		 NULL,
		FILE_ID                       		VARCHAR(50)		 NOT NULL,
		FILE_PID                      		VARCHAR(50)		 NULL,
		FILE_PATH                     		VARCHAR(255)		 NULL,
		FILE_NM                       		VARCHAR(255)		 NULL,
		FILE_PATH2                    		VARCHAR(255)		 NULL,
		FILE_NM2                      		VARCHAR(255)		 NULL,
		FILE_HTML_PATH                		VARCHAR(255)		 NULL,
		FILE_HTML_NM                  		VARCHAR(255)		 NULL,
		FILE_NUM                      		INT(10)		 DEFAULT 0		 NULL,
		FILE_TYPE                     		VARCHAR(30)		 NULL,
		FILE_CLASS                    		VARCHAR(30)		 NULL,
		HTML_FILE                     		VARCHAR(4000)		 NULL,
		BACKGROUND_FILE               		VARCHAR(4000)		 NULL,
		DISABLE_EMBOSSING             		VARCHAR(15)		 NULL,
		TRANSPARENT_PAGE              		VARCHAR(15)		 NULL,
		PAGE_NUMBER                   		VARCHAR(30)		 DEFAULT '0'		 NULL,
		PAGE_NAME                     		VARCHAR(100)		 NULL,
		PAGE_LABEL                    		VARCHAR(100)		 NULL,
		"DATA"                          		VARCHAR(15)		 NULL,
		THUMBNAIL_IMAGE               		VARCHAR(4000)		 NULL,
		DATA_UNLOAD                   		VARCHAR(15)		 NULL,
		UPLOAD_FILE                   		VARCHAR(4000)		 NULL,
		CONTENT                       		STRING		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);


ALTER TABLE JNITEBOOK ADD CONSTRAINT IDX_JNITEBOOK_PK PRIMARY KEY (EBOOK_ID);

ALTER TABLE JNITEBOOKFILE ADD CONSTRAINT IDX_JNITEBOOKFILE_PK PRIMARY KEY (FILE_ID);

