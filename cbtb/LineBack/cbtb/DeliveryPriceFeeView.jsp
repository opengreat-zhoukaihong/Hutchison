<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
String cityId=request.getParameter("cityId");
String containerTypeId=request.getParameter("containerTypeId");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>運價數據維護</title>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
<a href="DeliveryPriceFeeEdit.jsp?
cityId=<%=request.getParameter("cityId").trim()%>
&containerTypeId=<%=request.getParameter("containerTypeId").trim()%>
&status=<%=request.getParameter("status").trim()%>
&ibFeeToTruck=<%=request.getParameter("ibFeeToTruck").trim()%>
&obFeeToTruck=<%=request.getParameter("obFeeToTruck").trim()%>
&ibPriceToShipper=<%=request.getParameter("ibPriceToShipper").trim()%>
&obPriceToShipper=<%=request.getParameter("obPriceToShipper").trim()%>">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">更新</font></a>
  | <a href="DeliveryPriceFeeDelView.jsp?
cityId=<%=request.getParameter("cityId").trim()%>
&containerTypeId=<%=request.getParameter("containerTypeId").trim()%>
&status=<%=request.getParameter("status").trim()%>
&ibFeeToTruck=<%=request.getParameter("ibFeeToTruck").trim()%>
&obFeeToTruck=<%=request.getParameter("obFeeToTruck").trim()%>
&ibPriceToShipper=<%=request.getParameter("ibPriceToShipper").trim()%>
&obPriceToShipper=<%=request.getParameter("obPriceToShipper").trim()%>">
	<font	color="#003366" size="2" face="Arial, Helvetica, sans-serif">刪除</font></a>
  | </font>
	<a href="javascript:history.back();"><font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a>
</p>

<p><font face="Arial, Helvetica, sans-serif" size="3">運價數據維護</font></p>
<hr>
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


