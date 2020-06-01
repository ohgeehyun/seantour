/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITMENU(
		MENU_SEQ                      		NUMBER(30)		 DEFAULT 0		 NOT NULL,
		MENU_URL                      		VARCHAR2(255)		 NULL ,
		MENU_DEPT                     		VARCHAR2(100)		 NULL ,
		MENU_PART                     		VARCHAR2(200)		 NULL ,
		MENU_TEL                      		VARCHAR2(20)		 NULL ,
		MENU_MEMID                    		VARCHAR2(20)		 NULL 
);

COMMENT ON TABLE JNITMENU is '메뉴테이블';
COMMENT ON COLUMN JNITMENU.MENU_SEQ is '메뉴순번';
COMMENT ON COLUMN JNITMENU.MENU_URL is '메뉴URL';
COMMENT ON COLUMN JNITMENU.MENU_DEPT is '담당부서';
COMMENT ON COLUMN JNITMENU.MENU_PART is '담당업무';
COMMENT ON COLUMN JNITMENU.MENU_TEL is '전화번호';
COMMENT ON COLUMN JNITMENU.MENU_MEMID is '담당자아이디';



ALTER TABLE JNITMENU ADD CONSTRAINT IDX_JNITMENU_PK PRIMARY KEY (MENU_SEQ);