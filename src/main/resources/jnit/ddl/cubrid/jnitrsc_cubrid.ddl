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

