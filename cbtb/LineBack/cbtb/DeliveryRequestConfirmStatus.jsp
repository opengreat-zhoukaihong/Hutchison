<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%> 
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestMode" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<%
   webOperator.clearPermissionContext();  
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "view"); //加入检查的内容
   if (webOperator.checkPermission())
      out.print("");
   else
       response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

   String sMarkLanguage = "CH";
   String captureChannel = "",recordStatus;
   String deliveryRequestNum="";
   deliveryRequestNum = request.getParameter("deliveryRequestNum");
   recordStatus =  request.getParameter("requestStatus");
   companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfile");
   deliveryRequestMode = (DeliveryRequestModel)session.getAttribute("deliveryRequestMode");
%>

<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp" %>
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
    <td height="11">發貨要求</td>
    <td height="11"> 
      <div align="right"><font
color="#003366" face="Arial, Helvetica, sans-serif"><a href="DeliveryRequestInsert.jsp?path=<%= request.getParameter("path") %>&companyId=<%= companyProfileModel.getCompanyId() %>&mode=UpdateStatus&recordStatus=<%= recordStatus %>&deliveryRequestNum=<%= deliveryRequestNum %>">確定</a> | <font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"></font><font color="#003366" face="Arial, Helvetica, sans-serif"><a href="javascript:history.back()">取消</a></font></div>
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

<p align="left"><font size="2"
face="Arial, Helvetica, sans-serif"><em>公司編號：  <%= companyProfileModel.getCompanyId() %> </em></font></p>
<table border="0" width="90%">
    <tr>
        <td><font size="2"><em>公司名稱： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%>&nbsp;</em></font></td>
        <td><font size="2"><em>公司聯絡人： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%>&nbsp;</em></font></td>
    </tr>
    <tr>
        <td><font size="2"><em>電話號碼：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%>&nbsp; </em></font></td>
        <td><font size="2"><em>傳真號碼：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getFaxNo()%>&nbsp;</em></font></td>
    </tr>
    <tr>
        <td><font size="2"><em>手提電話號碼： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getMobileNo()%>&nbsp;</em></font></td>
        <td><font size="2"><em>電郵地址：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getEmailAddr()%>&nbsp; </em></font></td>
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

  <table border="0" width="75%">
    <tr> 
      <td width="38%">送貨要求編號：</td>
      <td width="12%"><%= deliveryRequestMode.getDeliveryRequestNum() %></td>
      <td width="32%">提交日期：</td>
      <td width="18%"><%= utilTool.getCurrentDateTime() %></td>
    </tr>
   
    <tr> 
      <td width="38%">出發地城市：</td>
      <td width="12%"><%=  dbList.getCityDesc(deliveryRequestMode.getOriginCityId(),sMarkLanguage) %></td>
      <td width="32%">目的地城市：</td>
      <td width="18%"><%= dbList.getCityDesc(deliveryRequestMode.getDestinationCityId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td width="38%">發貨日期：</td>
      <td width="12%"><%= deliveryRequestMode.getDeliveryDate().toString().substring(0,10) %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">發貨時閒段：</td>
      <td width="12%"><%= dbList.getDeliveryTimeSlotDesc(deliveryRequestMode.getTimeSlotId(),sMarkLanguage) %></td>
      <td width="32%">發貨時閒：</td>
      <td width="18%"><%= dbList.getDeliveryTimeDesc(deliveryRequestMode.getTimeId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td width="38%">貨物種類：</td>
      <td width="12%"><%= dbList.getCargoCategoryDesc(deliveryRequestMode.getCargoId(),sMarkLanguage) %> </td>
      <td width="32%">要求貨櫃檯種類：</td>
      <td width="18%"><%= dbList.getContainerTypeDesc(deliveryRequestMode.getContainerTypeId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td height="20" width="38%">數量：</td>
      <td height="20" width="12%"><%= deliveryRequestMode.getCargoQty() %></td>
      <td height="20" width="32%">度量單位：</td>
      <td height="20" width="18%"><%= dbList.getPackageUomDesc(deliveryRequestMode.getCargoUom(),sMarkLanguage) %> </td>
    </tr>
    <tr> 
      <td width="38%">重量：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoWeight() %> </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">航運公司：</td>
      <td width="12%"><%= dbList.getShippingLineDesc(deliveryRequestMode.getShippingLineId(),sMarkLanguage) %> </td>
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
      <td height="20" width="38%">發貨公司名稱</td>
      <td height="20" width="12%"><%= dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoIssuer(),sMarkLanguage) %></td>
      <td height="20" width="32%">收貨公司名稱</td>
      <td height="20" width="18%"><%= dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoReceiver(),sMarkLanguage) %></td>
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
      <td width="38%">狀態:</td>
      <td width="12%"><%= dbList.getDeliveryStatusDesc(request.getParameter("requestStatus"),sMarkLanguage) %>&nbsp; </td>
      <td width="32%">運價：</td>
      <td width="18%"><%= deliveryRequestMode.getDeliveryFee() %></td>
    </tr>
    <tr> 
      <td width="38%">登記途經：</td>
      <td width="12%"><%= dbList.getCaptureChannelDesc(deliveryRequestMode.getCaptureChannel(),sMarkLanguage)%></td>
      <td width="32%">備注：</td>
      <td width="18%"><%= deliveryRequestMode.getRemark() %></td>
    </tr>
  <tr> 
      <td width="38%">配對編號：</td>
      <td width="12%"><%= deliveryRequestMode.getMatchNumber() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp;</td>
  </tr>
 </table>
</div>

<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>

</body>

</html>








