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

