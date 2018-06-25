<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>
<head>
<title>CBTB</title>
</head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<p align="left">&nbsp;</p>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="30">
      <p><a href="BillingMatchSearch.jsp"><font face="Arial, Helvetica, sans-serif" size="2" color="#003366">審核/配對紀錄維護</font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30"><a href="StatementGenerate.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">生成服務報表</font></a></td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="StatementManage.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">服務報表維護</font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="StatementPrint.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">打印服務報表</font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="InvoiceGenerate.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">生成發票</font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30"><a href="InvoiceMaintain.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">發票維護</font></a></td>
  </tr>
  <tr>
    <td height="30"><a href="InvoicePrint.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">打印發票</font></a></td>
  </tr>
  <tr>
    <td height="30"><a href="PaymentSearch.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">付款</font></a></td>
  </tr>
</table>
</body>
</html>







