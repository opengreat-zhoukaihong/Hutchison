﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
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
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨物種類數據維護</title>
</head>

<%
     String s_cargoId=request.getParameter("cargoId");
%>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="CargoCategoryDelete.jsp?cargoId=<%=s_cargoId%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font>
</a> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a> </p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨物種類數據維護</font></p>

<hr>
<p><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">刪除這條記錄嗎?</font></font></p>
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%" ><%=s_cargoId%></td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=dbList.getCargoCategoryDesc(request.getParameter("cargoId"),"EN")%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=dbList.getCargoCategoryDesc(request.getParameter("cargoId"),"CN")%></td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
