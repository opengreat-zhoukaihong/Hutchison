<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>系統處理參數列表
</title>
</head>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","SYSTEM_PARAMETER"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right">
<a href="SystemParameterUpdate.jsp?
recordId=<%=request.getParameter("recordId")%>&
&processLeadTime=<%=request.getParameter("processLeadTime")%>
&maxUserForTruck=<%=request.getParameter("maxUserForTruck")%>
&maxUserForShippe=<%=request.getParameter("maxUserForShippe")%>
&invoiceSpecificDay1=<%=request.getParameter("invoiceSpecificDay1")%>
&invoiceSpecificDay2=<%=request.getParameter("invoiceSpecificDay2")%>
&invoiceSpecificDay3=<%=request.getParameter("invoiceSpecificDay3")%>
&invoiceSpecificDay4=<%=request.getParameter("invoiceSpecificDay4")%>
&invoiceDuedays=<%=request.getParameter("invoiceDuedays")%>">
<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a>
 | <a href="javascript:history.back()">
<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">系統處理參數列表維護</font></p>

<hr>
<table width="48%" border="0">
  <tr> 
    <td width="32%"> 
      <div align="left">預配對天數：</div>
    </td>
    <td width="38%"><%=request.getParameter("processLeadTime")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">貨運公司用戶數：</div>
    </td>
    <td width="38%"><%=request.getParameter("maxUserForTruck")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">付貨公司用戶數：</div>
    </td>
    <td width="38%"><%=request.getParameter("maxUserForShippe")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日1：</div>
    </td>
    <td width="38%"><%=request.getParameter("invoiceSpecificDay1")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日2：</div>
    </td>
    <td width="38%"><%=request.getParameter("invoiceSpecificDay2")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日3：</div>
    </td>
    <td width="38%"><%=request.getParameter("invoiceSpecificDay3")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日4：</div>
    </td>
    <td width="38%"><%=request.getParameter("invoiceSpecificDay4")%></td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票預期未付天數：</div>
    </td>
    <td width="38%"><%=request.getParameter("invoiceDuedays")%></td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
