<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>量度單位數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="PackageUomEdit.jsp?uomId=<%=request.getParameter("uomId")%>">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">更新</font></a>
  | <a href="PackageUomDelView.jsp?uomId=<%=request.getParameter("uomId")%>">
	<font	color="#003366" size="2" face="Arial, Helvetica, sans-serif">刪除</font></a>
  | </font>
	<a href="javascript:history.back();"><font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a>
</p>

<p><font face="Arial, Helvetica, sans-serif" size="3">量度單位數據維護</font></p>

<hr>
<table width="56%" border="0">
<%
String uomId=request.getParameter("uomId");
%>
  <tr>
    <td width="50%">編號：</td>
    <td width="50%"><%=request.getParameter("uomId")%> </td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=dbList.getPackageUomDesc(uomId, "EN")%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
		<td width="50%"><%=dbList.getPackageUomDesc(uomId, "CN")%></td>
  </tr>
</table>
</body>
</html>