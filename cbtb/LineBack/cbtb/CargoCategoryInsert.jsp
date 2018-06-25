<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cargoCategoryBean" scope="page" class="com.cbtb.javabean.CargoCategoryJB" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","CARGO_CATEGORY"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String cargoCategoryData[] = new String[4]; 
  cargoCategoryData[0]=request.getParameter("cargoId");
  cargoCategoryData[1]=request.getParameter("cargoDesc");
  cargoCategoryData[2]=request.getParameter("cargoChineseDesc");
  cargoCategoryData[3]=constant.MASTER_CODE_ACTIVE;
  String backPageName = "";
  if (cargoCategoryBean.cargoCategoryInsert(cargoCategoryData))
    {
    dbList.loadCargoCategoryList();
    backPageName = "SuccessPage.jsp?backPage=CargoCategoryList.jsp&mode=Insert";}
  else{
    backPageName = "ErrorPage.jsp?backPage=CargoCategoryList.jsp&mode=Insert";}
%>
<jsp:forward page="<%=backPageName%>" />

