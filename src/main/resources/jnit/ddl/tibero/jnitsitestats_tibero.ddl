/**********************************/
/* Table Name: 사이트별 방문자 접속 카운트 */
/**********************************/
CREATE TABLE JNITSITESTATE(
		WHEN_DATE                     		VARCHAR2(50)		 NULL 
);

COMMENT ON TABLE JNITSITESTATE is '사이트별 방문자 접속 카운트';
COMMENT ON COLUMN JNITSITESTATE.WHEN_DATE is '접속일';


/**********************************/
/* Table Name: 방문자 접속자 리스트 */
/**********************************/
CREATE TABLE JNITSITESTATELIST(
		SITE                          		VARCHAR2(20)		 NULL ,
		IP                            		VARCHAR2(20)		 NULL 
);

COMMENT ON TABLE JNITSITESTATELIST is '방문자 접속자 리스트';
COMMENT ON COLUMN JNITSITESTATELIST.SITE is '사이트';
COMMENT ON COLUMN JNITSITESTATELIST.IP is 'IP';


