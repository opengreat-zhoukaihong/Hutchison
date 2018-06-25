<%@ include file="Init.jsp"%>  

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cityBean" scope="page" class="com.cbtb.javabean.CityJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
  String cityData[] = new String[5]; 
  cityData[0]=request.getParameter("cityId");
  cityData[1]=request.getParameter("zoneId");
  cityData[2]=request.getParameter("desc");
  cityData[3]=request.getParameter("chineseDesc");
  cityData[4]=constant.MASTER_CODE_ACTIVE;
  String backPageName = "";
  if (cityBean.cityInsert(cityData))
    {
      dbList.loadCityList();
      backPageName = "SuccessPage.jsp?backPage=CityList.jsp&mode=Insert";
    } 
  else
    backPageName = "ErrorPage.jsp?backPage=CityList.jsp&mode=Insert";
%>
<jsp:forward page="<%=backPageName%>" />