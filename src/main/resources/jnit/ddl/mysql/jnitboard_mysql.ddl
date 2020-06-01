/**********************************/
/* Table Name: 게시판 설정 테이블  */
/**********************************/
CREATE TABLE JNITBOARDINFO(
		BOARD_ID                      		VARCHAR(20)		 NOT NULL COMMENT '게시판코드',
		BOARD_GROUP                   		VARCHAR(100)		 NULL  COMMENT '게시판그룹',
		BOARD_TITLE                   		VARCHAR(200)		 NULL  COMMENT '게시판명',
		LATEST_CONFIG                 		VARCHAR(20)		 NULL  COMMENT '최근게시물 설정',
		LATEST_VALUE                  		VARCHAR(100)		 NULL  COMMENT '최근게시물 설정 값',
		BOARD_TYPE                    		VARCHAR(255)		 NULL  COMMENT '게시판종류',
		BOARD_SKIN                    		VARCHAR(100)		 DEFAULT 'default'		 NULL  COMMENT '스킨명',
		ROW_CNT                       		INT(10)		 NULL  COMMENT '페이지당목록수',
		USE_REPLY                       		INT(1)		 DEFAULT 1		 NULL  COMMENT '답글사용여부',
		BOARD_SORT                    		VARCHAR(100)		 NULL  COMMENT '게시물정렬기준',
		BOARD_LBL                     		VARCHAR(200)		 DEFAULT '글번호|제목|작성자|작성일|조회수'		 NULL  COMMENT '기본필드 라벨',
		FIELD_SORT_LIST               		VARCHAR(255)		 DEFAULT 'no,title,writer,created,hit'		 NULL  COMMENT '목록필드노출순서',
		FIELD_SORT_VIEW               		VARCHAR(255)		 NULL  COMMENT '조회필드노출순서',
		FIELD_SORT_WRITE              		VARCHAR(255)		 DEFAULT 'no,title,writer,created,hit,content'		 NULL  COMMENT '등록필드노출순서',
		USE_INTERNAL                       	INT(1)		 DEFAULT 0		 NULL COMMENT '내외부망 옵션',
		USE_CMT                       		INT(1)		 DEFAULT 0		 NULL  COMMENT '댓글사용여부',
		USE_LIST_REPLY                		INT(1)		 DEFAULT 1		 NULL  COMMENT '리스트답글노출',
		USE_VIEW_REPLY                		INT(1)		 DEFAULT 0		 NULL  COMMENT '조회답글노출',
		USE_ACTIVE                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '개시물승인사용여부',
		USE_SECRET                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '비밀글사용여부',
		USE_NOTICE                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '공지글사용여부',
		USE_FILTER                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '필터링사용유무',
		FIELTER_ACTION                		VARCHAR(200)		 NULL  COMMENT '필터링ActionUrl',
		USE_WYSWYG                    		INT(1)		 DEFAULT 1		 NULL  COMMENT '위지윅사용여부',
		USE_WYSWYG_TYPE               		VARCHAR(30)		 NULL  COMMENT '위지윅에디터 종류',
		USE_FILE                      		INT(1)		 DEFAULT 1		 NULL  COMMENT '파일첨부사용여부',
		USE_IMAGE                     		INT(1)		 DEFAULT 1		 NULL  COMMENT '이미지첨부사용여부',
		USE_MOVIE                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '동영상사용여부',
		USE_SMS                       		INT(1)		 DEFAULT 0		 NULL  COMMENT 'SMS발송여부',
		SMS_NUM                       		VARCHAR(100)		 NULL  COMMENT 'SMS번호',
		USE_CATEGORY                  		INT(1)		 DEFAULT 0		 NULL  COMMENT '카테고리사용여부',
		CATEGORY                      		VARCHAR(255)		 NULL  COMMENT '카테고리',
		USE_SOCIAL                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '소셜댓글 사용여부',
		USE_LANGUAGE                  		VARCHAR(25)		 NULL  COMMENT '국가별 언어 선택',
		USE_EXT01                     		INT(1)		 NULL  COMMENT '여유필드01 사용유무',
		EXT01_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드01 옵션',
		EXT01_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드01 라벨',
		USE_EXT02                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드02 사용유무',
		EXT02_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드02 옵션',
		EXT02_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드02 라벨',
		USE_EXT03                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드03 사용유무',
		EXT03_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드03 옵션',
		EXT03_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드03 라벨',
		USE_EXT04                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드04 사용유무',
		EXT04_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드04 옵션',
		EXT04_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드04 라벨',
		USE_EXT05                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드05 사용유무',
		EXT05_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드05 옵션',
		EXT05_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드05 라벨',
		USE_EXT06                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드06 사용유무',
		EXT06_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드06 옵션',
		EXT06_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드06 라벨',
		USE_EXT07                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드07 사용유무',
		EXT07_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드07 옵션',
		EXT07_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드07 라벨',
		USE_EXT08                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드08 사용유무',
		EXT08_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드08 옵션',
		EXT08_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드08 라벨',
		USE_EXT09                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드09 사용유무',
		EXT09_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드09 옵션',
		EXT09_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드09 라벨',
		USE_EXT10                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드10 사용유무',
		EXT10_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드10 옵션',
		EXT10_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드10 라벨',
		USE_EXT11                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드11 사용유무',
		EXT11_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드11 옵션',
		EXT11_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드11 라벨',
		USE_EXT12                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드12 사용유무',
		EXT12_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드12 옵션',
		EXT12_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드12 라벨',
		USE_EXT13                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드13 사용유무',
		EXT13_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드13 옵션',
		EXT13_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드13 라벨',
		USE_EXT14                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드14 사용유무',
		EXT14_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드14 옵션',
		EXT14_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드14 라벨',
		USE_EXT15                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드15 사용유무',
		EXT15_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드15 옵션',
		EXT15_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드15 라벨',
		USE_EXT16                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드16 사용유무',
		EXT16_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드16 옵션',
		EXT16_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드16 라벨',
		USE_EXT17                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드17 사용유무',
		EXT17_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드17 옵션',
		EXT17_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드17 라벨',
		USE_EXT18                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드18 사용유무',
		EXT18_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드18 옵션',
		EXT18_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드18 라벨',
		USE_EXT19                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드19 사용유무',
		EXT19_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드19 옵션',
		EXT19_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드19 라벨',
		USE_EXT20                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유필드20 사용유무',
		EXT20_OPT                     		VARCHAR(200)		 NULL  COMMENT '여유필드20 옵션',
		EXT20_LBL                     		VARCHAR(200)		 NULL  COMMENT '여유필드20 라벨',
		USE_DATE01                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유날짜01 사용여부',
		DATE01_OPT                    		VARCHAR(200)		 NULL  COMMENT '여유날짜01 옵션',
		DATE01_LBL                    		VARCHAR(200)		 NULL  COMMENT '여유날짜01 라벨',
		USE_DATE02                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '여유날짜02 사용여부',
		DATE02_OPT                    		VARCHAR(200)		 NULL  COMMENT '여유날짜02 옵션',
		DATE02_LBL                    		VARCHAR(200)		 NULL  COMMENT '여유날짜02 라벨',
		USE_REACT                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '반응형 사용 여부',
		ADM_EXT                       		TEXT		 NULL  COMMENT '개별관리자',
		ADM_LIST                      		VARCHAR(50)		 DEFAULT 'A,B,C'		 NULL  COMMENT '관리자레벨',
		PERM_LIST                     		VARCHAR(50)		 DEFAULT 'Z'		 NULL  COMMENT '목록접근권한',
		PERM_VIEW                     		VARCHAR(50)		 DEFAULT 'Z'		 NULL  COMMENT '보기접근권한',
		PERM_WRITE                    		VARCHAR(50)		 DEFAULT 'Z'		 NULL  COMMENT '쓰기접근권한',
		PERM_CMT                      		VARCHAR(50)		 DEFAULT 'Z'		 NULL  COMMENT '댓글쓰기접근권한',
		ANON_PERM_LIST                		INT(1)		 DEFAULT 1		 NULL  COMMENT '비회원목록권한',
		ANON_PERM_VIEW                		INT(1)		 DEFAULT 1		 NULL  COMMENT '비회원보기권한',
		ANON_PERM_WRITE               		INT(1)		 DEFAULT 0		 NULL  COMMENT '비회원용게시판여부',
		HIDE_WRITE                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '글쓰기버튼숨김',
		ACTIVE                        		INT(1)		 DEFAULT 1		 NULL  COMMENT '사용여부',
		PERM_REPLY                    		VARCHAR(50)		 NULL  COMMENT '답글쓰기접근권한',
		PERM_VIEW_TYPE                		VARCHAR(255)		 NULL  COMMENT '보기접근유형',
		PERM_WRITE_TYPE               		VARCHAR(255)		 NULL  COMMENT '쓰기접근유형',
		PERM_REPLY_TYPE               		VARCHAR(255)		 NULL  COMMENT '답글쓰기접근유형',
		FILTER_ACTION                 		VARCHAR(200)		 NULL  COMMENT '필터',
		PERM_LIST_TYPE                		VARCHAR(255)		 NULL  COMMENT '목록접근유형',
		PERM_CMT_TYPE                 		VARCHAR(255)		 NULL  COMMENT '댓글쓰기접근유형',
		PERM_FILE_DOWN                		VARCHAR(50)		 NULL  COMMENT '파일다운로드권한',
		PERM_FILE_DOWN_TYPE           		VARCHAR(255)		 NULL  COMMENT '파일다운로드접근권한',
		BOARD_URL                     		VARCHAR(255)		 NULL  COMMENT '게시판 URL',
		USE_LATESTLIST                		INT(1)		 DEFAULT 0		 NULL  COMMENT '최근게시물 표시노출여부',
		THUMB_WIDTH                   		INT(10)		 DEFAULT 0		 NULL  COMMENT '썸네일가로',
		THUMB_HEIGHT                  		INT(10)		 DEFAULT 0		 NULL  COMMENT '썸네일세로',
		THUMB_MAXDIM                  		INT(10)		 DEFAULT 0		 NULL  COMMENT '썸네일비율',
		FILE_BLACKLIST						VARCHAR(255)	NULL	COMMENT '파일 확장자 제한 목록',
		FILE_LIMIT_SIZE						INT(10)		DEFAULT 500	NULL	COMMENT '파일 용량 제한(MB)',
		FILE_LIMIT_COUNT					INT(10)		DEFAULT 5	NULL	COMMENT '파일 최대 업로드 개수',
		TMP1                          		VARCHAR(4000)		 NULL  COMMENT '여분필드01',
		TMP2                          		VARCHAR(255)		 NULL  COMMENT '여분필드02',
		TMP3                          		VARCHAR(255)		 NULL  COMMENT '여분필드03',
		TMP4                          		VARCHAR(255)		 NULL  COMMENT '여분필드04',
		TMP5                          		VARCHAR(255)		 NULL  COMMENT '여분필드05',
		ISDEL                         		INT(1)		 NULL  COMMENT 'ISDEL'
) COMMENT='게시판 설정 테이블 ';

/**********************************/
/* Table Name: 게시판코멘트테이블 */
/**********************************/
CREATE TABLE JNITBOARDCMT(
		CMT_ID                        		VARCHAR(20)		 NOT NULL COMMENT '코멘트고유번호',
		BOARD_ID                      		VARCHAR(20)		 NOT NULL COMMENT '게시판고유번호',
		BOARD_CNT_ID                  		INT(20)		 NOT NULL COMMENT '게시물고유번호',
		CMT_TEXT                      		TEXT		 NOT NULL COMMENT '코멘트내용',
		MBR_ID                        		VARCHAR(20)		 NOT NULL COMMENT '작성자고유번호',
		CREATED                       		DATETIME		 NULL  COMMENT '작성일시',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일시',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='게시판코멘트테이블';

/**********************************/
/* Table Name: 게시판첨부파일 */
/**********************************/
CREATE TABLE JNITBOARDFILE(
		FILE_ID                       		VARCHAR(20)		 NOT NULL COMMENT '첨부파일고유번호',
		BOARD_ID                      		VARCHAR(20)		 NULL  COMMENT '게시판고유번호',
		BOARD_CNT_ID                  		INT(20)		 NULL  COMMENT '게시물번호',
		FILE_URL                      		VARCHAR(255)		 NULL  COMMENT '첨부파일URL',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '첨부파일경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '첨부파일명',
		FILE_ONM                      		VARCHAR(255)		 NULL  COMMENT '첨부파일원본명',
		ISMAIN                        		INT(10)		 DEFAULT 0		 NULL  COMMENT '대표파일',
		FILE_DOWNLOAD_COUNT           		INT(38)		 DEFAULT 0		 NULL  COMMENT '다운로드 수',
		EXT01                         		VARCHAR(200)		 NULL  COMMENT '여유필드01',
		EXT02                         		VARCHAR(200)		 NULL  COMMENT '여유필드02',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='게시판첨부파일';

/**********************************/
/* Table Name: 일반게시판템플릿 */
/**********************************/
CREATE TABLE JNITBOARDTPL(
		ID                            		INT(20)		 NOT NULL COMMENT '고유번호',
		GRP                           		INT(20)		 NULL  COMMENT '답변 그룹ID',
		IDX                           		VARCHAR(255)		 NULL  COMMENT '답변ID',
		IS_SECRET                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '비밀글',
		IS_NOTICE                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '공지글',
		IS_HTML                       		INT(1)		 NULL  COMMENT 'HTML여부',
		CATEGORY                      		VARCHAR(100)		 NULL  COMMENT '카테고리',
		TITLE                         		VARCHAR(255)		 NOT NULL COMMENT '제목',
		CONTENT                       		LONGTEXT		 NULL  COMMENT '내용',
		PASSWORD                      		VARCHAR(255)		 NULL  COMMENT '비밀번호',
		EXT01                         		VARCHAR(255)		 NULL  COMMENT '여유필드01',
		EXT02                         		VARCHAR(255)		 NULL  COMMENT '여유필드02',
		EXT03                         		VARCHAR(255)		 NULL  COMMENT '여유필드03',
		EXT04                         		VARCHAR(255)		 NULL  COMMENT '여유필드04',
		EXT05                         		VARCHAR(255)		 NULL  COMMENT '여유필드05',
		EXT06                         		VARCHAR(255)		 NULL  COMMENT '여유필드06',
		EXT07                         		VARCHAR(255)		 NULL  COMMENT '여유필드07',
		EXT08                         		VARCHAR(255)		 NULL  COMMENT '여유필드08',
		EXT09                         		VARCHAR(255)		 NULL  COMMENT '여유필드09',
		EXT10                         		VARCHAR(255)		 NULL  COMMENT '여유필드10',
		EXT11                         		VARCHAR(255)		 NULL  COMMENT '여유필드11',
		EXT12                         		VARCHAR(255)		 NULL  COMMENT '여유필드12',
		EXT13                         		VARCHAR(255)		 NULL  COMMENT '여유필드13',
		EXT14                         		VARCHAR(255)		 NULL  COMMENT '여유필드14',
		EXT15                         		VARCHAR(255)		 NULL  COMMENT '여유필드15',
		EXT16                         		VARCHAR(255)		 NULL  COMMENT '여유필드16',
		EXT17                         		VARCHAR(255)		 NULL  COMMENT '여유필드17',
		EXT18                         		VARCHAR(255)		 NULL  COMMENT '여유필드18',
		EXT19                         		VARCHAR(255)		 NULL  COMMENT '여유필드19',
		EXT20                         		VARCHAR(255)		 NULL  COMMENT '여유필드20',
		DATE01                        		DATETIME		 NULL  COMMENT '날짜필드01',
		DATE02                        		DATETIME		 NULL  COMMENT '날짜필드02',
		HIT                           		INT(20)		 DEFAULT 0		 NULL  COMMENT '조회수',
		WRITER                        		VARCHAR(200)		 NULL  COMMENT '작성자',
		MBR_ID                        		VARCHAR(200)		 NULL  COMMENT '작성자ID',
		MBR_IP                        		VARCHAR(64)		 NULL  COMMENT '작성자IP',
		CREATED                       		DATETIME		 NULL  COMMENT '작성일시',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일시',
		ACTIVE                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '게시물활성화',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		TMP1                          		VARCHAR(255)		 NULL  COMMENT 'TMP1',
		TMP2                          		VARCHAR(255)		 NULL  COMMENT 'TMP2',
		TMP3                          		VARCHAR(255)		 NULL  COMMENT 'TMP3',
		TMP4                          		VARCHAR(255)		 NULL  COMMENT 'TMP4',
		TMP5                          		VARCHAR(255)		 NULL  COMMENT 'TMP5'
) COMMENT='일반게시판템플릿';

/**********************************/
/* Table Name: 게시판추천 */
/**********************************/
CREATE TABLE JNITBOARDGOOD(
		IDX                           		VARCHAR(20)		 NOT NULL COMMENT '번호',
		BOARD_ID                      		VARCHAR(20)		 NOT NULL COMMENT '게시판고유ID',
		BOARD_CNT_ID                  		INT(20)		 NOT NULL COMMENT '게시물번호',
		MBR_ID                        		VARCHAR(30)		 NULL  COMMENT '회원ID',
		IPADDR                        		VARCHAR(30)		 NULL  COMMENT '아이피',
		CREATED                       		DATETIME		 NULL  COMMENT 'CREATED',
		MODIFIED                      		DATETIME		 NULL  COMMENT 'MODIFIED',
		EXT01                         		VARCHAR(200)		 NULL  COMMENT '여유필드01',
		EXT02                         		VARCHAR(200)		 NULL  COMMENT '여유필드02',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='게시판추천';

/**********************************/
/* Table Name: 동영상게시판 */
/**********************************/
CREATE TABLE JNITBOARDMEDIA(
		JNITMEDIA_ID                  		INT(38)		 NOT NULL COMMENT '동영상 ID',
		ORG_NM                        		VARCHAR(255)		 NULL  COMMENT '파일이름',
		DST_NM                        		VARCHAR(255)		 NULL  COMMENT '실제 파일이름',
		SUCCESS_FLAG                  		INT(1)		 NULL  COMMENT '성공여부',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 NULL  COMMENT '삭제여부'
) COMMENT='동영상게시판';


ALTER TABLE JNITBOARDINFO ADD CONSTRAINT IDX_JNITBOARDINFO_PK PRIMARY KEY (BOARD_ID);

ALTER TABLE JNITBOARDCMT ADD CONSTRAINT IDX_JNITBOARDCMT_PK PRIMARY KEY (CMT_ID);

ALTER TABLE JNITBOARDFILE ADD CONSTRAINT IDX_JNITBOARDFILE_PK PRIMARY KEY (FILE_ID);

ALTER TABLE JNITBOARDTPL ADD CONSTRAINT IDX_JNITBOARDTPL_PK PRIMARY KEY (ID);

ALTER TABLE JNITBOARDGOOD ADD CONSTRAINT IDX_JNITBOARDGOOD_PK PRIMARY KEY (IDX);

ALTER TABLE JNITBOARDMEDIA ADD CONSTRAINT IDX_JNITBOARDMEDIA_PK PRIMARY KEY (JNITMEDIA_ID);

