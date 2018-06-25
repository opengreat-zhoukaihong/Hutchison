<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="packageUomBean" scope="page" class="com.cbtb.javabean.PackageUomJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String uomId ;
  String backPageName = "";
  uomId=request.getParameter("uomId");
  if (packageUomBean.PackageUomDelete(uomId))
	{
		dbList.loadPackageUomList();
    backPageName = "SuccessPage.jsp?backPage=PackageUomList.jsp&mode=Delete";
	}
  else
    backPageName = "ErrorPage.jsp?backPage=PackageUomList.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />