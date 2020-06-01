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

