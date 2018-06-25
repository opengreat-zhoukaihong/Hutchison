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
webOperator.putPermissionContext("action", "view");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
CompanyManager companyManager = webOperator.getCompanyManager();
truckCapacityModel = companyManager.findTruckCapacity(request.getParameter("truckCapacityNum"));
session.setAttribute("truckCapacityModel",truckCapacityModel);
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/headtrucker.jsp"%>
<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">登記空車貨運紀錄細節</font></b></font></td>
    <td>
      <div align="right">
			<%
			if(truckCapacityModel.getTruckCapacityStatus().equals(com.cbtb.util.CbtbConstant.TRUCK_CAPACITY_POST))
			{
			%>
				<a href="CapacityDeleteView.jsp"><font color="#003366">刪除</font></a>
				<font color="#003366"> | </font>
				<a href="CapacityEdit.jsp"><font color="#003366">更新細節</font></a> |
			<%}%>
			<a href="javascript:history.back()"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>&nbsp;&nbsp;空車編號：<%=truckCapacityModel.getTruckCapacityNum()%><BR>
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="18%">運輸公司編號：</td>
    <td width="27%"><%=companyProfileModel.getCompanyId()%></td>
    <td width="17%">運輸公司名稱：</td>
    <td width="19%"><%=companyProfileModel.getCompanyChineseName()%></td>
    <td width="9%">送貨日期：</td>
    <td width="10%"><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
  </tr>
  <tr>
    <td width="18%">出發地城市：</td>
    <td width="27%"><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%></td>
    <td width="17%">目的地城市：</td>
    <td width="19%"><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%></td>
    <td width="9%">送貨時段：</td>
    <td width="10%"><%=dbList.getDeliveryTimeSlotDesc(truckCapacityModel.getDeliveryTimeSlot(),language)%></td>
  </tr>
  <tr>
    <td width="18%">送貨時間：</td>
    <td width="27%"><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%></td>
    <td width="17%">拖架種類：</td>
    <td width="19%"><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%></td>
    <td width="9%">登記途徑：</td>
    <td width="10%"><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
  </tr>
  <tr>
    <td width="18%">配對編號：</td>
    <td width="27%"><%=truckCapacityModel.getMatchNumber()%></td>
    <td width="17%">狀況：</td>
    <td width="19%"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
    <td width="9%">運費：</td>
    <td width="10%"><%
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
  </tr>
	<tr>
    <td>備註：</td>
    <td><%=truckCapacityModel.getRemark()%>&nbsp;</td>
  </tr>
</table>
<BR>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨櫃車司機細節</font></b></font></td>
  </tr>
</table>
<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>貨櫃車編號  </td>
    <td>貨櫃車司機姓名  </td>
    <td>車牌號碼 </td>
  </tr>
  <tr>
    <td><%=truckCapacityModel.getTruckerId()%></td>
    <td><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%></td>
    <td><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%></td>
  </tr>
</table>
<%@ include file="../include/food.jsp"%>
</body>
</html>