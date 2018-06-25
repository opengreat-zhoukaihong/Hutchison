<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ page contentType="text/html;charset=UTF-8"%>   
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String language="CN";
truckCapacityModel.setTruckCapacityNum(request.getParameter("truckCapacityNum"));
CompanyManager companyManager =  webOperator.getCompanyManager();
truckCapacityModel = companyManager.findTruckCapacity(truckCapacityModel.getTruckCapacityNum().toString());
session.setAttribute("truckCapacityModel",truckCapacityModel);
System.out.println("getDeliveryTimeId:"+truckCapacityModel.getDeliveryTimeId());
System.out.println("getDeliveryTimeSlot:"+truckCapacityModel.getDeliveryTimeSlot());
System.out.println("getDeliveryFee:"+truckCapacityModel.getDeliveryFee());
System.out.println("getCaptureChannel:"+truckCapacityModel.getCaptureChannel());
System.out.println("getDestinationCityId:"+truckCapacityModel.getDestinationCityId());
System.out.println("getMatchNumber:"+truckCapacityModel.getMatchNumber());
%>

<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11">登記空車細節</td>
    <td height="11"> 
      <div align="right"><a href="javascript:history.back()"><font
color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<div align="left">

  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="44%" height="30">空車編號：</td>
      <td width="28%"><%=truckCapacityModel.getTruckCapacityNum()%></td>
      <td width="28%">提交日期：</td>
      <td width="56%"><%=truckCapacityModel.getSubMissionDatetime().toString().substring(0,10)%></td>
      <td width="56%">狀態：</td>
      <td width="56%"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
    </tr>
    <tr>
      <td width="44%" height="30">出發地城市：</td>
      <td width="0%"><%=dbList.getCityDesc(truckCapacityModel.getOriginCityId(),language)%></td>
      <td width="0%">目的地城市：</td>
      <td width="0%"><%=dbList.getCityDesc(truckCapacityModel.getDestinationCityId(),language)%></td>
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
      <td width="44%" height="30">貨櫃車編號</td>
      <td width="0%"><%=truckCapacityModel.getTruckCapacityNum()%></td>
      <td width="0%">貨櫃車司機姓名 </td>
      <td width="0%"><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%>&nbsp;</td>
      <td width="0%">車牌號碼</td>
      <td width="56%"><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>&nbsp;</td>
    </tr>
    <tr>
      <td width="44%" height="30">登記途徑：</td>
      <td width="0%"><%=dbList.getCaptureChannelDesc(truckCapacityModel.getCaptureChannel(),language)%></td>
      <td width="0%">運費：</td>
      <td width="0%"><%=truckCapacityModel.getDeliveryFee()%></td>
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