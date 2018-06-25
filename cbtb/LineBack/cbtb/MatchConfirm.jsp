<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="mfdm" scope="page" class="com.cbtb.model.MatchFeeDetailModel" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "create"); //加入检查的内容
  if (!webOperator.checkPermission())
    {
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
    }
  else
  {
    String language="CN";
    String matchRequestFee="";
    String deliveryFee="";
    ArrayList editList=new ArrayList();
    mcrm=(MatchModel)session.getAttribute("matchModel");
    ArrayList matchFeeList =(ArrayList)session.getAttribute("matchFeeList");
    String url=request.getParameter("url");
    if (url.equalsIgnoreCase("match"))
    {
        mcrm.setMatchNum(request.getParameter("matchNumber"));
        mcrm.setMatchStatus(request.getParameter("matchStatus"));
        if(request.getParameter("notifyTruckStatus")!=null)
            mcrm.setNotifyTruckStatus(constant.NOTIFY_TRUCK_STATUS);
        if(request.getParameter("notifyShipperStatus")!=null)
           mcrm.setNotifyShipperStatus(constant.NOTIFY_SHIPPER_STATUS);
        mcrm.setShipperContactFaxNo(request.getParameter("shipperContactFaxNo"));
        mcrm.setShipperContactPerson(request.getParameter("shipperContactPerson"));
        mcrm.setShipperContactTelphone(request.getParameter("shipperContactTelphone"));
        mcrm.setTruckContactFaxNo(request.getParameter("truckContactFaxNo"));
        mcrm.setTruckContactPerson(request.getParameter("truckContactPerson"));
        mcrm.setTruckContactTelPhone(request.getParameter("truckContactTelphone"));
         java.math.BigDecimal fee;
           fee=mcrm.getTruckCapacityModel().getMatchRequestFee();
         if(fee!=null)
           matchRequestFee=fee.toString();
           fee=mcrm.getDeliveryRequestModel().getDeliveryFee();
         if(fee!=null)
          deliveryFee=fee.toString();
    
    }
    session.setAttribute("matchModel",mcrm);
if (url.equalsIgnoreCase("matchFee"))
{
    String[] box = request.getParameterValues("box");
    for (int i=0; i<box.length;i++)
    {
     if (box[i]!=null)
        {
         editList.add(matchFeeList.get(Integer.parseInt(box[i])));
         matchFeeList.remove(Integer.parseInt(box[i]));}
    }
}
     session.setAttribute("matchFeeList",editList);
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
      <div align="right"><a href="javascript:confirm.submit()"><font color="#003366" face="Arial, Helvetica, sans-serif">確定</font></a>
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
<form action="MatchUpdate.jsp" name="confirm"  >
<input type="hidden" size="20" name="oldMatchStatus" value="<%=request.getParameter("oldMatchStatus")%>">
<input type="hidden" size="20" name="status" value="<%=request.getParameter("status")%>">
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
    <td width="59%"><%=mfdm.getAddFeeId()%></td>
    <td width="23%"><%=mfdm.getAddFeeTruckAmount()%></td>
    <td width="18%"><%=mfdm.getAddFeeShipperAmount()%></td>
  </tr>
<%
}}
%>
</table>
</form>
<p>&nbsp;</p>

<p></p>


</body>

</html>
