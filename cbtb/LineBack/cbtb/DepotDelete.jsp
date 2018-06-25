<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="depotBean" scope="page" class="com.cbtb.javabean.DepotJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","DEPOT"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String depotId ; 
  String backPageName = "";
  depotId=request.getParameter("depotId");
  if (depotBean.depotDelete(depotId))
   {
    dbList.loadDepotList();
    backPageName = "SuccessPage.jsp?backPage=DepotList.jsp&mode=Delete";}
  else
{
    backPageName = "ErrorPage.jsp?backPage=DepotList.jsp&mode=Delete";}
%>
<jsp:forward page="<%=backPageName%>" />
