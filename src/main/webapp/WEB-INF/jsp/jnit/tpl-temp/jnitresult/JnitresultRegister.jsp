<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : JnitresultRegister.jsp
  * @Description : Jnitresult Register 화면
  * @Modification Information
  * 
  * @author JNITRESULT2
  * @since 2014.01.20
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>1234 </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitresultVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitresultVO").action = "<c:url value='/jnitresult/JnitresultList.do'/>";
   	document.getElementById("jnitresultVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitresultVO").action = "<c:url value='/jnitresult/deleteJnitresult.do'/>";
   	document.getElementById("jnitresultVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitresultVO");
	frm.action = "<c:url value='/jnitresult/addJnitresult.do'/>";
	frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitresultVO">
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/rte/title_dot.gif'/>" alt="" /><c:out value="${registerFlag}"/></li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="table">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
			
		
		<tr>
			<th>MBR_ID</th>
			<td>
				<form:input path="mbrId" cssClass="txt"/>
				&nbsp;<form:errors path="mbrId" />
			</td>
		</tr>	
		<tr>
			<th>ADMIN_ID</th>
			<td>
				<form:input path="adminId" cssClass="txt"/>
				&nbsp;<form:errors path="adminId" />
			</td>
		</tr>	
		<tr>
			<th>RESULT_TYPE</th>
			<td>
				<form:input path="resultType" cssClass="txt"/>
				&nbsp;<form:errors path="resultType" />
			</td>
		</tr>	
		<tr>
			<th>RESULT_STATE</th>
			<td>
				<form:input path="resultState" cssClass="txt"/>
				&nbsp;<form:errors path="resultState" />
			</td>
		</tr>	
		<tr>
			<th>ADMIN_STATE</th>
			<td>
				<form:input path="adminState" cssClass="txt"/>
				&nbsp;<form:errors path="adminState" />
			</td>
		</tr>	
		<tr>
			<th>RESULT_WHY</th>
			<td>
				<form:input path="resultWhy" cssClass="txt"/>
				&nbsp;<form:errors path="resultWhy" />
			</td>
		</tr>	

		<tr>
			<th>COLUMN_13</th>
			<td>
				<form:input path="column13" cssClass="txt"/>
				&nbsp;<form:errors path="column13" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_14</th>
			<td>
				<form:input path="column14" cssClass="txt"/>
				&nbsp;<form:errors path="column14" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_15</th>
			<td>
				<form:input path="column15" cssClass="txt"/>
				&nbsp;<form:errors path="column15" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_16</th>
			<td>
				<form:input path="column16" cssClass="txt"/>
				&nbsp;<form:errors path="column16" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_17</th>
			<td>
				<form:input path="column17" cssClass="txt"/>
				&nbsp;<form:errors path="column17" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_18</th>
			<td>
				<form:input path="column18" cssClass="txt"/>
				&nbsp;<form:errors path="column18" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_19</th>
			<td>
				<form:input path="column19" cssClass="txt"/>
				&nbsp;<form:errors path="column19" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_20</th>
			<td>
				<form:input path="column20" cssClass="txt"/>
				&nbsp;<form:errors path="column20" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_21</th>
			<td>
				<form:input path="column21" cssClass="txt"/>
				&nbsp;<form:errors path="column21" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_22</th>
			<td>
				<form:input path="column22" cssClass="txt"/>
				&nbsp;<form:errors path="column22" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_23</th>
			<td>
				<form:input path="column23" cssClass="txt"/>
				&nbsp;<form:errors path="column23" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_24</th>
			<td>
				<form:input path="column24" cssClass="txt"/>
				&nbsp;<form:errors path="column24" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_25</th>
			<td>
				<form:input path="column25" cssClass="txt"/>
				&nbsp;<form:errors path="column25" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_26</th>
			<td>
				<form:input path="column26" cssClass="txt"/>
				&nbsp;<form:errors path="column26" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_27</th>
			<td>
				<form:input path="column27" cssClass="txt"/>
				&nbsp;<form:errors path="column27" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_28</th>
			<td>
				<form:input path="column28" cssClass="txt"/>
				&nbsp;<form:errors path="column28" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_29</th>
			<td>
				<form:input path="column29" cssClass="txt"/>
				&nbsp;<form:errors path="column29" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_30</th>
			<td>
				<form:input path="column30" cssClass="txt"/>
				&nbsp;<form:errors path="column30" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_31</th>
			<td>
				<form:input path="column31" cssClass="txt"/>
				&nbsp;<form:errors path="column31" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_32</th>
			<td>
				<form:input path="column32" cssClass="txt"/>
				&nbsp;<form:errors path="column32" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_33</th>
			<td>
				<form:input path="column33" cssClass="txt"/>
				&nbsp;<form:errors path="column33" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_34</th>
			<td>
				<form:input path="column34" cssClass="txt"/>
				&nbsp;<form:errors path="column34" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_35</th>
			<td>
				<form:input path="column35" cssClass="txt"/>
				&nbsp;<form:errors path="column35" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_36</th>
			<td>
				<form:input path="column36" cssClass="txt"/>
				&nbsp;<form:errors path="column36" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_37</th>
			<td>
				<form:input path="column37" cssClass="txt"/>
				&nbsp;<form:errors path="column37" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_38</th>
			<td>
				<form:input path="column38" cssClass="txt"/>
				&nbsp;<form:errors path="column38" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_39</th>
			<td>
				<form:input path="column39" cssClass="txt"/>
				&nbsp;<form:errors path="column39" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_40</th>
			<td>
				<form:input path="column40" cssClass="txt"/>
				&nbsp;<form:errors path="column40" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_41</th>
			<td>
				<form:input path="column41" cssClass="txt"/>
				&nbsp;<form:errors path="column41" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_42</th>
			<td>
				<form:input path="column42" cssClass="txt"/>
				&nbsp;<form:errors path="column42" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_43</th>
			<td>
				<form:input path="column43" cssClass="txt"/>
				&nbsp;<form:errors path="column43" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_44</th>
			<td>
				<form:input path="column44" cssClass="txt"/>
				&nbsp;<form:errors path="column44" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_45</th>
			<td>
				<form:input path="column45" cssClass="txt"/>
				&nbsp;<form:errors path="column45" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_46</th>
			<td>
				<form:input path="column46" cssClass="txt"/>
				&nbsp;<form:errors path="column46" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_47</th>
			<td>
				<form:input path="column47" cssClass="txt"/>
				&nbsp;<form:errors path="column47" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_48</th>
			<td>
				<form:input path="column48" cssClass="txt"/>
				&nbsp;<form:errors path="column48" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_49</th>
			<td>
				<form:input path="column49" cssClass="txt"/>
				&nbsp;<form:errors path="column49" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_50</th>
			<td>
				<form:input path="column50" cssClass="txt"/>
				&nbsp;<form:errors path="column50" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_51</th>
			<td>
				<form:input path="column51" cssClass="txt"/>
				&nbsp;<form:errors path="column51" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_52</th>
			<td>
				<form:input path="column52" cssClass="txt"/>
				&nbsp;<form:errors path="column52" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_53</th>
			<td>
				<form:input path="column53" cssClass="txt"/>
				&nbsp;<form:errors path="column53" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_54</th>
			<td>
				<form:input path="column54" cssClass="txt"/>
				&nbsp;<form:errors path="column54" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_55</th>
			<td>
				<form:input path="column55" cssClass="txt"/>
				&nbsp;<form:errors path="column55" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_56</th>
			<td>
				<form:input path="column56" cssClass="txt"/>
				&nbsp;<form:errors path="column56" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_57</th>
			<td>
				<form:input path="column57" cssClass="txt"/>
				&nbsp;<form:errors path="column57" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_58</th>
			<td>
				<form:input path="column58" cssClass="txt"/>
				&nbsp;<form:errors path="column58" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_59</th>
			<td>
				<form:input path="column59" cssClass="txt"/>
				&nbsp;<form:errors path="column59" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_60</th>
			<td>
				<form:input path="column60" cssClass="txt"/>
				&nbsp;<form:errors path="column60" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_61</th>
			<td>
				<form:input path="column61" cssClass="txt"/>
				&nbsp;<form:errors path="column61" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_62</th>
			<td>
				<form:input path="column62" cssClass="txt"/>
				&nbsp;<form:errors path="column62" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_63</th>
			<td>
				<form:input path="column63" cssClass="txt"/>
				&nbsp;<form:errors path="column63" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_64</th>
			<td>
				<form:input path="column64" cssClass="txt"/>
				&nbsp;<form:errors path="column64" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_65</th>
			<td>
				<form:input path="column65" cssClass="txt"/>
				&nbsp;<form:errors path="column65" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_66</th>
			<td>
				<form:input path="column66" cssClass="txt"/>
				&nbsp;<form:errors path="column66" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_67</th>
			<td>
				<form:input path="column67" cssClass="txt"/>
				&nbsp;<form:errors path="column67" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_68</th>
			<td>
				<form:input path="column68" cssClass="txt"/>
				&nbsp;<form:errors path="column68" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_69</th>
			<td>
				<form:input path="column69" cssClass="txt"/>
				&nbsp;<form:errors path="column69" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_70</th>
			<td>
				<form:input path="column70" cssClass="txt"/>
				&nbsp;<form:errors path="column70" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_71</th>
			<td>
				<form:input path="column71" cssClass="txt"/>
				&nbsp;<form:errors path="column71" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_72</th>
			<td>
				<form:input path="column72" cssClass="txt"/>
				&nbsp;<form:errors path="column72" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_73</th>
			<td>
				<form:input path="column73" cssClass="txt"/>
				&nbsp;<form:errors path="column73" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_74</th>
			<td>
				<form:input path="column74" cssClass="txt"/>
				&nbsp;<form:errors path="column74" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_75</th>
			<td>
				<form:input path="column75" cssClass="txt"/>
				&nbsp;<form:errors path="column75" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_76</th>
			<td>
				<form:input path="column76" cssClass="txt"/>
				&nbsp;<form:errors path="column76" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_77</th>
			<td>
				<form:input path="column77" cssClass="txt"/>
				&nbsp;<form:errors path="column77" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_78</th>
			<td>
				<form:input path="column78" cssClass="txt"/>
				&nbsp;<form:errors path="column78" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_79</th>
			<td>
				<form:input path="column79" cssClass="txt"/>
				&nbsp;<form:errors path="column79" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_80</th>
			<td>
				<form:input path="column80" cssClass="txt"/>
				&nbsp;<form:errors path="column80" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_81</th>
			<td>
				<form:input path="column81" cssClass="txt"/>
				&nbsp;<form:errors path="column81" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_82</th>
			<td>
				<form:input path="column82" cssClass="txt"/>
				&nbsp;<form:errors path="column82" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_83</th>
			<td>
				<form:input path="column83" cssClass="txt"/>
				&nbsp;<form:errors path="column83" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_84</th>
			<td>
				<form:input path="column84" cssClass="txt"/>
				&nbsp;<form:errors path="column84" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_85</th>
			<td>
				<form:input path="column85" cssClass="txt"/>
				&nbsp;<form:errors path="column85" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_86</th>
			<td>
				<form:input path="column86" cssClass="txt"/>
				&nbsp;<form:errors path="column86" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_87</th>
			<td>
				<form:input path="column87" cssClass="txt"/>
				&nbsp;<form:errors path="column87" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_88</th>
			<td>
				<form:input path="column88" cssClass="txt"/>
				&nbsp;<form:errors path="column88" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_89</th>
			<td>
				<form:input path="column89" cssClass="txt"/>
				&nbsp;<form:errors path="column89" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_90</th>
			<td>
				<form:input path="column90" cssClass="txt"/>
				&nbsp;<form:errors path="column90" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_91</th>
			<td>
				<form:input path="column91" cssClass="txt"/>
				&nbsp;<form:errors path="column91" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_92</th>
			<td>
				<form:input path="column92" cssClass="txt"/>
				&nbsp;<form:errors path="column92" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_93</th>
			<td>
				<form:input path="column93" cssClass="txt"/>
				&nbsp;<form:errors path="column93" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_94</th>
			<td>
				<form:input path="column94" cssClass="txt"/>
				&nbsp;<form:errors path="column94" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_95</th>
			<td>
				<form:input path="column95" cssClass="txt"/>
				&nbsp;<form:errors path="column95" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_96</th>
			<td>
				<form:input path="column96" cssClass="txt"/>
				&nbsp;<form:errors path="column96" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_97</th>
			<td>
				<form:input path="column97" cssClass="txt"/>
				&nbsp;<form:errors path="column97" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_98</th>
			<td>
				<form:input path="column98" cssClass="txt"/>
				&nbsp;<form:errors path="column98" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_99</th>
			<td>
				<form:input path="column99" cssClass="txt"/>
				&nbsp;<form:errors path="column99" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_100</th>
			<td>
				<form:input path="column100" cssClass="txt"/>
				&nbsp;<form:errors path="column100" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_101</th>
			<td>
				<form:input path="column101" cssClass="txt"/>
				&nbsp;<form:errors path="column101" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_102</th>
			<td>
				<form:input path="column102" cssClass="txt"/>
				&nbsp;<form:errors path="column102" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_103</th>
			<td>
				<form:input path="column103" cssClass="txt"/>
				&nbsp;<form:errors path="column103" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_104</th>
			<td>
				<form:input path="column104" cssClass="txt"/>
				&nbsp;<form:errors path="column104" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_105</th>
			<td>
				<form:input path="column105" cssClass="txt"/>
				&nbsp;<form:errors path="column105" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_106</th>
			<td>
				<form:input path="column106" cssClass="txt"/>
				&nbsp;<form:errors path="column106" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_107</th>
			<td>
				<form:input path="column107" cssClass="txt"/>
				&nbsp;<form:errors path="column107" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_108</th>
			<td>
				<form:input path="column108" cssClass="txt"/>
				&nbsp;<form:errors path="column108" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_109</th>
			<td>
				<form:input path="column109" cssClass="txt"/>
				&nbsp;<form:errors path="column109" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_110</th>
			<td>
				<form:input path="column110" cssClass="txt"/>
				&nbsp;<form:errors path="column110" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_111</th>
			<td>
				<form:input path="column111" cssClass="txt"/>
				&nbsp;<form:errors path="column111" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_112</th>
			<td>
				<form:input path="column112" cssClass="txt"/>
				&nbsp;<form:errors path="column112" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_113</th>
			<td>
				<form:input path="column113" cssClass="txt"/>
				&nbsp;<form:errors path="column113" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_114</th>
			<td>
				<form:input path="column114" cssClass="txt"/>
				&nbsp;<form:errors path="column114" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_115</th>
			<td>
				<form:input path="column115" cssClass="txt"/>
				&nbsp;<form:errors path="column115" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_116</th>
			<td>
				<form:input path="column116" cssClass="txt"/>
				&nbsp;<form:errors path="column116" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_117</th>
			<td>
				<form:input path="column117" cssClass="txt"/>
				&nbsp;<form:errors path="column117" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_118</th>
			<td>
				<form:input path="column118" cssClass="txt"/>
				&nbsp;<form:errors path="column118" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_119</th>
			<td>
				<form:input path="column119" cssClass="txt"/>
				&nbsp;<form:errors path="column119" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_120</th>
			<td>
				<form:input path="column120" cssClass="txt"/>
				&nbsp;<form:errors path="column120" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_121</th>
			<td>
				<form:input path="column121" cssClass="txt"/>
				&nbsp;<form:errors path="column121" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_122</th>
			<td>
				<form:input path="column122" cssClass="txt"/>
				&nbsp;<form:errors path="column122" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_123</th>
			<td>
				<form:input path="column123" cssClass="txt"/>
				&nbsp;<form:errors path="column123" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_124</th>
			<td>
				<form:input path="column124" cssClass="txt"/>
				&nbsp;<form:errors path="column124" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_125</th>
			<td>
				<form:input path="column125" cssClass="txt"/>
				&nbsp;<form:errors path="column125" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_126</th>
			<td>
				<form:input path="column126" cssClass="txt"/>
				&nbsp;<form:errors path="column126" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_127</th>
			<td>
				<form:input path="column127" cssClass="txt"/>
				&nbsp;<form:errors path="column127" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_128</th>
			<td>
				<form:input path="column128" cssClass="txt"/>
				&nbsp;<form:errors path="column128" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_129</th>
			<td>
				<form:input path="column129" cssClass="txt"/>
				&nbsp;<form:errors path="column129" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_130</th>
			<td>
				<form:input path="column130" cssClass="txt"/>
				&nbsp;<form:errors path="column130" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_131</th>
			<td>
				<form:input path="column131" cssClass="txt"/>
				&nbsp;<form:errors path="column131" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_132</th>
			<td>
				<form:input path="column132" cssClass="txt"/>
				&nbsp;<form:errors path="column132" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_133</th>
			<td>
				<form:input path="column133" cssClass="txt"/>
				&nbsp;<form:errors path="column133" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_134</th>
			<td>
				<form:input path="column134" cssClass="txt"/>
				&nbsp;<form:errors path="column134" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_135</th>
			<td>
				<form:input path="column135" cssClass="txt"/>
				&nbsp;<form:errors path="column135" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_136</th>
			<td>
				<form:input path="column136" cssClass="txt"/>
				&nbsp;<form:errors path="column136" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_137</th>
			<td>
				<form:input path="column137" cssClass="txt"/>
				&nbsp;<form:errors path="column137" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_138</th>
			<td>
				<form:input path="column138" cssClass="txt"/>
				&nbsp;<form:errors path="column138" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_139</th>
			<td>
				<form:input path="column139" cssClass="txt"/>
				&nbsp;<form:errors path="column139" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_140</th>
			<td>
				<form:input path="column140" cssClass="txt"/>
				&nbsp;<form:errors path="column140" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_141</th>
			<td>
				<form:input path="column141" cssClass="txt"/>
				&nbsp;<form:errors path="column141" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_142</th>
			<td>
				<form:input path="column142" cssClass="txt"/>
				&nbsp;<form:errors path="column142" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_143</th>
			<td>
				<form:input path="column143" cssClass="txt"/>
				&nbsp;<form:errors path="column143" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_144</th>
			<td>
				<form:input path="column144" cssClass="txt"/>
				&nbsp;<form:errors path="column144" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_145</th>
			<td>
				<form:input path="column145" cssClass="txt"/>
				&nbsp;<form:errors path="column145" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_146</th>
			<td>
				<form:input path="column146" cssClass="txt"/>
				&nbsp;<form:errors path="column146" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_147</th>
			<td>
				<form:input path="column147" cssClass="txt"/>
				&nbsp;<form:errors path="column147" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_148</th>
			<td>
				<form:input path="column148" cssClass="txt"/>
				&nbsp;<form:errors path="column148" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_149</th>
			<td>
				<form:input path="column149" cssClass="txt"/>
				&nbsp;<form:errors path="column149" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_150</th>
			<td>
				<form:input path="column150" cssClass="txt"/>
				&nbsp;<form:errors path="column150" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_151</th>
			<td>
				<form:input path="column151" cssClass="txt"/>
				&nbsp;<form:errors path="column151" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_152</th>
			<td>
				<form:input path="column152" cssClass="txt"/>
				&nbsp;<form:errors path="column152" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_153</th>
			<td>
				<form:input path="column153" cssClass="txt"/>
				&nbsp;<form:errors path="column153" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_154</th>
			<td>
				<form:input path="column154" cssClass="txt"/>
				&nbsp;<form:errors path="column154" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_155</th>
			<td>
				<form:input path="column155" cssClass="txt"/>
				&nbsp;<form:errors path="column155" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_156</th>
			<td>
				<form:input path="column156" cssClass="txt"/>
				&nbsp;<form:errors path="column156" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_157</th>
			<td>
				<form:input path="column157" cssClass="txt"/>
				&nbsp;<form:errors path="column157" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_158</th>
			<td>
				<form:input path="column158" cssClass="txt"/>
				&nbsp;<form:errors path="column158" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_159</th>
			<td>
				<form:input path="column159" cssClass="txt"/>
				&nbsp;<form:errors path="column159" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_160</th>
			<td>
				<form:input path="column160" cssClass="txt"/>
				&nbsp;<form:errors path="column160" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_161</th>
			<td>
				<form:input path="column161" cssClass="txt"/>
				&nbsp;<form:errors path="column161" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_162</th>
			<td>
				<form:input path="column162" cssClass="txt"/>
				&nbsp;<form:errors path="column162" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_163</th>
			<td>
				<form:input path="column163" cssClass="txt"/>
				&nbsp;<form:errors path="column163" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_164</th>
			<td>
				<form:input path="column164" cssClass="txt"/>
				&nbsp;<form:errors path="column164" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_165</th>
			<td>
				<form:input path="column165" cssClass="txt"/>
				&nbsp;<form:errors path="column165" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_166</th>
			<td>
				<form:input path="column166" cssClass="txt"/>
				&nbsp;<form:errors path="column166" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_167</th>
			<td>
				<form:input path="column167" cssClass="txt"/>
				&nbsp;<form:errors path="column167" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_168</th>
			<td>
				<form:input path="column168" cssClass="txt"/>
				&nbsp;<form:errors path="column168" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_169</th>
			<td>
				<form:input path="column169" cssClass="txt"/>
				&nbsp;<form:errors path="column169" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_170</th>
			<td>
				<form:input path="column170" cssClass="txt"/>
				&nbsp;<form:errors path="column170" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_171</th>
			<td>
				<form:input path="column171" cssClass="txt"/>
				&nbsp;<form:errors path="column171" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_172</th>
			<td>
				<form:input path="column172" cssClass="txt"/>
				&nbsp;<form:errors path="column172" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_173</th>
			<td>
				<form:input path="column173" cssClass="txt"/>
				&nbsp;<form:errors path="column173" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_174</th>
			<td>
				<form:input path="column174" cssClass="txt"/>
				&nbsp;<form:errors path="column174" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_175</th>
			<td>
				<form:input path="column175" cssClass="txt"/>
				&nbsp;<form:errors path="column175" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_176</th>
			<td>
				<form:input path="column176" cssClass="txt"/>
				&nbsp;<form:errors path="column176" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_177</th>
			<td>
				<form:input path="column177" cssClass="txt"/>
				&nbsp;<form:errors path="column177" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_178</th>
			<td>
				<form:input path="column178" cssClass="txt"/>
				&nbsp;<form:errors path="column178" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_179</th>
			<td>
				<form:input path="column179" cssClass="txt"/>
				&nbsp;<form:errors path="column179" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_180</th>
			<td>
				<form:input path="column180" cssClass="txt"/>
				&nbsp;<form:errors path="column180" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_181</th>
			<td>
				<form:input path="column181" cssClass="txt"/>
				&nbsp;<form:errors path="column181" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_182</th>
			<td>
				<form:input path="column182" cssClass="txt"/>
				&nbsp;<form:errors path="column182" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_183</th>
			<td>
				<form:input path="column183" cssClass="txt"/>
				&nbsp;<form:errors path="column183" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_184</th>
			<td>
				<form:input path="column184" cssClass="txt"/>
				&nbsp;<form:errors path="column184" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_185</th>
			<td>
				<form:input path="column185" cssClass="txt"/>
				&nbsp;<form:errors path="column185" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_186</th>
			<td>
				<form:input path="column186" cssClass="txt"/>
				&nbsp;<form:errors path="column186" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_187</th>
			<td>
				<form:input path="column187" cssClass="txt"/>
				&nbsp;<form:errors path="column187" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_188</th>
			<td>
				<form:input path="column188" cssClass="txt"/>
				&nbsp;<form:errors path="column188" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_189</th>
			<td>
				<form:input path="column189" cssClass="txt"/>
				&nbsp;<form:errors path="column189" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_190</th>
			<td>
				<form:input path="column190" cssClass="txt"/>
				&nbsp;<form:errors path="column190" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_191</th>
			<td>
				<form:input path="column191" cssClass="txt"/>
				&nbsp;<form:errors path="column191" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_192</th>
			<td>
				<form:input path="column192" cssClass="txt"/>
				&nbsp;<form:errors path="column192" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_193</th>
			<td>
				<form:input path="column193" cssClass="txt"/>
				&nbsp;<form:errors path="column193" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_194</th>
			<td>
				<form:input path="column194" cssClass="txt"/>
				&nbsp;<form:errors path="column194" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_195</th>
			<td>
				<form:input path="column195" cssClass="txt"/>
				&nbsp;<form:errors path="column195" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_196</th>
			<td>
				<form:input path="column196" cssClass="txt"/>
				&nbsp;<form:errors path="column196" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_197</th>
			<td>
				<form:input path="column197" cssClass="txt"/>
				&nbsp;<form:errors path="column197" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_198</th>
			<td>
				<form:input path="column198" cssClass="txt"/>
				&nbsp;<form:errors path="column198" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_199</th>
			<td>
				<form:input path="column199" cssClass="txt"/>
				&nbsp;<form:errors path="column199" />
			</td>
		</tr>	
		<tr>
			<th>COLUMN_200</th>
			<td>
				<form:input path="column200" cssClass="txt"/>
				&nbsp;<form:errors path="column200" />
			</td>
		</tr>	
	</table>
  </div>
	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitresultVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

