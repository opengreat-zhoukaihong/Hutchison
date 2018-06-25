<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%> 
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.CbtbConstant" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestModel" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<%
   webOperator.clearPermissionContext();  
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "view"); //加入检查的内容
   if (webOperator.checkPermission())
      out.print("");
   else
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");


   String sMarkLanguage = "CH"; //mark the language identifier
   String strIssuerName = "";    //the trading partner's name of send the cargo 
   String strReceiveName = "";   //the trading partner's name of receive the cargo
   String cargoReceiver="";     //the receive cargo trading partner name or ID
   String inputIssuer=null,inputReceiver=null; //pass to the readd the variable
   companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfile");
   String captureChannel="";
   String status="",recordStatus="";
   String mode = "";
   mode= request.getParameter("mode");
   String strContainerId ="",cargoIssuer="",deliveryRequestNum="";
   strContainerId = request.getParameter("requestContainerId");
   String strOriginCity = request.getParameter("originCityId");
   String strDistinationCity = request.getParameter("destinationCityId");
   if(request.getParameter("cargoIssuerInput").trim().length() > 0){
      cargoIssuer = request.getParameter("cargoIssuerInput");  //if input by type then the 'cargoIssuer ' is the  name of send cargo trading partner
   //   strIssuerName = cargoIssuer;//get the name of send cargo  trading partner
   }
   else 
       {
        cargoIssuer = dbList.getTradingPartnerDesc(request.getParameter("cargoIssuer"),sMarkLanguage);  //if not input then the 'cargoIssuer' is the ID of send cargo trading partner 
       // strIssuerName = dbList.getTradingPartnerDesc(cargoIssuer,sMarkLanguage); //get the name of send cargo  trading partner
   }

   if(request.getParameter("cargoReceiverInput").trim().length() > 0){
      cargoReceiver = request.getParameter("cargoReceiverInput");  //if input by type then the 'cargoReceiver ' is the  name of receive cargo trading partner
  //    strReceiveName = cargoReceiver;    //get the name of receive cargo  trading partner
   } 
   else
       {
        cargoReceiver = dbList.getTradingPartnerDesc(request.getParameter("cargoReceiver"),sMarkLanguage); //if not input then the 'cargoReceiver' is the ID of send cargo trading partner 
        //strReceiveName = dbList.getTradingPartnerDesc(cargoReceiver,sMarkLanguage); //get the name of receive cargo  trading partner
  }
   
   CbtbConstant cbtbConstant = new CbtbConstant();
   CompanyManager companyManager = webOperator.getCompanyManager();
   deliveryRequestNum =  request.getParameter("deliveryRequestNum");
   if(deliveryRequestNum == null){
     status = cbtbConstant.DELIVERY_REQUEST_POST; 
     deliveryRequestNum = webOperator.getCompanyManager().getNewDeliveryRequestNum();
     deliveryRequestModel.setRequestStatus(cbtbConstant.DELIVERY_REQUEST_POST);
   }
   else{
       deliveryRequestModel.setRequestStatus(request.getParameter("status"));
       status = deliveryRequestModel.getRequestStatus(); 
   }    
   deliveryRequestModel.setCompanyId(companyProfileModel.getCompanyId());
   deliveryRequestModel.setDeliveryRequestNum(deliveryRequestNum);
   deliveryRequestModel.setCargoId(request.getParameter("cargoId"));
   deliveryRequestModel.setCargoQty(request.getParameter("cargoQty"));
   deliveryRequestModel.setCargoUom(request.getParameter("cargoUom"));
   deliveryRequestModel.setCargoWeight(request.getParameter("cargoWeight"));
   deliveryRequestModel.setContainerTypeId(request.getParameter("requestContainerId"));
   deliveryRequestModel.setShippingLineId(request.getParameter("shippingLineId"));
   deliveryRequestModel.setShippingOrderNo(request.getParameter("shippingOrderNo"));
   deliveryRequestModel.setOriginCityId(request.getParameter("originCityId"));
   deliveryRequestModel.setDestinationCityId(request.getParameter("destinationCityId"));  
   
   deliveryRequestModel.setDeliveryFee(companyManager.calculateDeliveryFee(strContainerId,strOriginCity,strDistinationCity));
   deliveryRequestModel.setDeliveryDate(request.getParameter("deliveryDate"));
   deliveryRequestModel.setTimeId(request.getParameter("deliveryTimeId"));
   deliveryRequestModel.setTimeSlotId(request.getParameter("deliveryTimeSlot"));
   deliveryRequestModel.setMatchNumber(request.getParameter("matchNumber"));

   deliveryRequestModel.setCargoIssuer(cargoIssuer);
   deliveryRequestModel.setCargoIssuerPhoneNo(request.getParameter("cargoIssuerPhoneNo"));
   deliveryRequestModel.setCargoIssuerAddr1(request.getParameter("cargoIssuerAddr1"));
   deliveryRequestModel.setCargoIssuerAddr2(request.getParameter("cargoIssuerAddr2"));
   deliveryRequestModel.setCargoIssuerAddr3(request.getParameter("cargoIssuerAddr3"));
   deliveryRequestModel.setCargoIssuerAddr4(request.getParameter("cargoIssuerAddr4"));
   
   deliveryRequestModel.setCargoReceiver(cargoReceiver);
   deliveryRequestModel.setCargoReceiverPhoneNo(request.getParameter("cargoReceiverPhoneNo"));
   deliveryRequestModel.setCargoReceiverAddr1(request.getParameter("cargoReceiverAddr1"));
   deliveryRequestModel.setCargoReceiverAddr2(request.getParameter("cargoReceiverAddr2"));
   deliveryRequestModel.setCargoReceiverAddr3(request.getParameter("cargoReceiverAddr3"));
   deliveryRequestModel.setCargoReceiverAddr4(request.getParameter("cargoReceiverAddr4")); 
   deliveryRequestModel.setCaptureChannel(request.getParameter("captureChannel"));
   deliveryRequestModel.setSubMissionDatetime(utilTool.getCurrentDateTime());
   deliveryRequestModel.setRemark(request.getParameter("remark"));
           
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
color="#003366" face="Arial, Helvetica, sans-serif"><a href="DeliveryRequestInsert.jsp?path=<%= request.getParameter("path") %>&mode=<%= request.getParameter("mode") %>">確定</a></font>
 <% 
   if (request.getParameter("mode").equals("Insert"))
   {
 %>
    <font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font><font face="Arial, Helvetica, sans-serif"><a href="DeliveryRequestInsert.jsp?path=<%= request.getParameter("path") %>&reAddpath=DeliveryRequestReAdd.jsp&mode=<%= request.getParameter("mode") %>">確定&拷貝</a></font>
 <%
    }
 %>
 | <font color="#003366" face="Arial, Helvetica, sans-serif"><a href="javascript:history.back()">取消</a></font></div>
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

  <table border="0" width="85%">
    <tr> 
      <td width="38%">送貨要求編號：</td>
      <td width="12%"><%= deliveryRequestModel.getDeliveryRequestNum() %></td>
      <td width="32%">提交日期：</td>
      <td width="18%"><%= utilTool.getCurrentDateTime() %></td>
    </tr>
   
    <tr> 
      <td width="38%">出發地城市：</td>
      <td width="12%"><%=  dbList.getCityDesc(deliveryRequestModel.getOriginCityId(),sMarkLanguage) %></td>
      <td width="32%">目的地城市：</td>
      <td width="18%"><%= dbList.getCityDesc(deliveryRequestModel.getDestinationCityId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td width="38%">發貨日期：</td>
      <td width="12%"><%= deliveryRequestModel.getDeliveryDate().toString().substring(0,10) %></td>
      <td width="32%">&nbsp;</td>                               
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">發貨時閒段：</td>
      <td width="12%"><%= dbList.getDeliveryTimeSlotDesc(deliveryRequestModel.getTimeSlotId(),sMarkLanguage) %></td>
      <td width="32%">發貨時閒：</td>
      <td width="18%"><%= dbList.getDeliveryTimeDesc(deliveryRequestModel.getTimeId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td width="38%">貨物種類：</td>
      <td width="12%"><%= dbList.getCargoCategoryDesc(deliveryRequestModel.getCargoId(),sMarkLanguage) %> </td>
      <td width="32%">要求貨櫃檯種類：</td>
      <td width="18%"><%= dbList.getContainerTypeDesc(deliveryRequestModel.getContainerTypeId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td height="20" width="38%">數量：</td>
      <td height="20" width="12%"><%= deliveryRequestModel.getCargoQty() %></td>
      <td height="20" width="32%">度量單位：</td>
      <td height="20" width="18%"><%= dbList.getPackageUomDesc(deliveryRequestModel.getCargoUom(),sMarkLanguage) %> </td>
    </tr>
    <tr> 
      <td width="38%">重量：</td>
      <td width="12%"><%= deliveryRequestModel.getCargoWeight() %> </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">航運公司：</td>
      <td width="12%"><%= dbList.getShippingLineDesc(deliveryRequestModel.getShippingLineId(),sMarkLanguage) %> </td>
      <td width="32%">落貨紙號碼/提貨單號碼：</td>
      <td width="18%"><%= deliveryRequestModel.getShippingOrderNo() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%">&nbsp; </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td height="20" width="38%">發貨公司名稱：</td>
      <td height="20" width="12%"><%= deliveryRequestModel.getCargoIssuer() %></td>
      <td height="20" width="32%">收貨公司名稱：</td>
      <td height="20" width="18%"><%= deliveryRequestModel.getCargoReceiver() %></td>
    </tr>
    <tr> 
      <td width="38%">發貨公司聯絡人電話號碼：</td>
      <td width="12%"><%= deliveryRequestModel.getCargoIssuerPhoneNo() %></td>
      <td width="32%">收貨公司聯絡人電話號碼：</td>
      <td width="18%"><%= deliveryRequestModel.getCargoReceiverPhoneNo() %></td>
    </tr>
    <tr> 
      <td width="38%">發貨地詳細地址：</td>
      <td width="12%"><%= deliveryRequestModel.getCargoIssuerAddr1() %></td>
      <td width="32%">目的地詳細地址：</td>
      <td width="18%"><%= deliveryRequestModel.getCargoReceiverAddr1() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestModel.getCargoIssuerAddr2() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestModel.getCargoReceiverAddr2() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestModel.getCargoIssuerAddr3() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestModel.getCargoReceiverAddr3() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestModel.getCargoIssuerAddr4() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestModel.getCargoReceiverAddr4() %></td>
    </tr>
    <tr> 
      <td width="38%">狀態：</td>
      <td width="12%"><%= dbList.getDeliveryStatusDesc(status,sMarkLanguage) %>&nbsp;</td>
      <td width="32%">運價：</td>
      <td width="18%"><%= companyManager.calculateDeliveryFee(strContainerId,strOriginCity,strDistinationCity) %></td>
    </tr>
    <tr> 
      <td width="38%">登記途經：</td>
      <td width="12%"><%= dbList.getCaptureChannelDesc(deliveryRequestModel.getCaptureChannel(),sMarkLanguage) %></td>
      <td width="38%">配對編號：</td>
      <td width="12%"><%= deliveryRequestModel.getMatchNumber() %></td>
    </tr>
    <tr>
      <td width="38%">備注：</td>
      <td width="12%" align="left" colspan="3"> 
         <table>
            <tr>
             <td width="18%">&nbsp;
                <%
                   if(deliveryRequestModel.getRemark().length() > 0)
                   {
                %>
                <textarea rows = 5 cols=15 readonly style="font-family: 宋体; font-size: 9pt; border: 1 solid #000000"><%= deliveryRequestModel.getRemark() %></textarea>
                <%
                   }
                %>
             </td>
           </tr>
        </table>
      </td>
    </tr>
  </table>
</div>

<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>

</body>

</html>








