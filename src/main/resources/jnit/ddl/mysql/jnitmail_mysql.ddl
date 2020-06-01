/**********************************/
/* Table Name: CMS메일서비스 */
/**********************************/
CREATE TABLE JNITCMSMAIL(
		MAIL_ID                       		VARCHAR(50)		 NOT NULL COMMENT '메일고유키',
		ID_ME                         		VARCHAR(20)		 NOT NULL COMMENT '본인계정',
		ID_WHO                        		VARCHAR(20)		 NOT NULL COMMENT '등록계정',
		SEND_DATE                     		DATETIME		 NULL  COMMENT '날짜',
		CONTENT                       		LONGTEXT		 NULL  COMMENT '내용',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		`VIEW`                          		INT(1)		 DEFAULT 0		 NULL  COMMENT '확인여부',
		IMPORTANT                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '중요여부',
		EXT1                          		VARCHAR(255)		 NULL  COMMENT '여분필드1',
		EXT2                          		VARCHAR(255)		 NULL  COMMENT '여분필드2',
		EXT3                          		VARCHAR(255)		 NULL  COMMENT '여분필드3',
		EXT4                          		VARCHAR(255)		 NULL  COMMENT '여분필드4',
		EXT5                          		VARCHAR(255)		 NULL  COMMENT '여분필드5'
) COMMENT='CMS메일서비스';

/**********************************/
/* Table Name: 주소록관리 */
/**********************************/
CREATE TABLE JNITCMSMAILADDRESS(
		ID_ME                         		VARCHAR(20)		 NOT NULL COMMENT '본인계정',
		ID_WHO                        		VARCHAR(20)		 NOT NULL COMMENT '등록계정',
		`NAME`                          		VARCHAR(150)		 NULL  COMMENT '이름',
		`GROUP`                         		VARCHAR(150)		 NULL  COMMENT '그룹',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		EXT1                          		VARCHAR(255)		 NULL  COMMENT '여분필드1',
		EXT2                          		VARCHAR(255)		 NULL  COMMENT '여분필드2',
		EXT3                          		VARCHAR(255)		 NULL  COMMENT '여분필드3',
		EXT4                          		VARCHAR(255)		 NULL  COMMENT '여분필드4',
		EXT5                          		VARCHAR(255)		 NULL  COMMENT '여분필드5'
) COMMENT='주소록관리';

/**********************************/
/* Table Name: 파일관리 */
/**********************************/
CREATE TABLE JNITCMSMAILFILE(
		MAIL_ID                       		VARCHAR(50)		 NULL  COMMENT '메일고유키',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일경로',
		FILE_ID                       		VARCHAR(255)		 NOT NULL COMMENT '파일아이디',
		FILE_URL                      		VARCHAR(255)		 NULL  COMMENT '파일_URL',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일이름',
		FILE_ONM                      		VARCHAR(255)		 NULL  COMMENT '파일오리지널',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		EXT1                          		VARCHAR(255)		 NULL  COMMENT '여분필드1',
		EXT2                          		VARCHAR(255)		 NULL  COMMENT '여분필드2',
		EXT3                          		VARCHAR(255)		 NULL  COMMENT '여분필드3',
		EXT4                          		VARCHAR(255)		 NULL  COMMENT '여분필드4',
		EXT5                          		VARCHAR(255)		 NULL  COMMENT '여분필드5'
) COMMENT='파일관리';


ALTER TABLE JNITCMSMAIL ADD CONSTRAINT IDX_JNITCMSMAIL_PK PRIMARY KEY (MAIL_ID);

ALTER TABLE JNITCMSMAILADDRESS ADD CONSTRAINT IDX_JNITCMSMAILADDRESS_PK PRIMARY KEY (ID_ME, ID_WHO);

ALTER TABLE JNITCMSMAILFILE ADD CONSTRAINT IDX_JNITCMSMAILFILE_PK PRIMARY KEY (FILE_ID);
ALTER TABLE JNITCMSMAILFILE ADD CONSTRAINT IDX_JNITCMSMAILFILE_FK0 FOREIGN KEY (MAIL_ID) REFERENCES JNITCMSMAIL (MAIL_ID);

