<%@ include file="Init.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="zoneBean" scope="page" class="com.cbtb.javabean.ZoneJB" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ZONE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName ="";
  String zoneData[] = new String[4]; 
  zoneData[0]=request.getParameter("zoneId");
  zoneData[1]=request.getParameter("zoneDesc");
  zoneData[2]=request.getParameter("chineseDesc");
  zoneData[3]=constant.MASTER_CODE_ACTIVE;
  if (zoneBean.zoneInsert(zoneData)){
     dbList.loadZoneList();
     backPageName = "SuccessPage.jsp?backPage=ZoneList.jsp&mode=Insert";
  }
  else
     backPageName = "ErrorPage.jsp?backPage=ZoneList.jsp&mode=Insert";
%>
<jsp:forward page="<%=backPageName%>" />