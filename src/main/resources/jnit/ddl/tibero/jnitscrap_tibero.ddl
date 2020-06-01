/**********************************/
/* Table Name: 페이지 스크랩 */
/**********************************/
CREATE TABLE JNITSCRAP(
		SCRAP_ID                      		VARCHAR2(20)		 NULL ,
		MBR_ID                        		VARCHAR2(20)		 NULL ,
		TITLE                         		VARCHAR2(200)		 NULL ,
		URL                           		VARCHAR2(4000)		 NULL ,
		CREATED                       		DATE		 NULL 
);

COMMENT ON TABLE JNITSCRAP is '페이지 스크랩';
COMMENT ON COLUMN JNITSCRAP.SCRAP_ID is '고유키';
COMMENT ON COLUMN JNITSCRAP.MBR_ID is '회원 ID';
COMMENT ON COLUMN JNITSCRAP.TITLE is '제목';
COMMENT ON COLUMN JNITSCRAP.URL is 'URL';
COMMENT ON COLUMN JNITSCRAP.CREATED is '생성일';


