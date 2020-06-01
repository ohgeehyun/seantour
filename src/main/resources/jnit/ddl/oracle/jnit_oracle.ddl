/**********************************/
/* Table Name: SEQ키관리테이블 */
/**********************************/
CREATE TABLE JNITSEQ(
		TABLE_NAME                    		VARCHAR2(50)		 NOT NULL,
		NEXT_ID                       		NUMBER(38)		 NULL 
);

COMMENT ON TABLE JNITSEQ is 'SEQ키관리테이블';
COMMENT ON COLUMN JNITSEQ.TABLE_NAME is '테이블명';
COMMENT ON COLUMN JNITSEQ.NEXT_ID is 'SEQ키';



ALTER TABLE JNITSEQ ADD CONSTRAINT IDX_JNITSEQ_PK PRIMARY KEY (TABLE_NAME);

