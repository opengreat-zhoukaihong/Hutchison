<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="addFeeBean" scope="page" class="com.cbtb.javabean.AddFeeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
 <%
  String addFeeId ; 
  String backPageName = "";
  addFeeId=request.getParameter("addFeeId");
  if (addFeeBean.additionalFeeDelete(addFeeId))	{
	dbList.loadAddFeeList();
	backPageName = "SuccessPage.jsp?backPage=AdditionalFeeList.jsp&mode=Delete";
	  }
	else
	backPageName = "ErrorPage.jsp?backPage=AdditionalFeeList.jsp&mode=Delete";
response.sendRedirect(backPageName);

%>
