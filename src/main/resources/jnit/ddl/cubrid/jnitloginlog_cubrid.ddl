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

