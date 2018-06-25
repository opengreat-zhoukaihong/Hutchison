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
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "create");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");
session.setAttribute("truckCapacityModel",truckCapacityModel);
session.setAttribute("companyProfileModel",companyProfileModel);
CompanyManager companyManager =  webOperator.getCompanyManager();

truckCapacityModel.setCompanyId(companyProfileModel.getCompanyId());
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

java.util.Date now = new java.util.Date();
Timestamp nowTimestamp = new Timestamp(now.getTime());

truckCapacityModel.setOriginCityId(originCityId);
truckCapacityModel.setDestinationCityId(destinationCityId);
truckCapacityModel.setDeliveryDate(request.getParameter("deliveryDate"));
truckCapacityModel.setDeliveryTimeId(request.getParameter("deliveryTimeId"));
truckCapacityModel.setSubMissionDatetime(nowTimestamp);
truckCapacityModel.setTruckCapacityStatus("1");
truckCapacityModel.setCaptureChannel(com.cbtb.util.CbtbConstant.CAPTURE_CHANNEL_INTERNET);
truckCapacityModel.setMatchOriginCityId(originCityId);
truckCapacityModel.setMatchDestCityId(destinationCityId);

StringTokenizer stringTokenizer = new StringTokenizer("");
BigDecimal deliveryFee = new BigDecimal("0");
String deliveryTimeSlot = new String();
ArrayList truckCapacityModels = new ArrayList();
TruckCapacityModel theTruckCapacityModel = new TruckCapacityModel();
for(int i=0;i<5;i++)
{
	theTruckCapacityModel = new TruckCapacityModel();
	theTruckCapacityModel.copy(truckCapacityModel);
	theTruckCapacityModel.setTrailerId(request.getParameter("trailerId"+i));
	stringTokenizer = new StringTokenizer(request.getParameter("truckerId"+i));
	theTruckCapacityModel.setTruckerId(stringTokenizer.nextToken("$"));

	if(!theTruckCapacityModel.getTruckerId().equals("Any")&&!theTruckCapacityModel.getTrailerId().equals("Any"))
	{
		deliveryFee = new BigDecimal("0");
	  deliveryTimeSlot=request.getParameter("deliveryTimeSlot"+i);
		if(deliveryTimeSlot.equals("Any"))		deliveryTimeSlot  = null;

		theTruckCapacityModel.setTruckCapacityNum(companyManager.getNewTruckCapacityNum());
		theTruckCapacityModel.setDeliveryTimeSlot(deliveryTimeSlot);
		if(deliveryFeeCan)
		{
			deliveryFee = companyManager.calculateTruckFee(theTruckCapacityModel.getTrailerId(),theTruckCapacityModel.getOriginCityId(),theTruckCapacityModel.getDestinationCityId());
			if(deliveryFee==null) deliveryFee=new BigDecimal("0");
		}
		theTruckCapacityModel.setDeliveryFee(deliveryFee);
		theTruckCapacityModel.setMatchRequestFee(deliveryFee);
		theTruckCapacityModel.setMatchOriginCityId(originCityId);
		theTruckCapacityModel.setMatchDestCityId(destinationCityId);
		theTruckCapacityModel.setRemark(request.getParameter("remark"+i));
		truckCapacityModels.add(theTruckCapacityModel);
	}
}
session.setAttribute("truckCapacityModels",truckCapacityModels);
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
    <td width="81%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">登記空車細節</font></b></font></b></font></td>
    <td width="19%">
      <div align="right">
				<a href="CapacityInsert.jsp"><font color="#003366">確定 </font></a> |
				<a href="javascript:history.back()"><font color="#003366"> 取消</font></a>
      </div>
    </td>
  </tr>
</table>
<BR>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
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
<div align="left">

  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="42%">運輸公司編號：</td>
      <td width="58%"><%=companyProfileModel.getCompanyId()%></td>
      <td width="58%">運輸公司名稱：</td>
      <td width="29%"><%=companyProfileModel.getCompanyChineseName()%></td>
      <td width="14%">送貨日期：</td>
      <td width="15%"><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
    </tr>
    <tr>
      <td width="42%">出發地城市：</td>
      <td width="58%"><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%></td>
      <td width="58%">目的地城市：</td>
      <td width="29%"><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%></td>
      <td width="14%">送貨時間：</td>
      <td width="15%"><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%> </td>
    </tr>
  </table>
<BR>
</div>

<div align="left">

<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>空車編號</td>
		<td>貨櫃車編號</td>
		<td>司機姓名</td>
		<td>車牌號碼 </td>
		<td>拖架種類</td>
		<td>送貨時段</td>
		<td>登記途徑</td>
		<td>運費</td>
		<td>狀況</td>
		<td>備註</td>
	</tr>
	<%
	boolean color = true;
	for(int i=0;i<truckCapacityModels.size();i++)
	{
		if(color)
		{
			out.write("<tr>");
			color = false;
		}
		else
		{
			out.write("<tr bgcolor=\"#ddffdd\">");
			color = true;
		}
		theTruckCapacityModel = new TruckCapacityModel();
		theTruckCapacityModel = (TruckCapacityModel)truckCapacityModels.get(i);
	%>
		<td><%=theTruckCapacityModel.getTruckCapacityNum()%></td>
		<td><%=theTruckCapacityModel.getTruckerId()%></td>
    <td><%=dbList.getTruckerName(theTruckCapacityModel.getTruckerId(),language)%>&nbsp;</td>
    <td><%=dbList.getTruckerHKPlate(theTruckCapacityModel.getTruckerId())%>&nbsp;</td>
    <td><%=dbList.getTrailerTypeDesc(theTruckCapacityModel.getTrailerId(),language)%>&nbsp;</td>
		<td><%=dbList.getDeliveryTimeSlotDesc(theTruckCapacityModel.getDeliveryTimeSlot(),language)%>&nbsp;</td>
		<td><%=dbList.getCaptureChannelDesc(theTruckCapacityModel.getCaptureChannel(),language)%>&nbsp;</td>
    <td><%
					deliveryFee = new BigDecimal("0");
					if(theTruckCapacityModel.getMatchRequestFee().equals(deliveryFee))
					{
						out.write("&nbsp");
					}
					else
					{
						out.write(theTruckCapacityModel.getMatchRequestFee().toString());
					}
				%>
			</td>
    <td><%=dbList.getTruckCapacityStatusDesc(theTruckCapacityModel.getTruckCapacityStatus(),language)%>&nbsp;</td>
    <td><%=theTruckCapacityModel.getRemark()%>&nbsp;</td>
  </tr>
  <%}%>
</table>
</div>
<%@ include file="../include/food.jsp"%>
</body>
</html>
