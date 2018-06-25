<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{

    op.submit();
}
</SCRIPT>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>量度單位數據維護</title>
</head>
<%
	String URL=request.getParameter("URL");
	String uomId=request.getParameter("uomId");
	String uomDesc=request.getParameter("uomDesc");
	String uomChineseDesc=request.getParameter("uomChineseDesc");
	String recordStatus=request.getParameter("recordStatus");
%>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="javascript:doPost()">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a>
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> |</font>
	  <a href="javascript:history.back();">
	<font color="#003366" size="2"	face="Arial, Helvetica, sans-serif">取消</font></a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">量度單位數據維護</font></p>

<hr>
<form action="<%=URL%>" name="op" method="post" >
<table width="56%" border="0">
<input type="hidden" name="uomId" value="<%=uomId%>">
<input type="hidden" name="uomDesc" value="<%=uomDesc%>">
<input type="hidden" name="uomChineseDesc" value="<%=uomChineseDesc%>">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%"><%=uomId%></td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=uomDesc%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=uomChineseDesc%></td>
  </tr>
</table>
</form>
</body>
</html>
