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
<jsp:useBean id="mfdm" scope="page" class="com.cbtb.model.MatchFeeDetailModel" />
<jsp:useBean id="constant" scope="application" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="matchStatus" scope="application" class="com.cbtb.web.MatchStatus" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH_STATUS"); //加入检查的内容
  webOperator.putPermissionContext("action", "approve"); //加入检查的内容
  if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  String url=request.getParameter("url");  
  String matchNum="";
  String deliveryRequestNum="";
  String truckCapacityNum="";
  String language="CN";
  String path="";
  ArrayList matchFeeList=null;
  String matchNumber=request.getParameter("matchNumber");
  MatchManager mm=webOperator.getMatchManager();
  if (url!=null && url.equalsIgnoreCase("matchStatu")) 
   {
   matchNum=request.getParameter("matchNum");
   deliveryRequestNum=request.getParameter("deliveryRequestNum");
   truckCapacityNum=request.getParameter("truckCapacityNum");
   if(!mm.updateMatchStatus(matchNum,deliveryRequestNum,truckCapacityNum,constant.MATCH_STATUS_CONTAINER_DELIVERED))
   {
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_0001");
   }
   else
   {

   path="MatchView.jsp?type=search&matchNumber="+matchNum;
   response.sendRedirect(path);
   } 
  }
  else
  {
    mcrm=(MatchModel)session.getAttribute("matchModel");
    matchFeeList =(ArrayList)session.getAttribute("matchFeeList");
  }
%>


<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
function doPost(matchNum,deliveryNo,truckNo)
{
    
    matchSearch.action="MatchStatus.jsp?url=matchStatu&matchNum="+matchNum+"&deliveryRequestNum="+deliveryNo+"&truckCapacityNum="+truckNo;
    matchSearch.submit();

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
      <div align="right"><a href="JavaScript:doPost('<%=mcrm.getMatchNum()%>','<%=mcrm.getDeliveryRequestNum()%>','<%=mcrm.getTruckCapacityNum()%>')"><font color="#003366" face="Arial, Helvetica, sans-serif">由審核更改為已送貨</font></a>
        | <a href="javascript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">取消</font></a></div>
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
<form action="MatchUpdate.jsp" method="POST"  name="matchSearch" >
<table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
   <input type="hidden" name="url" value="<%=url%>">
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
        <td><%=mcrm.getTruckContactFaxNo()%></td>
    </tr>
    <tr>
        <td>航運公司：</td>
        <td><%=dbList.getShippingLineDesc(mcrm.getDeliveryRequestModel().getShippingLineId(),language)%></td>
        <td>貨櫃車司機姓名：</td>
        <td><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%>&nbsp;</td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td> <%=dbList.getMatchStatusDesc(mcrm.getMatchStatus(),language)%></td>
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
        <td><%=mcrm.getTruckCapacityModel().getMatchRequestFee()%></td>

    <td>付貨人運價：</td>
        <td><%=mcrm.getDeliveryRequestModel().getDeliveryFee()%></td>
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
    <td width="59%"><%=mfdm.getAddFeeId()%></td>
    <td width="23%"><%=mfdm.getAddFeeTruckAmount()%></td>
    <td width="18%"><%=mfdm.getAddFeeShipperAmount()%></td>
  </tr>
<%
}
%>
</table>
<input type="hidden" name="path" value="<%=path%>">
</form>
<p>&nbsp;</p>

<p></p>


</body>

</html>








