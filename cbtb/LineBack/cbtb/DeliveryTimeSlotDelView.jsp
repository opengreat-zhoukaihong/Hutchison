﻿<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間段數據維護</title>

</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="DeliveryTimeSlotDelete.jsp?timeSlotId=<%=request.getParameter("timeSlotId") %>&deliveryTimeId=<%=request.getParameter("deliveryTimeId") %>&fromTime=<%=request.getParameter("fromTime") %>&toTime=<%=request.getParameter("toTime") %>&slotDesc=<%=request.getParameter("slotDesc")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間段數據維護</font></p>

<p align="left"><FONT color=#ff0033>刪除這條紀錄?</font></p>

<hr>
<table width="56%" border="0">
<%
String timeSlotId=request.getParameter("timeSlotId");
%>
  <tr> 
    <td width="50%">時間段編號：</td>
    <td width="50%"><%=request.getParameter("timeSlotId") %></td>
  </tr>
   <tr> 
    <td width="50%">起始時間：</td>
    <td width="50%"><%=request.getParameter("fromTime") %></td>
  </tr>
  <tr> 
    <td width="50%">終止時間：</td>
    <td width="50%"><%=request.getParameter("toTime") %></td>
  </tr>
  <tr> 
    <td width="50%">貨運時間：</td>
    <td width="50%"><%= dbList.getDeliveryTimeDesc(request.getParameter("deliveryTimeId"), "CN") %></td>  
  </tr>
  <tr> 
    <td width="50%">時間段描述：</td>
    <td width="50%"><%=request.getParameter("slotDesc")%></td>
  </tr>
  <tr> 
    <td width="50%">時間段中文描述：</td>
    <td width="50%"><%=dbList.getDeliveryTimeSlotDesc(timeSlotId,"CN")%></td>
  </tr>

</table>
<p>&nbsp;</p>

</body>
</html>
