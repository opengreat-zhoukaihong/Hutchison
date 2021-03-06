﻿<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間數據維護</title>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="DeliveryTimeDelete.jsp?deliveryTimeId=<%=request.getParameter("deliveryTimeId")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間數據維護</font></p>

<p align="left"><FONT color=#ff0033>刪除這條紀錄?</font></p>

<hr>
<%
String deliveryTimeId=request.getParameter("deliveryTimeId");
%>
<table width="56%" border="0">
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"> 
      <%=request.getParameter("deliveryTimeId")%>
    </td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"> 
<%=dbList.getDeliveryTimeDesc(deliveryTimeId,"EN")%>
      </td>
  </tr>
  <tr> 
    <td width="50%">中文描述：</td>
    <td width="50%"> 
<%=dbList.getDeliveryTimeDesc(deliveryTimeId,"CH")%>
    </td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
