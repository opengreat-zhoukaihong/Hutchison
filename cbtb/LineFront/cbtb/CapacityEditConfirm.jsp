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
<%@ page import="java.sql.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "edit");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");

CompanyManager companyManager =  webOperator.getCompanyManager();

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
if(deliveryTimeSlot.equals("Any"))
{
	deliveryTimeSlot  = null;
}

java.util.Date now = new java.util.Date();
Timestamp nowTimestamp = new Timestamp(now.getTime());
StringTokenizer stringTokenizer = new StringTokenizer(request.getParameter("truckerId"));

truckCapacityModel.setTruckCapacityNum(truckCapacityModel.getTruckCapacityNum());
truckCapacityModel.setTruckerId(stringTokenizer.nextToken("$"));
truckCapacityModel.setCompanyId(companyProfileModel.getCompanyId());
truckCapacityModel.setOriginCityId(originCityId);
truckCapacityModel.setDestinationCityId(destinationCityId);
truckCapacityModel.setDeliveryDate(request.getParameter("deliveryDate"));
truckCapacityModel.setDeliveryTimeId(request.getParameter("deliveryTimeId"));
truckCapacityModel.setDeliveryTimeSlot(deliveryTimeSlot);
truckCapacityModel.setTrailerId(request.getParameter("trailerId"));
truckCapacityModel.setMatchNumber(null);
BigDecimal deliveryFee = new BigDecimal("0");
if(deliveryFeeCan)
{
	deliveryFee = companyManager.calculateTruckFee(truckCapacityModel.getTrailerId(),truckCapacityModel.getOriginCityId(),truckCapacityModel.getDestinationCityId());
	if(deliveryFee==null) deliveryFee=new BigDecimal("0");
}
truckCapacityModel.setDeliveryFee(deliveryFee);
truckCapacityModel.setRemark(request.getParameter("remark"));
truckCapacityModel.setTruckCapacityStatus("1");
truckCapacityModel.setSubMissionDatetime(nowTimestamp);
truckCapacityModel.setCaptureChannel(com.cbtb.util.CbtbConstant.CAPTURE_CHANNEL_INTERNET);
truckCapacityModel.setMatchOriginCityId(originCityId);
truckCapacityModel.setMatchDestCityId(destinationCityId);
truckCapacityModel.setMatchRequestFee(deliveryFee);
session.setAttribute("truckCapacityModel",truckCapacityModel);
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/headtrucker.jsp"%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><b><font color="#667852">確認修改</font></b></td>
    <td>
      <div align="right"><a href="CapacityUpdate.jsp"><font color="#003366">確定</font></a>
			<font color="#003366"> | </font>
			<a href="javascript:history.back()"><font color="#003366">取消</font></a></div>
    </td>
  </tr>
</table>
<BR>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="right">提交日期：<%=truckCapacityModel.getSubMissionDatetime().toString().substring(0,10)%></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="right">提交時間：<%=truckCapacityModel.getSubMissionDatetime().toString().substring(11,16)%></div>
    </td>
  </tr>
</table>
<BR>
<table cellpadding="4" cellspacing="0" width="98%" align="center" >
  <tr>
    <td width="100">運輸公司編號：</td>
    <td width="30%"><%=companyProfileModel.getCompanyId()%></td>
    <td width="100">運輸公司名稱：</td>
    <td width="37%"><%=companyProfileModel.getCompanyChineseName()%></td>
  </tr>
  <tr>
    <td width="100">出發地城市：</td>
    <td width="30%"><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%></td>
    <td width="100">目的地城市：</td>
    <td width="37%"><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%></td>
  </tr>
  <tr>
    <td width="100">送貨日期：</td>
    <td width="30%"><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
    <td width="100">送貨時間：</td>
    <td width="37%"><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%></td>
  </tr>
  <tr>
    <td width="100">備註：</td>
    <td width="30%"><%=truckCapacityModel.getRemark()%></td>
    <td width="100">狀況：</td>
    <td width="37%"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
  </tr>
  <tr>
    <td width="100" height="19">登記途徑：</td>
    <td width="30%" height="19"><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
    <td width="100" height="19">費用：</td>
    <td width="37%" height="19"><%
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
  </tr>
</table>
<BR>
<b><font color="#667852">&nbsp;貨櫃車司機列表</font></b>
<BR>
<table cellpadding="4" cellspacing="0" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td height="30">貨櫃車編號 </td>
      <td>貨櫃車司機姓名 </td>
      <td>車牌號碼  </td>
      <td>拖架種類</td>
      <td>送貨時段</td>
  </tr>
  <tr>
    <td height="30"><%=truckCapacityModel.getTruckCapacityNum()%></td>
    <td><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%></td>
    <td><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%></td>
    <td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%></td>
		<td><%=dbList.getDeliveryTimeSlotDesc(truckCapacityModel.getDeliveryTimeSlot(),language)%></td>
  </tr>
</table>
<%@ include file="../include/food.jsp"%>
</body>
</html>