/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITMENU(
		MENU_SEQ                      		INT(30)		 DEFAULT 0		 NOT NULL,
		MENU_URL                      		VARCHAR(255)		 NULL,
		MENU_DEPT                     		VARCHAR(100)		 NULL,
		MENU_PART                     		VARCHAR(200)		 NULL,
		MENU_TEL                      		VARCHAR(20)		 NULL,
		MENU_MEMID                    		VARCHAR(20)		 NULL
);


ALTER TABLE JNITMENU ADD CONSTRAINT IDX_JNITMENU_PK PRIMARY KEY (MENU_SEQ);