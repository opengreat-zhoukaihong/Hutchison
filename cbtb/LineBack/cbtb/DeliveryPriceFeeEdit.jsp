<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
String cityId=request.getParameter("cityId");
String containerTypeId=request.getParameter("containerTypeId");
%>

<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
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
   if (Trim(edit.ibFeeToTruck.value).length ==0)
   {
     alert("運費(入境)不能为空!");
     return;
   }
  if (isNaN(edit.ibFeeToTruck.value))
   { 
     alert("運費(入境)金額應為數字!");
     return;
   }
   if (Trim(edit.ibFeeToTruck.value).indexOf(".") == -1 && Trim(edit.ibFeeToTruck.value).length>6 || Trim(edit.ibFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運費(入境)金額應小於等於6位整數！");
     return ;
     }
     if (Trim(edit.obFeeToTruck.value).length ==0)
   {
     alert("運費(出境)不能为空!");
     return;
   }
  if (isNaN(edit.obFeeToTruck.value))
   { 
     alert("運費(出境)金額應為數字!");
     return;
   }
   if (Trim(edit.obFeeToTruck.value).indexOf(".") == -1 && Trim(edit.obFeeToTruck.value).length>6 || Trim(edit.obFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運費(出境)金額應小於等於6位整數！");
     return ;
     }

      if (Trim(edit.ibPriceToShipper.value).length ==0)
   {
     alert("運價(入境)不能为空!");
     return;
   }
  if (isNaN(edit.ibPriceToShipper.value))
   { 
     alert("運價(入境)金額應為數字!");
     return;
   }
   if (Trim(edit.ibPriceToShipper.value).indexOf(".") == -1 && Trim(edit.obFeeToTruck.value).length>6 || Trim(edit.obFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運價(入境)金額應小於等於6位整數！");
     return ;
     }
         if (Trim(edit.obPriceToShipper.value).length ==0)
   {
     alert("運價(出境)不能为空!");
     return;
   }
  if (isNaN(edit.obPriceToShipper.value))
   { 
     alert("運價(出境)金額應為數字!");
     return;
   }
   if (Trim(edit.obPriceToShipper.value).indexOf(".") == -1 && Trim(edit.obFeeToTruck.value).length>6 || Trim(edit.obFeeToTruck.value).indexOf(".") >6 )
    {
     alert("運價(出境)金額應小於等於6位整數！");
     return ;
     }
   if(parseFloat(edit.obPriceToShipper.value) < parseFloat(edit.obFeeToTruck.value))
     {
       alert("運價(出境)金額不能小於運費(出境)金額！");
       return;
     }
   if(parseFloat(edit.ibPriceToShipper.value) < parseFloat(edit.ibFeeToTruck.value))
     {
       alert("運價(入境)金額不能小於運費(入境)金額！");
       return;
     }

   edit.submit();
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

<p><font face="Arial, Helvetica, sans-serif" size="3">運價數據維護</font></p>
<hr>
<form method="post" name="edit" action = "DeliveryPriceFeeConfirm.jsp">
<input type="hidden" name="URL" value="DeliveryPriceFeeUpdate.jsp">

<table width="56%" border="0">
  <tr>
    <td width="50%">貨櫃種類：</td>
    <td width="50%"><%=dbList.getContainerTypeDesc(containerTypeId, "CN")%> </td>
      <input type="hidden" name="containerTypeId" value="<%=request.getParameter("containerTypeId")%>">
  </tr>
  <tr>
    <td width="50%">城市：</td>
    <td width="50%"><%=dbList.getCityDesc(cityId, "CN")%></td>
      <input type="hidden" name="cityId" value="<%=request.getParameter("cityId")%>">
  </tr>
  <tr>
    <td width="50%">運費(入境)：</td>
    <td width="50%">
    <input type="text" name="ibFeeToTruck" value="<%=request.getParameter("ibFeeToTruck")%>" 
      size="8" maxlength="9" >
    </td>
  </tr>
  <tr>
    <td width="50%">運費(出境)：</td>
    <td width="50%">
    <input type="text" name="obFeeToTruck" value="<%=request.getParameter("obFeeToTruck")%>"
      size="8" maxlength="9" >
    </td>
  </tr>
  <tr>
    <td width="50%">運價(入境)：</td>
    <td width="50%">
    <input type="text" name="ibPriceToShipper" value="<%=request.getParameter("ibPriceToShipper")%>"
      size="8" maxlength="9" >
    </td>
  </tr>
  <tr>
    <td width="50%">運價(出境)：</td>
    <td width="50%">
    <input type="text" name="obPriceToShipper" value="<%=request.getParameter("obPriceToShipper")%>"
      size="8" maxlength="9" >
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