/**
 * @version 3.2.0.1
 */
/**
 * 이클립스로 돌리시 SID는 지우시기 바랍니다. 
 */
DELETE FROM  BBS_1000000000000000;
DELETE FROM  JNITALLIM_IMGFILE;
DELETE FROM  JNITALLIM_ITEM;
DELETE FROM  JNITALLIM_GROUP;
DELETE FROM  JNITBOARDCMT;
DELETE FROM  JNITBOARDFILE;
DELETE FROM  JNITBOARDGOOD;
DELETE FROM  JNITBOARDINFO;
DELETE FROM  JNITBOARDTPL;
DELETE FROM  JNITCMSBOARDHIST;
DELETE FROM  JNITCMSDISSEMINATE;
DELETE FROM  JNITCMSDISSEMINATEHISTORY;
DELETE FROM  JNITCMSCSSHIST;
DELETE FROM  JNITCMSSCRIPTHIST;
DELETE FROM  JNITCMSTPLHIST;
DELETE FROM  JNITCMSHIST;
DELETE FROM  JNITCMSTPL;
DELETE FROM  JNITCMSCNT;
DELETE FROM  JNITCMSMENUMGR;
DELETE FROM  JNITCMSMENU;
DELETE FROM  JNITCMSSITE;
DELETE FROM  JNITCMSMBRPACKAGE;
DELETE FROM  JNITCMSMBR;
DELETE FROM  JNITCMSMBRTYPE;
DELETE FROM  JNITCMSPOS;
DELETE FROM  JNITCMSORG;
DELETE FROM  JNITCMSMBRLOG;
DELETE FROM  JNITCMSMBRSESS;
DELETE FROM  JNITCMSMGMT;
DELETE FROM  JNITCMSMGMTITEM;
DELETE FROM  JNITCMSMGMTCATEGORY;
DELETE FROM  JNITCMSRANK;
DELETE FROM  JNITEBOOKFILE;
DELETE FROM  JNITEBOOK;
DELETE FROM  JNITLOGINLOG;
DELETE FROM  JNITMENU;
DELETE FROM  JNITMGOVADDRLIST;
DELETE FROM  JNITMGOVADDRGRP;
DELETE FROM  MGOV_SERIAL;
DELETE FROM  JNIT_LTSKOREA_SMS;
DELETE FROM  JNITRESEARCHRESPONDENT;
DELETE FROM  JNITRESEARCHCATEGORY;
DELETE FROM  JNITRESEARCHANSWER;
DELETE FROM  JNITRESEARCHQUESTION;
DELETE FROM  JNITRESEARCH;
DELETE FROM  JNITRSCPAGEDATA;
DELETE FROM  JNITRSCPAGE;
DELETE FROM  JNITRSCDATA;
DELETE FROM  JNITRSC;
DELETE FROM  JNITSCRAP;
DELETE FROM  JNITSEQ;
DELETE FROM  JNITSITESTATE;
DELETE FROM  JNITSITESTATELIST;
DELETE FROM  JNITSMSADDRESSBOOK;
DELETE FROM  JNITVISITCOUNT;
DELETE FROM  JNITVISITLOG;

/** JNIT SEQ */
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITALLIM_GROUP_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITALLIM_IMGFILE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITALLIM_ITEM_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITBOARDCMT_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITBOARDFILE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITBOARDGOOD_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITBOARDINFO_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITBOARDTPL_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSBOARDHIST_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSCNT_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSCSSHIST_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSDISSEMINATEHISTORY_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSDISSEMINATE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSHIST_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMBRLOG_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMBRPACKAGE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMBRSESS_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMENUMGR_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMENU_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMGMTCATEGORY_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMGMTITEM_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMGMT_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSORG_ID', 4);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSPOS_ID', 12);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMBRTYPE_ID', 33);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSMBR_ID', 2);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSRANK_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSSCRIPTHIST_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSSITE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSTPLHIST_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITCMSTPL_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITEBOOKFILE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITEBOOK_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITLOGINLOG_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITMENU_ID', 0);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITMGOVADDRGRP_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITMGOVADDRLIST_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESANSWER_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESEARCHANSWER_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESEARCHCATEGORY_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESEARCHQUESTION_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESEARCHRESPONDENT_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESEARCH_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRESQUESTION_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRSCDATA_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRSCPAGEDATA_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRSCPAGE_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITRSC_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITSCRAP_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITSEQ_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITSMSADDRESSBOOK_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITVISITCOUNT_ID', 1);
INSERT INTO jnitseq (table_name, next_id) VALUES ('JNITVISITLOG', 1);

/** INSERT ORG TABLE */
INSERT INTO jnitcmsorg (org_id, org_nm, created, modified, isdel, org_deth, org_rank, org_rank_odr, connect_type, org_tel) VALUES ('20002', '사이트관리', SYSDATE, SYSDATE, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO jnitcmsorg (org_id, org_nm, created, modified, isdel, org_deth, org_rank, org_rank_odr, connect_type, org_tel) VALUES ('20003', '기타', SYSDATE, SYSDATE, 0, NULL, NULL, 0, NULL, NULL);

/** INSERT POS TABLE */
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10001', '사이트관리자', 1, SYSDATE, SYSDATE, 0, NULL);
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10002', '기타', 10, SYSDATE, SYSDATE, 0, NULL);
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10003', '주무관', 1, SYSDATE, SYSDATE, 0, NULL);
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10004', '사무원', 1, SYSDATE, SYSDATE, 0, NULL);
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10005', '과장', 1, SYSDATE, SYSDATE, 0, NULL);
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10010', '팀장', 1, SYSDATE, SYSDATE, 0, NULL);
INSERT INTO jnitcmspos (pos_id, pos_nm, pos_lv, created, modified, isdel, connect_type) VALUES ('10011', '주임', 1, SYSDATE, SYSDATE, 0, NULL);

/** INSERT MBR_TYPE TABLE */
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30003', '기본유형', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30006', '단체회원', 'B', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30012', '일반회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30013', '공인인증 비회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30014', 'G-pin 비회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30015', '실명인증 비회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30016', '탈퇴회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30017', '14세 미만 회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30020', '최고관리자', 'A', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30021', '직원관리자', 'C', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30022', '사이트관리자', 'C', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30023', '개발자그룹', 'C', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30024', '유지보수팀', 'A', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30026', '페이스북회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30029', '아이핀인증회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30028', '실명인증회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30031', '공인인증회원', 'Z', SYSDATE, SYSDATE, 0);
INSERT INTO jnitcmsmbrtype (type_id, type_nm, type_lv, created, modified, isdel) VALUES ('30032', '기존웹회원', 'Z', SYSDATE, SYSDATE, 0);

/** INSERT MBR TABLE */
INSERT INTO jnitcmsmbr (mbr_id, mbr_login, org_id, pos_id, site_id, mbr_nm, mbr_photo, passwd, type_id, tel, mobile, email, sn, dp, created, modified, isdel, homepage, postcode, address, address_new, email_recv, sms_recv, establishment, corporation, primary_key, mutual, corporate_name, group_name, business_place, business_addr, business_addr_new, group_kind, group_tel, group_pax, group_type, grp_confirm, rank_id, work_contents, grade_nm, odr, connect_type, group_title, pw_miscnt, ex01, ex02, ex03) 
VALUES ('MBR_0000000001', 'cmsad', '20002', '10001', NULL, '관리자', '', 'E99CEA237C3FF853E04DFBF13EEADA53F6B638EFF1530D4A775C379BFE2B37', '30020', '', '', '', NULL, NULL, SYSDATE, SYSDATE, 0, '', '', '', '', 0, 0, '', '', '', '', '', '', '', '', '', '', '', '', NULL, 'Y', '', '', '', 0, NULL, '', 1, '', '', '');

/** INSERT MGOV_SERIAL */
INSERT INTO MGOV_SERIAL VALUES('1');