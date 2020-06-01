/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITMENU(
		MENU_SEQ                      		INT(30)		 DEFAULT 0		 NOT NULL COMMENT '메뉴순번',
		MENU_URL                      		VARCHAR(255)		 NULL  COMMENT '메뉴URL',
		MENU_DEPT                     		VARCHAR(100)		 NULL  COMMENT '담당부서',
		MENU_PART                     		VARCHAR(200)		 NULL  COMMENT '담당업무',
		MENU_TEL                      		VARCHAR(20)		 NULL  COMMENT '전화번호',
		MENU_MEMID                    		VARCHAR(20)		 NULL  COMMENT '담당자아이디'
) COMMENT='메뉴테이블';


ALTER TABLE JNITMENU ADD CONSTRAINT IDX_JNITMENU_PK PRIMARY KEY (MENU_SEQ);