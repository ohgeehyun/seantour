
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

