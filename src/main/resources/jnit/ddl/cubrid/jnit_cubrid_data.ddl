/**
 * @version 3.2.0.1
 */
DELETE FROM `bbs_1000000000000000`;
DELETE FROM `jnitallim_item`;
DELETE FROM `jnitallim_group`;
DELETE FROM `jnitboardcmt`;
DELETE FROM `jnitboardfile`;
DELETE FROM `jnitboardgood`;
DELETE FROM `jnitboardinfo`;
DELETE FROM `jnitboardtpl`;

DELETE FROM `jnitcmsboardhist`;
DELETE FROM `jnitcmsdisseminate`;
DELETE FROM `jnitcmsdisseminatehistory`;
DELETE FROM `jnitcmscsshist`;
DELETE FROM `jnitcmsscripthist`;
DELETE FROM `jnitcmstplhist`;
DELETE FROM `jnitcmshist`;
DELETE FROM `jnitcmstpl`;
DELETE FROM `jnitcmscnt`;
DELETE FROM `jnitcmsmenumgr`;
DELETE FROM `jnitcmsmenu`;
DELETE FROM `jnitcmssite`;
DELETE FROM `jnitcmsmbrpackage`;
DELETE FROM `jnitcmsmbr`;
DELETE FROM `jnitcmsmbrtype`;
DELETE FROM `jnitcmspos`;
DELETE FROM `jnitcmsorg`;
DELETE FROM `jnitcmsmbrlog`;
DELETE FROM `jnitcmsmbrsess`;
DELETE FROM `jnitcmsmgmt`;
DELETE FROM `jnitcmsmgmtitem`;
DELETE FROM `jnitcmsmgmtcategory`;
DELETE FROM `jnitcmsrank`;

DELETE FROM `jnitebookfile`;
DELETE FROM `jnitebook`;

DELETE FROM `jnitloginlog`;
DELETE FROM `jnitmenu`;
DELETE FROM `jnitmgovaddrlist`;
DELETE FROM `jnitmgovaddrgrp`;
DELETE FROM `jnit_ltskorea_sms`;
DELETE FROM `mgov_serial`;

DELETE FROM `jnitresearchrespondent`;
DELETE FROM `jnitresearchcategory`;
DELETE FROM `jnitresearchanswer`;
DELETE FROM `jnitresearchquestion`;
DELETE FROM `jnitresearch`;

DELETE FROM `jnitrscpagedata`;
DELETE FROM `jnitrscpage`;
DELETE FROM `jnitrscdata`;
DELETE FROM `jnitrsc`;

DELETE FROM `jnitscrap`;
DELETE FROM `jnitseq`;
DELETE FROM `jnitsitestate`;
DELETE FROM `jnitsitestatelist`;
DELETE FROM `jnitsmsaddressbook`;
DELETE FROM `jnitvisitcount`;
DELETE FROM `jnitvisitlog`;

DELETE FROM `jnitcmsmenutree`;

/** JNIT SEQ */
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITALLIM_GROUP_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITALLIM_IMGFILE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITALLIM_ITEM_ID', 1);

INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITBOARDCMT_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITBOARDFILE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITBOARDGOOD_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITBOARDINFO_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITBOARDTPL_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSBOARDHIST_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSCNT_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSCSSHIST_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSDISSEMINATEHISTORY_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSDISSEMINATE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSHIST_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMBRLOG_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMBRPACKAGE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMBRSESS_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMENUMGR_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMENU_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMGMTCATEGORY_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMGMTITEM_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMGMT_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSORG_ID', 4);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSPOS_ID', 12);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMBRTYPE_ID', 33);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSMBR_ID', 2);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSRANK_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSSCRIPTHIST_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSSITE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSTPLHIST_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITCMSTPL_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITEBOOKFILE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITEBOOK_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITLOGINLOG_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITMENU_ID', 0);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITMGOVADDRGRP_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITMGOVADDRLIST_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESANSWER_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESEARCHANSWER_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESEARCHCATEGORY_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESEARCHQUESTION_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESEARCHRESPONDENT_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESEARCH_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRESQUESTION_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRSCDATA_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRSCPAGEDATA_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRSCPAGE_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITRSC_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITSCRAP_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITSEQ_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITSMSADDRESSBOOK_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITVISITCOUNT_ID', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('JNITVISITLOG', 1);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('MENUTREE_ID', 114);
INSERT INTO `jnitseq` (table_name, next_id) VALUES ('BOARD_DATA_ID', 1);

/** INSERT ORG TABLE */
INSERT INTO `jnitcmsorg` (org_id, org_nm, created, modified, isdel, org_deth, org_rank, org_rank_odr, connect_type, org_tel) VALUES ('20002', '사이트관리', NOW(), NOW(), 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `jnitcmsorg` (org_id, org_nm, created, modified, isdel, org_deth, org_rank, org_rank_odr, connect_type, org_tel) VALUES ('20003', '기타', NOW(), NOW(), 0, NULL, NULL, 0, NULL, NULL);

/** INSERT POS TABLE */
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10001', '사이트관리자', 1, NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10002', '기타', 10, NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10003', '주무관', 1, NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10004', '사무원', 1, NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10005', '과장', 1, NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10010', '팀장', 1, NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmspos` (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10011', '주임', 1, NOW(), NOW(), 0, NULL);

/** INSERT MBR_TYPE TABLE */
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30003', '기본유형', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30006', '단체회원', 'B', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30012', '일반회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30013', '공인인증 비회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30014', 'G-pin 비회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30015', '실명인증 비회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30016', '탈퇴회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30017', '14세 미만 회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30020', '최고관리자', 'A', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30021', '직원관리자', 'C', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30022', '사이트관리자', 'C', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30023', '개발자그룹', 'C', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30024', '유지보수팀', 'A', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30026', '페이스북회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30029', '아이핀인증회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30028', '실명인증회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30031', '공인인증회원', 'Z', NOW(), NOW(), 0, NULL);
INSERT INTO `jnitcmsmbrtype` (type_id, type_nm, type_lv, created, modified, isdel, menu_active) VALUES ('30032', '기존웹회원', 'Z', NOW(), NOW(), 0, NULL);

/** INSERT MBR TABLE */
INSERT INTO `jnitcmsmbr` (mbr_id, mbr_login, org_id, pos_id, site_id, mbr_nm, mbr_photo, passwd, type_id, tel, mobile, email, sn, dp, created, modified, isdel, homepage, postcode, address, address_new, email_recv, sms_recv, establishment, corporation, primary_key, mutual, corporate_name, group_name, business_place, business_addr, business_addr_new, group_kind, group_tel, group_pax, group_type, grp_confirm, rank_id, work_contents, grade_nm, odr, connect_type, group_title, pw_miscnt, ex01, ex02, ex03)
VALUES ('MBR_0000000001', 'cmsad', '20002', '10001', NULL, '관리자', '', 'E99CEA237C3FF853E04DFBF13EEADA53F6B638EFF1530D4A775C379BFE2B37', '30020', '', '', '', NULL, NULL, NOW(), NOW(), 0, '', '', '', '', 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', NULL, 'Y', '', '', '', 0, NULL, '', 1, '', '', '');

/** INSERT MGOV_SERIAL */
INSERT INTO MGOV_SERIAL VALUES('1');


/** INSERT MENUTREE TABLE */
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000001','m01000000','환경설정','',1,'cog',1,'null',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000002','m01010000','기본설정','',2,'cog',1,'m01000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000003','m01010100','일반설정','/cms/config/default.do',3,'cog',1,'m01010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000004','m01010200','주소 API 설정','/cms/config/apiKey.do',3,'cog',1,'m01010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000005','m01010300','회원가입항목설정','/cms/config/item.do',3,'cog',1,'m01010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000006','m01010400','사이트통계설정','/cms/config/analytics.do',3,'cog',1,'m01010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000007','m01020000','보안설정','/cms/config/secure.do',2,'lock',1,'m01000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000008','m01030000','관리자 메뉴관리','/cms/sub2/020101.do',2,'ban-circle',1,'m01000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000009','m01040000','사이트설정','/cms/sub3/0101.do',2,'desktop',1,'m01000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000010','m01050000','메뉴관리','/jnitcmsmenutree/List.do',2,'cog',1,'m01000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000011','m02000000','회원관리','',1,'hdd',1,'null',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000012','m02010000','조직관리','',2,'sitemap',1,'m02000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000013','m02010100','직급설정','/cms/sub1/0101.do',3,'sitemap',1,'m02010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000014','m02010200','부서설정','/cms/sub1/0201.do',3,'sitemap',1,'m02010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000015','m02010300','직급분류설정','/cms/sub1/0401.do',3,'sitemap',1,'m02010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000016','m02020000','회원관리','',2,'group',1,'m02000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000017','m02020100','회원관리','/cms/sub2/0101.do',3,'group',1,'m02020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000018','m02020200','업체인증관리','/cms/sub2/0101.do?retTypeId=company',3,'group',1,'m02020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000019','m02020300','회원개인정보수정이력','/cms/mbrlog/mbrlogList.do',3,'group',1,'m02020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000020','m02020400','lock회원관리','/cms/sub2/0101.do?retTypeId=lock',3,'group',1,'m02020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000021','m02020500','유형관리','/cms/sub2/0201.do',3,'group',1,'m02020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000022','m03000000','통계','',1,'signal',1,'null',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000023','m03010000','구글연계통계','',2,'bar-chart',1,'m03000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000024','m03010100','시간별 방문자','/analytics.do?mode=time',3,'time',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000025','m03010200','브라우저별 방문자','/analytics.do?mode=browser',3,'apple',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000026','m03010300','OS별 방문자','/analytics.do?mode=os',3,'desktop',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000027','m03010400','일별 방문자','/analytics.do?mode=date',3,'bar-chart',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000028','m03010500','월별 방문자','/analytics.do?mode=month',3,'bar-chart',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000029','m03010600','년별 방문자','/analytics.do?mode=year',3,'bar-chart',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000030','m03010700','사이트별 통계','/analytics.do?mode=pageview',3,'bar-chart',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000031','m03010800','인기도 통계','/analytics.do?mode=popular',3,'bar-chart',1,'m03010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000032','m03020000','관리자접속로그','/login/logList.do',2,'book',1,'m03000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000033','m04000000','템플릿관리','',1,'file',1,'null',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000034','m04010000','템플릿관리','',2,'cog',1,'m04000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000035','m04010100','메인템플릿','/cms/sub4/0101.do',3,'cog',1,'m04010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000036','m04010200','서브템플릿','/cms/sub4/0102.do',3,'cog',1,'m04010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000037','m04010300','로그인템플릿','',3,'off',1,'m04010000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000038','m04010301','로그인','/cms/sub4/0104.do?tplType=C',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000039','m04010302','아이디찾기','/cms/sub4/0104.do?tplType=I',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000040','m04010303','패스워드찾기','/cms/sub4/0104.do?tplType=J',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000041','m04010304','비인증 아이디찾기','/cms/sub4/0104.do?tplType=M',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000042','m04010305','비인증 아이디찾기 결과','/cms/sub4/0104.do?tplType=M1',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000043','m04010306','비인증 패스워드찾기','/cms/sub4/0104.do?tplType=N',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000044','m04010307','비인증 패스워드찾기 결과','/cms/sub4/0104.do?tplType=N1',4,'cog',1,'m04010300',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000045','m04010400','회원템플릿','',3,'user',1,'m04010000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000046','m04010401','회원구분양식','/cms/sub4/0104.do?tplType=K',4,'user',1,'m04010400',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000047','m04010402','회원약관동의','/cms/sub4/0104.do?tplType=D',4,'user',1,'m04010400',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000048','m04010403','회원가입항목입력','/cms/sub4/0104.do?tplType=E',4,'user',1,'m04010400',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000049','m04010404','회원가입완료','/cms/sub4/0104.do?tplType=F',4,'user',1,'m04010400',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000050','m04010405','마이페이지','/cms/sub4/0104.do?tplType=G',4,'user',1,'m04010400',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000051','m04010406','회원탈퇴','/cms/sub4/0104.do?tplType=H',4,'user',1,'m04010400',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000052','m04020000','템플릿관리','',2,'file',1,'m04000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000053','m04020100','콘텐츠영역 바로가기','/cms/page/templateShortCut.do',3,'list',1,'m04020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000054','m04020200','페이지평가템플릿','',3,'bar-chart',1,'m04020000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000055','m04020201','페이지평가통계','/cms/rsc/page.do',4,'bar-chart',1,'m04020200',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000056','m04020202','평가페이지디자인','/cms/rsc/jspPage.do?bindType=addPage',4,'code',1,'m04020200',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000057','m04020203','결과페이지디자인','/cms/rsc/jspPage.do?bindType=upPage',4,'code',1,'m04020200',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000058','m04020300','좌측메뉴','/cms/page/view.do?bindType=leftMenu',3,'list',1,'m04020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000059','m04020400','상단메뉴','/cms/page/view.do?bindType=topMenu',3,'th-large',1,'m04020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000060','m04020500','콘텐츠담당표시','/cms/page/view.do?bindType=contentAdmin',3,'user',1,'m04020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000061','m04020600','수정버튼표시','/cms/page/view.do?bindType=updateButton',3,'wrench',1,'m04020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000062','m04020700','사이트맵디자인','/cms/page/view.do?bindType=sitemap',3,'info-sign',1,'m04020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000063','m05000000','콘텐츠관리','',1,'file-text-alt',1,'null',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000064','m05010000','메뉴/콘텐츠관리','/cms/sub10/0101.do',2,'file-text-alt',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000065','m05020000','웹접근성관리','/cms/sub8/0101.do',2,'warning-sign',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000066','m05030000','CSS관리','/cms/mgmt/list.do?mgmtType=css',2,'eye-open',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000067','m05040000','스크립트관리','/cms/mgmt/list.do?mgmtType=js',2,'cogs',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000068','m05050000','이미지관리','/cms/mgmt/list.do?mgmtType=img',2,'picture',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000069','m05060000','동영상관리','/cms/mgmt/list.do?mgmtType=video',2,'facetime-video',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000070','m05070000','첨부파일관리','/cms/mgmt/list.do?mgmtType=file',2,'save',1,'m05000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000071','m06000000','컴포넌트관리','',1,'th-large',1,'null',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000072','m06010000','게시판관리','',2,'list-alt',1,'m06000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000073','m06010100','게시판설정','/cms/board/list.do',3,'list',1,'m06010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000074','m06010200','게시판공통스크립트','/cms/board/pageView.do',3,'cogs',1,'m06010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000075','m06010300','게시판 디자인','/cms/board/skinList.do',3,'code',1,'m06010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000076','m06010400','게시글 관리','/cms/mgmt/board/list.do',3,'file-text-alt',1,'m06010000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000077','m06010500','최근게시물 관리','',3,'file-text-alt',1,'m06010000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000078','m06010501','최근게시물디자인','/cms/mgmt/list.do?mgmtType=boardLatest',4,'th-list',1,'m06010500',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000079','m06010502','최근게시물설정','/jnit/boardData/index.do',4,'cog',1,'m06010500',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000080','m06020000','배너관리','',2,'picture',1,'m06000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000081','m06020100','배너설정','/cms/allim/groupList.do?type=banner',3,'copy',1,'m06020000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000082','m06020200','배너디자인','',3,'code',1,'m06020000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000083','m06020201','배너메인','/cms/page/view.do?bindType=bannerRolling',4,'copy',1,'m06020200',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000084','m06020202','배너더보기','/cms/page/view.do?bindType=bannerMore',4,'code',1,'m06020200',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000085','m06030000','알리미관리','',2,'picture',1,'m06000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000086','m06030100','알리미설정','/cms/allim/groupList.do?type=allim',3,'copy',1,'m06030000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000087','m06030200','알리미디자인','/cms/page/view.do?bindType=allimView',3,'code',1,'m06030000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000088','m06040000','팝업관리','',2,'picture',1,'m06000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000089','m06040100','팝업설정','/cms/allim/groupList.do?type=popup',3,'copy',1,'m06040000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000090','m06040200','팝업디자인','/cms/page/view.do?bindType=PopupView',3,'code',1,'m06040000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000091','m06050000','통합검색관리','/cms/search/total.do',2,'search',1,'m06000000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000092','m06060000','SMS관리','',2,'envelope',1,'m06000000',1,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000093','m06060100','SMS 설정','/cms/config/sms.do',3,'envelope',1,'m06060000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000094','m06060200','SMS 보내기','/cms/sms/sendMessage.do',3,'envelope',1,'m06060000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000095','m06060300','SMS 주소록','/cms/mgov/addrList.do',3,'user',1,'m06060000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000096','m06060400','SMS 전송내역','/cms/sms/list.do',3,'inbox',1,'m06060000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);
INSERT INTO `jnitcmsmenutree` VALUES ('MENU_000000097','m06060500','LMS 전송내역','/cms/lms/list.do',3,'inbox',1,'m06060000',0,'MBR_0000000001','MBR_0000000001',SYSDATETIME,SYSDATETIME,0);

update jnitseq set NEXT_ID = '1000' where TABLE_NAME = 'MENUTREE_ID';