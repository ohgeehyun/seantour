/**********************************/
/* Table Name: 페이지 스크랩 */
/**********************************/
CREATE TABLE JNITSCRAP(
		SCRAP_ID                      		VARCHAR(20)		 NULL  COMMENT '고유키',
		MBR_ID                        		VARCHAR(20)		 NULL  COMMENT '회원 ID',
		TITLE                         		VARCHAR(200)		 NULL  COMMENT '제목',
		URL                           		VARCHAR(4000)		 NULL  COMMENT 'URL',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일'
) COMMENT='페이지 스크랩';

