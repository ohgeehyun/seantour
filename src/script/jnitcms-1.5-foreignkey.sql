
--
-- Constraints for dumped tables
--

--
-- Constraints for table `jnitbbscmt`
--
ALTER TABLE `jnitbbscmt`
  ADD CONSTRAINT `IDX_JNITBBSCMT_FK0` FOREIGN KEY (`BBS_ID`) REFERENCES `jnitbbsinfo` (`BBS_ID`);

--
-- Constraints for table `jnitbbsfile`
--
ALTER TABLE `jnitbbsfile`
  ADD CONSTRAINT `IDX_JNITBBSFILE_FK0` FOREIGN KEY (`BBS_ID`) REFERENCES `jnitbbsinfo` (`BBS_ID`);

--
-- Constraints for table `jnitcmscnt`
--
ALTER TABLE `jnitcmscnt`
  ADD CONSTRAINT `IDX_JNITCMSCNT_FK0` FOREIGN KEY (`SITE_ID`, `MENU_ID`) REFERENCES `jnitcmsmenu` (`SITE_ID`, `MENU_ID`);

--
-- Constraints for table `jnitcmsmbr`
--
ALTER TABLE `jnitcmsmbr`
  ADD CONSTRAINT `IDX_JNITCMSMBR_FK0` FOREIGN KEY (`POS_ID`) REFERENCES `jnitcmspos` (`POS_ID`),
  ADD CONSTRAINT `IDX_JNITCMSMBR_FK1` FOREIGN KEY (`ORG_ID`) REFERENCES `jnitcmsorg` (`ORG_ID`),
  ADD CONSTRAINT `IDX_JNITCMSMBR_FK2` FOREIGN KEY (`TYPE_ID`) REFERENCES `jnitcmsmbrtype` (`TYPE_ID`);

--
-- Constraints for table `jnitcmsmenu`
--
ALTER TABLE `jnitcmsmenu`
  ADD CONSTRAINT `JNITCMSMENU_ibfk_1` FOREIGN KEY (`SITE_ID`) REFERENCES `jnitcmssite` (`SITE_ID`);

--
-- Constraints for table `jnitcmsmenumgr`
--
ALTER TABLE `jnitcmsmenumgr`
  ADD CONSTRAINT `IDX_JNITCMSMENUMGR_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`),
  ADD CONSTRAINT `IDX_JNITCMSMENUMGR_FK1` FOREIGN KEY (`SITE_ID`, `MENU_ID`) REFERENCES `jnitcmsmenu` (`SITE_ID`, `MENU_ID`);

--
-- Constraints for table `jnitcmstpl`
--
ALTER TABLE `jnitcmstpl`
  ADD CONSTRAINT `IDX_JNITCMSTPL_FK0` FOREIGN KEY (`SITE_ID`) REFERENCES `jnitcmssite` (`SITE_ID`);

--
-- Constraints for table `jnitcultarea`
--
ALTER TABLE `jnitcultarea`
  ADD CONSTRAINT `IDX_JNITCULTAREA_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultcourse`
--
ALTER TABLE `jnitcultcourse`
  ADD CONSTRAINT `IDX_JNITCULTCOURSE_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultcoursedata`
--
ALTER TABLE `jnitcultcoursedata`
  ADD CONSTRAINT `IDX_JNITCULTCOURSEDATA_FK0` FOREIGN KEY (`COURSE_ID`) REFERENCES `jnitcultcourse` (`COURSE_ID`),
  ADD CONSTRAINT `IDX_JNITCULTCOURSEDATA_FK1` FOREIGN KEY (`TOUR_ID`) REFERENCES `jnitculttour` (`TOUR_ID`);

--
-- Constraints for table `jnitcultcourseimg`
--
ALTER TABLE `jnitcultcourseimg`
  ADD CONSTRAINT `IDX_JNITCULTCOURSEIMG_FK0` FOREIGN KEY (`COURSE_ID`) REFERENCES `jnitcultcourse` (`COURSE_ID`);

--
-- Constraints for table `jnitcultfood`
--
ALTER TABLE `jnitcultfood`
  ADD CONSTRAINT `IDX_JNITCULTFOOD_FK0` FOREIGN KEY (`AREA_ID`) REFERENCES `jnitcultarea` (`AREA_ID`),
  ADD CONSTRAINT `IDX_JNITCULTFOOD_FK1` FOREIGN KEY (`ZONE_ID`) REFERENCES `jnitcultzone` (`ZONE_ID`),
  ADD CONSTRAINT `IDX_JNITCULTFOOD_FK2` FOREIGN KEY (`ORIGIN_ID`) REFERENCES `jnitcultorigin` (`ORIGIN_ID`),
  ADD CONSTRAINT `IDX_JNITCULTFOOD_FK3` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultfoodmenu`
--
ALTER TABLE `jnitcultfoodmenu`
  ADD CONSTRAINT `IDX_JNITCULTFOODMENU_FK0` FOREIGN KEY (`FOOD_ID`) REFERENCES `jnitcultfood` (`FOOD_ID`);

--
-- Constraints for table `jnitcultfstv`
--
ALTER TABLE `jnitcultfstv`
  ADD CONSTRAINT `IDX_JNITCULTFSTV_FK0` FOREIGN KEY (`AREA_ID`) REFERENCES `jnitcultarea` (`AREA_ID`),
  ADD CONSTRAINT `IDX_JNITCULTFSTV_FK1` FOREIGN KEY (`ZONE_ID`) REFERENCES `jnitcultzone` (`ZONE_ID`),
  ADD CONSTRAINT `IDX_JNITCULTFSTV_FK2` FOREIGN KEY (`ORIGIN_ID`) REFERENCES `jnitcultorigin` (`ORIGIN_ID`),
  ADD CONSTRAINT `IDX_JNITCULTFSTV_FK3` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultfstvimg`
--
ALTER TABLE `jnitcultfstvimg`
  ADD CONSTRAINT `IDX_JNITCULTFSTVIMG_FK0` FOREIGN KEY (`FSTV_ID`) REFERENCES `jnitcultfstv` (`FSTV_ID`);

--
-- Constraints for table `jnitcultorigin`
--
ALTER TABLE `jnitcultorigin`
  ADD CONSTRAINT `IDX_JNITCULTORIGIN_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultshop`
--
ALTER TABLE `jnitcultshop`
  ADD CONSTRAINT `IDX_JNITCULTSHOP_FK0` FOREIGN KEY (`AREA_ID`) REFERENCES `jnitcultarea` (`AREA_ID`),
  ADD CONSTRAINT `IDX_JNITCULTSHOP_FK1` FOREIGN KEY (`ZONE_ID`) REFERENCES `jnitcultzone` (`ZONE_ID`),
  ADD CONSTRAINT `IDX_JNITCULTSHOP_FK2` FOREIGN KEY (`ORIGIN_ID`) REFERENCES `jnitcultorigin` (`ORIGIN_ID`),
  ADD CONSTRAINT `IDX_JNITCULTSHOP_FK3` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultshopinfo`
--
ALTER TABLE `jnitcultshopinfo`
  ADD CONSTRAINT `IDX_JNITCULTSHOPINFO_FK0` FOREIGN KEY (`SHOP_ID`) REFERENCES `jnitcultshop` (`SHOP_ID`);

--
-- Constraints for table `jnitcultstay`
--
ALTER TABLE `jnitcultstay`
  ADD CONSTRAINT `IDX_JNITCULTSTAY_FK0` FOREIGN KEY (`AREA_ID`) REFERENCES `jnitcultarea` (`AREA_ID`),
  ADD CONSTRAINT `IDX_JNITCULTSTAY_FK1` FOREIGN KEY (`ZONE_ID`) REFERENCES `jnitcultzone` (`ZONE_ID`),
  ADD CONSTRAINT `IDX_JNITCULTSTAY_FK2` FOREIGN KEY (`ORIGIN_ID`) REFERENCES `jnitcultorigin` (`ORIGIN_ID`),
  ADD CONSTRAINT `IDX_JNITCULTSTAY_FK3` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitcultstayroom`
--
ALTER TABLE `jnitcultstayroom`
  ADD CONSTRAINT `IDX_JNITCULTSTAYROOM_FK0` FOREIGN KEY (`STAY_ID`) REFERENCES `jnitcultstay` (`STAY_ID`);

--
-- Constraints for table `jnitculttour`
--
ALTER TABLE `jnitculttour`
  ADD CONSTRAINT `IDX_JNITCULTTOUR_FK0` FOREIGN KEY (`AREA_ID`) REFERENCES `jnitcultarea` (`AREA_ID`),
  ADD CONSTRAINT `IDX_JNITCULTTOUR_FK1` FOREIGN KEY (`ZONE_ID`) REFERENCES `jnitcultzone` (`ZONE_ID`),
  ADD CONSTRAINT `IDX_JNITCULTTOUR_FK2` FOREIGN KEY (`ORIGIN_ID`) REFERENCES `jnitcultorigin` (`ORIGIN_ID`),
  ADD CONSTRAINT `IDX_JNITCULTTOUR_FK3` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitculttourimg`
--
ALTER TABLE `jnitculttourimg`
  ADD CONSTRAINT `IDX_JNITCULTTOURIMG_FK0` FOREIGN KEY (`TOUR_ID`) REFERENCES `jnitculttour` (`TOUR_ID`);

--
-- Constraints for table `jnitculttourrel`
--
ALTER TABLE `jnitculttourrel`
  ADD CONSTRAINT `IDX_JNITCULTTOURREL_FK0` FOREIGN KEY (`TOUR_ID`) REFERENCES `jnitculttour` (`TOUR_ID`),
  ADD CONSTRAINT `IDX_JNITCULTTOURREL_FK1` FOREIGN KEY (`REL_TOUR_ID`) REFERENCES `jnitculttour` (`TOUR_ID`);

--
-- Constraints for table `jnitculttravel`
--
ALTER TABLE `jnitculttravel`
  ADD CONSTRAINT `IDX_JNITCULTTRAVEL_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitculttraveldata`
--
ALTER TABLE `jnitculttraveldata`
  ADD CONSTRAINT `IDX_JNITCULTTRAVELDATA_FK0` FOREIGN KEY (`TRAVEL_ID`) REFERENCES `jnitculttravel` (`TRAVEL_ID`),
  ADD CONSTRAINT `IDX_JNITCULTTRAVELDATA_FK1` FOREIGN KEY (`COURSE_ID`) REFERENCES `jnitcultcourse` (`COURSE_ID`);

--
-- Constraints for table `jnitculttravelthemes`
--
ALTER TABLE `jnitculttravelthemes`
  ADD CONSTRAINT `IDX_JNITCULTTRAVELTHEMES_FK0` FOREIGN KEY (`TRAVEL_ID`) REFERENCES `jnitculttravel` (`TRAVEL_ID`),
  ADD CONSTRAINT `IDX_JNITCULTTRAVELTHEMES_FK1` FOREIGN KEY (`THEME_ID`) REFERENCES `jnitculttheme` (`THEME_ID`);

--
-- Constraints for table `jnitcultzone`
--
ALTER TABLE `jnitcultzone`
  ADD CONSTRAINT `IDX_JNITCULTZONE_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitrscdata`
--
ALTER TABLE `jnitrscdata`
  ADD CONSTRAINT `IDX_JNITRSCDATA_FK0` FOREIGN KEY (`RSC_ID`) REFERENCES `jnitrsc` (`RSC_ID`);

--
-- Constraints for table `jnitrsvcan`
--
ALTER TABLE `jnitrsvcan`
  ADD CONSTRAINT `IDX_JNITRSVCAN_FK0` FOREIGN KEY (`RSVINFO_ID`) REFERENCES `jnitrsvinfo` (`RSVINFO_ID`);

--
-- Constraints for table `jnitrsvedulist`
--
ALTER TABLE `jnitrsvedulist`
  ADD CONSTRAINT `IDX_JNITRSVEDULIST_FK0` FOREIGN KEY (`EDU_ID`) REFERENCES `jnitrsvedu` (`EDU_ID`);

--
-- Constraints for table `jnitrsvfaclo`
--
ALTER TABLE `jnitrsvfaclo`
  ADD CONSTRAINT `IDX_JNITRSVFACLO_FK0` FOREIGN KEY (`FAMNG_ID`) REFERENCES `jnitrsvfamng` (`FAMNG_ID`);

--
-- Constraints for table `jnitrsvfamng`
--
ALTER TABLE `jnitrsvfamng`
  ADD CONSTRAINT `IDX_JNITRSVFAMNG_FK0` FOREIGN KEY (`FATYP_ID`) REFERENCES `jnitrsvfatyp` (`FATYP_ID`);

--
-- Constraints for table `jnitrsvpay`
--
ALTER TABLE `jnitrsvpay`
  ADD CONSTRAINT `IDX_JNITRSVPAY_FK0` FOREIGN KEY (`RSVINFO_ID`) REFERENCES `jnitrsvinfo` (`RSVINFO_ID`);

--
-- Constraints for table `jnitrsvsta`
--
ALTER TABLE `jnitrsvsta`
  ADD CONSTRAINT `IDX_JNITRSVSTA_FK0` FOREIGN KEY (`FAMNG_ID`) REFERENCES `jnitrsvfamng` (`FAMNG_ID`),
  ADD CONSTRAINT `IDX_JNITRSVSTA_FK1` FOREIGN KEY (`RSVINFO_ID`) REFERENCES `jnitrsvinfo` (`RSVINFO_ID`);

--
-- Constraints for table `jnitrsvthr`
--
ALTER TABLE `jnitrsvthr`
  ADD CONSTRAINT `IDX_JNITRSVTHR_FK0` FOREIGN KEY (`RSVINFO_ID`) REFERENCES `jnitrsvinfo` (`RSVINFO_ID`);

--
-- Constraints for table `jnitucourse`
--
ALTER TABLE `jnitucourse`
  ADD CONSTRAINT `IDX_JNITUCOURSE_FK0` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitucoursecmt`
--
ALTER TABLE `jnitucoursecmt`
  ADD CONSTRAINT `IDX_JNITUCOURSECMT_FK0` FOREIGN KEY (`UCOURSE_ID`) REFERENCES `jnitucourse` (`UCOURSE_ID`),
  ADD CONSTRAINT `IDX_JNITUCOURSECMT_FK1` FOREIGN KEY (`MBR_ID`) REFERENCES `jnitcmsmbr` (`MBR_ID`);

--
-- Constraints for table `jnitucoursedata`
--
ALTER TABLE `jnitucoursedata`
  ADD CONSTRAINT `IDX_JNITUCOURSEDATA_FK0` FOREIGN KEY (`UCOURSE_ID`) REFERENCES `jnitucourse` (`UCOURSE_ID`);
