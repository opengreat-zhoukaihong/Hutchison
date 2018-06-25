<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="mfdm" scope="session" class="com.cbtb.model.MatchFeeDetailModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="cbtbConstant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH_ADDITIONAL_FEE"); //加入检查的内容
  webOperator.putPermissionContext("action", "edit"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  String language="CN";
  mcrm=(MatchModel)session.getAttribute("matchModel");
  ArrayList matchFeeList =(ArrayList)session.getAttribute("matchFeeList");  
  java.math.BigDecimal fee;
  String matchRequestFee="";
  String deliveryFee="";
  String notifyTruckCheck="";
  String notifyShipperCheck="";
  if(mcrm.getNotifyTruckStatus().equals(cbtbConstant.NOTIFY_TRUCK_STATUS))
    notifyTruckCheck="是";
  else
    notifyTruckCheck="否"; 
  if(mcrm.getNotifyShipperStatus().equals(cbtbConstant.NOTIFY_SHIPPER_STATUS))
    notifyShipperCheck="是";
  else
    notifyShipperCheck="否";
       fee=mcrm.getTruckCapacityModel().getMatchRequestFee();
     if(fee!=null)
       matchRequestFee=fee.toString();
       fee=mcrm.getDeliveryRequestModel().getDeliveryFee();
     if(fee!=null)
      deliveryFee=fee.toString();
session.setAttribute("matchModel",mcrm);
session.setAttribute("matchFeeList",matchFeeList);
%>

<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
function doPost(i)
{
  if(i==1)
   {
     var ifCheck=false;
     for(j=0;j<matchEdit.box.length;j++)
      {
       if(matchEdit.box[j].checked)
        {
          ifCheck=true;
          break;
         }
      }
     if(ifCheck==false)
        {
         alert("請選擇要刪除的附加費用!");
         return;
        }
        if(matchEdit.status.value!=matchEdit.delivery.value)
        {
         if(matchEdit.status.value!=matchEdit.pickUp.value)
         {
         alert("對不起！在此狀況下不能刪除附加費用");
         return;
         }
        }
    matchEdit.action="MatchUpdate.jsp"   
    matchEdit.submit();
    }
  if(i==2)
   {
        if(matchEdit.status.value!=matchEdit.delivery.value)
        {
         if(matchEdit.status.value!=matchEdit.pickUp.value)
         {
           alert("對不起！在此狀況下不能增加附加費用");
           return;
         }
        }
    matchEdit.action="AddFee.jsp"
    matchEdit.submit();
   }
}
</SCRIPT>
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
      <div align="right"><a href="MatchView.jsp?type=search&matchNumber=<%=mcrm.getMatchNum()%>"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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

<form method="POST"  name="matchEdit" action="MatchConfirm.jsp">
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
<input type="hidden" name="url" value="matchFee">
<input type="hidden" name="act" value="Delete">
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
        <td><%=mcrm.getShipperContactTelphone()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人傳真號碼：</td>
        <td><%=mcrm.getShipperContactFaxNo()%></td>
        <td>收貨聯絡人傳真號碼：</td>
        <td><%=mcrm.getShipperContactFaxNo()%></td>
    </tr>
    <tr>
        <td>航運公司：</td>
        <td><%=dbList.getShippingLineDesc(mcrm.getDeliveryRequestModel().getShippingLineId(),language)%></td>
        <td>貨櫃車司機姓名：</td>
        <td><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%></td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td><%=dbList.getMatchStatusDesc(mcrm.getMatchStatus(),language)%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>通知付貨人：</td>
        <td><%=notifyShipperCheck%> </td>
        <td>通知運輸公司：</td>
        <td><%=notifyTruckCheck%></td>
    </tr>
    <tr>
        
    <td>運輸公司運費：</td>
        <td><%=matchRequestFee%></td>
        
    <td>付貨人運價：</td>
        <td><%=deliveryFee%></td>
    </tr>
</table>

<p>&nbsp;</p>

<p>附加費用 [<a
href="JavaScript:doPost(2)">增加</a> | <a href="JavaScript:doPost(1)">刪除</a>]</p>
<table border="1" width="75%">
  <tr> 
    <td width="5%">選擇</td>
    <td width="54%">費用描述</td>
    <td width="23%">運輸公司附加費</td>
    <td width="18%">付貨人附加費</td>
  </tr>
<input type="hidden" name="status" value="<%=mcrm.getMatchStatus()%>">
<input type="hidden" name="size" value="<%=matchFeeList.size()%>">
<input type="hidden" name="pickUp" value="<%=cbtbConstant.MATCH_STATUS_CONTAINER_PICKUP%>">
<input type="hidden" name="delivery" value="<%=cbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED%>">
<%

     for (int i = 0;  (!matchFeeList.isEmpty()) && i < matchFeeList.size(); i++) {
        mfdm = (MatchFeeDetailModel)matchFeeList.get(i);
     
%>
  <tr> 
    <td width="5%"> 
      <input type="checkbox" name="box" value="<%=i%>">
    </td>
    <td width="59%"><%=dbList.getAddFeeDesc(mfdm.getAddFeeId(),language)%></td>
    <td width="23%"><%=mfdm.getAddFeeTruckAmount()%></td>
    <td width="18%"><%=mfdm.getAddFeeShipperAmount()%></td>
  </tr>
<%
}
%>
</table>

</form>
<p></p>


</body>

</html>








