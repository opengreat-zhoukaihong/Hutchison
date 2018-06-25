<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cargoCategoryBean" scope="page" class="com.cbtb.javabean.CargoCategoryJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","CARGO_CATEGORY"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String cargoId ; 
  String backPageName = "";
  cargoId=request.getParameter("cargoId");
  if (cargoCategoryBean.cargoCategoryDelete(cargoId))
   {
    dbList.loadCargoCategoryList();
    backPageName = "SuccessPage.jsp?backPage=CargoCategoryList.jsp&mode=Delete";}
  else
{
    backPageName = "ErrorPage.jsp?backPage=CargoCategoryList.jsp&mode=Delete";}
%>
<jsp:forward page="<%=backPageName%>" />
