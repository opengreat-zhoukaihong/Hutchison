<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="mfdm" scope="session" class="com.cbtb.model.MatchFeeDetailModel" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
  String closePage=(String)session.getAttribute("closePage");
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "view"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
  String language="CN";
  String type=request.getParameter("type");
  MatchManager matchManager = webOperator.getMatchManager();
  ArrayList matchFeeList=new ArrayList();
  String backPageName="";
  backPageName=request.getParameter("page");
  if(type.equals("search"))
  {
     String matchNumber=request.getParameter("matchNumber");
     mcrm = matchManager.findMatchCapacityRequest(matchNumber);
     matchFeeList= (ArrayList)matchManager.getMatchFee(matchNumber);
   }
  else if(type.equals("match"))
    {
      webOperator.clearPermissionContext();  //清除以前检查的内容
      webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
      webOperator.putPermissionContext("action", "create"); //加入检查的内容
      if (!webOperator.checkPermission())
        response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
      else
      {

      String deliveryRequestNum=request.getParameter("deliveryRequestNum");
      String truckCapacityNum=request.getParameter("truckCapacityNum");
      if(deliveryRequestNum.length()==0)
      deliveryRequestNum=null;
      if(truckCapacityNum.length()==0)
      truckCapacityNum=null;
      mcrm=matchManager.match(deliveryRequestNum,truckCapacityNum);
      }
     }
     java.math.BigDecimal fee;
     String matchRequestFee="";
     String deliveryFee="";
      fee=mcrm.getTruckCapacityModel().getMatchRequestFee();
     if(fee!=null)
       matchRequestFee=fee.toString();
       fee=mcrm.getDeliveryRequestModel().getDeliveryFee();
     if(fee!=null)
      deliveryFee=fee.toString();
     if(mcrm.getNotifyTruckStatus()==null)
        mcrm.setNotifyTruckStatus(constant.NOT_NOTIFY_TRUCK_STATUS);
     if(mcrm.getNotifyShipperStatus()==null)
        mcrm.setNotifyShipperStatus(constant.NOT_NOTIFY_SHIPPER_STATUS);
     session.setAttribute("matchModel",mcrm);
     session.setAttribute("matchFeeList",matchFeeList);
    
%>

<html>
<head>
<title>Untitled Document</title>

<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">

<%@ include file="../include/head.jsp"%>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>配對記錄細節</td>
    <td>
      <div align="right">
<%
if(Integer.parseInt(mcrm.getMatchStatus())<Integer.parseInt(constant.MATCH_STATUS_APPROVE) && type.equals("search"))
{
%>
<a href="MatchEdit.jsp"><font
color="#003366" face="Arial, Helvetica, sans-serif">更新 </font></a><font color="#003366"
face="Arial, Helvetica, sans-serif"></font><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">| </font>
<%
if(constant.MATCH_STATUS_CONTAINER_DELIVERED.equals(mcrm.getMatchStatus()) || constant.MATCH_STATUS_CONTAINER_PICKUP.equals(mcrm.getMatchStatus()))
{
%>
<a href="MatchFeeEdit.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">附加費用</font></a><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font>
<%
}}
if(Integer.parseInt(mcrm.getMatchStatus())==Integer.parseInt(constant.MATCH_STATUS_APPROVE))
{
%>
<a href="MatchStatus.jsp?path=MatchSearch.jsp&matchNumber=<%=mcrm.getMatchNum()%>"><font color="#003366"
face="Arial, Helvetica, sans-serif">更新狀況</font></a><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> |
<%}%>
<a href="<%=closePage%>"><font
color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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
<form >

<table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
  <tr>
        <td>配對編號：</td>
        <td><%=mcrm.getMatchNum()%></td>
        <td>提交日期：</td>
        <td><%=(mcrm.getTruckCapacityModel().getSubMissionDatetime().toString()).substring(0,10)%></td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td><%=dbList.getCityDesc(mcrm.getDeliveryRequestModel().getOriginCityId(),language)%></td>
        <td>目的地城市：</td>
        <td><%=dbList.getCityDesc(mcrm.getDeliveryRequestModel().getDestinationCityId(),language)%></td>
    </tr>
    <tr>
        <td>送貨日期：</td>
        <td><%=(mcrm.getTruckCapacityModel().getDeliveryDate().toString()).substring(0,10)%></td>
        <td>送貨時間：</td>
        <td><%=dbList.getDeliveryTimeDesc(mcrm.getTruckCapacityModel().getDeliveryTimeId(),language)%></td>
    </tr>
    <tr>
        <td>送貨要求編號：</td>
        <td><%=mcrm.getDeliveryRequestNum()%></td>
        <td>登記空車編號：</td>
        <td><%=mcrm.getTruckCapacityNum()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人：</td>
        <td><%=mcrm.getShipperContactPerson()%></td>
        <td>收貨聯絡人：</td>
        <td><%=mcrm.getTruckContactPerson()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人電話號碼：</td>
        <td><%=mcrm.getShipperContactTelphone()%></td>
        <td>收貨聯絡人電話號碼：</td>
        <td><%=mcrm.getTruckContactTelPhone()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人傳真號碼：</td>
        <td><%=mcrm.getShipperContactFaxNo()%></td>
        <td>收貨聯絡人傳真號碼：</td>
        <td><%=mcrm.getShipperContactFaxNo()%></td>
    </tr>
    <tr>
        <td>航運公司：</td>
        <td><%=dbList.getShippingLineDesc(mcrm.getDeliveryRequestModel().getShippingLineId(),language)%>&nbsp;</td>
        <td>貨櫃車司機姓名：</td>
        <td><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%>&nbsp;</td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td><%=dbList.getMatchStatusDesc(mcrm.getMatchStatus(),language)%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>通知付貨人：</td>
        <td><%=mcrm.getNotifyShipperStatus().equals(constant.NOTIFY_SHIPPER_STATUS)?"是":"否"%></td>
        <td>通知運輸公司：</td>
        <td><%=mcrm.getNotifyTruckStatus().equals(constant.NOTIFY_TRUCK_STATUS)?"是":"否"%></td>
    </tr>
    <tr>

    <td>運輸公司運費：</td>
        <td><%=matchRequestFee%></td>

    <td>付貨人運價：</td>
        <td><%=deliveryFee%></td>
    </tr>
</table>

<p>附加費用<br>
</p>

<table border="1" width="75%">
  <tr>
    <td width="59%">費用描述</td>
    <td width="23%">運輸公司附加費</td>
    <td width="18%">付貨人附加費</td>
  </tr>
<%


     for (int i = 0;  (!matchFeeList.isEmpty()) && i < matchFeeList.size(); i++) {
        mfdm = (MatchFeeDetailModel)matchFeeList.get(i);

%>
  <tr>
    <td width="59%"><%=dbList.getAddFeeDesc(mfdm.getAddFeeId(),language)%></td>
    <td width="23%"><%=mfdm.getAddFeeTruckAmount()%></td>
    <td width="18%"><%=mfdm.getAddFeeShipperAmount()%></td>
  </tr>
 <%
   }}
  %>
</table>
</form>

<p>&nbsp;</p>

</body>
</html>
</p>


</body>
</html>







