<%@ include file="Init.jsp"%>  

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cityBean" scope="page" class="com.cbtb.javabean.CityJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
  String cityId ; 
  String backPageName = "";
  cityId=request.getParameter("cityId");
  if (cityBean.cityDelete(cityId))
    {
    dbList.loadCityList();
    backPageName = "SuccessPage.jsp?backPage=CityList.jsp&mode=Delete";
    }
  else
    backPageName = "ErrorPage.jsp?backPage=CityList.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />
