/**********************************/
/* Table Name: SMS 주소록 목록 */
/**********************************/
CREATE TABLE JNITMGOVADDRGRP(
		GRP_ID                        		VARCHAR(20)		 NULL  COMMENT '고유키',
		GRP_NM                        		VARCHAR(50)		 NULL  COMMENT '그룹 명칭',
		USER_MBR                      		VARCHAR(30)		 NULL  COMMENT '관리자 아이디',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '임시삭제'
) COMMENT='SMS 주소록 목록';

/**********************************/
/* Table Name: SMS 주소록 명단 */
/**********************************/
CREATE TABLE JNITMGOVADDRLIST(
		LIST_ID                       		VARCHAR(20)		 NULL  COMMENT '고유키',
		GRP_ID                        		VARCHAR(20)		 NULL  COMMENT 'FK',
		MBR_NM                        		VARCHAR(20)		 NULL  COMMENT '회원 이름',
		MBR_ID                        		VARCHAR(30)		 NULL  COMMENT '회원 고유값',
		MBR_LOGIN                     		VARCHAR(30)		 NULL  COMMENT '회원 로그인 아이디',
		PHONE                         		VARCHAR(15)		 NULL  COMMENT '핸드폰 번호',
		PHONE2                        		VARCHAR(15)		 NULL  COMMENT '핸드폰 번호2',
		POS_ID                        		VARCHAR(30)		 NULL  COMMENT '부서 아이디',
		POS_NM                        		VARCHAR(30)		 NULL  COMMENT '부서명',
		ORG_ID                        		VARCHAR(30)		 NULL  COMMENT '직급 아이디',
		ORG_NM                        		VARCHAR(30)		 NULL  COMMENT '직급명',
		MBRTYPE_ID                    		VARCHAR(30)		 NULL  COMMENT '회원 유형 아이디',
		MBRTYPE_NM                    		VARCHAR(30)		 NULL  COMMENT '회원유형 명',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '임시삭제'
) COMMENT='SMS 주소록 명단';

/**********************************/
/* Table Name: SMS주소록 */
/**********************************/
CREATE TABLE JNITSMSADDRESSBOOK(
		ADDR_ID                       		VARCHAR(20)		 NULL  COMMENT 'ADDR_ID',
		ADDR_ME_MBR_ID                		VARCHAR(20)		 NULL  COMMENT 'ADDR_ME_MBR_ID',
		ADDR_MBR_ID                   		VARCHAR(20)		 NULL  COMMENT 'ADDR_MBR_ID',
		ADDR_NAME                     		VARCHAR(16)		 NULL  COMMENT 'ADDR_NAME',
		ADDR_PHONE                    		VARCHAR(20)		 NULL  COMMENT 'ADDR_PHONE',
		ADDR_EXT01                    		VARCHAR(255)		 NULL  COMMENT 'ADDR_EXT01',
		ADDR_EXT02                    		VARCHAR(255)		 NULL  COMMENT 'ADDR_EXT02',
		DATE01                        		DATETIME		 NULL  COMMENT 'DATE01',
		DATE02                        		DATETIME		 NULL  COMMENT 'DATE02',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT 'ISDEL',
		TYPE                          		VARCHAR(30)		 NULL  COMMENT 'TYPE'
) COMMENT='SMS주소록';

/**********************************/
/* Table Name: SMS 키테이블 */
/**********************************/
CREATE TABLE MGOV_SERIAL(
		ID                            		INT(10)		 DEFAULT 0		 NULL  COMMENT '키값'
) COMMENT='SMS 키테이블';

/**********************************/
/* Table Name: JNIT_LTSKOREA_SMS */
/**********************************/
CREATE TABLE JNIT_LTSKOREA_SMS(
		USERDATA                      		INT(10)		 NULL  COMMENT '유저 정보',
		MSG_SEQ                       		INT(10)		 NULL  COMMENT '메세지 고유값',
		SUB_ID                        		VARCHAR(20)		 NULL  COMMENT '보조 고유값',
		CUR_STATE                     		INT(1)		 NULL  COMMENT '현재 상태값 ',
		SENT_DATE                     		DATETIME		 NULL  COMMENT 'SMS 전송 일자',
		RSLT_DATE                     		DATETIME		 NULL  COMMENT 'SMS 최종 전송 일자',
		REQ_DATE                      		DATETIME		 NULL  COMMENT 'SMS 요청 일자',
		RSLT_CODE                     		INT(15)		 NULL  COMMENT '전송 결과 코드2',
		RSLT_CODE2                    		VARCHAR(1)		 NULL  COMMENT '전송 결과 코드2',
		RSLT_NET                      		VARCHAR(3)		 NULL  COMMENT '결과',
		CALL_TO                       		VARCHAR(12)		 NULL  COMMENT '받는사람 핸드폰번호',
		CALL_FROM                     		VARCHAR(12)		 NULL  COMMENT '보내는사람 전화번호',
		SMS_TXT                       		VARCHAR(160)		 NULL  COMMENT 'SMS 내용',
		MSG_TYPE                      		INT(1)		 NULL  COMMENT 'SMS 타입',
		CONT_SEQ                      		INT(10)		 NULL  COMMENT '첨부파일고유값'
) COMMENT='JNIT_LTSKOREA_SMS';


ALTER TABLE JNITMGOVADDRGRP ADD CONSTRAINT IDX_JNITMGOVADDRGRP_PK PRIMARY KEY (GRP_ID);

ALTER TABLE JNITMGOVADDRLIST ADD CONSTRAINT IDX_JNITMGOVADDRLIST_PK PRIMARY KEY (LIST_ID);
ALTER TABLE JNITMGOVADDRLIST ADD CONSTRAINT IDX_JNITMGOVADDRLIST_FK0 FOREIGN KEY (GRP_ID) REFERENCES JNITMGOVADDRGRP (GRP_ID);

