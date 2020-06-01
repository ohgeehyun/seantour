/**********************************/
/* Table Name: 회원 패키지 테이블 */
/**********************************/
CREATE TABLE JNITCMSMBRPACKAGE(
		PACK_ID                       		VARCHAR(30)		 NULL,
		PACKAGE_NM                    		VARCHAR(100)		 NULL,
		MBR_ACCESS                    		VARCHAR(255)		 NULL,
		MBR_DENY                     		VARCHAR(255)		 NULL,
		ORG_ACCESS                    		VARCHAR(255)		 NULL,
		ORG_DENY                     		VARCHAR(255)		 NULL,
		POS_ACCESS                    		VARCHAR(255)		 NULL,
		POS_DENY                     		VARCHAR(255)		 NULL,
		TYPE_ACCESS                   		VARCHAR(255)		 NULL,
		TYPE_DENY                    		VARCHAR(255)		 NULL,
		"QUERY"                         		STRING		 NULL,
		"COMMENT"                       		VARCHAR(255)		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);


ALTER TABLE JNITCMSMBRPACKAGE ADD CONSTRAINT IDX_JNITCMSMBRPACKAGE_PK PRIMARY KEY (PACK_ID);

