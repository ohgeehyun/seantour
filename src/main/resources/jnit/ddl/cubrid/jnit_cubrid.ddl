/**********************************/
/* Table Name: SEQ키관리테이블 */
/**********************************/
CREATE TABLE JNITSEQ(
		TABLE_NAME                    		VARCHAR(50)		 NOT NULL,
		NEXT_ID                       		INT(38)		 NULL
);

ALTER TABLE JNITSEQ ADD CONSTRAINT IDX_JNITSEQ_PK PRIMARY KEY (TABLE_NAME);

