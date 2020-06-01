/**********************************/
/* Table Name: 배포 히스토리 테이블 */
/**********************************/
CREATE TABLE JNITCMSDISSEMINATEHISTORY(
		HISTORY_ID                    		VARCHAR(30)		 NULL  COMMENT 'HISTORY_ID',
		SITE_ID                       		VARCHAR(30)		 NULL  COMMENT 'SITE_ID',
		MENU_ID                       		VARCHAR(30)		 NULL  COMMENT 'MENU_ID',
		CNT_ID                        		VARCHAR(30)		 NULL  COMMENT 'CNT_ID',
		CONTENT_PATH                  		VARCHAR(255)		 NULL  COMMENT '콘텐츠경로',
		DISSEMINATE_TYPE              		VARCHAR(10)		 NULL  COMMENT '승인유형',
		DISSEMINATE_LINE              		TEXT		 NULL  COMMENT '결제라인',
		MBR_ID                        		VARCHAR(20)		 NULL  COMMENT '결제자',
		DISSEMINATE_USERCONFIRM       		VARCHAR(10)		 NULL  COMMENT '결제자상태',
		DISSEMINATE_CONFIRM           		INT(1)		 DEFAULT 0		 NULL  COMMENT '콘텐츠상태',
		DISSEMINATE_DAY               		DATETIME		 NULL  COMMENT '예약날자',
		DISSEMINATE_CREATED           		DATETIME		 NULL  COMMENT '생성일',
		HISTORY_MEMO                  		TEXT		 NULL  COMMENT '메모'
) COMMENT='배포 히스토리 테이블';

/**********************************/
/* Table Name: 배포테이블 */
/**********************************/
CREATE TABLE JNITCMSDISSEMINATE(
		DISSEMINATE_ID                		VARCHAR(30)		 NULL  COMMENT 'DISSEMINATE_ID',
		SITE_ID                       		VARCHAR(30)		 NULL  COMMENT 'SITE_ID',
		MENU_ID                       		VARCHAR(30)		 NULL  COMMENT 'MENU_ID',
		CNT_ID                        		VARCHAR(30)		 NULL  COMMENT 'CNT_ID',
		CONTENT_PATH                  		TEXT		 NULL  COMMENT '콘텐츠경로',
		DISSEMINATE_TYPE              		VARCHAR(10)		 NULL  COMMENT '설정유형',
		MBR_ID                        		VARCHAR(30)		 NULL  COMMENT '회원',
		DISSEMINATE_CONFIRM           		INT(1)		 DEFAULT 0		 NULL  COMMENT '승인여부',
		DISSEMINATE_MEMO              		TEXT		 NULL  COMMENT '메모',
		CONTENT_CONFIRM               		INT(1)		 NULL  COMMENT '콘텐츠 완료여부',
		DISSEMINATE_DAY               		DATETIME		 NULL  COMMENT '예약 날짜',
		DISSEMINATE_HISTORY_ID        		VARCHAR(30)		 NULL  COMMENT '히스토리',
		DISSEMINATE_NAME              		TEXT		 NULL  COMMENT '파일이름',
		DISSEMINATE_NUM               		VARCHAR(20)		 NULL  COMMENT '번호',
		ORIGIN_URL                    		VARCHAR(255)		 NULL  COMMENT '원문 URL',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		DISSEMINATE_STAND             		INT(3)		 DEFAULT 0		 NULL  COMMENT 'DISSEMINATE_STAND'
) COMMENT='배포테이블';


ALTER TABLE JNITCMSDISSEMINATEHISTORY ADD CONSTRAINT IDX_JNITCMSDISSEMINATEHISTORY_PK PRIMARY KEY (HISTORY_ID);

ALTER TABLE JNITCMSDISSEMINATE ADD CONSTRAINT IDX_JNITCMSDISSEMINATE_PK PRIMARY KEY (DISSEMINATE_ID);

