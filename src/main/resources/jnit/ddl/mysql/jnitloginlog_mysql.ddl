/**********************************/
/* Table Name: 로그인 로그 테이블 */
/**********************************/
CREATE TABLE JNITLOGINLOG(
		IP_ID                         		VARCHAR(255)		 NULL  COMMENT 'IP_ID',
		MBR_ID                        		VARCHAR(255)		 NULL  COMMENT 'MBR_ID',
		IP_ADDR                       		VARCHAR(255)		 NULL  COMMENT 'IP_주소',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일'
) COMMENT='로그인 로그 테이블';


ALTER TABLE JNITLOGINLOG ADD CONSTRAINT IDX_JNITLOGINLOG_PK PRIMARY KEY (IP_ID);

