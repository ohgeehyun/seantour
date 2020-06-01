/**********************************/
/* Table Name: 설문조사카테고리 */
/**********************************/
CREATE TABLE JNITRESEARCHCATEGORY(
		CATEGORY_ID                   		VARCHAR(30)		 NULL  COMMENT '카테고리ID',
		CATEGORY_NAME                 		VARCHAR(255)		 NULL  COMMENT '카테고리이름',
		SITE_PATH                     		VARCHAR(255)		 NULL  COMMENT '사이트경로',
		ISDEL                         		INTEGER(1)		 NULL  COMMENT '삭제여부'
) COMMENT='설문조사카테고리';

/**********************************/
/* Table Name: 설문조사테이블 */
/**********************************/
CREATE TABLE JNITRESEARCH(
		RESEARCH_ID                   		VARCHAR(20)		 NOT NULL COMMENT '설문조사ID',
		RESEARCH_NM                   		VARCHAR		 NULL  COMMENT '설문조사제목',
		RESEARCH_OPEN                 		INTEGER(1)		 NULL  COMMENT '설문조사공개',
		STARTTIME                     		DATETIME		 NULL  COMMENT '시작일',
		ENDTIME                       		DATETIME		 NULL  COMMENT '종료일',
		STATE                         		INTEGER(1)		 NULL  COMMENT '저장상태',
		ENTRY                         		INTEGER(8)		 NULL  COMMENT '참여인원',
		BLOCK                         		INTEGER(1)		 NULL  COMMENT '설문참여방식',
		RESEARCH_TARGET               		VARCHAR(255)		 NULL  COMMENT '설문대상',
		NAME_OPEN                     		INTEGER(1)		 NULL  COMMENT '익명/실명',
		RESULT_OPEN                   		INTEGER(1)		 NULL  COMMENT '결과공개여부',
		INTRODUCE                     		VARCHAR		 NULL  COMMENT '설문소개',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INTEGER(1)		 NULL  COMMENT 'ISDEL',
		MODIFIED_WHO                  		VARCHAR(255)		 NULL  COMMENT '수정자',
		CATEGORY_ID                   		VARCHAR(30)		 NULL  COMMENT '카테고리ID',
		SITE_PATH                     		VARCHAR(255)		 NULL  COMMENT '사이트경로'
) COMMENT='설문조사테이블';

/**********************************/
/* Table Name: 설문조사질문 */
/**********************************/
CREATE TABLE JNITRESEARCHQUESTION(
		QUESTION_ID                   		VARCHAR(20)		 NOT NULL COMMENT '질문ID',
		RESEARCH_ID                   		VARCHAR(20)		 NULL  COMMENT '설문조사ID',
		QUESTION_NM                   		VARCHAR		 NULL  COMMENT '설문조사질문',
		TYPE                          		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '질문타입',
		ORDERCHECK                    		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '기타답변',
		VISIBLE                       		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '기본값활성화설정',
		ANSWER_CNT                    		INTEGER(3)		 DEFAULT 1		 NULL  COMMENT '체크박스답변선택수',
		ANSWER_FORM                   		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '주관식박스형태',
		FILE_URL                      		VARCHAR(255)		 NULL  COMMENT '파일 URL',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일 경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일 저장명',
		FILE_ONM                      		VARCHAR(255)		 NULL  COMMENT '파일 원본명',
		FILE_WIDTH                    		INTEGER(5)		 NULL  COMMENT '파일 가로크기',
		FILE_HEIGHT                   		INTEGER(5)		 NULL  COMMENT '파일 세로크기',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT 'ISDEL',
		LINEUP                        		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '답정렬',
		LINEUP_CNT                    		INTEGER(3)		 NULL  COMMENT '답정렬개수'
) COMMENT='설문조사질문';

/**********************************/
/* Table Name: 설문조사답변테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHANSWER(
		ANSWER_ID                     		VARCHAR(20)		 NOT NULL COMMENT '답변 ID',
		QUESTION_ID                   		VARCHAR(20)		 NULL  COMMENT '질문ID',
		RESEARCH_ID                   		VARCHAR(20)		 NULL  COMMENT '설문조사ID',
		ANSWER_NM                     		VARCHAR		 NULL  COMMENT '답변이름',
		TYPE                          		INTEGER(1)		 NULL  COMMENT '답변타입',
		CRITERION_OPT                 		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '척도점수설정',
		CRITERION_CNT                 		INTEGER(4)		 DEFAULT 0		 NULL  COMMENT '척도점수',
		ANSOPT                        		INTEGER(1)		 DEFAULT 0		 NULL  COMMENT '문항설정',
		ANSOPT_NUM                    		VARCHAR(255)		 DEFAULT 0		 NULL  COMMENT '활성화번호',
		ANSOPT_MOVE                   		VARCHAR(255)		 DEFAULT 0		 NULL  COMMENT '이동번호',
		ANSOPT_VISIBLE                		INTEGER(1)		 NULL  COMMENT '답변선택시활성화정책',
		FILE_URL                      		VARCHAR(255)		 NULL  COMMENT '파일 URL',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일 경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일 저장명',
		FILE_ONM                      		VARCHAR(255)		 NULL  COMMENT '파일 원본명',
		FILE_WIDTH                    		INTEGER(5)		 NULL  COMMENT '파일 가로크기',
		FILE_HEIGHT                   		INTEGER(5)		 NULL  COMMENT '파일 세로크기',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INTEGER(1)		 NULL  COMMENT 'ISDEL'
) COMMENT='설문조사답변테이블';

/**********************************/
/* Table Name: 설문응답테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHRESPONDENT(
		RESPONDENT_ID                 		VARCHAR(20)		 NULL  COMMENT '응답ID',
		RESEARCH_ID                   		VARCHAR(20)		 NULL  COMMENT '설문조사ID',
		QUESTION_ID                   		VARCHAR(20)		 NULL  COMMENT '질문ID',
		ANSWER_ID                     		VARCHAR(20)		 NULL  COMMENT '답변 ID',
		MBR_IP                        		VARCHAR(50)		 NULL  COMMENT '참여자IP',
		MBR_ID                        		VARCHAR(255)		 NULL  COMMENT '참여자,MBR_ID',
		ANSWER                        		VARCHAR		 NULL  COMMENT '답변',
		ORDER_ANSWER                  		VARCHAR		 NULL  COMMENT '기타답변',
		CREATED                       		DATETIME		 NULL  COMMENT '응답일시',
		MODIFIDE                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INTEGER(1)		 NULL  COMMENT 'ISDEL'
) COMMENT='설문응답테이블';

/**********************************/
/* Table Name: 설문조사관리자테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHADMIN(
		ADMIN_ID                      		VARCHAR(255)		 NOT NULL COMMENT '관리자ID',
		MBR_ID                        		VARCHAR(255)		 NULL  COMMENT '회원ID',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		CREATE_WHO                    		VARCHAR(255)		 NULL  COMMENT '등록자',
		ISDEL                         		INTEGER(1)		 NULL  COMMENT 'ISDEL',
		SITE_PATH                     		VARCHAR(255)		 NULL  COMMENT '사이트경로',
		EXT01                         		VARCHAR(50)		 NULL  COMMENT 'EXT01',
		EXT02                         		VARCHAR(50)		 NULL  COMMENT 'EXT02'
) COMMENT='설문조사관리자테이블';


ALTER TABLE JNITRESEARCHCATEGORY ADD CONSTRAINT IDX_JNITRESEARCHCATEGORY_PK PRIMARY KEY (CATEGORY_ID);

ALTER TABLE JNITRESEARCH ADD CONSTRAINT IDX_JNITRESEARCH_PK PRIMARY KEY (RESEARCH_ID);

ALTER TABLE JNITRESEARCHQUESTION ADD CONSTRAINT IDX_JNITRESEARCHQUESTION_PK PRIMARY KEY (QUESTION_ID);
ALTER TABLE JNITRESEARCHQUESTION ADD CONSTRAINT IDX_JNITRESEARCHQUESTION_FK0 FOREIGN KEY (RESEARCH_ID) REFERENCES JNITRESEARCH (RESEARCH_ID);

ALTER TABLE JNITRESEARCHANSWER ADD CONSTRAINT IDX_JNITRESEARCHANSWER_PK PRIMARY KEY (ANSWER_ID);
ALTER TABLE JNITRESEARCHANSWER ADD CONSTRAINT IDX_JNITRESEARCHANSWER_FK0 FOREIGN KEY (QUESTION_ID) REFERENCES JNITRESEARCHQUESTION (QUESTION_ID);
ALTER TABLE JNITRESEARCHANSWER ADD CONSTRAINT IDX_JNITRESEARCHANSWER_FK1 FOREIGN KEY (RESEARCH_ID) REFERENCES JNITRESEARCH (RESEARCH_ID);

ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_PK PRIMARY KEY (RESPONDENT_ID);
ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_FK0 FOREIGN KEY (RESEARCH_ID) REFERENCES JNITRESEARCH (RESEARCH_ID);
ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_FK1 FOREIGN KEY (QUESTION_ID) REFERENCES JNITRESEARCHQUESTION (QUESTION_ID);
ALTER TABLE JNITRESEARCHRESPONDENT ADD CONSTRAINT IDX_JNITRESEARCHRESPONDENT_FK2 FOREIGN KEY (ANSWER_ID) REFERENCES JNITRESEARCHANSWER (ANSWER_ID);

ALTER TABLE JNITRESEARCHADMIN ADD CONSTRAINT IDX_JNITRESEARCHADMIN_PK PRIMARY KEY (ADMIN_ID);

