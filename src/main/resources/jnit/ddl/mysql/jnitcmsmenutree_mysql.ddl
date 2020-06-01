/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITCMSMENUTREE(
		MENU_CODE_ID                  		VARCHAR(100)		 NOT NULL COMMENT '메뉴ID',
		MENU_ID                       		VARCHAR(100)		 DEFAULT 0		 NULL  COMMENT '메뉴코드',
		MENU_NAME                     		VARCHAR(200)		 NULL  COMMENT '메뉴명',
		MENU_LINK                     		VARCHAR(255)		 NULL  COMMENT '메뉴링크',
		MENU_DEPTH                    		INT(1)	 DEFAULT 1		 NULL  COMMENT '메뉴뎁스',
		MENU_ICON                     		VARCHAR(100)		 NULL  COMMENT '메뉴아이콘',
		MENU_ACTIVE                   		INT(1)		 NULL  COMMENT '활성화',
		MENU_PARENT                   		VARCHAR(100)		 NULL  COMMENT '부모노드',
		MENU_CHILD                    		INT(1)		 NULL  COMMENT '자식노드유무',
		CREATED_MBR_ID						VARCHAR(50)		 NULL  COMMENT '생성자',
		MODIFIED_MBR_ID						VARCHAR(50)		 NULL  COMMENT '수정자',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT 'ISDEL'
) COMMENT='메뉴테이블';


ALTER TABLE JNITCMSMENUTREE ADD CONSTRAINT IDX_JNITCMSMENUTREE_PK PRIMARY KEY (MENU_CODE_ID);

