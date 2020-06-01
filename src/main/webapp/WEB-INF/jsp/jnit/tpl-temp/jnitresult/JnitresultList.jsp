<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : JnitresultList.jsp
  * @Description : Jnitresult List 화면
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
<title>목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(resuleId) {
	document.getElementById("listForm").resuleId.value = resuleId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitresult/updateJnitresultView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitresult/addJnitresultView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitresult/JnitresultList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
	<input type="hidden" name="resuleId" />
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/rte/title_dot.gif'/>" alt="title" /> List </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
							</colgroup>		  
			<tr>
								<th align="center">ResuleId</th>
								<th align="center">MbrId</th>
								<th align="center">AdminId</th>
								<th align="center">ResultType</th>
								<th align="center">ResultState</th>
								<th align="center">AdminState</th>
								<th align="center">ResultWhy</th>
								<th align="center">Created</th>
								<th align="center">Modified</th>
								<th align="center">Isdel</th>
								<th align="center">Column13</th>
								<th align="center">Column14</th>
								<th align="center">Column15</th>
								<th align="center">Column16</th>
								<th align="center">Column17</th>
								<th align="center">Column18</th>
								<th align="center">Column19</th>
								<th align="center">Column20</th>
								<th align="center">Column21</th>
								<th align="center">Column22</th>
								<th align="center">Column23</th>
								<th align="center">Column24</th>
								<th align="center">Column25</th>
								<th align="center">Column26</th>
								<th align="center">Column27</th>
								<th align="center">Column28</th>
								<th align="center">Column29</th>
								<th align="center">Column30</th>
								<th align="center">Column31</th>
								<th align="center">Column32</th>
								<th align="center">Column33</th>
								<th align="center">Column34</th>
								<th align="center">Column35</th>
								<th align="center">Column36</th>
								<th align="center">Column37</th>
								<th align="center">Column38</th>
								<th align="center">Column39</th>
								<th align="center">Column40</th>
								<th align="center">Column41</th>
								<th align="center">Column42</th>
								<th align="center">Column43</th>
								<th align="center">Column44</th>
								<th align="center">Column45</th>
								<th align="center">Column46</th>
								<th align="center">Column47</th>
								<th align="center">Column48</th>
								<th align="center">Column49</th>
								<th align="center">Column50</th>
								<th align="center">Column51</th>
								<th align="center">Column52</th>
								<th align="center">Column53</th>
								<th align="center">Column54</th>
								<th align="center">Column55</th>
								<th align="center">Column56</th>
								<th align="center">Column57</th>
								<th align="center">Column58</th>
								<th align="center">Column59</th>
								<th align="center">Column60</th>
								<th align="center">Column61</th>
								<th align="center">Column62</th>
								<th align="center">Column63</th>
								<th align="center">Column64</th>
								<th align="center">Column65</th>
								<th align="center">Column66</th>
								<th align="center">Column67</th>
								<th align="center">Column68</th>
								<th align="center">Column69</th>
								<th align="center">Column70</th>
								<th align="center">Column71</th>
								<th align="center">Column72</th>
								<th align="center">Column73</th>
								<th align="center">Column74</th>
								<th align="center">Column75</th>
								<th align="center">Column76</th>
								<th align="center">Column77</th>
								<th align="center">Column78</th>
								<th align="center">Column79</th>
								<th align="center">Column80</th>
								<th align="center">Column81</th>
								<th align="center">Column82</th>
								<th align="center">Column83</th>
								<th align="center">Column84</th>
								<th align="center">Column85</th>
								<th align="center">Column86</th>
								<th align="center">Column87</th>
								<th align="center">Column88</th>
								<th align="center">Column89</th>
								<th align="center">Column90</th>
								<th align="center">Column91</th>
								<th align="center">Column92</th>
								<th align="center">Column93</th>
								<th align="center">Column94</th>
								<th align="center">Column95</th>
								<th align="center">Column96</th>
								<th align="center">Column97</th>
								<th align="center">Column98</th>
								<th align="center">Column99</th>
								<th align="center">Column100</th>
								<th align="center">Column101</th>
								<th align="center">Column102</th>
								<th align="center">Column103</th>
								<th align="center">Column104</th>
								<th align="center">Column105</th>
								<th align="center">Column106</th>
								<th align="center">Column107</th>
								<th align="center">Column108</th>
								<th align="center">Column109</th>
								<th align="center">Column110</th>
								<th align="center">Column111</th>
								<th align="center">Column112</th>
								<th align="center">Column113</th>
								<th align="center">Column114</th>
								<th align="center">Column115</th>
								<th align="center">Column116</th>
								<th align="center">Column117</th>
								<th align="center">Column118</th>
								<th align="center">Column119</th>
								<th align="center">Column120</th>
								<th align="center">Column121</th>
								<th align="center">Column122</th>
								<th align="center">Column123</th>
								<th align="center">Column124</th>
								<th align="center">Column125</th>
								<th align="center">Column126</th>
								<th align="center">Column127</th>
								<th align="center">Column128</th>
								<th align="center">Column129</th>
								<th align="center">Column130</th>
								<th align="center">Column131</th>
								<th align="center">Column132</th>
								<th align="center">Column133</th>
								<th align="center">Column134</th>
								<th align="center">Column135</th>
								<th align="center">Column136</th>
								<th align="center">Column137</th>
								<th align="center">Column138</th>
								<th align="center">Column139</th>
								<th align="center">Column140</th>
								<th align="center">Column141</th>
								<th align="center">Column142</th>
								<th align="center">Column143</th>
								<th align="center">Column144</th>
								<th align="center">Column145</th>
								<th align="center">Column146</th>
								<th align="center">Column147</th>
								<th align="center">Column148</th>
								<th align="center">Column149</th>
								<th align="center">Column150</th>
								<th align="center">Column151</th>
								<th align="center">Column152</th>
								<th align="center">Column153</th>
								<th align="center">Column154</th>
								<th align="center">Column155</th>
								<th align="center">Column156</th>
								<th align="center">Column157</th>
								<th align="center">Column158</th>
								<th align="center">Column159</th>
								<th align="center">Column160</th>
								<th align="center">Column161</th>
								<th align="center">Column162</th>
								<th align="center">Column163</th>
								<th align="center">Column164</th>
								<th align="center">Column165</th>
								<th align="center">Column166</th>
								<th align="center">Column167</th>
								<th align="center">Column168</th>
								<th align="center">Column169</th>
								<th align="center">Column170</th>
								<th align="center">Column171</th>
								<th align="center">Column172</th>
								<th align="center">Column173</th>
								<th align="center">Column174</th>
								<th align="center">Column175</th>
								<th align="center">Column176</th>
								<th align="center">Column177</th>
								<th align="center">Column178</th>
								<th align="center">Column179</th>
								<th align="center">Column180</th>
								<th align="center">Column181</th>
								<th align="center">Column182</th>
								<th align="center">Column183</th>
								<th align="center">Column184</th>
								<th align="center">Column185</th>
								<th align="center">Column186</th>
								<th align="center">Column187</th>
								<th align="center">Column188</th>
								<th align="center">Column189</th>
								<th align="center">Column190</th>
								<th align="center">Column191</th>
								<th align="center">Column192</th>
								<th align="center">Column193</th>
								<th align="center">Column194</th>
								<th align="center">Column195</th>
								<th align="center">Column196</th>
								<th align="center">Column197</th>
								<th align="center">Column198</th>
								<th align="center">Column199</th>
								<th align="center">Column200</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
													<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.resuleId}"/>')"><c:out value="${result.resuleId}"/></a>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.mbrId}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.adminId}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.resultType}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.resultState}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.adminState}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.resultWhy}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.created}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.modified}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.isdel}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column13}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column14}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column15}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column16}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column17}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column18}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column19}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column20}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column21}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column22}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column23}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column24}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column25}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column26}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column27}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column28}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column29}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column30}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column31}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column32}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column33}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column34}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column35}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column36}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column37}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column38}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column39}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column40}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column41}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column42}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column43}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column44}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column45}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column46}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column47}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column48}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column49}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column50}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column51}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column52}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column53}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column54}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column55}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column56}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column57}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column58}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column59}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column60}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column61}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column62}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column63}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column64}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column65}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column66}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column67}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column68}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column69}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column70}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column71}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column72}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column73}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column74}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column75}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column76}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column77}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column78}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column79}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column80}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column81}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column82}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column83}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column84}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column85}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column86}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column87}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column88}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column89}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column90}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column91}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column92}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column93}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column94}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column95}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column96}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column97}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column98}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column99}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column100}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column101}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column102}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column103}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column104}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column105}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column106}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column107}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column108}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column109}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column110}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column111}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column112}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column113}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column114}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column115}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column116}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column117}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column118}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column119}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column120}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column121}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column122}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column123}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column124}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column125}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column126}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column127}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column128}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column129}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column130}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column131}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column132}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column133}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column134}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column135}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column136}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column137}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column138}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column139}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column140}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column141}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column142}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column143}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column144}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column145}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column146}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column147}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column148}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column149}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column150}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column151}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column152}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column153}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column154}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column155}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column156}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column157}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column158}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column159}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column160}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column161}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column162}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column163}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column164}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column165}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column166}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column167}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column168}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column169}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column170}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column171}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column172}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column173}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column174}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column175}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column176}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column177}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column178}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column179}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column180}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column181}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column182}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column183}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column184}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column185}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column186}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column187}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column188}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column189}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column190}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column191}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column192}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column193}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column194}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column195}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column196}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column197}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column198}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column199}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.column200}"/>&nbsp;</td>
				    			</tr>
			</c:forEach>
		</table>
	</div>
	<!-- /List -->
	<div id="paging">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
	<div id="sysbtn1">
		<ul>
			<li>
				<div id="sysbtn">
					<span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" />
					</span>
				</div>
			</li>
		</ul>
	</div>
</div>
</form:form>
</body>
</html>
