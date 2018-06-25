<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<html>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間段數據維護</title>

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.timeSlotId.value =="")
   {
     alert("時間段編號不能为空!");
     add.timeSlotId.focus();
     return;
   }
   
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

   if (add.deliveryTimeId.value =="Any")
   {
     alert("貨運時間編號不能為空!");
     add.deliveryTimeId.focus();
     return;
    }
    add.submit();
  }
 
</SCRIPT>


</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間段數據維護</font></p>
<form action="DeliveryTimeSlotAddConfirm.jsp" name="add" method="POST">
  <table width="60%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td >時間段編號：</td>
      <td > 
        <input type="text" maxlength="5" size="5" name="timeSlotId">
      </td>
    </tr>
    <tr> 
      <td >起始時間：</td>
      <td > <input type="text" maxlength="5" size="5" name="fromTime">
      </td>
    </tr>
    <tr> 
      <td >終止時間：</td>
      <td > 
        <input type="text"  maxlength="5" size="5" name="toTime">
      </td>
    </tr>
     <tr> 
          <td width="50%"> 
            貨運時間編號：</div>
          </td>
          <td width="50%"> 
              <select name="deliveryTimeId" >
                  <%=dbList.getDeliveryTimeList("","")%>             
              </select> 
         </td> 
     </tr>
    <tr> 
      <td >時間段描述：</td>
      <td > <input type="text" maxlength="20" size="20" name="slotDesc"></td>
    </tr>
    <tr> 
      <td >時間段中文描述：</td>
      <td > <input type="text" maxlength="10" size="10" name="slotChineseDesc"></td>
    </tr>
  </table>

    <p><input type="button" name="denglu  3" value="提交" LANGUAGE=javascript  onclick="return doPost()">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>
