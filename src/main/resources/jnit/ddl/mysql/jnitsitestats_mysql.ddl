/**********************************/
/* Table Name: 사이트별 방문자 접속 카운트 */
/**********************************/
CREATE TABLE JNITSITESTATE(
		WHEN_DATE                     		VARCHAR(50)		 NULL  COMMENT '접속일'
) COMMENT='사이트별 방문자 접속 카운트';

/**********************************/
/* Table Name: 방문자 접속자 리스트 */
/**********************************/
CREATE TABLE JNITSITESTATELIST(
		SITE                          		VARCHAR(20)		 NULL  COMMENT '사이트',
		IP                            		VARCHAR(20)		 NULL  COMMENT 'IP'
) COMMENT='방문자 접속자 리스트';

