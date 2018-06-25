<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間段數據維護</title>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


</head>

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.fromTime.value =="")
   {
     alert("起始時間不能為空!");
     add.fromTime.focus();
     return;
    }
   if (add.toTime.value =="")
   {
     alert("終止時間不能為空!");
     add.toTime.focus();
     return;
   }
    if (add.slotDesc.value =="")
   {
     alert("時間段描述不能為空!");
     add.slotDesc.focus();
     return;
   }
    
    add.submit();
}
</SCRIPT>

</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="javascript:history.back();"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">取消</a></font></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間段數據維護</font></p>

<hr>
<form  name="add" action="DeliveryTimeSlotConfirm.jsp" method="POST">
<table width="56%" border="0">
<%
String timeSlotId=request.getParameter("timeSlotId");
%>
  <tr> 
    <td width="50%">時間段編號：</td>
    <td width="50%"> 
  <%=request.getParameter("timeSlotId") %> 
  <input type="hidden" name="timeSlotId" value="<%=request.getParameter("timeSlotId")%>">
    </td>
  </tr>
  <tr> 
    <td width="50%">起始時間：</td>
    <td width="50%"> 
      <input type="text" maxlength="5" size="5" name="fromTime" value="<%=request.getParameter("fromTime") %>">
    </td>
  </tr>
  <tr> 
    <td width="50%">終止時間：</td>
    <td width="50%"> 
      <input type="text" maxlength="5" size="5" name="toTime" size = "20" value="<%=request.getParameter("toTime")%>">
    </td>
  </tr>

  <tr> 
    <td width="50%">貨運時間：</td>
    <td width="50%">
      <select name="deliveryTimeId" >
                  <%=dbList.getDeliveryTimeList(request.getParameter("deliveryTimeId"),"CN")%>             
              </select> 
    </td>
    <input type="hidden" name="deliveryTimeId" value="<%=request.getParameter("deliveryTimeId")%>">
  </tr>
  <tr> 
    <td width="50%">時間段描述：</td>
    <td width="50%"> 
      <input type="text" name="slotDesc" maxlength="20" size = "20" value="<%=request.getParameter("slotDesc")%>">
    </td>
  </tr>
    <tr> 
      <td >時間段中文描述：</td>
      <td > <input type="text" maxlength="10" size="20" name="slotChineseDesc"  value="<%=dbList.getDeliveryTimeSlotDesc(timeSlotId,"CN")%>"></td>
    </tr>
</table>
    <p><input type="button" name="denglu  3" value="提交" LANGUAGE=javascript  onclick="return doPost()">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>