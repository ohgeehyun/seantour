/**********************************/
/* Table Name: 방문자분석데이터 */
/**********************************/
CREATE TABLE JNITVISITLOG(
		WHEN_DATETIME                 		DATETIME		 NULL  COMMENT '날짜시간',
		WHEN_DATE                     		VARCHAR(200)		 NULL  COMMENT '날짜',
		SITE                          		VARCHAR(100)		 NULL  COMMENT '사이트아이디',
		IPADDR                        		VARCHAR(255)		 NULL  COMMENT 'IP',
		REFERER                       		TEXT		 NULL  COMMENT '레퍼러',
		USER_OS                       		VARCHAR(255)		 NULL  COMMENT 'UserOS',
		BROWSER                       		VARCHAR(255)		 NULL  COMMENT 'UserBrowser',
		USER_AGENT                    		VARCHAR(255)		 NULL  COMMENT 'UserAgent',
		PAGE                          		VARCHAR(255)		 NULL  COMMENT 'PAGE',
		USER                          		VARCHAR(100)		 NULL  COMMENT 'USER',
		USR_ACTION                    		VARCHAR(200)		 NULL  COMMENT 'USR_ACTION'
) COMMENT='방문자분석데이터';

/**********************************/
/* Table Name: 방문자 접속 데이터 */
/**********************************/
CREATE TABLE JNITVISITCOUNT(
		SITE                          		VARCHAR(100)		 NULL  COMMENT '사이트',
		VDATE                         		DATE		 NULL  COMMENT '날짜',
		VHOUR                         		INT(2)		 NULL  COMMENT '시간',
		USER_OS                       		VARCHAR(100)		 NULL  COMMENT '운영체제',
		BROWSER                       		VARCHAR(100)		 NULL  COMMENT '브라우저',
		HIT                           		INT(10)		 NULL  COMMENT '카운트'
) COMMENT='방문자 접속 데이터';


ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_PK PRIMARY KEY (WHEN_DATETIME);
CREATE INDEX IDX_JNITVISITLOG_1 ON JNITVISITLOG (WHEN_DATE, SITE);
ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_2 UNIQUE (WHEN_DATE, SITE, IPADDR);

ALTER TABLE JNITVISITCOUNT ADD CONSTRAINT IDX_JNITVISITCOUNT_1 UNIQUE (SITE, VDATE, VHOUR, USER_OS, BROWSER);

