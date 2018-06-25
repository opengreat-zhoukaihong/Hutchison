<%@ include file="Init.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="zoneBean" scope="page" class="com.cbtb.javabean.ZoneJB" />

<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ZONE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName = "";
  String zoneId; 
  String zbackPageName = "";
  zoneId=request.getParameter("zoneId");
  if (zoneBean.zoneDelete(zoneId)){
      dbList.loadZoneList();
      backPageName = "SuccessPage.jsp?backPage=ZoneList.jsp&mode=Delete";
  }
  else
      backPageName = "ErrorPage.jsp?backPage=Zonelist.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />