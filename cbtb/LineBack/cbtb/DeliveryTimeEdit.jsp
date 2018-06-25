<%@ include file="Init.jsp"%>  
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
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.deliveryTimeDesc.value =="")
   {
     alert("英文描述不能為空!");
     add.deliveryTimeDesc.focus();
     return;
    }
    else
    {
     if(add.deliveryTimeDesc.value.length > 20)
     {
        alert("英文描述不能超過二十位!");
        add.deliveryTimeDesc.focus();
        return;
     }
   }
   if (add.chineseDesc.value =="")
   {
     alert("中文描述不能為空!");
     add.chineseDesc.focus();
     return;
     }
    else
    {
     if(add.chineseDesc.value.length > 20)
     {
        alert("中文描述不能超過二十位!");
        add.chineseDesc.focus();
        return;
     }
   }
    add.submit();
}
</SCRIPT>

</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right">
	<a href="javascript:history.back();">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font>
	</a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間數據維護</font></p>

<hr>
<form  name="add" action="DeliveryTimeConfirm.jsp" method="POST">
<table width="56%" border="0">
<%
String deliveryTimeId=request.getParameter("deliveryTimeId");
%>
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"> 
  <%=request.getParameter("deliveryTimeId")%>
  <input type="hidden" name="deliveryTimeId" value="<%=request.getParameter("deliveryTimeId")%>">
    </td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"> 
      <input type="text" name="deliveryTimeDesc" maxlength="20" size="20" value="<%=dbList.getDeliveryTimeDesc(deliveryTimeId,"EN")%>">
    </td>
  </tr>
  <tr> 
    <td width="50%">中文描述：</td>
    <td width="50%"> 
      <input type="text" name="chineseDesc" maxlength="10" size="20" value="<%=dbList.getDeliveryTimeDesc(deliveryTimeId,"CH")%>">
    </td>
  </tr>
</table>
<p>&nbsp;</p>
    <p><input type="button" name="denglu  3" value="提 交" LANGUAGE=javascript  onclick="return doPost()">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>