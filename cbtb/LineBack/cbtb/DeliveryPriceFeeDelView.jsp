<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
String cityId=request.getParameter("cityId");
String containerTypeId=request.getParameter("containerTypeId");
%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>運價數據維護</title>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="DeliveryPriceFeeDelete.jsp?cityId=<%=request.getParameter("cityId")%>&containerTypeId=<%=request.getParameter("containerTypeId")%>">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a>
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">
	| <a href="javascript:history.back();">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a>
</p>

<p><font face="Arial, Helvetica, sans-serif" szie="3">運價數據維護</font></p>

<hr>
<p><font face="Arial, Helvetica, sans-serif" color="#FF0033">刪除這條記錄嗎?</font></font></p>
<table width="56%" border="0">
  <tr>
    <td width="50%">貨櫃種類：</td>
    <td width="50%"><%=dbList.getContainerTypeDesc(containerTypeId, "CN")%> </td>
  </tr>
  <tr>
    <td width="50%">城市：</td>
    <td width="50%"><%=dbList.getCityDesc(cityId, "CN")%></td>
  </tr>
  <tr>
    <td width="50%">運費(入境)：</td>
    <td width="50%"><%=request.getParameter("ibFeeToTruck")%></td>
  </tr>
  <tr>
    <td width="50%">運費(出境)：</td>
    <td width="50%"><%=request.getParameter("obFeeToTruck")%></td>
  </tr>
  <tr>
    <td width="50%">運價(入境)：</td>
    <td width="50%"><%=request.getParameter("ibPriceToShipper")%></td>
  </tr>
  <tr>
    <td width="50%">運價(出境)：</td>
    <td width="50%"><%=request.getParameter("obPriceToShipper")%></td>
  </tr>
</table>
</body>
</html>
