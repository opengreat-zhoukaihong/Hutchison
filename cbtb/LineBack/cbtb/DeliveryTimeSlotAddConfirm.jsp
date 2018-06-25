<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間段數據維護</title>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<SCRIPT LANGUAGE="JavaScript">

function doPost()
{

    add.submit();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="javascript:doPost()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間段數據維護</font></p>

<hr>
<form action="DeliveryTimeSlotInsert.jsp" name="add" method="post" >

<input type="hidden" name="timeSlotId" value="<%=request.getParameter("timeSlotId") %>">
<input type="hidden" name="deliveryTimeId" value="<%=request.getParameter("deliveryTimeId") %>">
<input type="hidden" name="fromTime" value="<%=request.getParameter("fromTime")%>">
<input type="hidden" name="toTime" value="<%=request.getParameter("toTime") %>">
<input type="hidden" name="slotDesc" value="<%=request.getParameter("slotDesc") %>">
<input type="hidden" name="slotChineseDesc" value="<%=request.getParameter("slotChineseDesc")%>">
<table width="56%" border="0">
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
    <td width="50%"><%= dbList.getDeliveryTimeDesc(request.getParameter("deliveryTimeId"), "EN") %></td>  
  </tr>
  <tr> 
    <td width="50%">時間段描述：</td>
    <td width="50%"><%=request.getParameter("slotDesc")%></td>
  </tr>
  <tr> 
    <td width="50%">時間段中文描述：</td>
    <td width="50%"><%=request.getParameter("slotChineseDesc")%></td>
  </tr>
</table>
</form>
<p>&nbsp;</p>

</body>
</html>
