/**********************************/
/* Table Name: 로그인 로그 테이블 */
/**********************************/
CREATE TABLE JNITLOGINLOG(
		IP_ID                         		VARCHAR2(255)		 NULL ,
		MBR_ID                        		VARCHAR2(255)		 NULL ,
		IP_ADDR                       		VARCHAR2(255)		 NULL ,
		CREATED                       		DATE		 NULL 
);

COMMENT ON TABLE JNITLOGINLOG is '로그인 로그 테이블';
COMMENT ON COLUMN JNITLOGINLOG.IP_ID is 'IP_ID';
COMMENT ON COLUMN JNITLOGINLOG.MBR_ID is 'MBR_ID';
COMMENT ON COLUMN JNITLOGINLOG.IP_ADDR is 'IP_주소';
COMMENT ON COLUMN JNITLOGINLOG.CREATED is '생성일';



ALTER TABLE JNITLOGINLOG ADD CONSTRAINT IDX_JNITLOGINLOG_PK PRIMARY KEY (IP_ID);

