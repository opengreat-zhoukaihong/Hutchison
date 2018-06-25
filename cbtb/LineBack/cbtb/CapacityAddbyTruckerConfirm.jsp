<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckerDataModel" scope="session" class="com.cbtb.model.TruckerDataModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "create");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = (String)session.getAttribute("language");
CompanyManager companyManager =  webOperator.getCompanyManager();
truckerDataModel = (TruckerDataModel)session.getAttribute("truckerDataModel");
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");

boolean deliveryFeeCan = true;
String originCityId=request.getParameter("originCityId");
if(originCityId.equals("Any"))
{
	originCityId= null;
	deliveryFeeCan = false;
}
String destinationCityId=request.getParameter("destinationCityId");
if(destinationCityId.equals("Any"))
{
	destinationCityId  = null;
	deliveryFeeCan = false;
}
String deliveryTimeSlot=request.getParameter("deliveryTimeSlot");
if(deliveryTimeSlot.equals("Any"))		deliveryTimeSlot  = null;
BigDecimal deliveryFee = new BigDecimal("0");
java.util.Date now = new java.util.Date();
Timestamp nowTimestamp = new Timestamp(now.getTime());

truckCapacityModel.setTruckCapacityNum(companyManager.getNewTruckCapacityNum());
truckCapacityModel.setCompanyId(truckerDataModel.getCompanyId());
truckCapacityModel.setTruckerId(truckerDataModel.getTruckerId());
truckCapacityModel.setOriginCityId(originCityId);
truckCapacityModel.setDestinationCityId(destinationCityId);
truckCapacityModel.setDeliveryTimeSlot(deliveryTimeSlot);
truckCapacityModel.setDeliveryDate(request.getParameter("deliveryDate"));
truckCapacityModel.setDeliveryTimeId(request.getParameter("deliveryTimeId"));
truckCapacityModel.setRemark(request.getParameter("remark"));
truckCapacityModel.setCaptureChannel(request.getParameter("captureChannel"));
truckCapacityModel.setTrailerId(request.getParameter("trailerId"));
truckCapacityModel.setTruckCapacityStatus("1");
if(deliveryFeeCan)
{
	deliveryFee = companyManager.calculateTruckFee(truckCapacityModel.getTrailerId(),truckCapacityModel.getOriginCityId(),truckCapacityModel.getDestinationCityId());
	if(deliveryFee==null) deliveryFee=new BigDecimal("0");
}
truckCapacityModel.setDeliveryFee(deliveryFee);
truckCapacityModel.setSubMissionDatetime(nowTimestamp);
truckCapacityModel.setMatchRequestFee(deliveryFee);
truckCapacityModel.setMatchOriginCityId(originCityId);
truckCapacityModel.setMatchDestCityId(destinationCityId);

ArrayList truckCapacityModels = new ArrayList();
truckCapacityModels.add(truckCapacityModel);
session.setAttribute("truckCapacityModels",truckCapacityModels);
%>

<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/head.jsp"%>
<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11">登記空車細節</td>
    <td height="11">
      <div align="right">
				<font color="#003366"><a href="CapacityInsert.jsp">確定</a></font> | <font color="#003366"><a href="javascript:history.back()">取消</a></font></div>
    </td>
  </tr>
</table><BR>

<font size="2" face="Arial, Helvetica, sans-serif">
	貨櫃車編號：<%=truckerDataModel.getTruckerId()%>&nbsp;&nbsp;
  司機姓名：<%=truckerDataModel.getTruckerChineseName()%>
</font>

<table border="0" width="90%">
  <tr>
      <td><font size="2"><em>公司名稱： </em></font></td>
      <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%></em></font></td>
      <td><font size="2"><em>公司聯絡人： </em></font></td>
      <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%></em></font></td>
  </tr>
  <tr>
      <td><font size="2"><em>電話號碼：</em></font></td>
      <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%></em></font></td>

  <td><font size="2"><em>手提電話號碼：</em></font></td>
      <td><font size="2"><em><%=companyProfileModel.getMobileNo()%></em></font></td>
  </tr>
  <tr>

  <td><font size="2">貨櫃車牌照號碼</font></td>
      <td><font size="2"><em><%=truckerDataModel.getHkPagerNo()%></em></font></td>

  <td><font size="2">香港駕照號<em>：</em></font></td>
      <td><font size="2"><em><%=truckerDataModel.getHkLicenseNo()%></em></font></td>
  </tr>
</table>
<BR>
<div align="left">
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="35%" height="30">出發地城市：</td>
      <td width="22%"><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%></td>
      <td width="30%">目的地城市：</td>
      <td width="13%"><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%></td>
    </tr>
    <tr>
      <td width="35%" height="30">送貨日期：</td>
      <td width="22%" ><%=truckCapacityModel.getDeliveryDate().toString().trim().substring(0,10)%>&nbsp;</td>
      <td width="30%" >送貨時間：</td>
      <td width="13%" ><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%> </td>
    </tr>
    <tr>
      <td width="35%" height="30">送貨時間段：</td>
      <td width="22%"><%=dbList.getDeliveryTimeSlotDesc(truckCapacityModel.getDeliveryTimeSlot(),language) %>&nbsp;</td>
      <td width="30%">登記途徑：</td>
      <td width="13%"><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
    </tr>
    <tr>
      <td width="35%" height="30">拖架種類：</td>
      <td width="22%"><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%></td>
      <td width="30%">狀態</td>
      <td width="13%"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
    </tr>
    <tr>
      <td width="35%" height="30">運費：</td>
      <td width="22%"><%
												deliveryFee = new BigDecimal("0");
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
      <td width="30%">備註：</td>
      <td width="13%"><%=truckCapacityModel.getRemark()%></td>
    </tr>

  </table>
</div>
</body>
</html>