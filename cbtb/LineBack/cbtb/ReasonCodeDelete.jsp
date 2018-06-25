<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="reasonBean" scope="page" class="com.cbtb.javabean.ReasonCodeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","REASON_CODE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String reasonId ;
  String backPageName = "";
  reasonId=request.getParameter("reasonId");
  if (reasonBean.ReasonCodeDelete(reasonId))
	{
		dbList.loadReasonCodeList();
		backPageName = "SuccessPage.jsp?backPage=ReasonCodeList.jsp&mode=Delete";
	}
  else
    backPageName = "ErrorPage.jsp?backPage=ReasonCodeList.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />