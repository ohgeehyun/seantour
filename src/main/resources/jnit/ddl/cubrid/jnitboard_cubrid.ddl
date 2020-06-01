/**********************************/
/* Table Name: 게시판 설정 테이블  */
/**********************************/
CREATE TABLE JNITBOARDINFO(
		BOARD_ID                      		VARCHAR(20)		 NOT NULL,
		BOARD_GROUP                   		VARCHAR(100)		 NULL,
		BOARD_TITLE                   		VARCHAR(200)		 NULL,
		LATEST_CONFIG                 		VARCHAR(20)		 NULL,
		LATEST_VALUE                  		VARCHAR(100)		 NULL,
		BOARD_TYPE                    		VARCHAR(255)		 NULL,
		BOARD_SKIN                    		VARCHAR(100)		 DEFAULT 'default'		 NULL,
		ROW_CNT                       		INT(10)		 NULL,
		USE_REPLY                       		INT(1)		 DEFAULT 1		 NULL,
		BOARD_SORT                    		VARCHAR(100)		 NULL,
		BOARD_LBL                     		VARCHAR(200)		 DEFAULT '글번호|제목|작성자|작성일|조회수'		 NULL,
		FIELD_SORT_LIST               		VARCHAR(255)		 DEFAULT 'no,title,writer,created,hit'		 NULL,
		FIELD_SORT_VIEW               		VARCHAR(255)		 NULL,
		FIELD_SORT_WRITE              		VARCHAR(255)		 DEFAULT 'no,title,writer,created,hit,content'		 NULL,
		USE_INTERNAL                       	INT(1)		 DEFAULT 0		 NULL,
		USE_CMT                       		INT(1)		 DEFAULT 0		 NULL,
		USE_LIST_REPLY                		INT(1)		 DEFAULT 1		 NULL,
		USE_VIEW_REPLY                		INT(1)		 DEFAULT 0		 NULL,
		USE_ACTIVE                    		INT(1)		 DEFAULT 0		 NULL,
		USE_SECRET                    		INT(1)		 DEFAULT 0		 NULL,
		USE_NOTICE                    		INT(1)		 DEFAULT 0		 NULL,
		USE_FILTER                    		INT(1)		 DEFAULT 0		 NULL,
		FIELTER_ACTION                		VARCHAR(200)		 NULL,
		USE_WYSWYG                    		INT(1)		 DEFAULT 1		 NULL,
		USE_WYSWYG_TYPE               		VARCHAR(30)		 NULL,
		USE_FILE                      		INT(1)		 DEFAULT 1		 NULL,
		USE_IMAGE                     		INT(1)		 DEFAULT 1		 NULL,
		USE_MOVIE                     		INT(1)		 DEFAULT 0		 NULL,
		USE_SMS                       		INT(1)		 DEFAULT 0		 NULL,
		SMS_NUM                       		VARCHAR(100)		 NULL,
		USE_CATEGORY                  		INT(1)		 DEFAULT 0		 NULL,
		CATEGORY                      		VARCHAR(255)		 NULL,
		USE_SOCIAL                    		INT(1)		 DEFAULT 0		 NULL,
		USE_LANGUAGE                  		VARCHAR(25)		 NULL,
		USE_EXT01                     		INT(1)		 NULL,
		EXT01_OPT                     		VARCHAR(200)		 NULL,
		EXT01_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT02                     		INT(1)		 DEFAULT 0		 NULL,
		EXT02_OPT                     		VARCHAR(200)		 NULL,
		EXT02_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT03                     		INT(1)		 DEFAULT 0		 NULL,
		EXT03_OPT                     		VARCHAR(200)		 NULL,
		EXT03_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT04                     		INT(1)		 DEFAULT 0		 NULL,
		EXT04_OPT                     		VARCHAR(200)		 NULL,
		EXT04_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT05                     		INT(1)		 DEFAULT 0		 NULL,
		EXT05_OPT                     		VARCHAR(200)		 NULL,
		EXT05_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT06                     		INT(1)		 DEFAULT 0		 NULL,
		EXT06_OPT                     		VARCHAR(200)		 NULL,
		EXT06_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT07                     		INT(1)		 DEFAULT 0		 NULL,
		EXT07_OPT                     		VARCHAR(200)		 NULL,
		EXT07_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT08                     		INT(1)		 DEFAULT 0		 NULL,
		EXT08_OPT                     		VARCHAR(200)		 NULL,
		EXT08_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT09                     		INT(1)		 DEFAULT 0		 NULL,
		EXT09_OPT                     		VARCHAR(200)		 NULL,
		EXT09_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT10                     		INT(1)		 DEFAULT 0		 NULL,
		EXT10_OPT                     		VARCHAR(200)		 NULL,
		EXT10_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT11                     		INT(1)		 DEFAULT 0		 NULL,
		EXT11_OPT                     		VARCHAR(200)		 NULL,
		EXT11_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT12                     		INT(1)		 DEFAULT 0		 NULL,
		EXT12_OPT                     		VARCHAR(200)		 NULL,
		EXT12_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT13                     		INT(1)		 DEFAULT 0		 NULL,
		EXT13_OPT                     		VARCHAR(200)		 NULL,
		EXT13_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT14                     		INT(1)		 DEFAULT 0		 NULL,
		EXT14_OPT                     		VARCHAR(200)		 NULL,
		EXT14_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT15                     		INT(1)		 DEFAULT 0		 NULL,
		EXT15_OPT                     		VARCHAR(200)		 NULL,
		EXT15_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT16                     		INT(1)		 DEFAULT 0		 NULL,
		EXT16_OPT                     		VARCHAR(200)		 NULL,
		EXT16_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT17                     		INT(1)		 DEFAULT 0		 NULL,
		EXT17_OPT                     		VARCHAR(200)		 NULL,
		EXT17_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT18                     		INT(1)		 DEFAULT 0		 NULL,
		EXT18_OPT                     		VARCHAR(200)		 NULL,
		EXT18_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT19                     		INT(1)		 DEFAULT 0		 NULL,
		EXT19_OPT                     		VARCHAR(200)		 NULL,
		EXT19_LBL                     		VARCHAR(200)		 NULL,
		USE_EXT20                     		INT(1)		 DEFAULT 0		 NULL,
		EXT20_OPT                     		VARCHAR(200)		 NULL,
		EXT20_LBL                     		VARCHAR(200)		 NULL,
		USE_DATE01                    		INT(1)		 DEFAULT 0		 NULL,
		DATE01_OPT                    		VARCHAR(200)		 NULL,
		DATE01_LBL                    		VARCHAR(200)		 NULL,
		USE_DATE02                    		INT(1)		 DEFAULT 0		 NULL,
		DATE02_OPT                    		VARCHAR(200)		 NULL,
		DATE02_LBL                    		VARCHAR(200)		 NULL,
		USE_REACT                     		INT(1)		 DEFAULT 0		 NULL,
		ADM_EXT                       		STRING		 NULL,
		ADM_LIST                      		VARCHAR(50)		 DEFAULT 'A,B,C'		 NULL,
		PERM_LIST                     		VARCHAR(50)		 DEFAULT 'Z'		 NULL,
		PERM_VIEW                     		VARCHAR(50)		 DEFAULT 'Z'		 NULL,
		PERM_WRITE                    		VARCHAR(50)		 DEFAULT 'Z'		 NULL,
		PERM_CMT                      		VARCHAR(50)		 DEFAULT 'Z'		 NULL,
		ANON_PERM_LIST                		INT(1)		 DEFAULT 1		 NULL,
		ANON_PERM_VIEW                		INT(1)		 DEFAULT 1		 NULL,
		ANON_PERM_WRITE               		INT(1)		 DEFAULT 0		 NULL,
		HIDE_WRITE                    		INT(1)		 DEFAULT 0		 NULL,
		ACTIVE                        		INT(1)		 DEFAULT 1		 NULL,
		PERM_REPLY                    		VARCHAR(50)		 NULL,
		PERM_VIEW_TYPE                		VARCHAR(255)		 NULL,
		PERM_WRITE_TYPE               		VARCHAR(255)		 NULL,
		PERM_REPLY_TYPE               		VARCHAR(255)		 NULL,
		FILTER_ACTION                 		VARCHAR(200)		 NULL,
		PERM_LIST_TYPE                		VARCHAR(255)		 NULL,
		PERM_CMT_TYPE                 		VARCHAR(255)		 NULL,
		PERM_FILE_DOWN                		VARCHAR(50)		 NULL,
		PERM_FILE_DOWN_TYPE           		VARCHAR(255)		 NULL,
		BOARD_URL                     		VARCHAR(255)		 NULL,
		USE_LATESTLIST                		INT(1)		 DEFAULT 0		 NULL,
		THUMB_WIDTH                   		INT(10)		 DEFAULT 0		 NULL,
		THUMB_HEIGHT                  		INT(10)		 DEFAULT 0		 NULL,
		THUMB_MAXDIM                  		INT(10)		 DEFAULT 0		 NULL,
		FILE_BLACKLIST						VARCHAR(255)	NULL,
		FILE_LIMIT_SIZE						INT(10)		DEFAULT 500	NULL,
		FILE_LIMIT_COUNT					INT(10)		DEFAULT 5	NULL,
		TMP1                          		VARCHAR(4000)		 NULL,
		TMP2                          		VARCHAR(255)		 NULL,
		TMP3                          		VARCHAR(255)		 NULL,
		TMP4                          		VARCHAR(255)		 NULL,
		TMP5                          		VARCHAR(255)		 NULL,
		ISDEL                         		INT(1)		 NULL
);

/**********************************/
/* Table Name: 게시판코멘트테이블 */
/**********************************/
CREATE TABLE JNITBOARDCMT(
		CMT_ID                        		VARCHAR(20)		 NOT NULL,
		BOARD_ID                      		VARCHAR(20)		 NOT NULL,
		BOARD_CNT_ID                  		INT(20)		 NOT NULL,
		CMT_TEXT                     		STRING		 NOT NULL,
		MBR_ID                        		VARCHAR(20)		 NOT NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: 게시판첨부파일 */
/**********************************/
CREATE TABLE JNITBOARDFILE(
		FILE_ID                       		VARCHAR(20)		 NOT NULL,
		BOARD_ID                      		VARCHAR(20)		 NULL,
		BOARD_CNT_ID                  		INT(20)		 NULL,
		FILE_URL                      		VARCHAR(255)		 NULL,
		FILE_PATH                     		VARCHAR(255)		 NULL,
		FILE_NM                       		VARCHAR(255)		 NULL,
		FILE_ONM                      		VARCHAR(255)		 NULL,
		ISMAIN                        		INT(10)		 DEFAULT 0		 NULL,
		FILE_DOWNLOAD_COUNT           		INT(38)		 DEFAULT 0		 NULL,
		EXT01                         		VARCHAR(200)		 NULL,
		EXT02                         		VARCHAR(200)		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);


/**********************************/
/* Table Name: 일반게시판템플릿 */
/**********************************/
CREATE TABLE JNITBOARDTPL(
		ID                            		INT(20)		 NOT NULL,
		GRP                           		INT(20)		 NULL,
		IDX                           		VARCHAR(255)		 NULL,
		IS_SECRET                     		INT(1)		 DEFAULT 0		 NULL,
		IS_NOTICE                     		INT(1)		 DEFAULT 0		 NULL,
		IS_HTML                       		INT(1)		 NULL,
		CATEGORY                      		VARCHAR(100)		 NULL,
		TITLE                         		VARCHAR(255)		 NOT NULL,
		CONTENT                       		STRING		 NULL,
		PASSWORD                      		VARCHAR(255)		 NULL,
		EXT01                         		VARCHAR(255)		 NULL,
		EXT02                         		VARCHAR(255)		 NULL,
		EXT03                         		VARCHAR(255)		 NULL,
		EXT04                         		VARCHAR(255)		 NULL,
		EXT05                         		VARCHAR(255)		 NULL,
		EXT06                         		VARCHAR(255)		 NULL,
		EXT07                         		VARCHAR(255)		 NULL,
		EXT08                         		VARCHAR(255)		 NULL,
		EXT09                         		VARCHAR(255)		 NULL,
		EXT10                         		VARCHAR(255)		 NULL,
		EXT11                         		VARCHAR(255)		 NULL,
		EXT12                         		VARCHAR(255)		 NULL,
		EXT13                         		VARCHAR(255)		 NULL,
		EXT14                         		VARCHAR(255)		 NULL,
		EXT15                         		VARCHAR(255)		 NULL,
		EXT16                         		VARCHAR(255)		 NULL,
		EXT17                         		VARCHAR(255)		 NULL,
		EXT18                         		VARCHAR(255)		 NULL,
		EXT19                         		VARCHAR(255)		 NULL,
		EXT20                         		VARCHAR(255)		 NULL,
		DATE01                        		DATETIME		 NULL,
		DATE02                        		DATETIME		 NULL,
		HIT                           		INT(20)		 DEFAULT 0		 NULL,
		WRITER                        		VARCHAR(200)		 NULL,
		MBR_ID                        		VARCHAR(200)		 NULL,
		MBR_IP                        		VARCHAR(64)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		"ACTIVE"                        		INT(1)		 DEFAULT 0		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		TMP1                          		VARCHAR(255)		 NULL,
		TMP2                          		VARCHAR(255)		 NULL,
		TMP3                          		VARCHAR(255)		 NULL,
		TMP4                          		VARCHAR(255)		 NULL,
		TMP5                          		VARCHAR(255)		 NULL
);

/**********************************/
/* Table Name: 게시판추천 */
/**********************************/
CREATE TABLE JNITBOARDGOOD(
		IDX                           		VARCHAR(20)		 NOT NULL,
		BOARD_ID                      		VARCHAR(20)		 NOT NULL,
		BOARD_CNT_ID                  		INT(20)		 NOT NULL,
		MBR_ID                        		VARCHAR(30)		 NULL,
		IPADDR                        		VARCHAR(30)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		EXT01                         		VARCHAR(200)		 NULL,
		EXT02                         		VARCHAR(200)		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: 동영상게시판 */
/**********************************/
CREATE TABLE JNITBOARDMEDIA(
		JNITMEDIA_ID                  		INT(38)		 NOT NULL,
		ORG_NM                        		VARCHAR(255)		 NULL,
		DST_NM                        		VARCHAR(255)		 NULL,
		SUCCESS_FLAG                  		INT(1)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 NULL
);


ALTER TABLE JNITBOARDINFO ADD CONSTRAINT IDX_JNITBOARDINFO_PK PRIMARY KEY (BOARD_ID);

ALTER TABLE JNITBOARDCMT ADD CONSTRAINT IDX_JNITBOARDCMT_PK PRIMARY KEY (CMT_ID);

ALTER TABLE JNITBOARDFILE ADD CONSTRAINT IDX_JNITBOARDFILE_PK PRIMARY KEY (FILE_ID);

ALTER TABLE JNITBOARDTPL ADD CONSTRAINT IDX_JNITBOARDTPL_PK PRIMARY KEY (ID);

ALTER TABLE JNITBOARDGOOD ADD CONSTRAINT IDX_JNITBOARDGOOD_PK PRIMARY KEY (IDX);

ALTER TABLE JNITBOARDMEDIA ADD CONSTRAINT IDX_JNITBOARDMEDIA_PK PRIMARY KEY (JNITMEDIA_ID);
