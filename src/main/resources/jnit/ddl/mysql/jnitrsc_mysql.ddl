/**********************************/
/* Table Name: 만족도메인테이블 */
/**********************************/
CREATE TABLE JNITRSC(
		RSC_ID                        		VARCHAR(20)		 NOT NULL COMMENT '만족도고유코드',
		RSC_MENU                      		VARCHAR(100)		 NOT NULL COMMENT '만족도메뉴',
		RSC_URL                       		VARCHAR(100)		 NULL  COMMENT '만족도메뉴URL',
		RSC_TOT_SCORE                 		INT(15)		 DEFAULT 0		 NULL  COMMENT '만족도점수합계'
) COMMENT='만족도메인테이블';

/**********************************/
/* Table Name: 만족도데이터테이블 */
/**********************************/
CREATE TABLE JNITRSCDATA(
		DATA_ID                       		VARCHAR(20)		 NOT NULL COMMENT '만족도데이터코드',
		RSC_ID                        		VARCHAR(20)		 NOT NULL COMMENT '만족도고유코드',
		DATA_MEMO                     		VARCHAR(1000)		 NULL  COMMENT '만족도평가메모',
		DATA_SCORE                    		INT(15)		 DEFAULT 0		 NOT NULL COMMENT '만족도평가점수',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일자',
		REMOTE_ADDR                   		VARCHAR(128)		 NULL  COMMENT '등록자IP'
) COMMENT='만족도데이터테이블';

/**********************************/
/* Table Name: 페이지통계 */
/**********************************/
CREATE TABLE JNITRSCPAGE(
		RSCP_ID                       		VARCHAR(20)		 NOT NULL COMMENT '페이지통계코드',
		SITE_ID                       		VARCHAR(20)		 NULL  COMMENT '사이트코드',
		MENU_ID                       		VARCHAR(20)		 NULL  COMMENT '메뉴코드',
		PAGE_URL                      		VARCHAR(128)		 NOT NULL COMMENT '페이지URL',
		PAGE_VIEW                     		INT(10)		 DEFAULT 0		 NULL  COMMENT '페이지뷰카운트',
		HIT1                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가1',
		HIT2                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가2',
		HIT3                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가3',
		HIT4                          		INT(10)		 NULL  COMMENT '평가4',
		HIT5                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가5'
) COMMENT='페이지통계';

/**********************************/
/* Table Name: 페이지평가데이터 */
/**********************************/
CREATE TABLE JNITRSCPAGEDATA(
		PDATA_ID                      		VARCHAR(20)		 NOT NULL COMMENT '페이지평가데이터코드',
		RSCP_ID                       		VARCHAR(20)		 NULL  COMMENT '페이지평가코드',
		MEMO                          		VARCHAR(1000)		 NULL  COMMENT '메모',
		HIT1                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가1',
		HIT2                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가2',
		HIT3                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가3',
		HIT4                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가4',
		HIT5                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가5',
		REMOTE_ADDR                   		VARCHAR(128)		 NULL  COMMENT '평가자IP',
		CREATED                       		DATETIME		 NULL  COMMENT '평가일시'
) COMMENT='페이지평가데이터';


ALTER TABLE JNITRSC ADD CONSTRAINT IDX_JNITRSC_PK PRIMARY KEY (RSC_ID);

ALTER TABLE JNITRSCDATA ADD CONSTRAINT IDX_JNITRSCDATA_PK PRIMARY KEY (DATA_ID);
ALTER TABLE JNITRSCDATA ADD CONSTRAINT IDX_JNITRSCDATA_FK0 FOREIGN KEY (RSC_ID) REFERENCES JNITRSC (RSC_ID);

ALTER TABLE JNITRSCPAGE ADD CONSTRAINT IDX_JNITRSCPAGE_PK PRIMARY KEY (RSCP_ID);
ALTER TABLE JNITRSCPAGE ADD CONSTRAINT UNQ_PAGE_URL UNIQUE (PAGE_URL);

ALTER TABLE JNITRSCPAGEDATA ADD CONSTRAINT IDX_JNITRSCPAGEDATA_PK PRIMARY KEY (PDATA_ID);
ALTER TABLE JNITRSCPAGEDATA ADD CONSTRAINT IDX_JNITRSCPAGEDATA_FK0 FOREIGN KEY (RSCP_ID) REFERENCES JNITRSCPAGE (RSCP_ID);

