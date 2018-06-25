<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<HTML>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>運價數據維護</title>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>

<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
  if (add.containerTypeId.value =="Any")
   {
     alert("货柜种类不能为空!");
     return;
   }
  if (add.cityId.value =="Any")
   {
     alert("城市不能为空!");
     return;
   }
  if (Trim(add.ibFeeToTruck.value).length ==0)
   {
     alert("運費(入境)不能为空!");
     return;
   }
  if (isNaN(add.ibFeeToTruck.value))
   { 
     alert("運費(入境)金額應為數字!");
     return;
   }
   if (Trim(add.ibFeeToTruck.value).indexOf(".") == -1 && Trim(add.ibFeeToTruck.value).length>6 || Trim(add.ibFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運費(入境)金額應小於等於6位整數！");
     return ;
     }
     if (Trim(add.obFeeToTruck.value).length ==0)
   {
     alert("運費(出境)不能为空!");
     return;
   }
  if (isNaN(add.obFeeToTruck.value))
   { 
     alert("運費(出境)金額應為數字!");
     return;
   }
   if (Trim(add.obFeeToTruck.value).indexOf(".") == -1 && Trim(add.obFeeToTruck.value).length>6 || Trim(add.obFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運費(出境)金額應小於等於6位整數！");
     return ;
     }

      if (Trim(add.ibPriceToShipper.value).length ==0)
   {
     alert("運價(入境)不能为空!");
     return;
   }
  if (isNaN(add.ibPriceToShipper.value))
   { 
     alert("運價(入境)金額應為數字!");
     return;
   }
   if (Trim(add.ibPriceToShipper.value).indexOf(".") == -1 && Trim(add.obFeeToTruck.value).length>6 || Trim(add.obFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運價(入境)金額應小於等於6位整數！");
     return ;
     }
         if (Trim(add.obPriceToShipper.value).length ==0)
   {
     alert("運價(出境)不能为空!");
     return;
   }
  if (isNaN(add.obPriceToShipper.value))
   { 
     alert("運價(出境)金額應為數字!");
     return;
   }
   if (Trim(add.obPriceToShipper.value).indexOf(".") == -1 && Trim(add.obFeeToTruck.value).length>6 || Trim(add.obFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運價(出境)金額應小於等於6位整數！");
     return ;
     }

   if(parseFloat(add.obPriceToShipper.value) < parseFloat(add.obFeeToTruck.value))
     {
       alert("運價(出境)金額不能小於運費(出境)金額！");
       return;
     }
   if(parseFloat(add.ibPriceToShipper.value) < parseFloat(add.ibFeeToTruck.value))
     {
       alert("運價(入境)金額不能小於運費(入境)金額！");
       return;
     }

   add.submit();
}
</SCRIPT>
</head>

<body bgcolor="ffffff">
<%@ include file="../include/head.jsp"%>
<p align="right">
	<a href="javascript:history.back();">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font>
	</a>
</p>

<p><font face="Arial, Helvetica, sans-serif" size="3" >運價數據維護</font></p>
<hr>
<form method="post" name="add" action="DeliveryPriceFeeConfirm.jsp">
<input type="hidden" name="URL" value="DeliveryPriceFeeInsert.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">货柜种类：</td>
	<td width="50%">
	<select name="containerTypeId" >
		<%=dbList.getContainerTypeList("","")%>
	</select>
    </td>
 </tr>
  <tr>
    <td width="50%">城市：</td>
	<td width="50%">
	<select name="cityId" >
		<%=dbList.getCityList("","")%>
	</select>
    </td>
 </tr>
 <tr>
    <td width="50%">運費（入境）：</td>
    <td width="50%">
	<input type="text" name="ibFeeToTruck" value=""size="8" maxlength="9" ></td>
 </tr>
 <tr>
   <td width="50%">運費（出境）：</td>
   <td width="50%">
	<input type="text" name="obFeeToTruck" value=""size="8" maxlength="8" >
   </td>
 </tr>
 <tr>
    <td width="50%">運價（入境）：</td>
    <td width="50%">
	<input type="text" name="ibPriceToShipper" value=""size="8" maxlength="8" >
    </td>
 </tr>
 <tr>
    <td width="50%">運價（出境）：</td>
    <td width="50%">
	<input type="text" name="obPriceToShipper" value=""size="8" maxlength="8" >
    </td>
 </tr>
</table>
<p>
	<input type="button" name="post" onClick="javascript:doPost()" value="提交">&nbsp;&nbsp;
	<input type="reset" name="clear" value="清除">
</p>
</form>
</body>
</html>
