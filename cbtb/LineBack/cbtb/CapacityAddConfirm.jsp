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
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "create");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");

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
truckCapacityModel.setOriginCityId(originCityId);
truckCapacityModel.setDestinationCityId(destinationCityId);
truckCapacityModel.setDeliveryDate(request.getParameter("deliveryDate"));
truckCapacityModel.setDeliveryTimeId(request.getParameter("deliveryTimeId"));
truckCapacityModel.setRemark(request.getParameter("remark"));
truckCapacityModel.setCaptureChannel(request.getParameter("captureChannel"));
truckCapacityModel.setTruckCapacityStatus("1");

TruckCapacityModel theTruckCapacityModel = new TruckCapacityModel();
StringTokenizer stringTokenizer = new StringTokenizer("");
BigDecimal deliveryFee = new BigDecimal("0");
String deliveryTimeSlot = new String();
java.util.Date now = new java.util.Date();
Timestamp nowTimestamp = new Timestamp(now.getTime());
ArrayList truckCapacityModels = new ArrayList();

for(int i=0;i<5;i++)
{
	theTruckCapacityModel = new TruckCapacityModel();
	theTruckCapacityModel.copy(truckCapacityModel);
	stringTokenizer = new StringTokenizer(request.getParameter("truckerId"+i));
	theTruckCapacityModel.setTruckerId(stringTokenizer.nextToken("$"));
	theTruckCapacityModel.setTrailerId(request.getParameter("trailerId"+i));

	if(!theTruckCapacityModel.getTruckerId().equals("Any")&&!theTruckCapacityModel.getTrailerId().equals("Any"))
	{
		deliveryFee = new BigDecimal("0");
		if(deliveryFeeCan)
		{
			deliveryFee = companyManager.calculateTruckFee(theTruckCapacityModel.getTrailerId(),originCityId,destinationCityId);
			if(deliveryFee==null) deliveryFee=new BigDecimal("0");
		}
		deliveryTimeSlot=request.getParameter("deliveryTimeSlot"+i);
		if(deliveryTimeSlot.equals("Any"))		deliveryTimeSlot  = null;

		theTruckCapacityModel.setSubMissionDatetime(nowTimestamp);
		theTruckCapacityModel.setTruckCapacityNum(companyManager.getNewTruckCapacityNum());
		theTruckCapacityModel.setDeliveryTimeSlot(deliveryTimeSlot);
		theTruckCapacityModel.setDeliveryFee(deliveryFee);
		theTruckCapacityModel.setMatchRequestFee(deliveryFee);
		theTruckCapacityModel.setMatchOriginCityId(originCityId);
		theTruckCapacityModel.setMatchDestCityId(destinationCityId);

		truckCapacityModels.add(theTruckCapacityModel);
	}
}
System.out.println("truckCapacityModels.size="+truckCapacityModels.size());
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
      <div align="right"><font color="#003366"><a href="CapacityInsert.jsp">確定</a></font> | <font color="#003366"><a href="javascript:history.back()">取消</a></font></div>
    </td>
  </tr>
</table>
<BR>
<p align="left">
<font size="2" face="Arial, Helvetica, sans-serif">
	公司編號： <%=companyProfileModel.getCompanyId()%>
</font></p>
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
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="35%" height="30">出發地城市：</td>
      <td width="22%"><%=dbList.getCityDesc(truckCapacityModel.getOriginCityId(),language)%></td>
      <td width="30%">目的地城市：</td>
      <td width="13%"><%=dbList.getCityDesc(truckCapacityModel.getDestinationCityId(),language)%></td>
    </tr>
    <tr>
      <td width="35%" height="30">送貨日期：</td>
      <td width="22%" ><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
      <td width="30%" >送貨時間：</td>
      <td width="13%" ><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%> </td>
    </tr>
    <tr>
      <td width="35%" height="30">登記途徑：</td>
      <td width="22%"><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
      <td width="30%">備註：</td>
      <td width="13%"><%=truckCapacityModel.getRemark()%></td>
    </tr>
  </table>
</div>

<p align="left">貨櫃車司機列表</p>
<div align="left">

  <table border="1" width="98%" cellpadding="0" cellspacing="0">
    <tr>
      <td width="19%">貨櫃車編號</td>
      <td width="21%">貨櫃車司機姓名</td>
      <td width="13%">車牌號碼</td>
      <td width="24%">拖架種類</td>
      <td width="11%">送貨時段</td>
      <td width="5%">提交日期</td>
      <td width="3%">運費</td>
      <td width="4%">狀態</td>
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
      <td width="19%"><%=theTruckCapacityModel.getTruckerId()%></td>
      <td width="21%"><%=dbList.getTruckerName(theTruckCapacityModel.getTruckerId(),language)%></td>
      <td width="13%"><%=dbList.getTruckerHKPlate(theTruckCapacityModel.getTruckerId())%></td>
      <td width="24%"><%=dbList.getTrailerTypeDesc(theTruckCapacityModel.getTrailerId(),language)%></td>
      <td width="11%"><%=dbList.getDeliveryTimeSlotDesc(theTruckCapacityModel.getDeliveryTimeSlot(),language)%>&nbsp;</td>
      <td width="5%"><%=theTruckCapacityModel.getSubMissionDatetime().toString().substring(0,10)%></td>
      <td width="3%"><%
										  deliveryFee = new BigDecimal("0");
										  if(theTruckCapacityModel.getMatchRequestFee().equals(deliveryFee))
										  {
												out.write("&nbsp");
											}
											else
											{
												out.write(theTruckCapacityModel.getMatchRequestFee().toString());
											}%></td>
      <td width="4%"><%=dbList.getTruckCapacityStatusDesc(theTruckCapacityModel.getTruckCapacityStatus(),language)%>&nbsp;</td>
    </tr>
    <%}%>
  </table>
</div>
</body>
</html>