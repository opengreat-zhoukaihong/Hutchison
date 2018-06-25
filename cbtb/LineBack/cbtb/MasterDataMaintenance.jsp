<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>系統數據維護</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<body bgcolor="#FFFFFF">
</head>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","SYSTEM_MAINTENANCE"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<table border="0" cellspacing="2" cellpadding="2" width="70%">
  <tr> 
    <td height="30"><font size="2"><a href="DeliveryTimeList.jsp">
     <font color="#003366" face="Arial, Helvetica, sans-serif">
      貨運時間表</font></a></font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="DeliveryTimeSlotList.jsp">
      <font color="#003366" face="Arial, Helvetica, sans-serif">
      貨運時間段表</font></a>
    </font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="TrailerTypeList.jsp">
	<font color="#003366" face="Arial, Helvetica, sans-serif">
	拖架種類</font></a>
    </font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="ContainerTypeList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        貨櫃種類</font></a>
    </font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="DeliveryPriceFeeList.jsp">
      <font face="Arial, Helvetica, sans-serif" color="#003366">
      貨運價格</font></a> 
    </font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="AdditionalFeeList.jsp">
       <font color="#003366"face="Arial, Helvetica, sans-serif">
       附加費用</font></a> 
    </font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="ZoneList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
         區域</font></a> 
    </font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="CityList.jsp">
    <font face="Arial, Helvetica, sans-serif" color="#003366">
    城市</font></a></font></td>
  </tr>
  <tr> 
      <td height="30"><font size="2"><a href="ShippingLineList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        航運公司</font></a></font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="CargoCategoryList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        貨物種類</font></a></font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="PackageUomList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        度量單位表</font></a></font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="DepotList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        貨場</font></a></font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="ReasonCodeList.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        原因代碼</font></a></font></td>
  </tr>
  <tr> 
    <td height="30"><font size="2"><a href="SystemParameterView.jsp">
	<font face="Arial, Helvetica, sans-serif" color="#003366">
        系統處理參數</font></a></font></td>
  </tr>
</table>
</body>
</html>
