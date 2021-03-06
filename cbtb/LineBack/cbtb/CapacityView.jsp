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

String language="CH";
String truckCapacityNum = request.getParameter("truckCapacityNum");
String backPage = "CapacityView.jsp?truckCapacityNum="+ truckCapacityNum;
session.setAttribute("backPage",backPage);

CompanyManager companyManager = webOperator.getCompanyManager();
truckCapacityModel = companyManager.findTruckCapacity(truckCapacityNum);
companyProfileModel = companyManager.findCompanyProfile(truckCapacityModel.getCompanyId());

session.setAttribute("companyProfileModel",companyProfileModel);
session.setAttribute("truckCapacityModel",truckCapacityModel);
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
      <div align="right"><font color="#003366">
			<%
			if(truckCapacityModel.getTruckCapacityStatus().equals(com.cbtb.util.CbtbConstant.TRUCK_CAPACITY_POST))
			{
			%>
			<a href="CapacityStatusEdit.jsp">更新狀況</a> |
			<a href="CapacityEdit.jsp">更新細節</a></font> |
			<a href="MatchDelivery.jsp?truckCapacityNum=<%=truckCapacityModel.getTruckCapacityNum()%>&t_change=1">直接配對</a> |
			<%}%>
			<a href="CapacitySearch.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table><BR>
<p align="left"><font size="2"face="Arial, Helvetica, sans-serif">公司編號：<%=companyProfileModel.getCompanyId()%></font></p>
<table border="0" width="90%">
  <tr>
    <td><font size="2"><em>公司名稱： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%></em></font></td>
    <td><font size="2"><em>公司聯絡人： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%></em></font></td>
  </tr>
  <tr>
    <td><font size="2"><em>電話號碼：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%> </em></font></td>
    <td><font size="2"><em>傳真號碼：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getFaxNo()%></em></font></td>
  </tr>
  <tr>
    <td><font size="2"><em>手提電話號碼： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getMobileNo()%></em></font></td>
    <td><font size="2"><em>電郵地址：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getEmailAddr()%></em></font></td>
  </tr>
</table>
<BR>
<div align="left">

  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="44%" height="30">空車編號：</td>
      <td width="28%"><%=truckCapacityModel.getTruckCapacityNum()%></td>
      <td width="28%">提交日期：</td>
      <td width="56%"><%=truckCapacityModel.getSubMissionDatetime()%></td>
      <td width="56%">狀態：</td>
      <td width="56%"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
    </tr>
    <tr>
      <td width="44%" height="30">出發地城市：</td>
      <td width="0%"><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%></td>
      <td width="0%">目的地城市：</td>
      <td width="0%"><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%></td>
      <td width="0%">送貨日期：</td>
      <td width="56%"><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
    </tr>
    <tr>
      <td width="44%" height="30">送貨時間：</td>
      <td width="0%" height="11"><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%></td>
      <td width="0%" height="11">送貨時段：</td>
      <td width="0%" height="11"><%=dbList.getDeliveryTimeSlotDesc(truckCapacityModel.getDeliveryTimeSlot(),language)%>&nbsp;</td>
      <td width="0%" height="11">拖架種類：</td>
      <td width="56%" height="11"><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%>&nbsp;</td>
    </tr>
    <tr>
      <td width="44%" height="30">貨櫃車編號：</td>
      <td width="0%"><%=truckCapacityModel.getTruckCapacityNum()%></td>
      <td width="0%">貨櫃車司機姓名：</td>
      <td width="0%"><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%>&nbsp;</td>
      <td width="0%">車牌號碼：</td>
      <td width="56%"><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>&nbsp;</td>
    </tr>
    <tr>
      <td width="44%" height="30">登記途徑：</td>
      <td width="0%"><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
      <td width="0%">運費：</td>
      <td width="0%"><%
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
      <td width="0%">配對編號：</td>
      <td width="56%"><%=truckCapacityModel.getMatchNumber()%></td>
    </tr>
    <tr>
      <td width="44%" height="30">備註：</td>
      <td width="56%" colspan="5"><%=truckCapacityModel.getRemark()%></td>
    </tr>
  </table>
</div>
</body>
</html>