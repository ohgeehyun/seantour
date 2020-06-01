/**********************************/
/* Table Name: 알리미 그룹 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_GROUP(
		GROUP_ID                      		VARCHAR(20)		 NULL,
		GROUP_NM                      		VARCHAR(255)		 NULL,
		GROUP_WIDTH                   		VARCHAR(255)		 NULL,
		GROUP_HEIGHT                  		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		GROUP_EXT01                   		VARCHAR(255)		 NULL,
		GROUP_EXT02                   		VARCHAR(255)		 NULL,
		GROUP_EXT03                   		INT(10)		 DEFAULT 0		 NULL,
		GROUP_EXT04                   		INT(10)		 DEFAULT 0		 NULL,
		GROUP_TYPE                    		VARCHAR(20)		 NULL,
		GROUP_CLASSNAME               		VARCHAR(255)		 NULL,
		GROUP_DIRECTION               		INT(1)		 DEFAULT 0		 NULL,
		GROUP_CHANGETIME              		INT(4)		 DEFAULT 0		 NULL,
		GROUP_SHOWITEMS               		INT(4)		 DEFAULT 0		 NULL,
		GROUP_TIMERDELAY              		INT(10)		 DEFAULT 0		 NULL,
		GROUP_ANIMATIONDELAY          		INT(10)		 DEFAULT 0		 NULL,
		GROUP_AUTO                    		INT(1)		 DEFAULT 0		 NULL,
		GROUP_CATEGORY                		VARCHAR(50)		 NULL
);

/**********************************/
/* Table Name: 알리미 데이터 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_ITEM(
		ITEM_ID                       		VARCHAR(20)		 NULL,
		GROUP_ID                      		VARCHAR(20)		 NULL,
		ITEM_NM                       		VARCHAR(255)		 NULL,
		ITEM_TYPE                     		VARCHAR(100)		 NULL,
		ITEM_LINK                     		VARCHAR(255)		 NULL,
		ITEM_TARGET                   		VARCHAR(50)		 NULL,
		ITEM_DESCRIPT                 		VARCHAR(255)		 NULL,
		ITEM_MEMO                     		STRING		 NULL,
		ITEM_ACTIVE                   		INT(1)		 DEFAULT 0		 NULL,
		ITEM_STARTDATE                		DATETIME		 NULL,
		ITEM_ENDDATE                  		DATETIME		 NULL,
		ITEM_HTMLCODE                 		STRING		 NULL,
		ITEM_MODE                     		VARCHAR(100)		 NULL,
		ITEM_WIDTH                    		VARCHAR(255)		 NULL,
		ITEM_HEIGHT                   		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		ITEM_EXT01                    		VARCHAR(255)		 NULL,
		ITEM_EXT02                    		VARCHAR(255)		 NULL,
		ITEM_EXT03                    		INT(10)		 DEFAULT 0		 NULL,
		ITEM_EXT04                    		INT(10)		 DEFAULT 0		 NULL,
		ITEM_URL                      		VARCHAR(255)		 NULL,
		ITEM_SORT                     		INT(4)		 DEFAULT 0		 NULL,
		ITEM_ORIGIN                   		VARCHAR(255)		 NULL,
		ITEM_ALT                      		STRING		 NULL,
		ITEM_TOP                      		VARCHAR(255)		 NULL,
		ITEM_RIGHT                    		VARCHAR(255)		 NULL,
		ITEM_EXT05                    		VARCHAR(255)		 NULL,
		ITEM_EXT06                    		VARCHAR(255)		 NULL,
		ITEM_EXT07                    		VARCHAR(255)		 NULL,
		ITEM_EXT08                    		VARCHAR(255)		 NULL,
		ITEM_EXT09                    		VARCHAR(255)		 NULL,
		ITEM_EXT10                    		VARCHAR(255)		 NULL,
		ITEM_EXT11                    		VARCHAR(255)		 NULL,
		ITEM_EXT12                    		VARCHAR(255)		 NULL,
		ITEM_URL_PATH                 		VARCHAR(255)		 NULL
);

/**********************************/
/* Table Name: 알리미 데이터 이미지 파일 테이블 */
/**********************************/
CREATE TABLE JNITALLIM_IMGFILE(
		IMG_ID                        		VARCHAR(20)		 NULL,
		ITEM_ID                       		VARCHAR(20)		 NULL,
		IMG_URL                       		STRING		 NULL,
		IMG_ORIGINNM                  		VARCHAR(255)		 NULL,
		IMG_SORTNUM                   		INT(10)		 DEFAULT 0		 NULL,
		IMG_PATH                      		VARCHAR(255)		 NULL,
		CREATED                       		DATETIME		 NULL,
		MODIFIED                      		DATETIME		 NULL,
		ISDEL                         		INT(1)		 DEFAULT 0		 NULL,
		IMG_EXT01                     		VARCHAR(255)		 NULL,
		IMG_EXT02                     		VARCHAR(255)		 NULL,
		IMG_EXT03                     		INT(10)		 NULL,
		IMG_EXT04                     		INT(10)		 NULL
);

ALTER TABLE JNITALLIM_GROUP ADD CONSTRAINT IDX_JNITALLIM_GROUP_PK PRIMARY KEY (GROUP_ID);

ALTER TABLE JNITALLIM_ITEM ADD CONSTRAINT IDX_JNITALLIM_ITEM_PK PRIMARY KEY (ITEM_ID);
ALTER TABLE JNITALLIM_ITEM ADD CONSTRAINT IDX_JNITALLIM_ITEM_FK0 FOREIGN KEY (GROUP_ID) REFERENCES JNITALLIM_GROUP (GROUP_ID);

ALTER TABLE JNITALLIM_IMGFILE ADD CONSTRAINT IDX_JNITALLIM_IMGFILE_PK PRIMARY KEY (IMG_ID);
ALTER TABLE JNITALLIM_IMGFILE ADD CONSTRAINT IDX_JNITALLIM_IMGFILE_FK0 FOREIGN KEY (ITEM_ID) REFERENCES JNITALLIM_ITEM (ITEM_ID);