/**********************************/
/* Table Name: CMS파일서비스 */
/**********************************/
CREATE TABLE `jnitbiguploadfile` (
  `FILE_ID` int(22) NOT NULL,
  `PHSICAL_DIR` varchar(256) DEFAULT NULL,
  `VIEW_FILENAME` varchar(256) DEFAULT NULL,
  `PHSICAL_FILENAME` varchar(256) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT NULL,
  `FILE_SIZE` int(22) DEFAULT NULL,
  PRIMARY KEY (`FILE_ID`)
) 