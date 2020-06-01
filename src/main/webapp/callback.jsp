<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.net.*,java.io.*" %>
<%
        String code = request.getParameter("code");
        String appID = "500723520025267"; // 자신의 appID로 수정
        
        String appSecret = "7212e624796ccc712d2f244beb4abdd2"; // 자신의 app secret로 수정
        String callbackUrl = "http://" + request.getServerName() + "/callback.jsp";
        String access_token_url = "https://graph.facebook.com/oauth/access_token?" 
                + "client_id="+ appID 
                + "&redirect_uri=" + URLEncoder.encode(callbackUrl, "UTF-8") 
                + "&client_secret=" + appSecret + "&code=" + code;
        

        URL yahoo = new URL(access_token_url);
        URLConnection yc = yahoo.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                yc.getInputStream()));
        String inputLine = null;
        out.println("<br/>access_token response =======================");
        while ((inputLine = in.readLine()) != null) 
            out.println(inputLine);
        out.println("<br/>access_token response =======================");
        in.close();
%>
<br />code : <%= code %>  <br />