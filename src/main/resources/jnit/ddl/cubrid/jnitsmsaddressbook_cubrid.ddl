/**********************************/
/* Table Name: SMS 주소록 목록 */
/**********************************/
CREATE TABLE JNITMGOVADDRGRP(
		GRP_ID                        		VARCHAR(20)		 NULL,
		GRP_NM                        		VARCHAR(50)		 NULL,
		USER_MBR                      		VARCHAR(30)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: SMS 주소록 명단 */
/**********************************/
CREATE TABLE JNITMGOVADDRLIST(
		LIST_ID                       		VARCHAR(20)		 NULL,
		GRP_ID                        		VARCHAR(20)		 NULL,
		MBR_NM                        		VARCHAR(20)		 NULL,
		MBR_ID                        		VARCHAR(30)		 NULL,
		MBR_LOGIN                     		VARCHAR(30)		 NULL,
		PHONE                         		VARCHAR(15)		 NULL,
		PHONE2                        		VARCHAR(15)		 NULL,
		POS_ID                        		VARCHAR(30)		 NULL,
		POS_NM                        		VARCHAR(30)		 NULL,
		ORG_ID                        		VARCHAR(30)		 NULL,
		ORG_NM                        		VARCHAR(30)		 NULL,
		MBRTYPE_ID                    		VARCHAR(30)		 NULL,
		MBRTYPE_NM                    		VARCHAR(30)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL
);

/**********************************/
/* Table Name: SMS주소록 */
/**********************************/
CREATE TABLE JNITSMSADDRESSBOOK(
		ADDR_ID                       		VARCHAR(20)		 NULL,
		ADDR_ME_MBR_ID                		VARCHAR(20)		 NULL,
		ADDR_MBR_ID                   		VARCHAR(20)		 NULL,
		ADDR_NAME                     		VARCHAR(16)		 NULL,
		ADDR_PHONE                    		VARCHAR(20)		 NULL,
		ADDR_EXT01                    		VARCHAR(255)		 NULL,
		ADDR_EXT02                    		VARCHAR(255)		 NULL,
		DATE01                        		DATETIME		 NULL,
		DATE02                        		DATETIME		 NULL,
		ISDEL                         		INT(1)		 NULL,
		TYPE                          		VARCHAR(30)		 NULL
);

/**********************************/
/* Table Name: SMS 키테이블 */
/**********************************/
CREATE TABLE MGOV_SERIAL(
		ID                            		INT(10)		 DEFAULT 0
);

/**********************************/
/* Table Name: JNIT_LTSKOREA_SMS */
/**********************************/
CREATE TABLE JNIT_LTSKOREA_SMS(
		USERDATA                      		INT(10)		 NULL,
		MSG_SEQ                       		INT(10)		 NULL,
		SUB_ID                        		VARCHAR(20)		 NULL,
		CUR_STATE                     		INT(1)		 NULL,
		SENT_DATE                     		DATETIME		 NULL,
		RSLT_DATE                     		DATETIME		 NULL,
		REQ_DATE                      		DATETIME		 NULL,
		RSLT_CODE                     		INT(15)		 NULL,
		RSLT_CODE2                    		VARCHAR(1)		 NULL,
		RSLT_NET                      		VARCHAR(3)		 NULL,
		CALL_TO                       		VARCHAR(12)		 NULL,
		CALL_FROM                     		VARCHAR(12)		 NULL,
		SMS_TXT                       		VARCHAR(160)		 NULL,
		MSG_TYPE                      		INT(1)		 NULL,
		CONT_SEQ                      		INT(10)		 NULL
);

ALTER TABLE JNITMGOVADDRGRP ADD CONSTRAINT IDX_JNITMGOVADDRGRP_PK PRIMARY KEY (GRP_ID);

ALTER TABLE JNITMGOVADDRLIST ADD CONSTRAINT IDX_JNITMGOVADDRLIST_PK PRIMARY KEY (LIST_ID);
ALTER TABLE JNITMGOVADDRLIST ADD CONSTRAINT IDX_JNITMGOVADDRLIST_FK0 FOREIGN KEY (GRP_ID) REFERENCES JNITMGOVADDRGRP (GRP_ID);

