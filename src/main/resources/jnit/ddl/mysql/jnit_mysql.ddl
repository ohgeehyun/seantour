/**********************************/
/* Table Name: SEQ키관리테이블 */
/**********************************/
CREATE TABLE JNITSEQ(
		TABLE_NAME                    		VARCHAR(50)		 NOT NULL COMMENT '테이블명',
		NEXT_ID                       		INT(38)		 DEFAULT 0		 NULL  COMMENT 'SEQ키'
) COMMENT='SEQ키관리테이블';


ALTER TABLE JNITSEQ ADD CONSTRAINT IDX_JNITSEQ_PK PRIMARY KEY (TABLE_NAME);

