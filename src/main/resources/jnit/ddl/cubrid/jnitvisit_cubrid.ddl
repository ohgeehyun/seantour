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


ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_PK PRIMARY KEY (WHEN_DATETIME);
CREATE INDEX IDX_JNITVISITLOG_1 ON JNITVISITLOG (WHEN_DATE, SITE);
ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_2 UNIQUE (WHEN_DATE, SITE, IPADDR);

ALTER TABLE JNITVISITCOUNT ADD CONSTRAINT IDX_JNITVISITCOUNT_1 UNIQUE (SITE, VDATE, VHOUR, USER_OS, BROWSER);

