﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","CARGO_CATEGORY"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨物種類數據維護</title>
</head>
<%
     String URL=request.getParameter("URL");
     String s_cargoId=request.getParameter("cargoId");
     String s_cargoDesc=request.getParameter("cargoDesc");
     String s_cargoChineseDesc=request.getParameter("cargoChineseDesc");
%>
<script language="javascript">
function doPost()
{
  edit.submit();
}
</script>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:doPost()"><font
size="2"color="#003366"  face="Arial, Helvetica, sans-serif">確定</font>
</a> | <a href="javascript:history.back();"><font
size="2" color="#003366"  face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨物種類數據維護</font></p>

<hr>
<form name="edit" action="CargoCategoryUpdate.jsp" method="post">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%"><%=s_cargoId%></td>
    <input type="hidden" name="cargoId" value="<%=s_cargoId%>">
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=s_cargoDesc%></td>
    <input type="hidden" name="cargoDesc" value="<%=s_cargoDesc%>">
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=s_cargoChineseDesc%></td>
    <input type="hidden" name="cargoChineseDesc" value="<%=s_cargoChineseDesc%>">
  </tr>
</table>
<p>&nbsp;</p>
</form>
</body>
</html>
