<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script Language="JavaScript" src="../js/JsLib.js"></script>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.entity.TradingPartnerValue" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.CbtbConstant " %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestMode" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<%
   webOperator.clearPermissionContext(); 
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "view"); //加入检查的内容
   if (!webOperator.checkPermission())
   {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
   }

   String sMarkLanguage = "CN";
   CompanyProfileModel companyProfileModel=new CompanyProfileModel();
   companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
   String companyId=companyProfileModel.getCompanyId(); 
   String companyName = companyProfileModel.getCompanyChineseName();
   TradingPartnerValue  tradingPartnerValue  = new TradingPartnerValue();
   CbtbConstant cbtbConstant = new CbtbConstant();
   deliveryRequestMode = (DeliveryRequestModel)session.getAttribute("deliveryRequestMode");
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>       
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>送貨要求細節</b></font></font></td>
      <td width="57%">   
      <div align="right"><a href="DeliveryRequestInsert.jsp?path=<%= request.getParameter("path") + "?rootPath=" + request.getParameter("rootPath") %>&mode=UpdateStatus&recordStatus=<%= cbtbConstant.DELIVERY_REQUEST_CANCEL %>&deliveryRequestNum=<%= deliveryRequestMode.getDeliveryRequestNum() %>"><font
color="#003366">確定</font></a> | <a href="javascript:history.back()"><font
color="#003366">取消</font></a></div>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td> 
      <div align="right">提交日期： <%= deliveryRequestMode.getSubMissionDatetime().toString().substring(0,10)  %></div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="right">送貨要求號碼： <%= deliveryRequestMode.getDeliveryRequestNum()  %></div>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td> 
      <div align="left"><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">刪除這個送貨要求細節嗎?</font></font></div>
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
<div align="left">

  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr> 
    <td width="38%">付貨人編號：</td>
    <td width="12%"><%= companyId %></td>
    <td width="32%">付貨人姓名：</td>
    <td width="18%"><%= companyName %></td>
  </tr>

<tr> 
      <td width="38%">出發地城市：</td>
      <td width="12%"><%=  dbList.getCityDesc(deliveryRequestMode.getOriginCityId(),"EN") %></td>
      <td width="32%">目的地城市：</td>
      <td width="18%"><%= dbList.getCityDesc(deliveryRequestMode.getDestinationCityId(),"EN") %></td>
    </tr>
    <tr> 
      <td width="38%">發貨日期：</td>
      <td width="12%"><%= deliveryRequestMode.getDeliveryDate().toString().substring(0,10) %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">發貨時閒段：</td>
      <td width="12%"><%= dbList.getDeliveryTimeSlotDesc(deliveryRequestMode.getTimeSlotId(),"EN") %></td>
      <td width="32%">發貨時閒：</td>
      <td width="18%"><%= dbList.getDeliveryTimeDesc(deliveryRequestMode.getTimeId(),"EN") %></td>
    </tr>
    <tr> 
      <td width="38%">貨物種類：</td>
      <td width="12%"><%= dbList.getCargoCategoryDesc(deliveryRequestMode.getCargoId(),"EN") %> </td>
      <td width="32%">要求貨櫃檯種類：</td>
      <td width="18%"><%= dbList.getContainerTypeDesc(deliveryRequestMode.getContainerTypeId(),"EN") %></td>
    </tr>
    <tr> 
      <td height="20" width="38%">數量：</td>
      <td height="20" width="12%"><%= deliveryRequestMode.getCargoQty() %></td>
      <td height="20" width="32%">度量單位：</td>
      <td height="20" width="18%"><%= dbList.getPackageUomDesc(deliveryRequestMode.getCargoUom(),"EN") %> </td>
    </tr>
    <tr> 
      <td width="38%">重量：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoWeight() %> </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">航運公司：</td>
      <td width="12%"><%= dbList.getShippingLineDesc(deliveryRequestMode.getShippingLineId(),"EN") %> </td>
      <td width="32%">落貨紙號碼/提貨單號碼：</td>
      <td width="18%"><%= deliveryRequestMode.getShippingOrderNo() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%">&nbsp; </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td height="20" width="38%">發貨公司名稱：</td>
      <td height="20" width="12%"><%= dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoIssuer(),"EN") %></td>
      <td height="20" width="32%">收貨公司名稱：</td>
      <td height="20" width="18%"><%= dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoReceiver(),"EN") %></td>
    </tr>
    <tr> 
      <td width="38%">發貨公司聯絡人電話號碼：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerPhoneNo() %></td>
      <td width="32%">收貨公司聯絡人電話號碼：</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverPhoneNo() %></td>
    </tr>
    <tr> 
      <td width="38%">發貨地詳細地址：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr1() %></td>
      <td width="32%">目的地詳細地址：</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr1() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr2() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr2() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr3() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr3()%></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr4() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr4() %></td>
    </tr>
    <tr> 
      <td width="38%">狀態：</td>
      <td width="12%"><%= dbList.getDeliveryStatusDesc(deliveryRequestMode.getRequestStatus(),"EN") %>&nbsp; </td>
      <td width="32%">運價：</td>
      <td width="18%"><%= deliveryRequestMode.getDeliveryFee() %></td>
    </tr>
    <tr> 
      <td width="38%">登記途經：</td>
      <td width="12%"><%= dbList.getCaptureChannelDesc(deliveryRequestMode.getCaptureChannel(),"EN")  %></td>
      <td width="32%">備注：</td>
      <td width="18%"><%= deliveryRequestMode.getRemark() %></td>
    </tr>
</table>
</div>


<p align="left">&nbsp;</p>
<p align="left">&nbsp;</p>
<hr>
      
<%@ include file = "../include/end.jsp" %>
</body>
</html>


