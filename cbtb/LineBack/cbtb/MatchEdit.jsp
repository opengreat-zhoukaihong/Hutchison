<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="cbtbConstant" scope="application" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="matchStatus" scope="application" class="com.cbtb.web.MatchStatus" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "edit"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  mcrm=(MatchModel)session.getAttribute("matchModel");
  ArrayList matchFeeList =(ArrayList)session.getAttribute("matchFeeList");
  String language="CN";
  String notifyStatus="0";
  String status=matchStatus.EDIT;
  boolean approve=false;

session.setAttribute("matchModel",mcrm);
session.setAttribute("matchFeeList",matchFeeList);
%>


<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
     with ( document.matchEdit)
      {
     shipperContactTelphone.value=Trim(shipperContactTelphone.value);
     truckContactTelphone.value=Trim(truckContactTelphone.value);
     shipperContactFaxNo.value=Trim(shipperContactFaxNo.value);
     truckContactFaxNo.value=Trim(truckContactFaxNo.value);
     if(shipperContactTelphone.value!="" && !isInt(shipperContactTelphone.value))
     {
      alert("請輸入正確的發貨聯絡人電話號碼！");
      shipperContactTelphone.select();
      return;
     }
     if(truckContactTelphone.value!="" && !isInt(truckContactTelphone.value))
     {
      alert("請輸入正確的收貨聯絡人電話號碼！");
      truckContactTelphone.select();
      return;
     }
     if(shipperContactFaxNo.value!="" && !isInt(shipperContactFaxNo.value))
     {
      alert("請輸入正確的發貨聯絡人傳真號碼！");
      shipperContactFaxNo.select();
      return;
     }
     if(truckContactFaxNo.value!="" && !isInt(truckContactFaxNo.value))
     {
      alert("請輸入正確的收貨聯絡人傳真號碼！");
      truckContactFaxNo.select();
      return;
     }
     if(matchStatus.value==oldMatchStatus.value)
        {
        status.value="0";
        }
     else if(parseInt(matchStatus.value)*parseInt(oldMatchStatus.value)==parseInt(aMatchStatus.value)*parseInt(cMatchStatus.value))
            {
             if(matchStatus.value>oldMatchStatus.value)
                {
                  status.value="-1";
                }
             else
               {
                  status.value="1";
                }
              }
       else
          {
             if(parseInt(matchStatus.value)-parseInt(oldMatchStatus.value)==-1)
                {
                 status.value="-1";
               }
             else if(parseInt(matchStatus.value)-parseInt(oldMatchStatus.value)==1)
               {
                 status.value="1";
                 if(notifyStatus.value==1 || notifyStatus.value==3)
                 {
                 if(!notifyShipperStatus.checked)
                 {
                 alert("請選擇通知付貨人");
                 return;
                 }
                 }
                if(notifyStatus.value==2 || notifyStatus.value==3)
                {
                if(!notifyTruckStatus.checked)
                {
                alert("請選擇通知運輸公司");
                return;
                }
                }
               }
             else
               {
                 alert("此狀態下不能更新！");
                 return;
                }
           }
      }
    matchEdit.action="MatchConfirm.jsp"
    matchEdit.submit();
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
      <div align="right"><a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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
<form action="MatchConfirm.jsp" name="matchEdit">
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
<input type="hidden" name="url" value="match">
<input type="hidden" name="status" value="">
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
        <td><input type="text" size="20" name="shipperContactPerson" value="<%=mcrm.getShipperContactPerson()%>" maxlength="30"> </td>
        <td>收貨聯絡人：</td>
        <td><input type="text" size="20" name="truckContactPerson" value="<%=mcrm.getTruckContactPerson()%>" maxlength="30"> </td>
    </tr>
    <tr>
        <td>發貨聯絡人電話號碼：</td>
        <td><input type="text" size="20" name="shipperContactTelphone" value="<%=mcrm.getShipperContactTelphone()%>" maxlength="20"> </td>
        <td>收貨聯絡人電話號碼：</td>
        <td><input type="text" size="20" name="truckContactTelphone" value="<%=mcrm.getTruckContactTelPhone()%>" maxlength="20"> </td>
    </tr>
    <tr>
        <td>發貨聯絡人傳真號碼：</td>
        <td><input type="text" size="20" name="shipperContactFaxNo" value="<%=mcrm.getShipperContactFaxNo()%>" maxlength="20"> </td>
        <td>收貨聯絡人傳真號碼：</td>
        <td><input type="text" size="20" name="truckContactFaxNo" value="<%=mcrm.getTruckContactFaxNo()%>" maxlength="20"> </td>
    </tr>
<%
%>
<input type="hidden" size="20" name="matchNumber" value="<%=mcrm.getMatchNum()%>">
<input type="hidden" size="20" name="oldMatchStatus" value="<%=mcrm.getMatchStatus()%>">
<input type="hidden" size="20" name="cMatchStatus" value="<%=cbtbConstant.MATCH_STATUS_CONFIRM%>">
<input type="hidden" size="20" name="aMatchStatus" value="<%=cbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED%>">
    <tr>
        <td>航運公司：</td>
        <td><%=dbList.getShippingLineDesc(mcrm.getDeliveryRequestModel().getShippingLineId(),language)%>&nbsp;</td>
        <td>貨櫃車司機姓名：</td>
        <td><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%>&nbsp;</td>
    </tr>
    <tr>
        <td>狀況：</td>
         <td>

          <select name="matchStatus" size="1">
           <%=matchStatus.getStatusList(matchStatus.EDIT,mcrm.getMatchStatus(),language)%>
          </select>

         </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>

        <td>通知付貨人：</td>
<%
if(mcrm.getNotifyShipperStatus().equals(cbtbConstant.NOT_NOTIFY_SHIPPER_STATUS))
{
  notifyStatus="1";
%>
        <td><input type="checkbox" name="notifyShipperStatus"
        value="<%=cbtbConstant.NOTIFY_SHIPPER_STATUS%>" > </td>
<%}else{%>
<td>是</td>
<%}%>
        <td>通知運輸公司：</td>
      <%if(mcrm.getNotifyTruckStatus().equals(cbtbConstant.NOT_NOTIFY_TRUCK_STATUS))
        {
        if(notifyStatus.equals("1"))
          notifyStatus="3";
        else
          notifyStatus="2";
      %>
        <td><input type="checkbox" name="notifyTruckStatus"
        value="<%=cbtbConstant.NOTIFY_TRUCK_STATUS%>" > </td>
    <%
     }else
      {
  %>
      <td>是</td>
  <%}%>
    </tr>
</table>


    <p><input type="button" name="button" onClick="JavaScript:doPost()" value="提 交">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
<input type="hidden" size="20" name="notifyStatus" value="<%=notifyStatus%>">
</form>
<p></p>


</body>

</html>








