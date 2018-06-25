<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "cancel");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");
session.setAttribute("truckCapacityModel",truckCapacityModel);
%>

<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/headtrucker.jsp"%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<BR>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="right">
			<a href="CapacityDelete.jsp"><font color="#003366">確定</font></a>
			<font color="#003366"> | </font>
			<a href="javascript:history.back()"><font color="#003366">取消</font></a></div>
    </td>
  </tr>
</table>
<BR>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="9">
      <div align="right">空車編號：<%=truckCapacityModel.getTruckCapacityNum()%></div>
    </td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">刪除這個空車貨運紀錄細節嗎?</font></font></td>
  </tr>
</table>
<BR>
<div align="left">
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td>運輸公司編號：</td>
        <td><%=companyProfileModel.getCompanyId()%></td>
    </tr>
    <tr>
        <td>運輸公司名稱：</td>
        <td><%=companyProfileModel.getCompanyChineseName()%></td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%></td>
    </tr>
    <tr>
        <td>目的地城市：</td>
        <td><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%></td>
    </tr>
    <tr>
        <td>送貨日期：</td>
        <td><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
    </tr>
    <tr>
        <td>送貨時段：</td>
        <td><%=dbList.getDeliveryTimeSlotDesc(truckCapacityModel.getDeliveryTimeSlot(),language)%></td>
    </tr>
    <tr>
        <td>送貨時間：</td>
        <td><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%></td>
    </tr>
    <tr>
        <td>拖架種類：</td>
        <td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%></td>
    </tr>
    <tr>
        <td>備註：</td>
        <td><%=truckCapacityModel.getRemark()%>&nbsp;</td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
    </tr>
    <tr>
        <td>運費：</td>
        <td><%
							BigDecimal deliveryFee = new BigDecimal("0");
							if(truckCapacityModel.getMatchRequestFee().equals(deliveryFee))
							{
								out.write("&nbsp");
							}
							else
							{
								out.write(truckCapacityModel.getMatchRequestFee().toString());
							}
						%>
			  </td>
    </tr>
    <tr>
        <td>登記途徑：</td>
        <td><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
    </tr>
    <tr>
        <td>配對編號：</td>
        <td><%=truckCapacityModel.getMatchNumber()%></td>
    </tr>
</table>
</div>
<BR>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨櫃車司機細節</font></b></font></td>
  </tr>
</table>
<div align="left">
  <table cellpadding="4" cellspacing="" width="98%" align="center">
    <tr bgcolor="e0e0e0">
      <td height="28">貨櫃車編號 </td>
        <td>貨櫃車司機姓名</td>
        <td>車牌號碼 </td>
    </tr>
    <tr>
      <td height="28"><%=truckCapacityModel.getTruckerId()%></td>
      <td height="21"><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%></td>
      <td height="21"><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%></td>
    </tr>
</table>
</div>
<%@ include file="../include/food.jsp"%>
</body>
</html>