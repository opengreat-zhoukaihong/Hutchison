<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="trailerTypeBean" scope="page" class="com.cbtb.javabean.TrailerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRAILER_TYPE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String trailerId ; 
  String backPageName = "";
  trailerId=request.getParameter("trailerId");
  if (trailerTypeBean.trailerTypeDelete(trailerId))
   {
   dbList.loadTrailerTypeList(); 
   backPageName = "SuccessPage.jsp?backPage=TrailerTypeList.jsp&mode=Delete";}
  else
{
    backPageName = "ErrorPage.jsp?backPage=TrailerTypeList.jsp&mode=Delete";}
%>
<jsp:forward page="<%=backPageName%>" />
