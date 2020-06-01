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
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL	,
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

