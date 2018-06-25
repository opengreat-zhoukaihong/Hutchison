<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間數據維護</title>

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.deliveryTimeId.value =="")
   {
     alert("貨運時間编码不能为空!");
     add.deliveryTimeId.focus();
     return;
   }
   else
   {
     if(add.deliveryTimeId.value.length > 5)
     {
        alert("貨運時間编码不能超過五位!");
        add.deliveryTimeId.focus();
        return;
     }
   }
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
        alert("英文描述不能超過20位!");
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
        alert("中文描述不能超過20位!");
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
<p align="right"><a href="javascript:history.go(-1)"><font
color="#003366"  size="2">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間數據維護</font></p>

<form name="add" action="DeliveryTimeAddConfirm.jsp" method="POST">
  <table width="60%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td >編號：</td>
      <td > 
        <input type="text" name="deliveryTimeId" maxlength="5" size="5">
      </td>
    </tr>
    <tr> 
      <td >英文描述：</td>
      <td > 
        <input type="text" name="deliveryTimeDesc" maxlength="20" size="20">
      </td>
    </tr>
    <tr> 
      <td >中文描述：</td>
      <td > 
        <input type="text" name="chineseDesc" maxlength="10" size="10">
      </td>
    </tr>
  </table>
    <p><input type="button" name="denglu  3" value="提 交" LANGUAGE=javascript  onclick="return doPost()">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>
