/**
 * @version 3.2.0.1
 */
DROP TABLE  IF EXISTS `bbs_1000000000000000`;
DROP TABLE  IF EXISTS `jnit_ltskorea_sms`;
DROP TABLE  IF EXISTS `jnitallim_imgfile`;
DROP TABLE  IF EXISTS `jnitallim_item`;
DROP TABLE  IF EXISTS `jnitallim_group`;
DROP TABLE  IF EXISTS `jnitboardcmt`;
DROP TABLE  IF EXISTS `jnitboardfile`;
DROP TABLE  IF EXISTS `jnitboardgood`;
DROP TABLE  IF EXISTS `jnitboardinfo`;
DROP TABLE  IF EXISTS `jnitboardtpl`;
DROP TABLE  IF EXISTS `jnitboardmedia`;


DROP TABLE  IF EXISTS `jnitcmsboardhist`;
DROP TABLE  IF EXISTS `jnitcmsdisseminate`;
DROP TABLE  IF EXISTS `jnitcmsdisseminatehistory`;
DROP TABLE  IF EXISTS `jnitcmscsshist`;
DROP TABLE  IF EXISTS `jnitcmsscripthist`;
DROP TABLE  IF EXISTS `jnitcmstplhist`;
DROP TABLE  IF EXISTS `jnitcmshist`;
DROP TABLE  IF EXISTS `jnitcmstpl`;
DROP TABLE  IF EXISTS `jnitcmscnt`;
DROP TABLE  IF EXISTS `jnitcmsmenumgr`;
DROP TABLE  IF EXISTS `jnitcmsmenu`;
DROP TABLE  IF EXISTS `jnitcmssite`;
DROP TABLE  IF EXISTS `jnitcmsmbrpackage`;
DROP TABLE  IF EXISTS `jnitcmsmbr`;
DROP TABLE  IF EXISTS `jnitcmsmbrtype`;
DROP TABLE  IF EXISTS `jnitcmspos`;
DROP TABLE  IF EXISTS `jnitcmsorg`;
DROP TABLE  IF EXISTS `jnitcmsmbrlog`;
DROP TABLE  IF EXISTS `jnitcmsmbrsess`;
DROP TABLE  IF EXISTS `jnitcmsmgmt`;
DROP TABLE  IF EXISTS `jnitcmsmgmtitem`;
DROP TABLE  IF EXISTS `jnitcmsmgmtcategory`;
DROP TABLE  IF EXISTS `jnitcmsrank`;

DROP TABLE  IF EXISTS `jnitebookfile`;
DROP TABLE  IF EXISTS `jnitebook`;

DROP TABLE  IF EXISTS `jnitloginlog`;
DROP TABLE  IF EXISTS `jnitmenu`;
DROP TABLE  IF EXISTS `jnitmgovaddrlist`;
DROP TABLE  IF EXISTS `jnitmgovaddrgrp`;

DROP TABLE  IF EXISTS `jnitresearchadmin`;
DROP TABLE  IF EXISTS `jnitresearchrespondent`;
DROP TABLE  IF EXISTS `jnitresearchcategory`;
DROP TABLE  IF EXISTS `jnitresearchanswer`;
DROP TABLE  IF EXISTS `jnitresearchquestion`;
DROP TABLE  IF EXISTS `jnitresearch`;

DROP TABLE  IF EXISTS `jnitrscpagedata`;
DROP TABLE  IF EXISTS `jnitrscpage`;
DROP TABLE  IF EXISTS `jnitrscdata`;
DROP TABLE  IF EXISTS `jnitrsc`;

DROP TABLE  IF EXISTS `jnitscrap`;
DROP TABLE  IF EXISTS `jnitseq`;
DROP TABLE  IF EXISTS `jnitsitestate`;
DROP TABLE  IF EXISTS `jnitsitestatelist`;
DROP TABLE  IF EXISTS `jnitsmsaddressbook`;
DROP TABLE  IF EXISTS `jnitvisitcount`;
DROP TABLE  IF EXISTS `jnitvisitlog`;
DROP TABLE  IF EXISTS `mgov_serial`;

DROP VIEW  `jnitcmscntvt`;
DROP VIEW  `jnitcmsmenu_vt`;
DROP VIEW  `jnitmenu_vt`;

DROP TABLE IF EXISTS `jnitcmsmenutree`;

/**********************************/
/* Table Name: SEQ키관리테이블 */
/**********************************/
CREATE TABLE JNITSEQ(
		TABLE_NAME                    		VARCHAR(50)		 NOT NULL,
		NEXT_ID                       		INT(38)		 NULL
);

ALTER TABLE JNITSEQ ADD CONSTRAINT IDX_JNITSEQ_PK PRIMARY KEY (TABLE_NAME);

/**********************************/
/* Table Name: 알리미 그룹 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_GROUP(
		GROUP_ID                      		VARCHAR(20)		 NULL,
		GROUP_NM                      		VARCHAR(255)		 NULL,
		GROUP_WIDTH                   		VARCHAR(255)		 NULL,
		GROUP_HEIGHT                  		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		GROUP_EXT01                   		VARCHAR(255)		 NULL,
		GROUP_EXT02                   		VARCHAR(255)		 NULL,
		GROUP_EXT03                   		INT(10)		 DEFAULT 0		 NULL,
		GROUP_EXT04                   		INT(10)		 DEFAULT 0		 NULL,
		GROUP_TYPE                    		VARCHAR(20)		 NULL,
		GROUP_CLASSNAME               		VARCHAR(255)		 NULL,
		GROUP_DIRECTION               		INT(1)		 DEFAULT 0		 NULL,
		GROUP_CHANGETIME              		INT(4)		 DEFAULT 0		 NULL,
		GROUP_SHOWITEMS               		INT(4)		 DEFAULT 0		 NULL,
		GROUP_TIMERDELAY              		INT(10)		 DEFAULT 0		 NULL,
		GROUP_ANIMATIONDELAY          		INT(10)		 DEFAULT 0		 NULL,
		GROUP_AUTO                    		INT(1)		 DEFAULT 0		 NULL,
		GROUP_CATEGORY                		VARCHAR(50)		 NULL
);

/**********************************/
/* Table Name: 알리미 데이터 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_ITEM(
		ITEM_ID                       		VARCHAR(20)		 NULL,
		GROUP_ID                      		VARCHAR(20)		 NULL,
		ITEM_NM                       		VARCHAR(255)		 NULL,
		ITEM_TYPE                     		VARCHAR(100)		 NULL,
		ITEM_LINK                     		VARCHAR(255)		 NULL,
		ITEM_TARGET                   		VARCHAR(50)		 NULL,
		ITEM_DESCRIPT                 		VARCHAR(255)		 NULL,
		ITEM_MEMO                     		STRING		 NULL,
		ITEM_ACTIVE                   		INT(1)		 DEFAULT 0		 NULL,
		ITEM_STARTDATE                		DATETIME		 NULL,
		ITEM_ENDDATE                  		DATETIME		 NULL,
		ITEM_HTMLCODE                 		STRING		 NULL,
		ITEM_MODE                     		VARCHAR(100)		 NULL,
		ITEM_WIDTH                    		VARCHAR(255)		 NULL,
		ITEM_HEIGHT                   		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		ITEM_EXT01                    		VARCHAR(255)		 NULL,
		ITEM_EXT02                    		VARCHAR(255)		 NULL,
		ITEM_EXT03                    		INT(10)		 DEFAULT 0		 NULL,
		ITEM_EXT04                    		INT(10)		 DEFAULT 0		 NULL,
		ITEM_URL                      		VARCHAR(255)		 NULL,
		ITEM_SORT                     		INT(4)		 DEFAULT 0		 NULL,
		ITEM_ORIGIN                   		VARCHAR(255)		 NULL,
		ITEM_ALT                      		STRING		 NULL,
		ITEM_TOP                      		VARCHAR(255)		 NULL,
		ITEM_RIGHT                    		VARCHAR(255)		 NULL,
		ITEM_EXT05                    		VARCHAR(255)		 NULL,
		ITEM_EXT06                    		VARCHAR(255)		 NULL,
		ITEM_EXT07                    		VARCHAR(255)		 NULL,
		ITEM_EXT08                    		VARCHAR(255)		 NULL,
		ITEM_EXT09                    		VARCHAR(255)		 NULL,
		ITEM_EXT10                    		VARCHAR(255)		 NULL,
		ITEM_EXT11                    		VARCHAR(255)		 NULL,
		ITEM_EXT12                    		VARCHAR(255)		 NULL,
		ITEM_URL_PATH                 		VARCHAR(255)		 NULL
);

/**********************************/
/* Table Name: 알리미 데이터 이미지 파일 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_IMGFILE(
		IMG_ID                        		VARCHAR(20)		 NULL,
		ITEM_ID                       		VARCHAR(20)		 NULL,
		IMG_URL                       		STRING		 NULL,
		IMG_ORIGINNM                  		VARCHAR(255)		 NULL,
		IMG_SORTNUM                   		INT(10)		 DEFAULT 0		 NULL,
		IMG_PATH                      		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		IMG_EXT01                     		VARCHAR(255)		 NULL,
		IMG_EXT02                     		VARCHAR(255)		 NULL,
		IMG_EXT03                     		INT(10)		 NULL,
		IMG_EXT04                     		INT(10)		 NULL
);

ALTER TABLE JNITALLIM_GROUP ADD CONSTRAINT IDX_JNITALLIM_GROUP_PK PRIMARY KEY (GROUP_ID);

ALTER TABLE JNITALLIM_ITEM ADD CONSTRAINT IDX_JNITALLIM_ITEM_PK PRIMARY KEY (ITEM_ID);
ALTER TABLE JNITALLIM_ITEM ADD CONSTRAINT IDX_JNITALLIM_ITEM_FK0 FOREIGN KEY (GROUP_ID) REFERENCES JNITALLIM_GROUP (GROUP_ID);

ALTER TABLE JNITALLIM_IMGFILE ADD CONSTRAINT IDX_JNITALLIM_IMGFILE_PK PRIMARY KEY (IMG_ID);
ALTER TABLE JNITALLIM_IMGFILE ADD CONSTRAINT IDX_JNITALLIM_IMGFILE_FK0 FOREIGN KEY (ITEM_ID) REFERENCES JNITALLIM_ITEM (ITEM_ID);

/**********************************/
/* Table Name: 게시판 설정 테이블  */
/**********************************/
CREATE TABLE JNITBOARDINFO(
		BOARD_ID                      		VARCHAR(20)		 NOT NULL,
		BOARD_GROUP                   		VARCHAR(100)		 NULL,
		BOARD_TITLE                   		VARCHAR(200)		 NULL,
		LATEST_CONFIG                 		VARCHAR(20)		 NULL,
		LATEST_VALUE                  		VARCHAR(100)		 NULL,
		BOARD_TYPE                    		VARCHAR(30)		 NULL,
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
		FILE_SIZE							BIGINT		 DEFAULT 0		 NULL,
		EXT01                         		VARCHAR(200)		 NULL,
		EXT02                         		VARCHAR(200)		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);
CREATE INDEX JNITBOARDFILE_IDX1 ON JNITBOARDFILE(BOARD_ID);


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
/* Table Name: bbs_1000000000000000 */
/**********************************/
CREATE TABLE bbs_1000000000000000(
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
ALTER TABLE BBS_1000000000000000 ADD CONSTRAINT IDX_BBS_1000000000000000_PK PRIMARY KEY(ID);

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

/**********************************/
/* Table Name: 직급테이블 */
/**********************************/
CREATE TABLE JNITCMSPOS(
		POS_ID                        		VARCHAR(10)		 NOT NULL  ,
		POS_NM                        		VARCHAR(50)		 NOT NULL  ,
		POS_LV                        		INT(10)		 DEFAULT 0		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		CONNECT_TYPE                  		VARCHAR(10)		 NULL
) ;

/**********************************/
/* Table Name: 부서테이블 */
/**********************************/
CREATE TABLE JNITCMSORG(
		ORG_ID                        		VARCHAR(10)		 NOT NULL  ,
		ORG_NM                        		VARCHAR(50)		 NOT NULL  ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		ORG_DETH                      		VARCHAR(30)		 NULL   ,
		ORG_RANK                      		VARCHAR(10)		 NULL   ,
		ORG_RANK_ODR                  		INT(10)		 DEFAULT 0		 NULL   ,
		CONNECT_TYPE                  		VARCHAR(10)		 NULL   ,
		ORG_TEL                       		VARCHAR(50)		 NULL
) ;

/**********************************/
/* Table Name: 사이트테이블 */
/**********************************/
CREATE TABLE JNITCMSSITE(
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		SITE_NM                       		VARCHAR(255)		 NOT NULL  ,
		SITE_PATH                     		VARCHAR(50)		 NOT NULL  ,
		SITE_ORD                      		INT		 DEFAULT 0		 NULL   ,
		ADM_MBR_ID                    		VARCHAR(20)		 NULL   ,
		ACTIVE                        		INT(1)		 DEFAULT 0		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 NULL   ,
		LANG                          		VARCHAR(20)		 NULL   ,
		ORIGIN_SITE                   		VARCHAR(20)		 NULL   ,
		LANGUAGE_USE_YN               		VARCHAR(3)		 NULL   ,
		LANGUAGE1                     		VARCHAR(20)		 NULL   ,
		LANGUAGE2                     		VARCHAR(20)		 NULL   ,
		LANGUAGE3                     		VARCHAR(20)		 NULL   ,
		LANGUAGE4                     		VARCHAR(20)		 NULL   ,
		LANGUAGE5                     		VARCHAR(20)		 NULL
) ;

/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITCMSMENU(
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		MENU_ID                       		VARCHAR(10)		 NOT NULL  ,
		MENU_NM                       		VARCHAR(255)		 NOT NULL  ,
		MENU_PATH                     		VARCHAR(100)		 NULL   ,
		PID                           		VARCHAR(10)		 NULL   ,
		"DEPTH"                         		INT(10)		 DEFAULT 0		 NULL   ,
		"METHOD"                        		INT(10)		 NULL   ,
		ISLINK                        		INT(1)		 DEFAULT 0		 NULL   ,
		ISCNT                         		INT(1)		 DEFAULT 0		 NULL   ,
		LINKURL                       		VARCHAR(255)		 NULL   ,
		LINKTGT                       		VARCHAR(50)		 NULL   ,
		TPL_ID                        		VARCHAR(20)		 NULL   ,
		CNT_ID                        		VARCHAR(20)		 NULL   ,
		DEF_MENU                      		VARCHAR(100)		 NULL   ,
		MENU_IMG_FILE                 		VARCHAR(255)		 NULL   ,
		MENU_IMG_PATH                 		VARCHAR(255)		 NULL   ,
		MENU_IMG_ONM                  		VARCHAR(255)		 NULL   ,
		MENU_IMG_URL                  		VARCHAR(255)		 NULL   ,
		ADM_MBR_ID                    		VARCHAR(255)		 NULL   ,
		ACTIVE                        		INT(1)		 DEFAULT 0		 NULL   ,
		CCL                           		VARCHAR(20)		 DEFAULT NULL,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		CONTENT_SEARCH_CHK            		INT(10)		 DEFAULT 0		 NULL   ,
		ROBOT_YN                      		INT(10)		 DEFAULT 0		 NULL   ,
		H_DEL                         		VARCHAR(2)		 NULL   ,
		S_DEL                         		VARCHAR(2)		 NULL   ,
		L_DEL                         		VARCHAR(2)		 NULL   ,
		REDIRECT_URL                  		VARCHAR(255)		 NULL   ,
		META_TITLE                    		VARCHAR(255)		 NULL   ,
		META_SUBJECT                  		VARCHAR(255)		 NULL   ,
		META_KEYWORD                  		VARCHAR(255)		 NULL   ,
		META_DESCRIPTION              		VARCHAR(255)		 NULL   ,
		META_CLASSIFICATION           		VARCHAR(30)		 NULL   ,
		META_REPLY                    		VARCHAR(30)		 NULL   ,
		META_LANGUAGE                 		VARCHAR(30)		 NULL   ,
		META_BUILD                    		VARCHAR(30)		 NULL   ,
		LANGUAGE1                     		VARCHAR(20)		 NULL   ,
		LANGUAGE2                     		VARCHAR(20)		 NULL   ,
		LANGUAGE3                     		VARCHAR(20)		 NULL   ,
		LANGUAGE4                     		VARCHAR(20)		 NULL   ,
		LANGUAGE5                     		VARCHAR(20)		 NULL
) ;

/**********************************/
/* Table Name: 회원유형테이블 */
/**********************************/
CREATE TABLE JNITCMSMBRTYPE(
		TYPE_ID                       		VARCHAR(20)		 NOT NULL  ,
		TYPE_NM                       		VARCHAR(50)		 NOT NULL  ,
		TYPE_LV                       		VARCHAR(2)		 NOT NULL  ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		MENU_ACTIVE                   		LONGTEXT		 NULL
) ;

/**********************************/
/* Table Name: 회원테이블 */
/**********************************/
CREATE TABLE JNITCMSMBR(
		MBR_ID                        		VARCHAR(20)		 NOT NULL  ,
		MBR_LOGIN                     		VARCHAR(100)		 NOT NULL  ,
		ORG_ID                        		VARCHAR(30)		 NULL   ,
		POS_ID                        		VARCHAR(30)		 NULL   ,
		SITE_ID                       		VARCHAR(30)		 NULL   ,
		MBR_NM                        		VARCHAR(50)		 NOT NULL  ,
		MBR_PHOTO                     		VARCHAR(255)		 NULL   ,
		PASSWD                        		VARCHAR(128)		 NOT NULL  ,
		TYPE_ID                       		VARCHAR(10)		 NULL   ,
		TEL                           		VARCHAR(20)		 NULL   ,
		MOBILE                        		VARCHAR(20)		 NULL   ,
		EMAIL                         		VARCHAR(50)		 NULL   ,
		SN                            		VARCHAR(100)		 NULL   ,
		DP                            		VARCHAR(200)		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		HOMEPAGE                      		VARCHAR(100)		 NULL   ,
		POSTCODE                      		VARCHAR(10)		 NULL   ,
		ADDRESS                       		VARCHAR(200)		 NULL   ,
		ADDRESS_NEW                   		VARCHAR(200)		 NULL   ,
		EMAIL_RECV                    		INT(1)		 DEFAULT 0		 NULL   ,
		SMS_RECV                      		INT(1)		 DEFAULT 0		 NULL   ,
		ESTABLISHMENT                 		VARCHAR(50)		 NULL   ,
		CORPORATION                   		VARCHAR(50)		 NULL   ,
		PRIMARY_KEY                   		VARCHAR(50)		 NULL   ,
		MUTUAL                        		VARCHAR(50)		 NULL   ,
		CORPORATE_NAME                		VARCHAR(50)		 NULL   ,
		GROUP_NAME                    		VARCHAR(50)		 NULL   ,
		BUSINESS_PLACE                		VARCHAR(100)		 NULL   ,
		BUSINESS_ADDR                 		VARCHAR(200)		 NULL   ,
		BUSINESS_ADDR_NEW             		VARCHAR(200)		 NULL   ,
		GROUP_KIND                    		VARCHAR(50)		 NULL   ,
		GROUP_TEL                     		VARCHAR(30)		 NULL   ,
		GROUP_PAX                     		VARCHAR(30)		 NULL   ,
		GROUP_TYPE                    		VARCHAR(30)		 NULL   ,
		GRP_CONFIRM                   		VARCHAR(3)		 NULL   ,
		RANK_ID                       		VARCHAR(30)		 NULL   ,
		WORK_CONTENTS                 		VARCHAR(255)		 NULL   ,
		GRADE_NM                      		VARCHAR(20)		 NULL   ,
		ODR                           		INT(10)		 DEFAULT 0		 NULL   ,
		CONNECT_TYPE                  		VARCHAR(10)		 NULL   ,
		GROUP_TITLE                   		VARCHAR(255)		 NULL   ,
		PW_MISCNT                     		INT(1)		 DEFAULT 0		 NULL   ,
		LOCK_DATE							DATETIME		NULL,
		EX01                          		VARCHAR(255)		 NULL   ,
		EX02                          		VARCHAR(255)		 NULL   ,
		EX03                          		VARCHAR(255)		 NULL
) ;

/**********************************/
/* Table Name: 메뉴관리자테이블 */
/**********************************/
CREATE TABLE JNITCMSMENUMGR(
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		MENU_ID                       		VARCHAR(10)		 NOT NULL  ,
		MBR_ID                        		VARCHAR(20)		 NOT NULL  ,
		MGR_LV                        		INT(10)		 DEFAULT 0		 NULL
) ;

/**********************************/
/* Table Name: 콘텐츠테이블 */
/**********************************/
CREATE TABLE JNITCMSCNT(
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		MENU_ID                       		VARCHAR(10)		 NOT NULL  ,
		CNT_ID                        		VARCHAR(20)		 NOT NULL  ,
		CNT_DESC                      		STRING		 NULL   ,
		CNT_SRC                       		STRING		 NULL   ,
		TPL_ID                        		VARCHAR(20)		 NOT NULL  ,
		ISMAIN                        		INT(1)		 DEFAULT 0		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		CNT_WEB_STANDARD              		INT(1)		 DEFAULT 0		 NULL   ,
		CNT_WEB_STANDARD_CSS          		INT(1)		 NULL   ,
		CNT_WEB_ACCESS                		INT(1)		 DEFAULT 0		 NULL
) ;

/**********************************/
/* Table Name: 템플릿테이블 */
/**********************************/
CREATE TABLE JNITCMSTPL(
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		TPL_ID                        		VARCHAR(20)		 NOT NULL  ,
		TPL_TYPE                      		VARCHAR(2)		 NOT NULL  ,
		TPL_NM                        		VARCHAR(50)		 NOT NULL  ,
		TPL_DESC                      		STRING		 NULL   ,
		TPL_SRC                       		STRING		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		STATIC_TYPE							INT(1)		DEFAULT 0	NULL
) ;

/**********************************/
/* Table Name: 콘텐츠히스토리테이블 */
/**********************************/
CREATE TABLE JNITCMSHIST(
		HIST_ID                       		VARCHAR(20)		 NOT NULL  ,
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		MENU_ID                       		VARCHAR(10)		 NOT NULL  ,
		CNT_ID                        		VARCHAR(20)		 NOT NULL  ,
		CNT_DESC                      		STRING		 NULL   ,
		CNT_SRC                       		STRING		 NULL   ,
		TPL_ID                        		VARCHAR(20)		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		RESERVED                      		DATETIME		 NULL
) ;

/**********************************/
/* Table Name: 팀테이블 */
/**********************************/
CREATE TABLE JNITCMSRANK(
		RANK_ID                       		VARCHAR(30)		 NULL   ,
		RANK_NAME                     		VARCHAR(20)		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		ORG_ID                        		VARCHAR(30)		 NULL   ,
		RANK_ODR                      		VARCHAR(10)		 NULL   ,
		CONNECT_TYPE                  		VARCHAR(10)		 NULL
) ;

/**********************************/
/* Table Name: 회원로그 */
/**********************************/
CREATE TABLE JNITCMSMBRLOG(
		MBRLOG_ID                     		VARCHAR(60)		 NOT NULL  ,
		MBR_ID                        		VARCHAR(50)		 NULL   ,
		MBRLOG_CONTENT                		VARCHAR(255)		 NULL   ,
		MBRLOG_STATUS                 		INT(1)		 DEFAULT 0		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MBR_NM                        		VARCHAR(50)		 NULL   ,
		MBR_LOGIN                     		VARCHAR(255)		 NULL   ,
		MBR_IP                        		VARCHAR(100)		 NULL   ,
		ACT_MBR_LOGIN                 		VARCHAR(60)		 NULL   ,
		MBRLOG_PATH                   		VARCHAR(50)		 NULL   ,
		MBRLOG_EXT01                  		VARCHAR(255)		 NULL
) ;

/**********************************/
/* Table Name: 세션테이블 */
/**********************************/
CREATE TABLE JNITCMSMBRSESS(
		MBR_ID                        		VARCHAR(20)		 NOT NULL  ,
		MBR_SESS                      		VARCHAR(200)		 NULL   ,
		SESS_LOCK                     		INTEGER(10)		 DEFAULT 0		 NULL   ,
		SESS_DATE                     		DATETIME		 NULL
) ;
ALTER TABLE JNITCMSMBRSESS ADD CONSTRAINT IDX_JNITCMSMBRSESS_PK PRIMARY KEY(MBR_ID, MBR_SESS);
​

/**********************************/
/* Table Name: 템플릿히스토리 */
/**********************************/
CREATE TABLE JNITCMSTPLHIST(
		SITE_ID                       		VARCHAR(20)		 NULL   ,
		TPL_ID                        		VARCHAR(20)		 NULL   ,
		HIST_ID                       		VARCHAR(30)		 NULL   ,
		TPL_TYPE                      		VARCHAR(10)		 NULL   ,
		TPL_DESC                      		STRING		 NULL   ,
		TPL_SRC                       		STRING		 NULL   ,
		ACT_MBR                       		VARCHAR(30)		 NULL   ,
		ACT_IP                        		VARCHAR(100)		 NULL   ,
		CREATED                       		DATETIME		 NULL
) ;
ALTER TABLE JNITCMSTPLHIST ADD CONSTRAINT IDX_JNITCMSTPLHIST_PK PRIMARY KEY(HIST_ID);

/**********************************/
/* Table Name: 관리테이블 */
/**********************************/
CREATE TABLE JNITCMSMGMT(
		SITE_ID                       		VARCHAR(20)		 NULL   ,
		MGMT_ID                       		VARCHAR(20)		 NULL   ,
		MGMT_SORT                     		INT(10)		 DEFAULT 0		 NULL   ,
		MGMT_NM                       		VARCHAR(255)		 NULL   ,
		MGMT_TYPE                     		VARCHAR(30)		 NULL   ,
		MGMT_SCRIPT_TYPE              		VARCHAR(20)		 NULL   ,
		MGMT_CONTENT                  		STRING		 NULL   ,
		CREATED                       		DATETIME		 NULL   ,
		MODIFIED                      		DATETIME		 NULL   ,
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL   ,
		MGMT_HEARDER_YN               		INT(1)		 DEFAULT 0		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL   ,
		MGMT_FILE_NM                  		VARCHAR(255)		 NULL   ,
		MGMT_FILE_ORIGIN              		VARCHAR(255)		 NULL   ,
		MGMT_FILE_PATH                		VARCHAR(255)		 NULL   ,
		MGMT_FILE_URL                 		STRING		 NULL   ,
		MGMT_FILE_PATH_URL            		STRING		 NULL   ,
		MGMT_INSERT_PATH              		VARCHAR(255)		 NULL   ,
		MGMT_DOWNLOAD_COUNT           		INT(38)		 DEFAULT 0		 NULL   ,
		BOARD_ID                      		VARCHAR(25)		 NULL   ,
		BOARD_COUNT                   		INT(10)		 DEFAULT 0		 NULL   ,
		BOARD_SKIN                    		VARCHAR(255)		 NULL,
		THUMB_WIDTH                   		INT(38)		 DEFAULT 0		 NULL   ,
		THUMB_HEIGHT                   		INT(38)		 DEFAULT 0		 NULL
) ;

/**********************************/
/* Table Name: CSS관리히스토리 */
/**********************************/
CREATE TABLE JNITCMSCSSHIST(
		SITE_ID                       		VARCHAR(10)		 NULL   ,
		MGMT_ID                       		VARCHAR(20)		 NULL   ,
		HIST_ID                       		VARCHAR(20)		 NULL   ,
		CONTENT                       		STRING		 NULL   ,
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL   ,
		MGMT_ACT_IP                   		VARCHAR(100)		 NULL   ,
		CREATED                       		DATETIME		 NULL
) ;

/**********************************/
/* Table Name: script관리히스토리 */
/**********************************/
CREATE TABLE JNITCMSSCRIPTHIST(
		SITE_ID                       		VARCHAR(10)		 NULL   ,
		MGMT_ID                       		VARCHAR(20)		 NULL   ,
		HIST_ID                       		VARCHAR(20)		 NULL   ,
		CONTENT                       		STRING		 NULL   ,
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL   ,
		MGMT_ACT_IP                   		VARCHAR(100)		 NULL   ,
		CREATED                       		DATETIME		 NULL
) ;

/**********************************/
/* Table Name: 게시판관리히스토리 */
/**********************************/
CREATE TABLE JNITCMSBOARDHIST(
		SITE_ID                       		VARCHAR(10)		 NULL   ,
		MGMT_ID                       		VARCHAR(20)		 NULL   ,
		HIST_ID                       		VARCHAR(20)		 NULL   ,
		CONTENT                       		STRING		 NULL   ,
		BOARD_SKIN                    		VARCHAR(255)		 NULL   ,
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL   ,
		MGMT_ACT_IP                   		VARCHAR(100)		 NULL   ,
		CREATED                       		DATETIME		 NULL
) ;

/**********************************/
/* Table Name: 파일관리 카테고리테이블 */
/**********************************/
CREATE TABLE JNITCMSMGMTCATEGORY(
		SITE_ID                       		VARCHAR(10)		 NOT NULL  ,
		MGMT_CATEGORY_ID              		VARCHAR(30)		 NOT NULL
) ;

/**********************************/
/* Table Name: 카테고리 아이템 테이블 */
/**********************************/
CREATE TABLE JNITCMSMGMTITEM(
		MGMT_CATEGORY_ID              		VARCHAR(30)		 NOT NULL  ,
		CATEGORY_ID                   		VARCHAR(30)		 NOT NULL  ,
		CATEGORY_NM                   		VARCHAR(100)		 NULL   ,
		CATEGORY_VAL                  		VARCHAR(255)		 NULL   ,
		CATEGORY_SORT                 		INT(10)		 DEFAULT 0		 NULL   ,
		CATEGORY_SOURCE               		VARCHAR(100)		 NULL   ,
		MODIFI_YN                     		INT(1)		 DEFAULT 0		 NULL   ,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
) ;


ALTER TABLE JNITCMSPOS ADD CONSTRAINT IDX_JNITCMSPOS_PK PRIMARY KEY (POS_ID);

ALTER TABLE JNITCMSORG ADD CONSTRAINT IDX_JNITCMSORG_PK PRIMARY KEY (ORG_ID);

ALTER TABLE JNITCMSSITE ADD CONSTRAINT IDX_JNITCMSSITE_PK PRIMARY KEY (SITE_ID);

ALTER TABLE JNITCMSMENU ADD CONSTRAINT IDX_JNITCMSMENU_PK PRIMARY KEY (SITE_ID, MENU_ID);
ALTER TABLE JNITCMSMENU ADD CONSTRAINT IDX_JNITCMSMENU_FK0 FOREIGN KEY (SITE_ID) REFERENCES JNITCMSSITE (SITE_ID);

ALTER TABLE JNITCMSMBRTYPE ADD CONSTRAINT IDX_JNITCMSMBRTYPE_PK PRIMARY KEY (TYPE_ID);

ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_PK PRIMARY KEY (MBR_ID);
ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_FK0 FOREIGN KEY (POS_ID) REFERENCES JNITCMSPOS (POS_ID);
ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_FK1 FOREIGN KEY (ORG_ID) REFERENCES JNITCMSORG (ORG_ID);
ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_FK2 FOREIGN KEY (TYPE_ID) REFERENCES JNITCMSMBRTYPE (TYPE_ID);

ALTER TABLE JNITCMSMENUMGR ADD CONSTRAINT IDX_JNITCMSMENUMGR_PK PRIMARY KEY (SITE_ID, MENU_ID);
ALTER TABLE JNITCMSMENUMGR ADD CONSTRAINT IDX_JNITCMSMENUMGR_FK0 FOREIGN KEY (MBR_ID) REFERENCES JNITCMSMBR (MBR_ID);
ALTER TABLE JNITCMSMENUMGR ADD CONSTRAINT IDX_JNITCMSMENUMGR_FK1 FOREIGN KEY (SITE_ID,MENU_ID) REFERENCES JNITCMSMENU (SITE_ID,MENU_ID);

ALTER TABLE JNITCMSCNT ADD CONSTRAINT IDX_JNITCMSCNT_PK PRIMARY KEY (SITE_ID, MENU_ID, CNT_ID);
ALTER TABLE JNITCMSCNT ADD CONSTRAINT IDX_JNITCMSCNT_FK0 FOREIGN KEY (SITE_ID,MENU_ID) REFERENCES JNITCMSMENU (SITE_ID,MENU_ID);

ALTER TABLE JNITCMSTPL ADD CONSTRAINT IDX_JNITCMSTPL_PK PRIMARY KEY (SITE_ID, TPL_ID);
ALTER TABLE JNITCMSTPL ADD CONSTRAINT IDX_JNITCMSTPL_FK0 FOREIGN KEY (SITE_ID) REFERENCES JNITCMSSITE (SITE_ID);

ALTER TABLE JNITCMSHIST ADD CONSTRAINT IDX_JNITCMSHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSHIST ADD CONSTRAINT IDX_JNITCMSHIST_FK0 FOREIGN KEY (SITE_ID,MENU_ID,CNT_ID) REFERENCES JNITCMSCNT (SITE_ID,MENU_ID,CNT_ID);

ALTER TABLE JNITCMSRANK ADD CONSTRAINT IDX_JNITCMSRANK_PK PRIMARY KEY (RANK_ID);

ALTER TABLE JNITCMSMBRLOG ADD CONSTRAINT IDX_JNITCMSMBRLOG_PK PRIMARY KEY (MBRLOG_ID);

ALTER TABLE JNITCMSTPLHIST ADD CONSTRAINT IDX_JNITCMSTPLHIST_FK0 FOREIGN KEY (SITE_ID) REFERENCES JNITCMSSITE (SITE_ID);
ALTER TABLE JNITCMSTPLHIST ADD CONSTRAINT IDX_JNITCMSTPLHIST_FK1 FOREIGN KEY (SITE_ID,TPL_ID) REFERENCES JNITCMSTPL (SITE_ID,TPL_ID);

ALTER TABLE JNITCMSMGMT ADD CONSTRAINT IDX_JNITCMSMGMT_PK PRIMARY KEY (MGMT_ID);

ALTER TABLE JNITCMSCSSHIST ADD CONSTRAINT IDX_JNITCMSCSSHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSCSSHIST ADD CONSTRAINT IDX_JNITCMSCSSHIST_FK0 FOREIGN KEY (MGMT_ID) REFERENCES JNITCMSMGMT (MGMT_ID);

ALTER TABLE JNITCMSSCRIPTHIST ADD CONSTRAINT IDX_JNITCMSSCRIPTHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSSCRIPTHIST ADD CONSTRAINT IDX_JNITCMSSCRIPTHIST_FK0 FOREIGN KEY (MGMT_ID) REFERENCES JNITCMSMGMT (MGMT_ID);

ALTER TABLE JNITCMSBOARDHIST ADD CONSTRAINT IDX_JNITCMSBOARDHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSBOARDHIST ADD CONSTRAINT IDX_JNITCMSBOARDHIST_FK0 FOREIGN KEY (MGMT_ID) REFERENCES JNITCMSMGMT (MGMT_ID);

ALTER TABLE JNITCMSMGMTCATEGORY ADD CONSTRAINT IDX_JNITCMSMGMTCATEGORY_PK PRIMARY KEY (MGMT_CATEGORY_ID);

ALTER TABLE JNITCMSMGMTITEM ADD CONSTRAINT IDX_JNITCMSMGMTITEM_PK PRIMARY KEY (CATEGORY_ID);
ALTER TABLE JNITCMSMGMTITEM ADD CONSTRAINT IDX_JNITCMSMGMTITEM_FK0 FOREIGN KEY (MGMT_CATEGORY_ID) REFERENCES JNITCMSMGMTCATEGORY (MGMT_CATEGORY_ID);

/**********************************/
/* Table Name: 회원 패키지 테이블 */
/**********************************/
CREATE TABLE JNITCMSMBRPACKAGE(
		PACK_ID                       		VARCHAR(30)		 NULL,
		PACKAGE_NM                    		VARCHAR(100)		 NULL,
		MBR_ACCESS                    		VARCHAR(255)		 NULL,
		MBR_DENY                     		VARCHAR(255)		 NULL,
		ORG_ACCESS                    		VARCHAR(255)		 NULL,
		ORG_DENY                     		VARCHAR(255)		 NULL,
		POS_ACCESS                    		VARCHAR(255)		 NULL,
		POS_DENY                     		VARCHAR(255)		 NULL,
		TYPE_ACCESS                   		VARCHAR(255)		 NULL,
		TYPE_DENY                    		VARCHAR(255)		 NULL,
		"QUERY"                         		STRING		 NULL,
		"COMMENT"                       		VARCHAR(255)		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);


ALTER TABLE JNITCMSMBRPACKAGE ADD CONSTRAINT IDX_JNITCMSMBRPACKAGE_PK PRIMARY KEY (PACK_ID);

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

/**********************************/
/* Table Name: 로그인 로그 테이블 */
/**********************************/
CREATE TABLE JNITLOGINLOG(
		IP_ID                         		VARCHAR(255)		 NULL,
		MBR_ID                        		VARCHAR(255)		 NULL,
		IP_ADDR                       		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL
);


ALTER TABLE JNITLOGINLOG ADD CONSTRAINT IDX_JNITLOGINLOG_PK PRIMARY KEY (IP_ID);

/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITMENU(
		MENU_SEQ                      		INT(30)		 DEFAULT 0		 NOT NULL,
		MENU_URL                      		VARCHAR(255)		 NULL,
		MENU_DEPT                     		VARCHAR(100)		 NULL,
		MENU_PART                     		VARCHAR(200)		 NULL,
		MENU_TEL                      		VARCHAR(20)		 NULL,
		MENU_MEMID                    		VARCHAR(20)		 NULL
);


ALTER TABLE JNITMENU ADD CONSTRAINT IDX_JNITMENU_PK PRIMARY KEY (MENU_SEQ);

/**********************************/
/* Table Name: 설문조사카테고리 */
/**********************************/
CREATE TABLE JNITRESEARCHCATEGORY(
		CATEGORY_ID                   		VARCHAR(30)		 NULL  ,
		CATEGORY_NAME                 		VARCHAR(255)		 NULL  ,
		SITE_PATH                     		VARCHAR(255)		 NULL  ,
		ISDEL                         		INTEGER(1)		 NULL
) ;

/**********************************/
/* Table Name: 설문조사테이블 */
/**********************************/
CREATE TABLE JNITRESEARCH(
		RESEARCH_ID                   		VARCHAR(20)		 NOT NULL,
		RESEARCH_NM                   		VARCHAR		 NULL  ,
		RESEARCH_OPEN                 		INTEGER(1)		 NULL  ,
		STARTTIME                     		DATETIME		 NULL  ,
		ENDTIME                       		DATETIME		 NULL  ,
		STATE                         		INTEGER(1)		 NULL  ,
		ENTRY                         		INTEGER(8)		 NULL  ,
		BLOCK                         		INTEGER(1)		 NULL  ,
		RESEARCH_TARGET               		VARCHAR(255)		 NULL  ,
		NAME_OPEN                     		INTEGER(1)		 NULL  ,
		RESULT_OPEN                   		INTEGER(1)		 NULL  ,
		INTRODUCE                     		VARCHAR		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIED                      		DATETIME		 NULL  ,
		ISDEL                         		INTEGER(1)		 NULL  ,
		MODIFIED_WHO                  		VARCHAR(255)		 NULL  ,
		CATEGORY_ID                   		VARCHAR(30)		 NULL  ,
		SITE_PATH                     		VARCHAR(255)		 NULL
) ;

/**********************************/
/* Table Name: 설문조사질문 */
/**********************************/
CREATE TABLE JNITRESEARCHQUESTION(
		QUESTION_ID                   		VARCHAR(20)		 NOT NULL ,
		RESEARCH_ID                   		VARCHAR(20)		 NULL  ,
		QUESTION_NM                   		VARCHAR		 NULL  ,
		TYPE                          		INTEGER(1)		 DEFAULT 0		 NULL  ,
		ORDERCHECK                    		INTEGER(1)		 DEFAULT 0		 NULL  ,
		VISIBLE                       		INTEGER(1)		 DEFAULT 0		 NULL  ,
		ANSWER_CNT                    		INTEGER(3)		 DEFAULT 1		 NULL  ,
		ANSWER_FORM                   		INTEGER(1)		 DEFAULT 0		 NULL  ,
		FILE_URL                      		VARCHAR(255)		 NULL  ,
		FILE_PATH                     		VARCHAR(255)		 NULL  ,
		FILE_NM                       		VARCHAR(255)		 NULL  ,
		FILE_ONM                      		VARCHAR(255)		 NULL  ,
		FILE_WIDTH                    		INTEGER(5)		 NULL  ,
		FILE_HEIGHT                   		INTEGER(5)		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIED                      		DATETIME		 NULL  ,
		ISDEL                         		INTEGER(1)		 DEFAULT 0		 NULL  ,
		LINEUP                        		INTEGER(1)		 DEFAULT 0		 NULL  ,
		LINEUP_CNT                    		INTEGER(3)		 NULL
) ;

/**********************************/
/* Table Name: 설문조사답변테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHANSWER(
		ANSWER_ID                     		VARCHAR(20)		 NOT NULL ,
		QUESTION_ID                   		VARCHAR(20)		 NULL  ,
		RESEARCH_ID                   		VARCHAR(20)		 NULL  ,
		ANSWER_NM                     		VARCHAR		 NULL  ,
		TYPE                          		INTEGER(1)		 NULL  ,
		CRITERION_OPT                 		INTEGER(1)		 DEFAULT 0		 NULL  ,
		CRITERION_CNT                 		INTEGER(4)		 DEFAULT 0		 NULL  ,
		ANSOPT                        		INTEGER(1)		 DEFAULT 0		 NULL  ,
		ANSOPT_NUM                    		VARCHAR(255)		 DEFAULT '0'		 NULL  ,
		ANSOPT_MOVE                   		VARCHAR(255)		 DEFAULT '0'		 NULL  ,
		ANSOPT_VISIBLE                		INTEGER(1)		 NULL  ,
		FILE_URL                      		VARCHAR(255)		 NULL  ,
		FILE_PATH                     		VARCHAR(255)		 NULL  ,
		FILE_NM                       		VARCHAR(255)		 NULL  ,
		FILE_ONM                      		VARCHAR(255)		 NULL  ,
		FILE_WIDTH                    		INTEGER(5)		 NULL  ,
		FILE_HEIGHT                   		INTEGER(5)		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIED                      		DATETIME		 NULL  ,
		ISDEL                         		INTEGER(1)		 NULL
) ;

/**********************************/
/* Table Name: 설문응답테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHRESPONDENT(
		RESPONDENT_ID                 		VARCHAR(20)		 NULL  ,
		RESEARCH_ID                   		VARCHAR(20)		 NULL  ,
		QUESTION_ID                   		VARCHAR(20)		 NULL  ,
		ANSWER_ID                     		VARCHAR(20)		 NULL  ,
		MBR_IP                        		VARCHAR(50)		 NULL  ,
		MBR_ID                        		VARCHAR(255)		 NULL  ,
		ANSWER                        		VARCHAR		 NULL  ,
		ORDER_ANSWER                  		VARCHAR		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIDE                      		DATETIME		 NULL  ,
		ISDEL                         		INTEGER(1)		 NULL
);

/**********************************/
/* Table Name: 설문조사관리자테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHADMIN(
		ADMIN_ID                      		VARCHAR(255)		 NOT NULL ,
		MBR_ID                        		VARCHAR(255)		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIED                      		DATETIME		 NULL  ,
		CREATE_WHO                    		VARCHAR(255)		 NULL  ,
		ISDEL                         		INTEGER(1)		 NULL  ,
		SITE_PATH                     		VARCHAR(255)		 NULL  ,
		EXT01                         		VARCHAR(50)		 NULL  ,
		EXT02                         		VARCHAR(50)		 NULL
) ;


ALTER TABLE JNITRESEARCHCATEGORY ADD CONSTRAINT IDX_JNITRESEARCHCATEGORY_PK PRIMARY KEY (CATEGORY_ID);

ALTER TABLE JNITRESEARCH ADD CONSTRAINT IDX_JNITRESEARCH_PK PRIMARY KEY (RESEARCH_ID);

ALTER TABLE JNITRESEARCHQUESTION ADD CONSTRAINT IDX_JNITRESEARCHQUESTION_PK PRIMARY KEY (QUESTION_ID);
ALTER TABLE JNITRESEARCHQUESTION ADD CONSTRAINT IDX_JNITRESEARCHQUESTION_FK0 FOREIGN KEY (RESEARCH_ID) REFERENCES JNITRESEARCH (RESEARCH_ID);

ALTER TABLE JNITRESEARCHANSWER ADD CONSTRAINT IDX_JNITRESEARCHANSWER_PK PRIMARY KEY (ANSWER_ID);
ALTER TABLE JNITRESEARCHANSWER ADD CONSTRAINT IDX_JNITRESEARCHANSWER_FK0 FOREIGN KEY (QUESTION_ID) REFERENCES JNITRESEARCHQUESTION (QUESTION_ID);
ALTER TABLE JNITRESEARCHANSWER ADD CONSTRAINT IDX_JNITRESEARCHANSWER_FK1 FOREIGN KEY (RESEARCH_ID) REFERENCES JNITRESEARCH (RESEARCH_ID);

ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_PK PRIMARY KEY (RESPONDENT_ID);
ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_FK0 FOREIGN KEY (RESEARCH_ID) REFERENCES JNITRESEARCH (RESEARCH_ID);
ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_FK1 FOREIGN KEY (QUESTION_ID) REFERENCES JNITRESEARCHQUESTION (QUESTION_ID);
ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_FK2 FOREIGN KEY (ANSWER_ID) REFERENCES JNITRESEARCHANSWER (ANSWER_ID);

ALTER TABLE JNITRESEARCHADMIN ADD CONSTRAINT IDX_JNITRESEARCHADMIN_PK PRIMARY KEY (ADMIN_ID);



/**********************************/
/* Table Name: 만족도메인테이블 */
/**********************************/
CREATE TABLE JNITRSC(
		RSC_ID                        		VARCHAR(20)		 NOT NULL,
		RSC_MENU                      		VARCHAR(100)		 NOT NULL,
		RSC_URL                       		VARCHAR(100)		 NULL ,
		RSC_TOT_SCORE                 		INT(15)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: 만족도데이터테이블 */
/**********************************/
CREATE TABLE JNITRSCDATA(
		DATA_ID                       		VARCHAR(20)		 NOT NULL,
		RSC_ID                        		VARCHAR(20)		 NOT NULL,
		DATA_MEMO                     		VARCHAR(1000)		 NULL ,
		DATA_SCORE                    		INT(15)		 DEFAULT 0		 NOT NULL,
		CREATED                       		DATETIME		 NULL ,
		REMOTE_ADDR                   		VARCHAR(128)		 NULL
);

/**********************************/
/* Table Name: 페이지통계 */
/**********************************/
CREATE TABLE JNITRSCPAGE(
		RSCP_ID                       		VARCHAR(20)		 NOT NULL,
		SITE_ID                       		VARCHAR(20)		 NULL ,
		MENU_ID                       		VARCHAR(20)		 NULL ,
		PAGE_URL                      		VARCHAR(128)		 NOT NULL,
		PAGE_VIEW                     		INT(10)		 NULL ,
		HIT1                          		INT(10)		 NULL ,
		HIT2                          		INT(10)		 NULL ,
		HIT3                          		INT(10)		 NULL ,
		HIT4                          		INT(10)		 NULL ,
		HIT5                          		INT(10)		 NULL
);

/**********************************/
/* Table Name: 페이지평가데이터 */
/**********************************/
CREATE TABLE JNITRSCPAGEDATA(
		PDATA_ID                      		VARCHAR(20)		 NOT NULL,
		RSCP_ID                       		VARCHAR(20)		 NULL ,
		MEMO                          		VARCHAR(1000)		 NULL ,
		HIT1                          		INT(10)		 NULL ,
		HIT2                          		INT(10)		 NULL ,
		HIT3                          		INT(10)		 NULL ,
		HIT4                          		INT(10)		 NULL ,
		HIT5                          		INT(10)		 NULL ,
		REMOTE_ADDR                   		VARCHAR(128)		 NULL ,
		CREATED                       		DATETIME		 NULL
);


ALTER TABLE JNITRSC ADD CONSTRAINT IDX_JNITRSC_PK PRIMARY KEY (RSC_ID);

ALTER TABLE JNITRSCDATA ADD CONSTRAINT IDX_JNITRSCDATA_PK PRIMARY KEY (DATA_ID);
ALTER TABLE JNITRSCDATA ADD CONSTRAINT IDX_JNITRSCDATA_FK0 FOREIGN KEY (RSC_ID) REFERENCES JNITRSC (RSC_ID);

ALTER TABLE JNITRSCPAGE ADD CONSTRAINT IDX_JNITRSCPAGE_PK PRIMARY KEY (RSCP_ID);
ALTER TABLE JNITRSCPAGE ADD CONSTRAINT UNQ_PAGE_URL UNIQUE (PAGE_URL);

ALTER TABLE JNITRSCPAGEDATA ADD CONSTRAINT IDX_JNITRSCPAGEDATA_PK PRIMARY KEY (PDATA_ID);
ALTER TABLE JNITRSCPAGEDATA ADD CONSTRAINT IDX_JNITRSCPAGEDATA_FK0 FOREIGN KEY (RSCP_ID) REFERENCES JNITRSCPAGE (RSCP_ID);

/**********************************/
/* Table Name: 페이지 스크랩 */
/**********************************/
CREATE TABLE JNITSCRAP(
		SCRAP_ID                      		VARCHAR(20)		 NULL,
		MBR_ID                        		VARCHAR(20)		 NULL,
		TITLE                         		VARCHAR(200)		 NULL,
		URL                           		VARCHAR(4000)		 NULL,
		CREATED                       		DATETIME		 NULL
);
ALTER TABLE JNITSCRAP ADD CONSTRAINT IDX_JNITSCRAP_PK PRIMARY KEY(SCRAP_ID);

/**********************************/
/* Table Name: 사이트별 방문자 접속 카운트 */
/**********************************/
CREATE TABLE JNITSITESTATE(
		WHEN_DATE                     		VARCHAR(50)		 NULL
);
ALTER TABLE jnitsitestate ADD CONSTRAINT IDX_JNITSITESTATE_PK PRIMARY KEY(when_date);

/**********************************/
/* Table Name: 방문자 접속자 리스트 */
/**********************************/
CREATE TABLE JNITSITESTATELIST(
		SITE                          		VARCHAR(20)		 NULL,
		IP                            		VARCHAR(20)		 NULL
);
ALTER TABLE jnitsitestatelist ADD CONSTRAINT IDX_JNITSITESTATELIST_PK PRIMARY KEY(site, ip);

/**********************************/
/* Table Name: SMS 주소록 목록 */
/**********************************/
CREATE TABLE JNITMGOVADDRGRP(
		GRP_ID                        		VARCHAR(20)		 NULL,
		GRP_NM                        		VARCHAR(50)		 NULL,
		USER_MBR                      		VARCHAR(30)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: SMS 주소록 명단 */
/**********************************/
CREATE TABLE JNITMGOVADDRLIST(
		LIST_ID                       		VARCHAR(20)		 NULL,
		GRP_ID                        		VARCHAR(20)		 NULL,
		MBR_NM                        		VARCHAR(20)		 NULL,
		MBR_ID                        		VARCHAR(30)		 NULL,
		MBR_LOGIN                     		VARCHAR(30)		 NULL,
		PHONE                         		VARCHAR(15)		 NULL,
		PHONE2                        		VARCHAR(15)		 NULL,
		POS_ID                        		VARCHAR(30)		 NULL,
		POS_NM                        		VARCHAR(30)		 NULL,
		ORG_ID                        		VARCHAR(30)		 NULL,
		ORG_NM                        		VARCHAR(30)		 NULL,
		MBRTYPE_ID                    		VARCHAR(30)		 NULL,
		MBRTYPE_NM                    		VARCHAR(30)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: SMS주소록 */
/**********************************/
CREATE TABLE JNITSMSADDRESSBOOK(
		ADDR_ID                       		VARCHAR(20)		 NULL,
		ADDR_ME_MBR_ID                		VARCHAR(20)		 NULL,
		ADDR_MBR_ID                   		VARCHAR(20)		 NULL,
		ADDR_NAME                     		VARCHAR(16)		 NULL,
		ADDR_PHONE                    		VARCHAR(20)		 NULL,
		ADDR_EXT01                    		VARCHAR(255)		 NULL,
		ADDR_EXT02                    		VARCHAR(255)		 NULL,
		DATE01                        		DATETIME		 NULL,
		DATE02                        		DATETIME		 NULL,
		ISDEL                         		INT(1)		 NULL,
		TYPE                          		VARCHAR(30)		 NULL
);
ALTER TABLE JNITSMSADDRESSBOOK ADD CONSTRAINT IDX_JNITSMSADDRESSBOOK_PK PRIMARY KEY(ADDR_ID);

/**********************************/
/* Table Name: SMS 키테이블 */
/**********************************/
CREATE TABLE MGOV_SERIAL(
		ID                            		INT(10)		 DEFAULT 0
);
ALTER TABLE MGOV_SERIAL ADD CONSTRAINT IDX_MGOV_SERIAL_PK PRIMARY KEY(ID);

/**********************************/
/* Table Name: JNIT_LTSKOREA_SMS */
/**********************************/
CREATE TABLE JNIT_LTSKOREA_SMS(
		USERDATA                      		INT(10)		 NULL,
		MSG_SEQ                       		INT(10)		 NULL,
		SUB_ID                        		VARCHAR(20)		 NULL,
		CUR_STATE                     		INT(1)		 NULL,
		SENT_DATE                     		DATETIME		 NULL,
		RSLT_DATE                     		DATETIME		 NULL,
		REQ_DATE                      		DATETIME		 NULL,
		RSLT_CODE                     		INT(15)		 NULL,
		RSLT_CODE2                    		VARCHAR(1)		 NULL,
		RSLT_NET                      		VARCHAR(3)		 NULL,
		CALL_TO                       		VARCHAR(12)		 NULL,
		CALL_FROM                     		VARCHAR(12)		 NULL,
		SMS_TXT                       		VARCHAR(160)		 NULL,
		MSG_TYPE                      		INT(1)		 NULL,
		CONT_SEQ                      		INT(10)		 NULL
);
ALTER TABLE JNIT_LTSKOREA_SMS ADD CONSTRAINT IDX_JNIT_LTSKOREA_SMS_PK PRIMARY KEY(MSG_SEQ);

ALTER TABLE JNITMGOVADDRGRP ADD CONSTRAINT IDX_JNITMGOVADDRGRP_PK PRIMARY KEY (GRP_ID);

ALTER TABLE JNITMGOVADDRLIST ADD CONSTRAINT IDX_JNITMGOVADDRLIST_PK PRIMARY KEY (LIST_ID);
ALTER TABLE JNITMGOVADDRLIST ADD CONSTRAINT IDX_JNITMGOVADDRLIST_FK0 FOREIGN KEY (GRP_ID) REFERENCES JNITMGOVADDRGRP (GRP_ID);

/**********************************/
/* Table Name: 방문자분석데이터 */
/**********************************/
CREATE TABLE JNITVISITLOG(
		WHEN_DATETIME                 		DATETIME		 NULL,
		WHEN_DATE                     		VARCHAR(200)		 NULL,
		SITE                          		VARCHAR(100)		 NULL,
		IPADDR                        		VARCHAR(255)		 NULL,
		REFERER                       		STRING		 NULL,
		USER_OS                       		VARCHAR(255)		 NULL,
		BROWSER                       		VARCHAR(255)		 NULL,
		USER_AGENT                    		VARCHAR(255)		 NULL,
		PAGE                          		VARCHAR(255)		 NULL,
		"USER"                          		VARCHAR(100)		 NULL,
		USR_ACTION                    		VARCHAR(200)		 NULL
);

/**********************************/
/* Table Name: 방문자 접속 데이터 */
/**********************************/
CREATE TABLE JNITVISITCOUNT(
		SITE                          		VARCHAR(100)		 NULL,
		VDATE                         		DATE		 NULL,
		VHOUR                         		INT(2)		 NULL,
		USER_OS                       		VARCHAR(100)		 NULL,
		BROWSER                       		VARCHAR(100)		 NULL,
		HIT                           		INT(10)		 NULL
);
ALTER TABLE JNITVISITCOUNT ADD CONSTRAINT IDX_JNITVISITCOUNT_PK PRIMARY KEY(SITE, VDATE, VHOUR, USER_OS, BROWSER);

ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_PK PRIMARY KEY (WHEN_DATETIME);
CREATE INDEX IDX_JNITVISITLOG_1 ON JNITVISITLOG (WHEN_DATE, SITE);
ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_2 UNIQUE (WHEN_DATE, SITE, IPADDR);

/**********************************/
/* Table Name: 배포 히스토리 테이블 */
/**********************************/
CREATE TABLE JNITCMSDISSEMINATEHISTORY(
		HISTORY_ID                    		VARCHAR(30)		 NULL,
		SITE_ID                       		VARCHAR(30)		 NULL,
		MENU_ID                       		VARCHAR(30)		 NULL,
		CNT_ID                        		VARCHAR(30)		 NULL,
		CONTENT_PATH                  		VARCHAR(255)		 NULL,
		DISSEMINATE_TYPE              		VARCHAR(10)		 NULL,
		DISSEMINATE_LINE              		STRING		 NULL,
		MBR_ID                        		VARCHAR(20)		 NULL,
		DISSEMINATE_USERCONFIRM       		VARCHAR(10)		 NULL,
		DISSEMINATE_CONFIRM           		INT(1)		 NULL,
		DISSEMINATE_DAY               		DATETIME		 NULL,
		DISSEMINATE_CREATED           		DATETIME		 NULL,
		HISTORY_MEMO                  		STRING		 NULL
);

/**********************************/
/* Table Name: 배포테이블 */
/**********************************/
CREATE TABLE JNITCMSDISSEMINATE(
		DISSEMINATE_ID                		VARCHAR(30)		 NULL,
		SITE_ID                       		VARCHAR(30)		 NULL,
		MENU_ID                       		VARCHAR(30)		 NULL,
		CNT_ID                        		VARCHAR(30)		 NULL,
		CONTENT_PATH                  		STRING		 NULL,
		DISSEMINATE_TYPE              		VARCHAR(10)		 NULL,
		MBR_ID                        		VARCHAR(30)		 NULL,
		DISSEMINATE_CONFIRM           		INT(1)		 DEFAULT 0		 NULL,
		DISSEMINATE_MEMO              		STRING		 NULL,
		CONTENT_CONFIRM               		INT(1)		 DEFAULT 0		 NULL,
		DISSEMINATE_DAY               		DATETIME		 NULL,
		DISSEMINATE_HISTORY_ID        		VARCHAR(30)		 NULL,
		DISSEMINATE_NAME              		STRING		 NULL,
		DISSEMINATE_NUM               		VARCHAR(20)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		DISSEMINATE_STAND             		INT(3)		 DEFAULT 0		 NULL
);


ALTER TABLE JNITCMSDISSEMINATEHISTORY ADD CONSTRAINT IDX_JNITCMSDISSEMINATEHISTORY_PK PRIMARY KEY (HISTORY_ID);

ALTER TABLE JNITCMSDISSEMINATE ADD CONSTRAINT IDX_JNITCMSDISSEMINATE_PK PRIMARY KEY (DISSEMINATE_ID);

/* VIEW TABLE */
/**********************************/
/* Table Name: 배포테이블 */
/**********************************/
CREATE OR REPLACE VIEW jnitcmscntvt (
	cnt_id CHARACTER VARYING (20),
	site_id CHARACTER VARYING (10),
	menu_id CHARACTER VARYING (10),
	ismain INTEGER,
	menu_nm CHARACTER VARYING (50),
	menu_path CHARACTER VARYING (100),
	pid CHARACTER VARYING (10),
	[depth] INTEGER DEFAULT 0,
	[method] INTEGER,
	cnt_desc CHARACTER VARYING (1073741823),
	cnt_src CHARACTER VARYING (1073741823),
	tpl_id CHARACTER VARYING (20),
	tpl_nm CHARACTER VARYING (50),
	created DATETIME,
	modified DATETIME,
	isdel INTEGER DEFAULT 0
)
AS
	SELECT
		[b].[CNT_ID],
		[a].[SITE_ID],
		[a].[MENU_ID],
	IF (([d].[CNT_ID] = [b].[CNT_ID]), 1, 0), CAST([a].[MENU_NM] AS VARCHAR(50)), [a].[MENU_PATH], [a].[PID], [a].[DEPTH], [a].[METHOD], [b].[CNT_DESC], [b].[CNT_SRC], [b].[TPL_ID], [c].[TPL_NM], [b].[CREATED], [b].[MODIFIED], [b].[ISDEL]
		FROM
			[jnitcmscnt] [b]
			LEFT OUTER JOIN [jnitcmsmenu] [a] ON (
				([a].[SITE_ID] = [b].[SITE_ID])
				AND ([a].[MENU_ID] = [b].[MENU_ID])
			)
			LEFT OUTER JOIN [jnitcmsmenu] [d] ON (
				([d].[SITE_ID] = [a].[SITE_ID])
				AND ([d].[MENU_ID] = [a].[PID])
			)
			LEFT OUTER JOIN [jnitcmstpl] [c] ON ([c].[TPL_ID] = [b].[TPL_ID]);

/**********************************/
/* Table Name: jnitcmsmenu_vt */
/**********************************/
CREATE OR REPLACE VIEW jnitcmsmenu_vt (
	site_id CHARACTER VARYING (10),
	menu_id CHARACTER VARYING (1),
	[method] CHARACTER VARYING (1),
	[depth] CHARACTER VARYING (1),
	iscnt CHARACTER VARYING (1),
	isdel CHARACTER VARYING (1),
	site_nm CHARACTER VARYING (50),
	menu_depth1 CHARACTER VARYING (50),
	menu_id1 CHARACTER VARYING (10),
	menu_depth2 CHARACTER VARYING (50),
	menu_id2 CHARACTER VARYING (10),
	menu_depth3 CHARACTER VARYING (50),
	menu_id3 CHARACTER VARYING (10),
	menu_depth4 CHARACTER VARYING (50),
	menu_id4 CHARACTER VARYING (10),
	menu_depth5 CHARACTER VARYING (50),
	menu_id5 CHARACTER VARYING (10),
	menu_depth6 CHARACTER VARYING (50),
	menu_id6 CHARACTER VARYING (10),
	menu_depth7 CHARACTER VARYING (50),
	menu_id7 CHARACTER VARYING (10),
	menu_url CHARACTER VARYING (1)
)
AS
	SELECT
		[a].[SITE_ID],
		CAST(IFNULL([g].[MENU_ID], IFNULL([f].[MENU_ID], IFNULL([e].[MENU_ID], IFNULL([d].[MENU_ID], IFNULL([c].[MENU_ID], IFNULL([b].[MENU_ID], IFNULL([a].[MENU_ID], ''))))))) AS VARCHAR(1)),
		CAST(LPAD(IFNULL([g].[METHOD], IFNULL([f].[METHOD], IFNULL([e].[METHOD], IFNULL([d].[METHOD], IFNULL([c].[METHOD], IFNULL([b].[METHOD], IFNULL([a].[METHOD], ''))))))), 10, '0') AS VARCHAR(1)),
		CAST(IFNULL([g].[DEPTH], IFNULL([f].[DEPTH], IFNULL([e].[DEPTH], IFNULL([d].[DEPTH], IFNULL([c].[DEPTH], IFNULL([b].[DEPTH], IFNULL([a].[DEPTH], ''))))))) AS VARCHAR(1)),
		CAST(IFNULL([g].[ISCNT], IFNULL([f].[ISCNT], IFNULL([e].[ISCNT], IFNULL([d].[ISCNT], IFNULL([c].[ISCNT], IFNULL([b].[ISCNT], IFNULL([a].[ISCNT], ''))))))) AS VARCHAR(1)),
		CAST(IFNULL([g].[ISDEL], IFNULL([f].[ISDEL], IFNULL([e].[ISDEL], IFNULL([d].[ISDEL], IFNULL([c].[ISDEL], IFNULL([b].[ISDEL], IFNULL([a].[ISDEL], ''))))))) AS VARCHAR(1)),
		[a1].[SITE_NM],
		CAST([a].[MENU_NM] AS VARCHAR(50)),
		[a].[MENU_ID],
		CAST([b].[MENU_NM] AS VARCHAR(50)),
		[b].[MENU_ID],
		CAST([c].[MENU_NM] AS VARCHAR(50)),
		[c].[MENU_ID],
		CAST([d].[MENU_NM] AS VARCHAR(50)),
		[d].[MENU_ID],
		CAST([e].[MENU_NM] AS VARCHAR(50)),
		[e].[MENU_ID],
		CAST([f].[MENU_NM] AS VARCHAR(50)),
		[f].[MENU_ID],
		CAST([g].[MENU_NM] AS VARCHAR(50)),
		[g].[MENU_ID],
		CAST(CONCAT(IF (([a1].[SITE_PATH] <> ''), '/', ''), IFNULL([a1].[SITE_PATH], ''), IF (([a].[MENU_PATH] <> ''), '/', ''), IFNULL([a].[MENU_PATH], ''), IF (([b].[MENU_PATH] <> ''), '/', ''), IFNULL([b].[MENU_PATH], ''), IF (([c].[MENU_PATH] <> ''), '/', ''), IFNULL([c].[MENU_PATH], ''), IF (([d].[MENU_PATH] <> ''), '/', ''), IFNULL([d].[MENU_PATH], ''), IF (([e].[MENU_PATH] <> ''), '/', ''), IFNULL([e].[MENU_PATH], ''), IF (([f].[MENU_PATH] <> ''), '/', ''), IFNULL([f].[MENU_PATH], ''), IF (([g].[MENU_PATH] <> ''), '/', ''), IFNULL([g].[MENU_PATH], ''), '/') AS VARCHAR(1))
	FROM
		[jnitcmssite] [a1]
		INNER JOIN [jnitcmsmenu] [a] ON (
			([a].[SITE_ID] = [a1].[SITE_ID])
			AND ([a].[DEPTH] = 0)
		)
		LEFT OUTER JOIN [jnitcmsmenu] [b] ON (
			([b].[SITE_ID] = [a].[SITE_ID])
			AND ([b].[PID] = [a].[MENU_ID])
		)
		LEFT OUTER JOIN [jnitcmsmenu] [c] ON (
			([c].[SITE_ID] = [a].[SITE_ID])
			AND ([c].[PID] = [b].[MENU_ID])
		)
		LEFT OUTER JOIN [jnitcmsmenu] [d] ON (
			([d].[SITE_ID] = [a].[SITE_ID])
			AND ([d].[PID] = [c].[MENU_ID])
		)
		LEFT OUTER JOIN [jnitcmsmenu] [e] ON (
			([e].[SITE_ID] = [a].[SITE_ID])
			AND ([e].[PID] = [d].[MENU_ID])
		)
		LEFT OUTER JOIN [jnitcmsmenu] [f] ON (
			([f].[SITE_ID] = [a].[SITE_ID])
			AND ([f].[PID] = [e].[MENU_ID])
		)
		LEFT OUTER JOIN [jnitcmsmenu] [g] ON (
			([g].[SITE_ID] = [a].[SITE_ID])
			AND ([g].[PID] = [f].[MENU_ID])
		);

/**********************************/
/* Table Name: jnitmenu_vt */
/**********************************/
CREATE OR REPLACE VIEW jnitmenu_vt (
	menu_seq INTEGER,
	site_nm CHARACTER VARYING (50),
	menu_depth1 CHARACTER VARYING (50),
	menu_depth2 CHARACTER VARYING (50),
	menu_depth3 CHARACTER VARYING (50),
	menu_depth4 CHARACTER VARYING (50),
	menu_depth5 CHARACTER VARYING (50),
	menu_depth6 CHARACTER VARYING (50),
	menu_depth7 CHARACTER VARYING (50),
	menu_url CHARACTER VARYING (1),
	menu_dept CHARACTER VARYING (100),
	menu_part CHARACTER VARYING (200),
	menu_tel CHARACTER VARYING (20),
	menu_memid CHARACTER VARYING (20),
	[method] CHARACTER VARYING (1)
)
AS
	SELECT
		[b].[MENU_SEQ],
		[a].[SITE_NM],
		[a].[MENU_DEPTH1],
		[a].[MENU_DEPTH2],
		[a].[MENU_DEPTH3],
		[a].[MENU_DEPTH4],
		[a].[MENU_DEPTH5],
		[a].[MENU_DEPTH6],
		[a].[MENU_DEPTH7],
		[a].[MENU_URL],
		[b].[MENU_DEPT],
		[b].[MENU_PART],
		[b].[MENU_TEL],
		[b].[MENU_MEMID],
		[a].[METHOD]
	FROM
		[jnitcmsmenu_vt] [a]
		LEFT OUTER JOIN [jnitmenu] [b] ON ([b].[MENU_URL] = [a].[MENU_URL])
	WHERE
		(
			([a].[ISCNT] = CAST(1 AS VARCHAR))
			AND ([a].[ISDEL] = CAST(0 AS VARCHAR))
		)
	ORDER BY
		[a].[SITE_ID],
		15,
		[a].[DEPTH];





/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/

CREATE TABLE JNITCMSMENUTREE(
		MENU_CODE_ID                  		VARCHAR(100)		 NOT NULL,
		MENU_ID                       		VARCHAR(100)		 DEFAULT '0'		 NOT NULL,
		MENU_NAME                     		VARCHAR(200)		 NULL,
		MENU_LINK                     		VARCHAR(255)		 NULL,
		MENU_DEPTH                    		INT(1)		 DEFAULT 1		 NULL,
		MENU_ICON                     		VARCHAR(100)		 NULL,
		MENU_ACTIVE                   		INT(1)		 NULL  ,
		MENU_PARENT                   		VARCHAR(100)		 NULL,
		MENU_CHILD                    		INT(1)		 NULL,
		CREATED_MBR_ID                		VARCHAR(50)		 NULL,
		MODIFIED_MBR_ID               		VARCHAR(50)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);


ALTER TABLE JNITCMSMENUTREE ADD CONSTRAINT IDX_JNITCMSMENUTREE_PK PRIMARY KEY (MENU_CODE_ID);

/**********************************/
/* Table Name: 최근게시물데이터 */
/**********************************/
CREATE TABLE JNITBOARDDATA(
		DATA_ID                       		VARCHAR(20)		 NOT NULL ,
		DATA_NM                       		VARCHAR(250)		 NOT NULL ,
		DATA_BOARD_IDS                	STRING		 NULL,
		DATA_CATEGORY                       		VARCHAR(250)		NULL ,
		DATA_ORDER                    		INT(1)		 NULL  ,
		DATA_LIMIT                    		INT(3)		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIED                      		DATETIME		 NULL  ,
		ISDEL                         		INT(1)		 DEFAULT 0
);


ALTER TABLE JNITBOARDDATA ADD CONSTRAINT IDX_JNITBOARDDATA_PK PRIMARY KEY (DATA_ID);

