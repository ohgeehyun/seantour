/**********************************/
/* Table Name: 회원 패키지 테이블 */
/**********************************/
CREATE TABLE JNITCMSMBRPACKAGE(
		PACK_ID                       		VARCHAR(30)		 NULL  COMMENT '기본키',
		PACKAGE_NM                    		VARCHAR(100)		 NULL  COMMENT '패키지 명',
		MBR_ACCESS                    		VARCHAR(255)		 NULL  COMMENT '접근허용 회원',
		MBR_DENY                     		VARCHAR(255)		 NULL  COMMENT '접근불가 회원',
		ORG_ACCESS                    		VARCHAR(255)		 NULL  COMMENT '접근허용 직급',
		ORG_DENY                     		VARCHAR(255)		 NULL  COMMENT '접근불가 직급',
		POS_ACCESS                    		VARCHAR(255)		 NULL  COMMENT '접근허용 부서',
		POS_DENY                     		VARCHAR(255)		 NULL  COMMENT '접근불가 부서',
		TYPE_ACCESS                   		VARCHAR(255)		 NULL  COMMENT '접근허용 타입',
		TYPE_DENY                    		VARCHAR(255)		 NULL  COMMENT '접근불가 타입',
		QUERY                         		TEXT		 NULL  COMMENT '쿼리',
		COMMENT                       		VARCHAR(255)		 NULL  COMMENT '설명',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '임시삭제'
) COMMENT='회원 패키지 테이블';


ALTER TABLE JNITCMSMBRPACKAGE ADD CONSTRAINT IDX_JNITCMSMBRPACKAGE_PK PRIMARY KEY (PACK_ID);

