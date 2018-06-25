<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="packageUomBean" scope="page" class="com.cbtb.javabean.PackageUomJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
  String Data[] = new String[4];
  Data[0]=request.getParameter("uomId");
  Data[1]=request.getParameter("uomDesc");
  Data[2]=request.getParameter("uomChineseDesc");
  Data[3]=constant.MASTER_CODE_ACTIVE;

  String backPageName = "";
  if (packageUomBean.PackageUomUpdate(Data))
	{
		dbList.loadPackageUomList();
    backPageName = "SuccessPage.jsp?backPage=PackageUomList.jsp&mode=Update";
	}
  else
    backPageName = "ErrorPage.jsp?backPage=PackageUomList.jsp&mode=Update";
%>
<jsp:forward page="<%=backPageName%>" />