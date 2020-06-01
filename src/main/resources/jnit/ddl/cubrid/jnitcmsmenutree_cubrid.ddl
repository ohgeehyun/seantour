/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITCMSMENUTREE(
		MENU_CODE_ID                  		VARCHAR(100)		 NOT NULL,
		MENU_ID                       		VARCHAR(100)		 DEFAULT '0'		 NOT NULL,
		MENU_NAME                     		VARCHAR(200)		 NULL,
		MENU_LINK                     		VARCHAR(255)		 NULL,
		MENU_DEPTH                    		INT(1)		 DEFAULT 1		 NULL,
		MENU_ICON                     		VARCHAR(100)		 NULL,
		MENU_ACTIVE                   		INT(1)		 NULL  ,
		MENU_PARENT                   		VARCHAR(100)		 NULL,
		MENU_CHILD                    		INT(1)		 NULL,
		CREATED_MBR_ID                		VARCHAR(50)		 NULL,
		MODIFIED_MBR_ID               		VARCHAR(50)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);


ALTER TABLE JNITCMSMENUTREE ADD CONSTRAINT IDX_JNITCMSMENUTREE_PK PRIMARY KEY (MENU_CODE_ID);

