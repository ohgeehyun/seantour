/**
 * @version 3.2.0.1
 */
CREATE OR REPLACE VIEW jnitcmscntvt 
(
cnt_id CHARACTER VARYING(20), 
site_id CHARACTER VARYING(10), 
menu_id CHARACTER VARYING(10), 
ismain INTEGER, 
menu_nm CHARACTER VARYING(50), 
menu_path CHARACTER VARYING(100), 
pid CHARACTER VARYING(10), 
[depth] INTEGER DEFAULT 0, 
[method] INTEGER, 
cnt_desc CHARACTER VARYING(1073741823), 
cnt_src CHARACTER VARYING(1073741823), 
tpl_id CHARACTER VARYING(20), 
tpl_nm CHARACTER VARYING(50), 
created DATETIME, 
modified DATETIME, 
isdel INTEGER DEFAULT 0 
)
AS 
SELECT 
	[b].[CNT_ID], 
	[a].[SITE_ID], 
	[a].[MENU_ID], 
	IF(
	
	(
		[d].[CNT_ID] = [b].[CNT_ID] 
	), 1, 0), 
	[a].[MENU_NM], 
	[a].[MENU_PATH], 
	[a].[PID], 
	[a].[DEPTH], 
	[a].[METHOD], 
	[b].[CNT_DESC], 
	[b].[CNT_SRC], 
	[b].[TPL_ID], 
	[c].[TPL_NM], 
	[b].[CREATED], 
	[b].[MODIFIED], 
	[b].[ISDEL] 
FROM 
	[jnitcmscnt] [b] 
	LEFT OUTER JOIN 
	[jnitcmsmenu] [a] 
	ON 
	(
		
	(
		[a].[SITE_ID] = [b].[SITE_ID] 
	)
	AND 
	(
		[a].[MENU_ID] = [b].[MENU_ID] 
	)
	)
	LEFT OUTER JOIN 
	[jnitcmsmenu] [d] 
	ON 
	(
		
	(
		[d].[SITE_ID] = [a].[SITE_ID] 
	)
	AND 
	(
		[d].[MENU_ID] = [a].[PID] 
	)
	)
	LEFT OUTER JOIN 
	[jnitcmstpl] [c] 
	ON 
	(
		[c].[TPL_ID] = [b].[TPL_ID] 
	);


	
	
CREATE 
OR
 REPLACE VIEW jnitcmsmenu_vt(
                             site_id CHARACTER VARYING(10),
                             menu_id CHARACTER VARYING(1),
                             [method] CHARACTER VARYING(1),
                             [depth] CHARACTER VARYING(1),
                             iscnt CHARACTER VARYING(1),
                             isdel CHARACTER VARYING(1),
                             site_nm CHARACTER VARYING(50),
                             menu_depth1 CHARACTER VARYING(50),
                             menu_id1 CHARACTER VARYING(10),
                             menu_depth2 CHARACTER VARYING(50),
                             menu_id2 CHARACTER VARYING(10),
                             menu_depth3 CHARACTER VARYING(50),
                             menu_id3 CHARACTER VARYING(10),
                             menu_depth4 CHARACTER VARYING(50),
                             menu_id4 CHARACTER VARYING(10),
                             menu_depth5 CHARACTER VARYING(50),
                             menu_id5 CHARACTER VARYING(10),
                             menu_depth6 CHARACTER VARYING(50),
                             menu_id6 CHARACTER VARYING(10),
                             menu_depth7 CHARACTER VARYING(50),
                             menu_id7 CHARACTER VARYING(10),
                             menu_url CHARACTER VARYING(1))
    AS 
SELECT
 [a].[SITE_ID],
  IFNULL([g].[MENU_ID],
           IFNULL([f].[MENU_ID],
             IFNULL([e].[MENU_ID],
               IFNULL([d].[MENU_ID],
                 IFNULL([c].[MENU_ID],
                   IFNULL([b].[MENU_ID],
                     IFNULL([a].[MENU_ID],
                      ''))))))),
  LPAD( IFNULL([g].[METHOD],
    IFNULL([f].[METHOD],
      IFNULL([e].[METHOD],
        IFNULL([d].[METHOD],
          IFNULL([c].[METHOD],
            IFNULL([b].[METHOD],
              IFNULL([a].[METHOD],
               ''))))))),
        10,
        '0'),
  IFNULL([g].[DEPTH],
           IFNULL([f].[DEPTH],
             IFNULL([e].[DEPTH],
               IFNULL([d].[DEPTH],
                 IFNULL([c].[DEPTH],
                   IFNULL([b].[DEPTH],
                     IFNULL([a].[DEPTH],
                      ''))))))),
  IFNULL([g].[ISCNT],
           IFNULL([f].[ISCNT],
             IFNULL([e].[ISCNT],
               IFNULL([d].[ISCNT],
                 IFNULL([c].[ISCNT],
                   IFNULL([b].[ISCNT],
                     IFNULL([a].[ISCNT],
                      ''))))))),
  IFNULL([g].[ISDEL],
           IFNULL([f].[ISDEL],
             IFNULL([e].[ISDEL],
               IFNULL([d].[ISDEL],
                 IFNULL([c].[ISDEL],
                   IFNULL([b].[ISDEL],
                     IFNULL([a].[ISDEL],
                      ''))))))),
 [a1].[SITE_NM],
 [a].[MENU_NM],
 [a].[MENU_ID],
 [b].[MENU_NM],
 [b].[MENU_ID],
 [c].[MENU_NM],
 [c].[MENU_ID],
 [d].[MENU_NM],
 [d].[MENU_ID],
 [e].[MENU_NM],
 [e].[MENU_ID],
 [f].[MENU_NM],
 [f].[MENU_ID],
 [g].[MENU_NM],
 [g].[MENU_ID],
  CONCAT( IF(([a1].[SITE_PATH]<>''),
   '/',
   ''),
           IFNULL([a1].[SITE_PATH],
            ''),
           IF(([a].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([a].[MENU_PATH],
            ''),
           IF(([b].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([b].[MENU_PATH],
            ''),
           IF(([c].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([c].[MENU_PATH],
            ''),
           IF(([d].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([d].[MENU_PATH],
            ''),
           IF(([e].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([e].[MENU_PATH],
            ''),
           IF(([f].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([f].[MENU_PATH],
            ''),
           IF(([g].[MENU_PATH]<>''),
            '/',
            ''),
           IFNULL([g].[MENU_PATH],
            ''),
          '/') 
FROM
 [jnitcmssite] [a1] 
INNER JOIN
 [jnitcmsmenu] [a] ON (([a].[SITE_ID]=[a1].[SITE_ID]) 
                       AND
                        ([a].[DEPTH]=0)) 
LEFT OUTER JOIN
 [jnitcmsmenu] [b] ON (([b].[SITE_ID]=[a].[SITE_ID]) 
                       AND
                        ([b].[PID]=[a].[MENU_ID])) 
LEFT OUTER JOIN
 [jnitcmsmenu] [c] ON (([c].[SITE_ID]=[a].[SITE_ID]) 
                       AND
                        ([c].[PID]=[b].[MENU_ID])) 
LEFT OUTER JOIN
 [jnitcmsmenu] [d] ON (([d].[SITE_ID]=[a].[SITE_ID]) 
                       AND
                        ([d].[PID]=[c].[MENU_ID])) 
LEFT OUTER JOIN
 [jnitcmsmenu] [e] ON (([e].[SITE_ID]=[a].[SITE_ID]) 
                       AND
                        ([e].[PID]=[d].[MENU_ID])) 
LEFT OUTER JOIN
 [jnitcmsmenu] [f] ON (([f].[SITE_ID]=[a].[SITE_ID]) 
                       AND
                        ([f].[PID]=[e].[MENU_ID])) 
LEFT OUTER JOIN
 [jnitcmsmenu] [g] ON (([g].[SITE_ID]=[a].[SITE_ID]) 
                       AND
                        ([g].[PID]=[f].[MENU_ID]));


                        
                        
                        
                        
CREATE 
OR
 REPLACE VIEW jnitmenu_vt(
                          menu_seq INTEGER,
                          site_nm CHARACTER VARYING(50),
                          menu_depth1 CHARACTER VARYING(50),
                          menu_depth2 CHARACTER VARYING(50),
                          menu_depth3 CHARACTER VARYING(50),
                          menu_depth4 CHARACTER VARYING(50),
                          menu_depth5 CHARACTER VARYING(50),
                          menu_depth6 CHARACTER VARYING(50),
                          menu_depth7 CHARACTER VARYING(50),
                          menu_url CHARACTER VARYING(1),
                          menu_dept CHARACTER VARYING(100),
                          menu_part CHARACTER VARYING(200),
                          menu_tel CHARACTER VARYING(20),
                          menu_memid CHARACTER VARYING(20),
                          [method] CHARACTER VARYING(1))
    AS 
SELECT
 [b].[MENU_SEQ],
 [a].[SITE_NM],
 [a].[MENU_DEPTH1],
 [a].[MENU_DEPTH2],
 [a].[MENU_DEPTH3],
 [a].[MENU_DEPTH4],
 [a].[MENU_DEPTH5],
 [a].[MENU_DEPTH6],
 [a].[MENU_DEPTH7],
 [a].[MENU_URL],
 [b].[MENU_DEPT],
 [b].[MENU_PART],
 [b].[MENU_TEL],
 [b].[MENU_MEMID],
 [a].[METHOD] 
FROM
 [jnitcmsmenu_vt] [a] 
LEFT OUTER JOIN
 [jnitmenu] [b] ON ([b].[MENU_URL]=[a].[MENU_URL]) 
WHERE
 (([a].[ISCNT]= CAST(1 AS VARCHAR)) 
  AND
   ([a].[ISDEL]= CAST(0 AS VARCHAR))) 
ORDER BY [a].[SITE_ID],
 15,
 [a].[DEPTH];