/**
 * @version 3.2.0.1
 */
DROP TABLE  IF EXISTS `bbs_1000000000000000`;
DROP TABLE  IF EXISTS `jnit_ltskorea_sms`;
DROP TABLE  IF EXISTS `jnitallim_imgfile`;
DROP TABLE  IF EXISTS `jnitallim_item`;
DROP TABLE  IF EXISTS `jnitallim_group`;

DROP TABLE  IF EXISTS `jnitboardcmt`;
DROP TABLE  IF EXISTS `jnitboardfile`;
DROP TABLE  IF EXISTS `jnitboardgood`;
DROP TABLE  IF EXISTS `jnitboardinfo`;
DROP TABLE  IF EXISTS `jnitboardtpl`;
DROP TABLE  IF EXISTS `jnitboardmedia`;
DROP TABLE  IF EXISTS `jnitboarddata`;

DROP TABLE  IF EXISTS `jnitcmsboardhist`;
DROP TABLE  IF EXISTS `jnitcmsdisseminate`;
DROP TABLE  IF EXISTS `jnitcmsdisseminatehistory`;
DROP TABLE  IF EXISTS `jnitcmscsshist`;
DROP TABLE  IF EXISTS `jnitcmsscripthist`;
DROP TABLE  IF EXISTS `jnitcmstplhist`;
DROP TABLE  IF EXISTS `jnitcmshist`;
DROP TABLE  IF EXISTS `jnitcmstpl`;
DROP TABLE  IF EXISTS `jnitcmscnt`;
DROP TABLE  IF EXISTS `jnitcmsmenumgr`;
DROP TABLE  IF EXISTS `jnitcmsmenu`;
DROP TABLE  IF EXISTS `jnitcmssite`;
DROP TABLE  IF EXISTS `jnitcmsmbrpackage`;
DROP TABLE  IF EXISTS `jnitcmsmbr`;
DROP TABLE  IF EXISTS `jnitcmsmbrtype`;
DROP TABLE  IF EXISTS `jnitcmspos`;
DROP TABLE  IF EXISTS `jnitcmsorg`;
DROP TABLE  IF EXISTS `jnitcmsmbrlog`;
DROP TABLE  IF EXISTS `jnitcmsmbrsess`;
DROP TABLE  IF EXISTS `jnitcmsmgmt`;
DROP TABLE  IF EXISTS `jnitcmsmgmtitem`;
DROP TABLE  IF EXISTS `jnitcmsmgmtcategory`;
DROP TABLE  IF EXISTS `jnitcmsrank`;

DROP TABLE  IF EXISTS `jnitebookfile`;
DROP TABLE  IF EXISTS `jnitebook`;

DROP TABLE  IF EXISTS `jnitloginlog`;
DROP TABLE  IF EXISTS `jnitmenu`;
DROP TABLE  IF EXISTS `jnitmgovaddrlist`;
DROP TABLE  IF EXISTS `jnitmgovaddrgrp`;


DROP TABLE  IF EXISTS `jnitresearchadmin`;
DROP TABLE  IF EXISTS `jnitresearchrespondent`;
DROP TABLE  IF EXISTS `jnitresearchrespondent`;
DROP TABLE  IF EXISTS `jnitresearchanswer`;
DROP TABLE  IF EXISTS `jnitresearchquestion`;
DROP TABLE  IF EXISTS `jnitresearch`;
DROP TABLE  IF EXISTS `jnitresearchcategory`;

DROP TABLE  IF EXISTS `jnitrscpagedata`;
DROP TABLE  IF EXISTS `jnitrscpage`;
DROP TABLE  IF EXISTS `jnitrscdata`;
DROP TABLE  IF EXISTS `jnitrsc`;

DROP TABLE  IF EXISTS `jnitscrap`;
DROP TABLE  IF EXISTS `jnitseq`;
DROP TABLE  IF EXISTS `jnitsitestate`;
DROP TABLE  IF EXISTS `jnitsitestatelist`;
DROP TABLE  IF EXISTS `jnitsmsaddressbook`;
DROP TABLE  IF EXISTS `jnitvisitcount`;
DROP TABLE  IF EXISTS `jnitvisitlog`;
DROP TABLE  IF EXISTS `mgov_serial`;

DROP VIEW IF EXISTS `jnitcmscntvt`;
DROP VIEW IF EXISTS `jnitcmsmenu_vt`;
DROP VIEW IF EXISTS `jnitmenu_vt`;

DROP TABLE IF EXISTS `jnitcmsmenutree`;

/**********************************/
/* Table Name: SEQ키관리테이블 */
/**********************************/
CREATE TABLE JNITSEQ(
		TABLE_NAME                    		VARCHAR(50)		 NOT NULL COMMENT '테이블명',
		NEXT_ID                       		INT(38)		 DEFAULT 0		 NULL  COMMENT 'SEQ키'
) COMMENT='SEQ키관리테이블';


ALTER TABLE JNITSEQ ADD CONSTRAINT IDX_JNITSEQ_PK PRIMARY KEY (TABLE_NAME);

/**********************************/
/* Table Name: 알리미 그룹 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_GROUP(
		GROUP_ID                      		VARCHAR(20)		 NULL  COMMENT '아이디',
		GROUP_NM                      		VARCHAR(255)		 NULL  COMMENT '이름',
		GROUP_WIDTH                   		VARCHAR(255)		 NULL  COMMENT '너비',
		GROUP_HEIGHT                  		VARCHAR(255)		 NULL  COMMENT '높이',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제',
		GROUP_EXT01                   		VARCHAR(255)		 NULL  COMMENT '여분필드01',
		GROUP_EXT02                   		VARCHAR(255)		 NULL  COMMENT '여분필드02',
		GROUP_EXT03                   		INT(10)		 DEFAULT 0		 NULL  COMMENT '여분필드03',
		GROUP_EXT04                   		INT(10)		 DEFAULT 0		 NULL  COMMENT '여분필드04',
		GROUP_TYPE                    		VARCHAR(20)		 NULL  COMMENT '타입',
		GROUP_CLASSNAME               		VARCHAR(255)		 NULL  COMMENT '클래스이름',
		GROUP_DIRECTION               		INT(1)		 DEFAULT 0		 NULL  COMMENT '배너 방향',
		GROUP_CHANGETIME              		INT(4)		 DEFAULT 5		 NULL  COMMENT '알리미 변경시간',
		GROUP_SHOWITEMS               		INT(4)		 DEFAULT 1		 NULL  COMMENT '노출될 아이템수',
		GROUP_TIMERDELAY              		INT(10)		 DEFAULT 0		 NULL  COMMENT '배너 반복 딜레이',
		GROUP_ANIMATIONDELAY          		INT(10)		 DEFAULT 0		 NULL  COMMENT '배너 애니메이션 딜레이',
		GROUP_AUTO                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '자동 롤링 여부',
		GROUP_CATEGORY                		VARCHAR(50)		 NULL  COMMENT '스킨명'
) COMMENT='알리미 그룹 테이블';

/**********************************/
/* Table Name: 알리미 데이터 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_ITEM(
		ITEM_ID                       		VARCHAR(20)		 NULL  COMMENT '아이탬 아이디',
		GROUP_ID                      		VARCHAR(20)		 NULL  COMMENT '아이디',
		ITEM_NM                       		VARCHAR(255)		 NULL  COMMENT '이름',
		ITEM_TYPE                     		VARCHAR(100)		 NULL  COMMENT '타입',
		ITEM_LINK                     		VARCHAR(255)		 NULL  COMMENT '링크',
		ITEM_TARGET                   		VARCHAR(50)		 NULL  COMMENT '타겟',
		ITEM_DESCRIPT                 		VARCHAR(255)		 NULL  COMMENT '적용사이트 명',
		ITEM_MEMO                     		TEXT		 NULL  COMMENT '메모',
		ITEM_ACTIVE                   		INT(1)		 DEFAULT 0		 NULL  COMMENT '활성화 여부',
		ITEM_STARTDATE                		DATETIME		 NULL  COMMENT '시작일',
		ITEM_ENDDATE                  		DATETIME		 NULL  COMMENT '종료일',
		ITEM_HTMLCODE                 		TEXT		 NULL  COMMENT '태그코드',
		ITEM_MODE                     		VARCHAR(100)		 NULL  COMMENT '모드',
		ITEM_WIDTH                    		VARCHAR(255)		 NULL  COMMENT '팝업 너비',
		ITEM_HEIGHT                   		VARCHAR(255)		 NULL  COMMENT '팝업 길이',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '임시삭제',
		ITEM_EXT01                    		VARCHAR(255)		 NULL  COMMENT '여분필드',
		ITEM_EXT02                    		VARCHAR(255)		 NULL  COMMENT '여분필드02',
		ITEM_EXT03                    		INT(10)		 DEFAULT 0		 NULL  COMMENT '여분필드03',
		ITEM_EXT04                    		INT(10)		 DEFAULT 0		 NULL  COMMENT '여분필드04',
		ITEM_URL                      		VARCHAR(255)		 NULL  COMMENT 'URL',
		ITEM_SORT                     		INT(4)		 DEFAULT 0		 NULL  COMMENT '정렬순서',
		ITEM_ORIGIN                   		VARCHAR(255)		 NULL  COMMENT '원본명',
		ITEM_ALT                      		TEXT		 NULL  COMMENT '이미지ALT',
		ITEM_TOP                      		VARCHAR(255)		 NULL  COMMENT '팝업 TOP 위치',
		ITEM_RIGHT                    		VARCHAR(255)		 NULL  COMMENT '팝업 RIGHT(LEFT) 위치',
		ITEM_EXT05                    		VARCHAR(255)		 NULL  COMMENT '여분필드05',
		ITEM_EXT06                    		VARCHAR(255)		 NULL  COMMENT '여분필드06',
		ITEM_EXT07                    		VARCHAR(255)		 NULL  COMMENT '여분필드07',
		ITEM_EXT08                    		VARCHAR(255)		 NULL  COMMENT '여분필드08',
		ITEM_EXT09                    		VARCHAR(255)		 NULL  COMMENT '여분필드09',
		ITEM_EXT10                    		VARCHAR(255)		 NULL  COMMENT '여분필드10',
		ITEM_EXT11                    		VARCHAR(255)		 NULL  COMMENT '여분필드11',
		ITEM_EXT12                    		VARCHAR(255)		 NULL  COMMENT '여분필드12',
		ITEM_URL_PATH                 		VARCHAR(255)		 NULL  COMMENT '상대경로'
) COMMENT='알리미 데이터 테이블';

/**********************************/
/* Table Name: 알리미 데이터 이미지 파일 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_IMGFILE(
		IMG_ID                        		VARCHAR(20)		 NULL  COMMENT '아이디',
		ITEM_ID                       		VARCHAR(20)		 NULL  COMMENT '아이탬 아이디',
		IMG_URL                       		TEXT		 NULL  COMMENT 'URL',
		IMG_ORIGINNM                  		VARCHAR(255)		 NULL  COMMENT '원본 이름',
		IMG_SORTNUM                   		INT(10)		 DEFAULT 0		 NULL  COMMENT '정렬 번호',
		IMG_PATH                      		VARCHAR(255)		 NULL  COMMENT '경로',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제',
		IMG_EXT01                     		VARCHAR(255)		 NULL  COMMENT '여분필드01',
		IMG_EXT02                     		VARCHAR(255)		 NULL  COMMENT '여분필드02',
		IMG_EXT03                     		INT(10)		 DEFAULT 0		 NULL  COMMENT '여분필드03',
		IMG_EXT04                     		INT(10)		 DEFAULT 0		 NULL  COMMENT '여분필드04'
) COMMENT='알리미 데이터 이미지 파일 테이블';


ALTER TABLE JNITALLIM_GROUP ADD CONSTRAINT IDX_JNITALLIM_GROUP_PK PRIMARY KEY (GROUP_ID);

ALTER TABLE JNITALLIM_ITEM ADD CONSTRAINT IDX_JNITALLIM_ITEM_PK PRIMARY KEY (ITEM_ID);
ALTER TABLE JNITALLIM_ITEM ADD CONSTRAINT IDX_JNITALLIM_ITEM_FK0 FOREIGN KEY (GROUP_ID) REFERENCES JNITALLIM_GROUP (GROUP_ID);

ALTER TABLE JNITALLIM_IMGFILE ADD CONSTRAINT IDX_JNITALLIM_IMGFILE_PK PRIMARY KEY (IMG_ID);
ALTER TABLE JNITALLIM_IMGFILE ADD CONSTRAINT IDX_JNITALLIM_IMGFILE_FK0 FOREIGN KEY (ITEM_ID) REFERENCES JNITALLIM_ITEM (ITEM_ID);


/**********************************/
/* Table Name: 게시판 설정 테이블  */
/**********************************/
CREATE TABLE JNITBOARDINFO(
		BOARD_ID                      		VARCHAR(20)		 NOT NULL COMMENT '게시판코드',
		BOARD_GROUP                   		VARCHAR(100)		 NULL  COMMENT '게시판그룹',
		BOARD_TITLE                   		VARCHAR(200)		 NULL  COMMENT '게시판명',
		LATEST_CONFIG                 		VARCHAR(20)		 NULL  COMMENT '최근게시물 설정',
		LATEST_VALUE                  		VARCHAR(100)		 NULL  COMMENT '최근게시물 설정 값',
		BOARD_TYPE                    		VARCHAR(30)		 NULL  COMMENT '게시판종류',
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
		FILE_SIZE							BIGINT		 DEFAULT 0		 NULL  COMMENT '파일 크기',
		EXT01                         		VARCHAR(200)		 NULL  COMMENT '여유필드01',
		EXT02                         		VARCHAR(200)		 NULL  COMMENT '여유필드02',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='게시판첨부파일';
CREATE INDEX JNITBOARDFILE_IDX1 ON JNITBOARDFILE(BOARD_ID);

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
/* Table Name: bbs_1000000000000000 */
/**********************************/
CREATE TABLE bbs_1000000000000000(
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
) COMMENT='bbs_1000000000000000';

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


/**********************************/
/* Table Name: 직급테이블 */
/**********************************/
CREATE TABLE JNITCMSPOS(
		POS_ID                        		VARCHAR(10)		 NOT NULL COMMENT '직급코드',
		POS_NM                        		VARCHAR(50)		 NOT NULL COMMENT '직급명',
		POS_LV                        		INT(10)		 DEFAULT 0		 NULL  COMMENT '등급',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		CONNECT_TYPE                  		VARCHAR(10)		 NULL  COMMENT 'DB 연결 타입'
) COMMENT='직급테이블';

/**********************************/
/* Table Name: 부서테이블 */
/**********************************/
CREATE TABLE JNITCMSORG(
		ORG_ID                        		VARCHAR(10)		 NOT NULL COMMENT '부서코드',
		ORG_NM                        		VARCHAR(50)		 NOT NULL COMMENT '부서명',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		ORG_DETH                      		VARCHAR(30)		 NULL  COMMENT '상위부서',
		ORG_RANK                      		VARCHAR(10)		 NULL  COMMENT '부서순위',
		ORG_RANK_ODR                  		INT(10)		 DEFAULT 0		 NULL  COMMENT '순서',
		CONNECT_TYPE                  		VARCHAR(10)		 NULL  COMMENT 'DB 연결 타입',
		ORG_TEL                       		VARCHAR(50)		 NULL  COMMENT '부서전화번호'
) COMMENT='부서테이블';

/**********************************/
/* Table Name: 사이트테이블 */
/**********************************/
CREATE TABLE JNITCMSSITE(
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트코드',
		SITE_NM                       		VARCHAR(255)		 NOT NULL COMMENT '사이트명',
		SITE_PATH                     		VARCHAR(50)		 NOT NULL COMMENT '시작경로',
		SITE_ORD                      		INT(10)		 DEFAULT 0		 NULL  COMMENT '정렬순서',
		ADM_MBR_ID                    		VARCHAR(20)		 NULL  COMMENT '담당관리자코드',
		ACTIVE                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '공개여부',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 NULL  COMMENT '삭제여부',
		LANG                          		VARCHAR(20)		 NULL  COMMENT '국가별 언어',
		ORIGIN_SITE                   		VARCHAR(20)		 NULL  COMMENT '원문 사이트',
		LANGUAGE_USE_YN               		VARCHAR(3)		 NULL  COMMENT '외국어 사이트 사용 여부',
		LANGUAGE1                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트1',
		LANGUAGE2                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트2',
		LANGUAGE3                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트3',
		LANGUAGE4                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트4',
		LANGUAGE5                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트5'
) COMMENT='사이트테이블';

/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITCMSMENU(
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트코드',
		MENU_ID                       		VARCHAR(10)		 NOT NULL COMMENT '메뉴코드',
		MENU_NM                       		VARCHAR(255)		 NOT NULL COMMENT '메뉴명',
		MENU_PATH                     		VARCHAR(100)		 NULL  COMMENT '메뉴경로명',
		PID                           		VARCHAR(10)		 NULL  COMMENT '상위메뉴',
		DEPTH                         		INT(10)		 DEFAULT 0		 NULL  COMMENT '메뉴깊이',
		METHOD                        		INT(10)		 DEFAULT 0		 NULL  COMMENT '정렬순서',
		ISLINK                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '링크여부',
		ISCNT                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '콘텐츠메뉴여부',
		LINKURL                       		VARCHAR(255)		 NULL  COMMENT '링크URL',
		LINKTGT                       		VARCHAR(50)		 NULL  COMMENT '링크타겟',
		TPL_ID                        		VARCHAR(20)		 NULL  COMMENT '콘텐츠템플릿코드',
		CNT_ID                        		VARCHAR(20)		 NULL  COMMENT '기본콘텐츠코드',
		DEF_MENU                      		VARCHAR(100)		 NULL  COMMENT '디폴트메뉴',
		MENU_IMG_FILE                 		VARCHAR(255)		 NULL  COMMENT '이미지파일',
		MENU_IMG_PATH                 		VARCHAR(255)		 NULL  COMMENT '이미지경로',
		MENU_IMG_ONM                  		VARCHAR(255)		 NULL  COMMENT '이미지이름',
		MENU_IMG_URL                  		VARCHAR(255)		 NULL  COMMENT '이미지URL',
		ADM_MBR_ID                    		VARCHAR(255)		 NULL  COMMENT '관리자회원코드',
		ACTIVE                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '공개여부',
		CCL                           		VARCHAR(20)		 DEFAULT '0'		 NULL  COMMENT 'CCL사용 여부',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		CONTENT_SEARCH_CHK            		INT(10)		 DEFAULT 0		 NULL  COMMENT '통합검색제한',
		ROBOT_YN                      		INT(10)		 DEFAULT 0		 NULL  COMMENT '로봇검색여부',
		H_DEL                         		VARCHAR(2)		 NULL  COMMENT '상단메뉴노출여부',
		S_DEL                         		VARCHAR(2)		 NULL  COMMENT '사이트맵노출여부',
		L_DEL                         		VARCHAR(2)		 NULL  COMMENT '레프트메뉴노출여부',
		REDIRECT_URL                  		VARCHAR(255)		 NULL  COMMENT '이동URL',
		META_TITLE                    		VARCHAR(255)		 NULL  COMMENT 'META_타이틀',
		META_SUBJECT                  		VARCHAR(255)		 NULL  COMMENT 'META_주제',
		META_KEYWORD                  		VARCHAR(255)		 NULL  COMMENT 'META키워드',
		META_DESCRIPTION              		VARCHAR(255)		 NULL  COMMENT 'META_설명',
		META_CLASSIFICATION           		VARCHAR(30)		 NULL  COMMENT 'META_분류',
		META_REPLY                    		VARCHAR(30)		 NULL  COMMENT 'META_이메일',
		META_LANGUAGE                 		VARCHAR(30)		 NULL  COMMENT 'META_언어',
		META_BUILD                    		VARCHAR(30)		 NULL  COMMENT 'META_생성일',
		LANGUAGE1                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트1',
		LANGUAGE2                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트2',
		LANGUAGE3                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트3',
		LANGUAGE4                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트4',
		LANGUAGE5                     		VARCHAR(20)		 NULL  COMMENT '외국어 사이트5'
) COMMENT='메뉴테이블';

/**********************************/
/* Table Name: 회원유형테이블 */
/**********************************/
CREATE TABLE JNITCMSMBRTYPE(
		TYPE_ID                       		VARCHAR(20)		 NOT NULL COMMENT '유형코드',
		TYPE_NM                       		VARCHAR(50)		 NOT NULL COMMENT '유형명',
		TYPE_LV                       		VARCHAR(2)		 NOT NULL COMMENT '레벨',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		MENU_ACTIVE                   		LONGTEXT		 NULL  COMMENT '활성화 메뉴'
) COMMENT='회원유형테이블';

/**********************************/
/* Table Name: 회원테이블 */
/**********************************/
CREATE TABLE JNITCMSMBR(
		MBR_ID                        		VARCHAR(20)		 NOT NULL COMMENT '회원코드',
		MBR_LOGIN                     		VARCHAR(100)		 NOT NULL COMMENT '회원아이디',
		ORG_ID                        		VARCHAR(30)		 NULL  COMMENT '부서코드',
		POS_ID                        		VARCHAR(30)		 NULL  COMMENT '직급코드',
		SITE_ID                       		VARCHAR(30)		 NULL  COMMENT '사이트ID',
		MBR_NM                        		VARCHAR(50)		 NOT NULL COMMENT '회원명',
		MBR_PHOTO                     		VARCHAR(255)		 NULL  COMMENT '회원사진',
		PASSWD                        		VARCHAR(128)		 NOT NULL COMMENT '패스워드',
		TYPE_ID                       		VARCHAR(10)		 NULL  COMMENT '회원유형',
		TEL                           		VARCHAR(20)		 NULL  COMMENT '전화번호',
		MOBILE                        		VARCHAR(20)		 NULL  COMMENT '휴대폰',
		EMAIL                         		VARCHAR(50)		 NULL  COMMENT '이메일',
		SN                            		VARCHAR(100)		 NULL  COMMENT 'SN',
		DP                            		VARCHAR(200)		 NULL  COMMENT 'DP',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		HOMEPAGE                      		VARCHAR(100)		 NULL  COMMENT '홈페이지',
		POSTCODE                      		VARCHAR(10)		 NULL  COMMENT '우편번호',
		ADDRESS                       		VARCHAR(200)		 NULL  COMMENT '주소',
		ADDRESS_NEW                   		VARCHAR(200)		 NULL  COMMENT '신주소',
		EMAIL_RECV                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '이메일수신동의',
		SMS_RECV                      		INT(1)		 DEFAULT 0		 NULL  COMMENT 'SMS수신동의',
		ESTABLISHMENT                 		VARCHAR(50)		 NULL  COMMENT '사업자번호',
		CORPORATION                   		VARCHAR(50)		 NULL  COMMENT '법인등록번호',
		PRIMARY_KEY                   		VARCHAR(50)		 NULL  COMMENT '고유번호',
		MUTUAL                        		VARCHAR(50)		 NULL  COMMENT '상호',
		CORPORATE_NAME                		VARCHAR(50)		 NULL  COMMENT '법인명(단체명)',
		GROUP_NAME                    		VARCHAR(50)		 NULL  COMMENT '대표자명',
		BUSINESS_PLACE                		VARCHAR(100)		 NULL  COMMENT '사업장 소재지',
		BUSINESS_ADDR                 		VARCHAR(200)		 NULL  COMMENT '사업장 주소',
		BUSINESS_ADDR_NEW             		VARCHAR(200)		 NULL  COMMENT '사업장 신주소',
		GROUP_KIND                    		VARCHAR(50)		 NULL  COMMENT '대표종목',
		GROUP_TEL                     		VARCHAR(30)		 NULL  COMMENT '대표 전화번호',
		GROUP_PAX                     		VARCHAR(30)		 NULL  COMMENT '대표 팩스',
		GROUP_TYPE                    		VARCHAR(30)		 NULL  COMMENT '단체종류',
		GRP_CONFIRM                   		VARCHAR(3)		 NULL  COMMENT '단체가입승인여부',
		RANK_ID                       		VARCHAR(30)		 NULL  COMMENT '팀코드',
		WORK_CONTENTS                 		VARCHAR(255)		 NULL  COMMENT '업무내용',
		GRADE_NM                      		VARCHAR(20)		 NULL  COMMENT '직책',
		ODR                           		INT(10)		 DEFAULT 0		 NULL  COMMENT '순서',
		CONNECT_TYPE                  		VARCHAR(10)		 NULL  COMMENT 'DB 연결 타입',
		GROUP_TITLE                   		VARCHAR(255)		 NULL  COMMENT '타이틀',
		PW_MISCNT                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '패스워드틀린횟수',
		LOCK_DATE							DATETIME		NULL	COMMENT '잠긴 일자',
		EX01                          		VARCHAR(255)		 NULL  COMMENT '여분필드01',
		EX02                          		VARCHAR(255)		 NULL  COMMENT '여분필드02',
		EX03                          		VARCHAR(255)		 NULL  COMMENT '여분필드03'
) COMMENT='회원테이블';

/**********************************/
/* Table Name: 메뉴관리자테이블 */
/**********************************/
CREATE TABLE JNITCMSMENUMGR(
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트코드',
		MENU_ID                       		VARCHAR(10)		 NOT NULL COMMENT '메뉴코드',
		MBR_ID                        		VARCHAR(20)		 NOT NULL COMMENT '관리자코드',
		MGR_LV                        		INT(10)		 DEFAULT 0		 NULL  COMMENT '관리권한등급'
) COMMENT='메뉴관리자테이블';

/**********************************/
/* Table Name: 콘텐츠테이블 */
/**********************************/
CREATE TABLE JNITCMSCNT(
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트코드',
		MENU_ID                       		VARCHAR(10)		 NOT NULL COMMENT '메뉴코드',
		CNT_ID                        		VARCHAR(20)		 NOT NULL COMMENT '콘텐츠코드',
		CNT_DESC                      		TEXT		 NULL  COMMENT '콘텐츠설명',
		CNT_SRC                       		TEXT		 NULL  COMMENT '콘텐츠소스',
		TPL_ID                        		VARCHAR(20)		 NOT NULL COMMENT '템플릿코드',
		ISMAIN                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '메인',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		CNT_WEB_STANDARD              		INT(1)		 DEFAULT 0		 NULL  COMMENT '웹표준',
		CNT_WEB_STANDARD_CSS          		INT(1)		 DEFAULT 0		 NULL  COMMENT '웹표준CSS',
		CNT_WEB_ACCESS                		INT(1)		 DEFAULT 0		 NULL  COMMENT '웹접근성'
) COMMENT='콘텐츠테이블';

/**********************************/
/* Table Name: 템플릿테이블 */
/**********************************/
CREATE TABLE JNITCMSTPL(
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트코드',
		TPL_ID                        		VARCHAR(20)		 NOT NULL COMMENT '템플릿코드',
		TPL_TYPE                      		VARCHAR(2)		 NOT NULL COMMENT '템플릿유형',
		TPL_NM                        		VARCHAR(50)		 NOT NULL COMMENT '템플릿명',
		TPL_DESC                      		TEXT		 NULL  COMMENT '템플릿설명',
		TPL_SRC                       		LONGTEXT		 NULL  COMMENT '템플릿소스',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		STATIC_TYPE							INT(1)		DEFAULT 0	NULL COMMENT '정적페이지'
) COMMENT='템플릿테이블';

/**********************************/
/* Table Name: 콘텐츠히스토리테이블 */
/**********************************/
CREATE TABLE JNITCMSHIST(
		HIST_ID                       		VARCHAR(20)		 NOT NULL COMMENT '히스토리코드',
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트코드',
		MENU_ID                       		VARCHAR(10)		 NOT NULL COMMENT '메뉴코드',
		CNT_ID                        		VARCHAR(20)		 NOT NULL COMMENT '콘텐츠코드',
		CNT_DESC                      		TEXT		 NULL  COMMENT '콘텐츠설명',
		CNT_SRC                       		TEXT		 NULL  COMMENT '콘텐츠소스',
		TPL_ID                        		VARCHAR(20)		 NULL  COMMENT '템플릿코드',
		CREATED                       		DATETIME		 NULL  COMMENT '저장일시',
		RESERVED                      		DATETIME		 NULL  COMMENT '예약일시'
) COMMENT='콘텐츠히스토리테이블';

/**********************************/
/* Table Name: 팀테이블 */
/**********************************/
CREATE TABLE JNITCMSRANK(
		RANK_ID                       		VARCHAR(30)		 NULL  COMMENT '팀_ID',
		RANK_NAME                     		VARCHAR(20)		 NULL  COMMENT '팀이름',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		ORG_ID                        		VARCHAR(30)		 NULL  COMMENT '부서코드',
		RANK_ODR                      		VARCHAR(10)		 NULL  COMMENT '부서코드_ID',
		CONNECT_TYPE                  		VARCHAR(10)		 NULL  COMMENT 'DB 연결 타입'
) COMMENT='팀테이블';

/**********************************/
/* Table Name: 회원로그 */
/**********************************/
CREATE TABLE JNITCMSMBRLOG(
		MBRLOG_ID                     		VARCHAR(60)		 NOT NULL COMMENT '로그ID',
		MBR_ID                        		VARCHAR(50)		 NULL  COMMENT '회원ID',
		MBRLOG_CONTENT                		VARCHAR(255)		 NULL  COMMENT '로그내용',
		MBRLOG_STATUS                 		INT(1)		 DEFAULT 0		 NULL  COMMENT '로그상태',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MBR_NM                        		VARCHAR(50)		 NULL  COMMENT '회원명',
		MBR_LOGIN                     		VARCHAR(255)		 NULL  COMMENT '로그인ID',
		MBR_IP                        		VARCHAR(100)		 NULL  COMMENT '로그인IP',
		ACT_MBR_LOGIN                 		VARCHAR(60)		 NULL  COMMENT '로그인한이름',
		MBRLOG_PATH                   		VARCHAR(50)		 NULL  COMMENT '로그인경로',
		MBRLOG_EXT01                  		VARCHAR(255)		 NULL  COMMENT '회원유형'
) COMMENT='회원로그';

/**********************************/
/* Table Name: 회원세션 */
/**********************************/
CREATE TABLE JNITCMSMBRSESS(
		MBR_ID                        		VARCHAR(20)		 NOT NULL COMMENT '회원ID',
		MBR_SESS                      		VARCHAR(200)		 NULL  COMMENT '세션',
		SESS_LOCK                     		INTEGER(10)		 DEFAULT 0		 NULL  COMMENT '세션락',
		SESS_DATE                     		DATETIME		 NULL  COMMENT '세션생성시간'
) COMMENT='회원세션';

/**********************************/
/* Table Name: 템플릿히스토리 */
/**********************************/
CREATE TABLE JNITCMSTPLHIST(
		SITE_ID                       		VARCHAR(20)		 NULL  COMMENT '사이트ID',
		TPL_ID                        		VARCHAR(20)		 NULL  COMMENT '템플릿ID',
		HIST_ID                       		VARCHAR(30)		 NULL  COMMENT '히스토리ID',
		TPL_TYPE                      		VARCHAR(10)		 NULL  COMMENT '템플릿타입',
		TPL_DESC                      		TEXT		 NULL  COMMENT '템플릿설명',
		TPL_SRC                       		LONGTEXT		 NULL  COMMENT '템플릿내용',
		ACT_MBR                       		VARCHAR(30)		 NULL  COMMENT '변경한ID',
		ACT_IP                        		VARCHAR(100)		 NULL  COMMENT '변경한IP',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일'
) COMMENT='템플릿히스토리';

/**********************************/
/* Table Name: 파일관리테이블 */
/**********************************/
CREATE TABLE JNITCMSMGMT(
		SITE_ID                       		VARCHAR(20)		 NULL  COMMENT '사이트 ID',
		MGMT_ID                       		VARCHAR(20)		 NULL  COMMENT '관리ID',
		MGMT_SORT                     		INT(10)		 DEFAULT 0		 NULL  COMMENT '파일순서',
		MGMT_NM                       		VARCHAR(255)		 NULL  COMMENT '이름',
		MGMT_TYPE                     		VARCHAR(30)		 NULL  COMMENT '관리형식',
		MGMT_SCRIPT_TYPE              		VARCHAR(20)		 NULL  COMMENT '스크립트 형식',
		MGMT_CONTENT                  		LONGTEXT		 NULL  COMMENT '내용',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL  COMMENT '저장한사람',
		MGMT_HEARDER_YN               		INT(1)		 DEFAULT 0		 NULL  COMMENT '해더 사용여부',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		MGMT_FILE_NM                  		VARCHAR(255)		 NULL  COMMENT '파일이름',
		MGMT_FILE_ORIGIN              		VARCHAR(255)		 NULL  COMMENT '파일원본이름',
		MGMT_FILE_PATH                		VARCHAR(255)		 NULL  COMMENT '파일경로',
		MGMT_FILE_URL                 		TEXT		 NULL  COMMENT '파일URL',
		MGMT_FILE_PATH_URL            		TEXT		 NULL  COMMENT '실제파일경로',
		MGMT_INSERT_PATH              		VARCHAR(255)		 NULL  COMMENT '소스 삽입 경로',
		MGMT_DOWNLOAD_COUNT           		INT(38)		 DEFAULT 0		 NULL  COMMENT '다운로드 횟수',
		BOARD_ID                      		VARCHAR(25)		 NULL  COMMENT '게시판ID',
		BOARD_COUNT                   		INT(10)		 DEFAULT 0		 NULL  COMMENT '게시물 수',
		BOARD_SKIN                    		VARCHAR(255)		 NULL  COMMENT '게시판스킨',
		THUMB_WIDTH                   		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 가로',
		THUMB_HEIGHT                   		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 세로'
) COMMENT='파일관리테이블';

/**********************************/
/* Table Name: CSS관리히스토리 */
/**********************************/
CREATE TABLE JNITCMSCSSHIST(
		SITE_ID                       		VARCHAR(10)		 NULL  COMMENT '사이트 ID',
		MGMT_ID                       		VARCHAR(20)		 NULL  COMMENT '관리ID',
		HIST_ID                       		VARCHAR(20)		 NULL  COMMENT '히스토리ID',
		CONTENT                       		LONGTEXT		 NULL  COMMENT '내용',
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL  COMMENT '저장한사람',
		MGMT_ACT_IP                   		VARCHAR(100)		 NULL  COMMENT '아이피경로',
		CREATED                       		DATETIME		 NULL  COMMENT '저장일자'
) COMMENT='CSS관리히스토리';

/**********************************/
/* Table Name: script관리히스토리 */
/**********************************/
CREATE TABLE JNITCMSSCRIPTHIST(
		SITE_ID                       		VARCHAR(10)		 NULL  COMMENT '사이트 ID',
		MGMT_ID                       		VARCHAR(20)		 NULL  COMMENT '관리ID',
		HIST_ID                       		VARCHAR(20)		 NULL  COMMENT '히스토리ID',
		CONTENT                       		LONGTEXT		 NULL  COMMENT '내용',
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL  COMMENT '저장한사람',
		MGMT_ACT_IP                   		VARCHAR(100)		 NULL  COMMENT '아이피경로',
		CREATED                       		DATETIME		 NULL  COMMENT '저장일자'
) COMMENT='script관리히스토리';

/**********************************/
/* Table Name: 게시판관리히스토리 */
/**********************************/
CREATE TABLE JNITCMSBOARDHIST(
		SITE_ID                       		VARCHAR(10)		 NULL  COMMENT '사이트 ID',
		MGMT_ID                       		VARCHAR(20)		 NULL  COMMENT '관리ID',
		HIST_ID                       		VARCHAR(20)		 NULL  COMMENT '히스토리ID',
		CONTENT                       		LONGTEXT		 NULL  COMMENT '내용',
		BOARD_SKIN                    		VARCHAR(255)		 NULL  COMMENT '게시판 스킨',
		MGMT_ACT_ID                   		VARCHAR(20)		 NULL  COMMENT '저장한사람',
		MGMT_ACT_IP                   		VARCHAR(100)		 NULL  COMMENT '아이피경로',
		CREATED                       		DATETIME		 NULL  COMMENT '저장일자'
) COMMENT='게시판관리히스토리';

/**********************************/
/* Table Name: 파일관리 카테고리테이블 */
/**********************************/
CREATE TABLE JNITCMSMGMTCATEGORY(
		SITE_ID                       		VARCHAR(10)		 NOT NULL COMMENT '사이트ID',
		MGMT_CATEGORY_ID              		VARCHAR(30)		 NOT NULL COMMENT '관리카테고리ID'
) COMMENT='파일관리 카테고리테이블';

/**********************************/
/* Table Name: 카테고리 아이템 테이블 */
/**********************************/
CREATE TABLE JNITCMSMGMTITEM(
		MGMT_CATEGORY_ID              		VARCHAR(30)		 NOT NULL COMMENT '기본키',
		CATEGORY_ID                   		VARCHAR(30)		 NOT NULL COMMENT '카테고리ID',
		CATEGORY_NM                   		VARCHAR(100)		 NULL  COMMENT '카테고리이름',
		CATEGORY_VAL                  		VARCHAR(255)		 NULL  COMMENT '카테고리 값',
		CATEGORY_SORT                 		INT(10)		 DEFAULT 0		 NULL  COMMENT '정렬순서',
		CATEGORY_SOURCE               		VARCHAR(100)		 NULL  COMMENT '출처',
		MODIFI_YN                     		INT(1)		 DEFAULT 0		 NULL  COMMENT '수정가능여부',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='카테고리 아이템 테이블';


ALTER TABLE JNITCMSPOS ADD CONSTRAINT IDX_JNITCMSPOS_PK PRIMARY KEY (POS_ID);

ALTER TABLE JNITCMSORG ADD CONSTRAINT IDX_JNITCMSORG_PK PRIMARY KEY (ORG_ID);

ALTER TABLE JNITCMSSITE ADD CONSTRAINT IDX_JNITCMSSITE_PK PRIMARY KEY (SITE_ID);

ALTER TABLE JNITCMSMENU ADD CONSTRAINT IDX_JNITCMSMENU_PK PRIMARY KEY (SITE_ID, MENU_ID);
ALTER TABLE JNITCMSMENU ADD CONSTRAINT IDX_JNITCMSMENU_FK0 FOREIGN KEY (SITE_ID) REFERENCES JNITCMSSITE (SITE_ID);

ALTER TABLE JNITCMSMBRTYPE ADD CONSTRAINT IDX_JNITCMSMBRTYPE_PK PRIMARY KEY (TYPE_ID);

ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_PK PRIMARY KEY (MBR_ID);
ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_FK0 FOREIGN KEY (POS_ID) REFERENCES JNITCMSPOS (POS_ID);
ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_FK1 FOREIGN KEY (ORG_ID) REFERENCES JNITCMSORG (ORG_ID);
ALTER TABLE JNITCMSMBR ADD CONSTRAINT IDX_JNITCMSMBR_FK2 FOREIGN KEY (TYPE_ID) REFERENCES JNITCMSMBRTYPE (TYPE_ID);

ALTER TABLE JNITCMSMENUMGR ADD CONSTRAINT IDX_JNITCMSMENUMGR_PK PRIMARY KEY (SITE_ID, MENU_ID);
ALTER TABLE JNITCMSMENUMGR ADD CONSTRAINT IDX_JNITCMSMENUMGR_FK0 FOREIGN KEY (MBR_ID) REFERENCES JNITCMSMBR (MBR_ID);
ALTER TABLE JNITCMSMENUMGR ADD CONSTRAINT IDX_JNITCMSMENUMGR_FK1 FOREIGN KEY (SITE_ID,MENU_ID) REFERENCES JNITCMSMENU (SITE_ID,MENU_ID);

ALTER TABLE JNITCMSCNT ADD CONSTRAINT IDX_JNITCMSCNT_PK PRIMARY KEY (SITE_ID, MENU_ID, CNT_ID);
ALTER TABLE JNITCMSCNT ADD CONSTRAINT IDX_JNITCMSCNT_FK0 FOREIGN KEY (SITE_ID,MENU_ID) REFERENCES JNITCMSMENU (SITE_ID,MENU_ID);

ALTER TABLE JNITCMSTPL ADD CONSTRAINT IDX_JNITCMSTPL_PK PRIMARY KEY (SITE_ID, TPL_ID);
ALTER TABLE JNITCMSTPL ADD CONSTRAINT IDX_JNITCMSTPL_FK0 FOREIGN KEY (SITE_ID) REFERENCES JNITCMSSITE (SITE_ID);

ALTER TABLE JNITCMSHIST ADD CONSTRAINT IDX_JNITCMSHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSHIST ADD CONSTRAINT IDX_JNITCMSHIST_FK0 FOREIGN KEY (SITE_ID,MENU_ID,CNT_ID) REFERENCES JNITCMSCNT (SITE_ID,MENU_ID,CNT_ID);

ALTER TABLE JNITCMSRANK ADD CONSTRAINT IDX_JNITCMSRANK_PK PRIMARY KEY (RANK_ID);

ALTER TABLE JNITCMSMBRLOG ADD CONSTRAINT IDX_JNITCMSMBRLOG_PK PRIMARY KEY (MBRLOG_ID);

ALTER TABLE JNITCMSTPLHIST ADD CONSTRAINT IDX_JNITCMSTPLHIST_FK0 FOREIGN KEY (SITE_ID) REFERENCES JNITCMSSITE (SITE_ID);
ALTER TABLE JNITCMSTPLHIST ADD CONSTRAINT IDX_JNITCMSTPLHIST_FK1 FOREIGN KEY (SITE_ID,TPL_ID) REFERENCES JNITCMSTPL (SITE_ID,TPL_ID);

ALTER TABLE JNITCMSMGMT ADD CONSTRAINT IDX_JNITCMSMGMT_PK PRIMARY KEY (MGMT_ID);

ALTER TABLE JNITCMSCSSHIST ADD CONSTRAINT IDX_JNITCMSCSSHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSCSSHIST ADD CONSTRAINT IDX_JNITCMSCSSHIST_FK0 FOREIGN KEY (MGMT_ID) REFERENCES JNITCMSMGMT (MGMT_ID);

ALTER TABLE JNITCMSSCRIPTHIST ADD CONSTRAINT IDX_JNITCMSSCRIPTHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSSCRIPTHIST ADD CONSTRAINT IDX_JNITCMSSCRIPTHIST_FK0 FOREIGN KEY (MGMT_ID) REFERENCES JNITCMSMGMT (MGMT_ID);

ALTER TABLE JNITCMSBOARDHIST ADD CONSTRAINT IDX_JNITCMSBOARDHIST_PK PRIMARY KEY (HIST_ID);
ALTER TABLE JNITCMSBOARDHIST ADD CONSTRAINT IDX_JNITCMSBOARDHIST_FK0 FOREIGN KEY (MGMT_ID) REFERENCES JNITCMSMGMT (MGMT_ID);

ALTER TABLE JNITCMSMGMTCATEGORY ADD CONSTRAINT IDX_JNITCMSMGMTCATEGORY_PK PRIMARY KEY (MGMT_CATEGORY_ID);

ALTER TABLE JNITCMSMGMTITEM ADD CONSTRAINT IDX_JNITCMSMGMTITEM_PK PRIMARY KEY (CATEGORY_ID);
ALTER TABLE JNITCMSMGMTITEM ADD CONSTRAINT IDX_JNITCMSMGMTITEM_FK0 FOREIGN KEY (MGMT_CATEGORY_ID) REFERENCES JNITCMSMGMTCATEGORY (MGMT_CATEGORY_ID);


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

/**********************************/
/* Table Name: EBOOK 테이블 */
/**********************************/
CREATE TABLE JNITEBOOK(
		EBOOK_ID                      		VARCHAR(50)		 NOT NULL COMMENT '고유번호',
		EBOOK_TITLE                   		VARCHAR(255)		 NULL  COMMENT '제목',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		PAGE_WIDTH                    		INT(38)		 DEFAULT 0		 NULL  COMMENT '페이지 가로',
		PAGE_HEIGHT                   		INT(38)		 DEFAULT 0		 NULL  COMMENT '페이지 세로',
		THUMB_YN                      		VARCHAR(15)		 NULL  COMMENT '썸네일 여부',
		THUMB_AOTO_HIDE               		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 숨기기',
		THUMB_WIDTH                   		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 가로',
		THUMB_HEIGHT                  		INT(38)		 DEFAULT 0		 NULL  COMMENT '썸네일 세로',
		SHARE_LINK                    		VARCHAR(255)		 NULL  COMMENT '링크주소',
		SHARE_TEXT                    		VARCHAR(255)		 NULL  COMMENT '메세지',
		SHARE_VIA                     		VARCHAR(255)		 NULL  COMMENT '소유주',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		EXT01                         		VARCHAR(255)		 NULL  COMMENT '여분필드01',
		EXT02                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '여분필드02',
		EXT03                         		VARCHAR(255)		 NULL  COMMENT '여분필드03',
		EXT04                         		VARCHAR(255)		 NULL  COMMENT '여분필드04',
		EXT05                         		VARCHAR(255)		 NULL  COMMENT '여분필드05'
) COMMENT='EBOOK 테이블';

/**********************************/
/* Table Name: EBOOK 파일테이블 */
/**********************************/
CREATE TABLE JNITEBOOKFILE(
		EBOOK_FILE_ID                 		VARCHAR(50)		 NULL  COMMENT 'EBOOK 고유번호',
		FILE_ID                       		VARCHAR(50)		 NOT NULL COMMENT '고유번호',
		FILE_PID                      		VARCHAR(50)		 NULL  COMMENT 'FILE_PID',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일 경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일 이름',
		FILE_PATH2                    		VARCHAR(255)		 NULL  COMMENT '파일 실제이름',
		FILE_NM2                      		VARCHAR(255)		 NULL  COMMENT '파일 URL',
		FILE_HTML_PATH                		VARCHAR(255)		 NULL  COMMENT 'Html 파일 경로',
		FILE_HTML_NM                  		VARCHAR(255)		 NULL  COMMENT 'Html 파일 이름',
		FILE_NUM                      		INT(10)		 DEFAULT 0		 NULL  COMMENT '순서',
		FILE_TYPE                     		VARCHAR(30)		 NULL  COMMENT '파일설정 종류',
		FILE_CLASS                    		VARCHAR(30)		 NULL  COMMENT 'FILE_CLASS',
		HTML_FILE                     		VARCHAR(4000)		 NULL  COMMENT 'HTML_FILE',
		BACKGROUND_FILE               		VARCHAR(4000)		 NULL  COMMENT 'BACKGROUND_FILE',
		DISABLE_EMBOSSING             		VARCHAR(15)		 NULL  COMMENT 'DISABLE_EMBOSSING',
		TRANSPARENT_PAGE              		VARCHAR(15)		 NULL  COMMENT 'TRANSPARENT_PAGE',
		PAGE_NUMBER                   		VARCHAR(30)		 DEFAULT '0'		 NULL  COMMENT 'PAGE_NUMBER',
		PAGE_NAME                     		VARCHAR(100)		 NULL  COMMENT 'PAGE_NAME',
		PAGE_LABEL                    		VARCHAR(100)		 NULL  COMMENT 'PAGE_LABEL',
		DATA                          		VARCHAR(15)		 NULL  COMMENT 'DATA',
		THUMBNAIL_IMAGE               		VARCHAR(4000)		 NULL  COMMENT 'THUMBNAIL_IMAGE',
		DATA_UNLOAD                   		VARCHAR(15)		 NULL  COMMENT 'DATA_UNLOAD',
		UPLOAD_FILE                   		VARCHAR(4000)		 NULL  COMMENT 'UPLOAD_FILE',
		CONTENT                       		TEXT		 NULL  COMMENT '내용',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부'
) COMMENT='EBOOK 파일테이블';


ALTER TABLE JNITEBOOK ADD CONSTRAINT IDX_JNITEBOOK_PK PRIMARY KEY (EBOOK_ID);

ALTER TABLE JNITEBOOKFILE ADD CONSTRAINT IDX_JNITEBOOKFILE_PK PRIMARY KEY (FILE_ID);

/**********************************/
/* Table Name: 로그인 로그 테이블 */
/**********************************/
CREATE TABLE JNITLOGINLOG(
		IP_ID                         		VARCHAR(255)		 NULL  COMMENT 'IP_ID',
		MBR_ID                        		VARCHAR(255)		 NULL  COMMENT 'MBR_ID',
		IP_ADDR                       		VARCHAR(255)		 NULL  COMMENT 'IP_주소',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일'
) COMMENT='로그인 로그 테이블';


ALTER TABLE JNITLOGINLOG ADD CONSTRAINT IDX_JNITLOGINLOG_PK PRIMARY KEY (IP_ID);

/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITMENU(
		MENU_SEQ                      		INT(30)		 DEFAULT 0		 NOT NULL COMMENT '메뉴순번',
		MENU_URL                      		VARCHAR(255)		 NULL  COMMENT '메뉴URL',
		MENU_DEPT                     		VARCHAR(100)		 NULL  COMMENT '담당부서',
		MENU_PART                     		VARCHAR(200)		 NULL  COMMENT '담당업무',
		MENU_TEL                      		VARCHAR(20)		 NULL  COMMENT '전화번호',
		MENU_MEMID                    		VARCHAR(20)		 NULL  COMMENT '담당자아이디'
) COMMENT='메뉴테이블';


ALTER TABLE JNITMENU ADD CONSTRAINT IDX_JNITMENU_PK PRIMARY KEY (MENU_SEQ);

/**********************************/
/* Table Name: 설문조사카테고리 */
/**********************************/
CREATE TABLE JNITRESEARCHCATEGORY(
		CATEGORY_ID                   		VARCHAR(30)		 NULL  COMMENT '카테고리ID',
		CATEGORY_NAME                 		VARCHAR(255)		 NULL  COMMENT '카테고리이름',
		SITE_PATH                     		VARCHAR(255)		 NULL  COMMENT '사이트경로',
		ISDEL                         		INT(1)		 NULL  COMMENT '삭제여부'
) COMMENT='설문조사카테고리';

/**********************************/
/* Table Name: 설문조사테이블 */
/**********************************/
CREATE TABLE JNITRESEARCH(
		RESEARCH_ID                   		VARCHAR(20)		 NOT NULL COMMENT '설문조사ID',
		RESEARCH_NM                   		LONGTEXT		 NULL  COMMENT '설문조사제목',
		RESEARCH_OPEN                 		INT(1)		 NULL  COMMENT '설문조사공개',
		STARTTIME                     		DATETIME		 NULL  COMMENT '시작일',
		ENDTIME                       		DATETIME		 NULL  COMMENT '종료일',
		STATE                         		INT(1)		 NULL  COMMENT '저장상태',
		ENTRY                         		INT(8)		 NULL  COMMENT '참여인원',
		BLOCK                         		INT(1)		 NULL  COMMENT '설문참여방식',
		RESEARCH_TARGET               		VARCHAR(255)		 NULL  COMMENT '설문대상',
		NAME_OPEN                     		INT(1)		 NULL  COMMENT '익명/실명',
		RESULT_OPEN                   		INT(1)		 NULL  COMMENT '결과공개여부',
		INTRODUCE                     		TEXT		 NULL  COMMENT '설문소개',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 NULL  COMMENT 'ISDEL',
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
		QUESTION_NM                   		LONGTEXT		 NULL  COMMENT '설문조사질문',
		TYPE                          		INT(1)		 DEFAULT 0		 NULL  COMMENT '질문타입',
		ORDERCHECK                    		INT(1)		 DEFAULT 0		 NULL  COMMENT '기타답변',
		VISIBLE                       		INT(1)		 DEFAULT 0		 NULL  COMMENT '기본값활성화설정',
		ANSWER_CNT                    		INT(3)		 DEFAULT 1		 NULL  COMMENT '체크박스답변선택수',
		ANSWER_FORM                   		INT(1)		 DEFAULT 0		 NULL  COMMENT '주관식박스형태',
		FILE_URL                      		VARCHAR(255)		 NULL  COMMENT '파일 URL',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일 경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일 저장명',
		FILE_ONM                      		VARCHAR(255)		 NULL  COMMENT '파일 원본명',
		FILE_WIDTH                    		INT(5)		 NULL  COMMENT '파일 가로크기',
		FILE_HEIGHT                   		INT(5)		 NULL  COMMENT '파일 세로크기',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT 'ISDEL',
		LINEUP                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '답정렬',
		LINEUP_CNT                    		INT(3)		 NULL  COMMENT '답정렬개수'
) COMMENT='설문조사질문';

/**********************************/
/* Table Name: 설문조사답변테이블 */
/**********************************/
CREATE TABLE JNITRESEARCHANSWER(
		ANSWER_ID                     		VARCHAR(20)		 NOT NULL COMMENT '답변 ID',
		QUESTION_ID                   		VARCHAR(20)		 NULL  COMMENT '질문ID',
		RESEARCH_ID                   		VARCHAR(20)		 NULL  COMMENT '설문조사ID',
		ANSWER_NM                     		LONGTEXT		 NULL  COMMENT '답변이름',
		TYPE                          		INT(1)		 NULL  COMMENT '답변타입',
		CRITERION_OPT                 		INT(1)		 DEFAULT 0		 NULL  COMMENT '척도점수설정',
		CRITERION_CNT                 		INT(4)		 DEFAULT 0		 NULL  COMMENT '척도점수',
		ANSOPT                        		INT(1)		 DEFAULT 0		 NULL  COMMENT '문항설정',
		ANSOPT_NUM                    		VARCHAR(255)		 DEFAULT 0		 NULL  COMMENT '활성화번호',
		ANSOPT_MOVE                   		VARCHAR(255)		 DEFAULT 0		 NULL  COMMENT '이동번호',
		ANSOPT_VISIBLE                		INT(1)		 NULL  COMMENT '답변선택시활성화정책',
		FILE_URL                      		VARCHAR(255)		 NULL  COMMENT '파일 URL',
		FILE_PATH                     		VARCHAR(255)		 NULL  COMMENT '파일 경로',
		FILE_NM                       		VARCHAR(255)		 NULL  COMMENT '파일 저장명',
		FILE_ONM                      		VARCHAR(255)		 NULL  COMMENT '파일 원본명',
		FILE_WIDTH                    		INT(5)		 NULL  COMMENT '파일 가로크기',
		FILE_HEIGHT                   		INT(5)		 NULL  COMMENT '파일 세로크기',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 NULL  COMMENT 'ISDEL'
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
		ANSWER                        		LONGTEXT		 NULL  COMMENT '답변',
		ORDER_ANSWER                  		LONGTEXT		 NULL  COMMENT '기타답변',
		CREATED                       		DATETIME		 NULL  COMMENT '응답일시',
		MODIFIDE                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 NULL  COMMENT 'ISDEL'
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
		ISDEL                         		INT(1)		 NULL  COMMENT 'ISDEL',
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



/**********************************/
/* Table Name: 만족도메인테이블 */
/**********************************/
CREATE TABLE JNITRSC(
		RSC_ID                        		VARCHAR(20)		 NOT NULL COMMENT '만족도고유코드',
		RSC_MENU                      		VARCHAR(100)		 NOT NULL COMMENT '만족도메뉴',
		RSC_URL                       		VARCHAR(100)		 NULL  COMMENT '만족도메뉴URL',
		RSC_TOT_SCORE                 		INT(15)		 DEFAULT 0		 NULL  COMMENT '만족도점수합계'
) COMMENT='만족도메인테이블';

/**********************************/
/* Table Name: 만족도데이터테이블 */
/**********************************/
CREATE TABLE JNITRSCDATA(
		DATA_ID                       		VARCHAR(20)		 NOT NULL COMMENT '만족도데이터코드',
		RSC_ID                        		VARCHAR(20)		 NOT NULL COMMENT '만족도고유코드',
		DATA_MEMO                     		VARCHAR(1000)		 NULL  COMMENT '만족도평가메모',
		DATA_SCORE                    		INT(15)		 DEFAULT 0		 NOT NULL COMMENT '만족도평가점수',
		CREATED                       		DATETIME		 NULL  COMMENT '등록일자',
		REMOTE_ADDR                   		VARCHAR(128)		 NULL  COMMENT '등록자IP'
) COMMENT='만족도데이터테이블';

/**********************************/
/* Table Name: 페이지통계 */
/**********************************/
CREATE TABLE JNITRSCPAGE(
		RSCP_ID                       		VARCHAR(20)		 NOT NULL COMMENT '페이지통계코드',
		SITE_ID                       		VARCHAR(20)		 NULL  COMMENT '사이트코드',
		MENU_ID                       		VARCHAR(20)		 NULL  COMMENT '메뉴코드',
		PAGE_URL                      		VARCHAR(128)		 NOT NULL COMMENT '페이지URL',
		PAGE_VIEW                     		INT(10)		 DEFAULT 0		 NULL  COMMENT '페이지뷰카운트',
		HIT1                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가1',
		HIT2                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가2',
		HIT3                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가3',
		HIT4                          		INT(10)		 NULL  COMMENT '평가4',
		HIT5                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가5'
) COMMENT='페이지통계';

/**********************************/
/* Table Name: 페이지평가데이터 */
/**********************************/
CREATE TABLE JNITRSCPAGEDATA(
		PDATA_ID                      		VARCHAR(20)		 NOT NULL COMMENT '페이지평가데이터코드',
		RSCP_ID                       		VARCHAR(20)		 NULL  COMMENT '페이지평가코드',
		MEMO                          		VARCHAR(1000)		 NULL  COMMENT '메모',
		HIT1                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가1',
		HIT2                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가2',
		HIT3                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가3',
		HIT4                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가4',
		HIT5                          		INT(10)		 DEFAULT 0		 NULL  COMMENT '평가5',
		REMOTE_ADDR                   		VARCHAR(128)		 NULL  COMMENT '평가자IP',
		CREATED                       		DATETIME		 NULL  COMMENT '평가일시'
) COMMENT='페이지평가데이터';


ALTER TABLE JNITRSC ADD CONSTRAINT IDX_JNITRSC_PK PRIMARY KEY (RSC_ID);

ALTER TABLE JNITRSCDATA ADD CONSTRAINT IDX_JNITRSCDATA_PK PRIMARY KEY (DATA_ID);
ALTER TABLE JNITRSCDATA ADD CONSTRAINT IDX_JNITRSCDATA_FK0 FOREIGN KEY (RSC_ID) REFERENCES JNITRSC (RSC_ID);

ALTER TABLE JNITRSCPAGE ADD CONSTRAINT IDX_JNITRSCPAGE_PK PRIMARY KEY (RSCP_ID);
ALTER TABLE JNITRSCPAGE ADD CONSTRAINT UNQ_PAGE_URL UNIQUE (PAGE_URL);

ALTER TABLE JNITRSCPAGEDATA ADD CONSTRAINT IDX_JNITRSCPAGEDATA_PK PRIMARY KEY (PDATA_ID);
ALTER TABLE JNITRSCPAGEDATA ADD CONSTRAINT IDX_JNITRSCPAGEDATA_FK0 FOREIGN KEY (RSCP_ID) REFERENCES JNITRSCPAGE (RSCP_ID);

/**********************************/
/* Table Name: 페이지 스크랩 */
/**********************************/
CREATE TABLE JNITSCRAP(
		SCRAP_ID                      		VARCHAR(20)		 NULL  COMMENT '고유키',
		MBR_ID                        		VARCHAR(20)		 NULL  COMMENT '회원 ID',
		TITLE                         		VARCHAR(200)		 NULL  COMMENT '제목',
		URL                           		VARCHAR(4000)		 NULL  COMMENT 'URL',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일'
) COMMENT='페이지 스크랩';

/**********************************/
/* Table Name: 사이트별 방문자 접속 카운트 */
/**********************************/
CREATE TABLE JNITSITESTATE(
		WHEN_DATE                     		VARCHAR(50)		 NULL  COMMENT '접속일'
) COMMENT='사이트별 방문자 접속 카운트';

/**********************************/
/* Table Name: 방문자 접속자 리스트 */
/**********************************/
CREATE TABLE JNITSITESTATELIST(
		SITE                          		VARCHAR(20)		 NULL  COMMENT '사이트',
		IP                            		VARCHAR(20)		 NULL  COMMENT 'IP'
) COMMENT='방문자 접속자 리스트';

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

/**********************************/
/* Table Name: 방문자분석데이터 */
/**********************************/
CREATE TABLE JNITVISITLOG(
		WHEN_DATETIME                 		DATETIME		 NULL  COMMENT '날짜시간',
		WHEN_DATE                     		VARCHAR(200)		 NULL  COMMENT '날짜',
		SITE                          		VARCHAR(100)		 NULL  COMMENT '사이트아이디',
		IPADDR                        		VARCHAR(255)		 NULL  COMMENT 'IP',
		REFERER                       		TEXT		 NULL  COMMENT '레퍼러',
		USER_OS                       		VARCHAR(255)		 NULL  COMMENT 'UserOS',
		BROWSER                       		VARCHAR(255)		 NULL  COMMENT 'UserBrowser',
		USER_AGENT                    		VARCHAR(255)		 NULL  COMMENT 'UserAgent',
		PAGE                          		VARCHAR(255)		 NULL  COMMENT 'PAGE',
		USER                          		VARCHAR(100)		 NULL  COMMENT 'USER',
		USR_ACTION                    		VARCHAR(200)		 NULL  COMMENT 'USR_ACTION'
) COMMENT='방문자분석데이터';

/**********************************/
/* Table Name: 방문자 접속 데이터 */
/**********************************/
CREATE TABLE JNITVISITCOUNT(
		SITE                          		VARCHAR(100)		 NULL  COMMENT '사이트',
		VDATE                         		DATE		 NULL  COMMENT '날짜',
		VHOUR                         		INT(2)		 NULL  COMMENT '시간',
		USER_OS                       		VARCHAR(100)		 NULL  COMMENT '운영체제',
		BROWSER                       		VARCHAR(100)		 NULL  COMMENT '브라우저',
		HIT                           		INT(10)		 NULL  COMMENT '카운트'
) COMMENT='방문자 접속 데이터';


ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_PK PRIMARY KEY (WHEN_DATETIME);

CREATE INDEX IDX_JNITVISITLOG_1 ON JNITVISITLOG (WHEN_DATE, SITE);

ALTER TABLE JNITVISITLOG ADD CONSTRAINT IDX_JNITVISITLOG_2 UNIQUE (WHEN_DATE, SITE, IPADDR);

ALTER TABLE JNITVISITCOUNT ADD CONSTRAINT IDX_JNITVISITCOUNT_1 UNIQUE (SITE, VDATE, VHOUR, USER_OS, BROWSER);

/**********************************/
/* Table Name: 배포 히스토리 테이블 */
/**********************************/
CREATE TABLE JNITCMSDISSEMINATEHISTORY(
		HISTORY_ID                    		VARCHAR(30)		 NULL  COMMENT 'HISTORY_ID',
		SITE_ID                       		VARCHAR(30)		 NULL  COMMENT 'SITE_ID',
		MENU_ID                       		VARCHAR(30)		 NULL  COMMENT 'MENU_ID',
		CNT_ID                        		VARCHAR(30)		 NULL  COMMENT 'CNT_ID',
		CONTENT_PATH                  		VARCHAR(255)		 NULL  COMMENT '콘텐츠경로',
		DISSEMINATE_TYPE              		VARCHAR(10)		 NULL  COMMENT '승인유형',
		DISSEMINATE_LINE              		TEXT		 NULL  COMMENT '결제라인',
		MBR_ID                        		VARCHAR(20)		 NULL  COMMENT '결제자',
		DISSEMINATE_USERCONFIRM       		VARCHAR(10)		 NULL  COMMENT '결제자상태',
		DISSEMINATE_CONFIRM           		INT(1)		 DEFAULT 0		 NULL  COMMENT '콘텐츠상태',
		DISSEMINATE_DAY               		DATETIME		 NULL  COMMENT '예약날자',
		DISSEMINATE_CREATED           		DATETIME		 NULL  COMMENT '생성일',
		HISTORY_MEMO                  		TEXT		 NULL  COMMENT '메모'
) COMMENT='배포 히스토리 테이블';

/**********************************/
/* Table Name: 배포테이블 */
/**********************************/
CREATE TABLE JNITCMSDISSEMINATE(
		DISSEMINATE_ID                		VARCHAR(30)		 NULL  COMMENT 'DISSEMINATE_ID',
		SITE_ID                       		VARCHAR(30)		 NULL  COMMENT 'SITE_ID',
		MENU_ID                       		VARCHAR(30)		 NULL  COMMENT 'MENU_ID',
		CNT_ID                        		VARCHAR(30)		 NULL  COMMENT 'CNT_ID',
		CONTENT_PATH                  		TEXT		 NULL  COMMENT '콘텐츠경로',
		DISSEMINATE_TYPE              		VARCHAR(10)		 NULL  COMMENT '설정유형',
		MBR_ID                        		VARCHAR(30)		 NULL  COMMENT '회원',
		DISSEMINATE_CONFIRM           		INT(1)		 DEFAULT 0		 NULL  COMMENT '승인여부',
		DISSEMINATE_MEMO              		TEXT		 NULL  COMMENT '메모',
		CONTENT_CONFIRM               		INT(1)		 NULL  COMMENT '콘텐츠 완료여부',
		DISSEMINATE_DAY               		DATETIME		 NULL  COMMENT '예약 날짜',
		DISSEMINATE_HISTORY_ID        		VARCHAR(30)		 NULL  COMMENT '히스토리',
		DISSEMINATE_NAME              		TEXT		 NULL  COMMENT '파일이름',
		DISSEMINATE_NUM               		VARCHAR(20)		 NULL  COMMENT '번호',
		ORIGIN_URL                    		VARCHAR(255)		 NULL  COMMENT '원문 URL',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT '삭제여부',
		DISSEMINATE_STAND             		INT(3)		 DEFAULT 0		 NULL  COMMENT 'DISSEMINATE_STAND'
) COMMENT='배포테이블';


ALTER TABLE JNITCMSDISSEMINATEHISTORY ADD CONSTRAINT IDX_JNITCMSDISSEMINATEHISTORY_PK PRIMARY KEY (HISTORY_ID);

ALTER TABLE JNITCMSDISSEMINATE ADD CONSTRAINT IDX_JNITCMSDISSEMINATE_PK PRIMARY KEY (DISSEMINATE_ID);


/* VIEW TABLE */
/**********************************/
/* Table Name: jnitcmscntvt */
/**********************************/
CREATE
    ALGORITHM = UNDEFINED
    SQL SECURITY DEFINER
VIEW `JNITCMSCNTVT` AS
    SELECT
        `b`.`CNT_ID` AS `CNT_ID`,
        `a`.`SITE_ID` AS `SITE_ID`,
        `a`.`MENU_ID` AS `MENU_ID`,
        IF((`d`.`CNT_ID` = `b`.`CNT_ID`), 1, 0) AS `ISMAIN`,
        `a`.`MENU_NM` AS `MENU_NM`,
        `a`.`MENU_PATH` AS `MENU_PATH`,
        `a`.`PID` AS `PID`,
        `a`.`DEPTH` AS `DEPTH`,
        `a`.`METHOD` AS `METHOD`,
        `b`.`CNT_DESC` AS `CNT_DESC`,
        `b`.`CNT_SRC` AS `CNT_SRC`,
        `b`.`TPL_ID` AS `TPL_ID`,
        `c`.`TPL_NM` AS `TPL_NM`,
        `b`.`CREATED` AS `CREATED`,
        `b`.`MODIFIED` AS `MODIFIED`,
        `b`.`ISDEL` AS `ISDEL`
    FROM
        (((`JNITCMSCNT` `b`
        LEFT JOIN `JNITCMSMENU` `a` ON (((`a`.`SITE_ID` = `b`.`SITE_ID`)
            AND (`a`.`MENU_ID` = `b`.`MENU_ID`))))
        LEFT JOIN `JNITCMSMENU` `d` ON (((`d`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`d`.`MENU_ID` = `a`.`PID`))))
        LEFT JOIN `JNITCMSTPL` `c` ON ((`c`.`TPL_ID` = `b`.`TPL_ID`)));

/**********************************/
/* Table Name: jnitcmsmenu_vt */
/**********************************/
CREATE
    ALGORITHM = UNDEFINED
    SQL SECURITY DEFINER
VIEW `JNITCMSMENU_VT` AS
    SELECT
        `a`.`SITE_ID` AS `SITE_ID`,
        IFNULL(`g`.`MENU_ID`,
                IFNULL(`f`.`MENU_ID`,
                        IFNULL(`e`.`MENU_ID`,
                                IFNULL(`d`.`MENU_ID`,
                                        IFNULL(`c`.`MENU_ID`,
                                                IFNULL(`b`.`MENU_ID`, IFNULL(`a`.`MENU_ID`, ''))))))) AS `MENU_ID`,
        LPAD(IFNULL(CONVERT( `g`.`METHOD` USING UTF8),
                        IFNULL(CONVERT( `f`.`METHOD` USING UTF8),
                                IFNULL(CONVERT( `e`.`METHOD` USING UTF8),
                                        IFNULL(CONVERT( `d`.`METHOD` USING UTF8),
                                                IFNULL(CONVERT( `c`.`METHOD` USING UTF8),
                                                        IFNULL(CONVERT( `b`.`METHOD` USING UTF8),
                                                                IFNULL(CONVERT( `a`.`METHOD` USING UTF8), ''))))))),
                10,
                '0') AS `METHOD`,
        IFNULL(CONVERT( `g`.`DEPTH` USING UTF8),
                IFNULL(CONVERT( `f`.`DEPTH` USING UTF8),
                        IFNULL(CONVERT( `e`.`DEPTH` USING UTF8),
                                IFNULL(CONVERT( `d`.`DEPTH` USING UTF8),
                                        IFNULL(CONVERT( `c`.`DEPTH` USING UTF8),
                                                IFNULL(CONVERT( `b`.`DEPTH` USING UTF8),
                                                        IFNULL(CONVERT( `a`.`DEPTH` USING UTF8), ''))))))) AS `DEPTH`,
        IFNULL(CONVERT( `g`.`ISCNT` USING UTF8),
                IFNULL(CONVERT( `f`.`ISCNT` USING UTF8),
                        IFNULL(CONVERT( `e`.`ISCNT` USING UTF8),
                                IFNULL(CONVERT( `d`.`ISCNT` USING UTF8),
                                        IFNULL(CONVERT( `c`.`ISCNT` USING UTF8),
                                                IFNULL(CONVERT( `b`.`ISCNT` USING UTF8),
                                                        IFNULL(CONVERT( `a`.`ISCNT` USING UTF8), ''))))))) AS `ISCNT`,
        IFNULL(CONVERT( `g`.`ISDEL` USING UTF8),
                IFNULL(CONVERT( `f`.`ISDEL` USING UTF8),
                        IFNULL(CONVERT( `e`.`ISDEL` USING UTF8),
                                IFNULL(CONVERT( `d`.`ISDEL` USING UTF8),
                                        IFNULL(CONVERT( `c`.`ISDEL` USING UTF8),
                                                IFNULL(CONVERT( `b`.`ISDEL` USING UTF8),
                                                        IFNULL(CONVERT( `a`.`ISDEL` USING UTF8), ''))))))) AS `ISDEL`,
        `a1`.`SITE_NM` AS `SITE_NM`,
        `a`.`MENU_NM` AS `MENU_DEPTH1`,
        `a`.`MENU_ID` AS `MENU_ID1`,
        `b`.`MENU_NM` AS `MENU_DEPTH2`,
        `b`.`MENU_ID` AS `MENU_ID2`,
        `c`.`MENU_NM` AS `MENU_DEPTH3`,
        `c`.`MENU_ID` AS `MENU_ID3`,
        `d`.`MENU_NM` AS `MENU_DEPTH4`,
        `d`.`MENU_ID` AS `MENU_ID4`,
        `e`.`MENU_NM` AS `MENU_DEPTH5`,
        `e`.`MENU_ID` AS `MENU_ID5`,
        `f`.`MENU_NM` AS `MENU_DEPTH6`,
        `f`.`MENU_ID` AS `MENU_ID6`,
        `g`.`MENU_NM` AS `MENU_DEPTH7`,
        `g`.`MENU_ID` AS `MENU_ID7`,
        CONCAT(CONVERT( IF((`a1`.`SITE_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`a1`.`SITE_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`a`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`a`.`MENU_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`b`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`b`.`MENU_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`c`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`c`.`MENU_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`d`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`d`.`MENU_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`e`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`e`.`MENU_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`f`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`f`.`MENU_PATH`, '') USING UTF8MB4),
                CONVERT( IF((`g`.`MENU_PATH` <> ''), '/', '') USING UTF8MB4),
                CONVERT( IFNULL(`g`.`MENU_PATH`, '') USING UTF8MB4),
                '/') AS `MENU_URL`
    FROM
        (((((((`JNITCMSSITE` `a1`
        JOIN `JNITCMSMENU` `a` ON (((`a`.`SITE_ID` = `a1`.`SITE_ID`)
            AND (`a`.`DEPTH` = 0))))
        LEFT JOIN `JNITCMSMENU` `b` ON (((`b`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`b`.`PID` = `a`.`MENU_ID`))))
        LEFT JOIN `JNITCMSMENU` `c` ON (((`c`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`c`.`PID` = `b`.`MENU_ID`))))
        LEFT JOIN `JNITCMSMENU` `d` ON (((`d`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`d`.`PID` = `c`.`MENU_ID`))))
        LEFT JOIN `JNITCMSMENU` `e` ON (((`e`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`e`.`PID` = `d`.`MENU_ID`))))
        LEFT JOIN `JNITCMSMENU` `f` ON (((`f`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`f`.`PID` = `e`.`MENU_ID`))))
        LEFT JOIN `JNITCMSMENU` `g` ON (((`g`.`SITE_ID` = `a`.`SITE_ID`)
            AND (`g`.`PID` = `f`.`MENU_ID`))));

/**********************************/
/* Table Name: jnitmenu_vt */
/**********************************/
CREATE
    ALGORITHM = UNDEFINED
    SQL SECURITY DEFINER
VIEW `JNITMENU_VT` AS
    SELECT
        `b`.`MENU_SEQ` AS `MENU_SEQ`,
        `a`.`SITE_NM` AS `SITE_NM`,
        `a`.`MENU_DEPTH1` AS `MENU_DEPTH1`,
        `a`.`MENU_DEPTH2` AS `MENU_DEPTH2`,
        `a`.`MENU_DEPTH3` AS `MENU_DEPTH3`,
        `a`.`MENU_DEPTH4` AS `MENU_DEPTH4`,
        `a`.`MENU_DEPTH5` AS `MENU_DEPTH5`,
        `a`.`MENU_DEPTH6` AS `MENU_DEPTH6`,
        `a`.`MENU_DEPTH7` AS `MENU_DEPTH7`,
        `a`.`MENU_URL` AS `MENU_URL`,
        `b`.`MENU_DEPT` AS `MENU_DEPT`,
        `b`.`MENU_PART` AS `MENU_PART`,
        `b`.`MENU_TEL` AS `MENU_TEL`,
        `b`.`MENU_MEMID` AS `MENU_MEMID`,
        `a`.`METHOD` AS `METHOD`
    FROM
        (`JNITCMSMENU_VT` `a`
        LEFT JOIN `JNITMENU` `b` ON ((CONVERT( `b`.`MENU_URL` USING UTF8MB4) = `a`.`MENU_URL`)))
    WHERE
        ((`a`.`ISCNT` = 1) AND (`a`.`ISDEL` = 0))
    ORDER BY `a`.`SITE_ID` , `a`.`METHOD` , `a`.`DEPTH`;


/**********************************/
/* Table Name: 메뉴테이블 */
/**********************************/
CREATE TABLE JNITCMSMENUTREE(
		MENU_CODE_ID                  		VARCHAR(100)		 NOT NULL COMMENT '메뉴ID',
		MENU_ID                       		VARCHAR(100)		 DEFAULT 0		 NULL  COMMENT '메뉴코드',
		MENU_NAME                     		VARCHAR(200)		 NULL  COMMENT '메뉴명',
		MENU_LINK                     		VARCHAR(255)		 NULL  COMMENT '메뉴링크',
		MENU_DEPTH                    		INT(1)		 DEFAULT 1		 NULL  COMMENT '메뉴뎁스',
		MENU_ICON                     		VARCHAR(100)		 NULL  COMMENT '메뉴아이콘',
		MENU_ACTIVE                   		BOOL		 NULL  COMMENT '활성화',
		MENU_PARENT                   		VARCHAR(100)		 NULL  COMMENT '부모노드',
		MENU_CHILD                    		BOOL		 NULL  COMMENT '자식노드유무',
		CREATED_MBR_ID						VARCHAR(50)		 NULL  COMMENT '생성자',
		MODIFIED_MBR_ID						VARCHAR(50)		 NULL  COMMENT '수정자',
		CREATED                       		DATETIME		 NULL  COMMENT '생성일',
		MODIFIED                      		DATETIME		 NULL  COMMENT '수정일',
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL  COMMENT 'ISDEL'
) COMMENT='메뉴테이블';


ALTER TABLE JNITCMSMENUTREE ADD CONSTRAINT IDX_JNITCMSMENUTREE_PK PRIMARY KEY (MENU_CODE_ID);

/**********************************/
/* Table Name: 최근게시물데이터 */
/**********************************/
CREATE TABLE JNITBOARDDATA(
		DATA_ID                       		VARCHAR(20)		 NOT NULL ,
		DATA_NM                       		VARCHAR(250)		 NOT NULL ,
		DATA_BOARD_IDS                		TEXT		 NULL,
		DATA_CATEGORY                       VARCHAR(250)	NULL ,
		DATA_ORDER                    		INT(1)		 NULL  ,
		DATA_LIMIT                    		INT(3)		 NULL  ,
		CREATED                       		DATETIME		 NULL  ,
		MODIFIED                      		DATETIME		 NULL  ,
		ISDEL                         		INT(1)		 DEFAULT 0
);


ALTER TABLE JNITBOARDDATA ADD CONSTRAINT IDX_JNITBOARDDATA_PK PRIMARY KEY (DATA_ID);
