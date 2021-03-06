﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script Language="JavaScript" src="../js/JsLib.js"></script>
<script Language="JavaScript" src="../js/changlist.js"></script>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.cbtb.util.CbtbConstant" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestModelList" scope="session" class="com.cbtb.model.DeliveryRequestModel" /> 
<jsp:useBean id="deliveryRequestMode" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<%
   webOperator.clearPermissionContext(); 
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "create"); //加入检查的内容
   if (!webOperator.checkPermission())
   {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
   }
   else
   {

   String sMarkLanguage = "CH";
   TradingPartnerValue  tradingPartnerValue  = new TradingPartnerValue();
   CbtbConstant cbtbConstant = new CbtbConstant();
   String rootPath = request.getParameter("rootPath");
   SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); //initialize the current date
   String strDate = date.format(new Date());                   //get current date
   String truckCapacityNum=request.getParameter("truckCapacityNum");
   String companyId=request.getParameter("companyId");
   String companyName=request.getParameter("companyName");
   if(companyId==null)
   {
     CompanyProfileModel companyProfileModel=new CompanyProfileModel();
     companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
     companyId=companyProfileModel.getCompanyId();
     companyName=dbList.getCompanyName(companyId,sMarkLanguage);
   }
   String originCityId=request.getParameter("originCityId");
   String destinationCityId=request.getParameter("destinationCityId");
   String deliveryDate=request.getParameter("deliveryDate");
   String deliveryTimeId=request.getParameter("deliveryTimeId");
%>
<html>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<%
   out.println(dbList.getTimeSlotClass(sMarkLanguage));
%>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{   
   if (add.originCityId.value =="Any")
   {
     alert("出發地城市不能為 'Any City!'");
     add.originCityId.focus();
     return;
   }
   if (add.destinationCityId.value =="Any")
   {
     alert("目的地城市不能為 'Any City!;");
     add.destinationCityId.focus();
     return;
   }

   if (add.originCityId.value==add.hongKongId.value && add.destinationCityId.value==add.hongKongId.value )
   {
	alert("'出發地城市'、'目的地城市'能且只能有一個為香港！");        
        add.originCityId.focus();
        return;

   }
   if (add.originCityId.value!=add.hongKongId.value && add.destinationCityId.value!=add.hongKongId.value )
   {
	alert("出發地城市,目的地城市必須有一個為香港！");
        add.originCityId.focus();
        return;
   }

   if (add.deliveryDate.value =="")
   {
     alert("發貨日期不能為空!");
     add.deliveryDate.focus();
     return;
   }

   if(!isDate(add.deliveryDate.value))
   {
      alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
      add.deliveryDate.focus();
      return;
   }
   if (add.deliveryTimeId.value =="Any")
   {
     alert("發貨時閒不能為 'Any Time!'");
     add.deliveryTimeId.focus();
     return;
   }
   if (add.deliveryTimeSlot.value =="Any")
   {
     alert("發貨時閒段不能為 'Any TimeSlot!'");
     add.deliveryTimeSlot.focus();
     return;
   }
   if (add.cargoId.value == "Any")
   {
     alert("貨物種類不能為 'Any Cargo Categotory!'");
     add.cargoId.focus();
     return;
   }
   if (add.requestContainerId.value == "Any")
   {
     alert("要求貨櫃檯種類不能為 'Any Container Type!'");
     add.requestContainerId.focus();
     return;
   }
   if (add.cargoQty.value =="")
   {
     alert("貨物數量不能為空！");
     add.cargoQty.focus();
     return;
   }
   if (add.cargoUom.value =="Any")
   {
     alert("度量單位不能為'Any Package UOM！'");
     add.cargoUom.focus();
     return;
   }
   if (add.cargoWeight.value =="")
   {
     alert("重量不能為空!");
     add.cargoWeight.focus();
     return;
   }
   if (add.shippingLineId.value == "Any")
   {
     alert("航運公司不能為 'Any Shipper LIne!'");
     add.shippingLineId.focus();
     return;
   }
   if (add.cargoIssuer.value =="Any")
   {
     if(RemoveSpace(add.cargoIssuerInput.value) == ""){
        alert("發貨公司名稱不能為'Any Partner!'");
        add.cargoIssuer.focus();
        return;
     }
   }
   if (add.cargoIssuerPhoneNo.value =="")
   {
       alert("發貨公司電話號碼不能為空!");
       add.cargoIssuerPhoneNo.focus();
       return;
   }
   if (add.cargoIssuerAddr1.value =="")
   {
     alert("發貨公司地址不能為空!");
     add.cargoIssuerAddr1.focus();
     return;
   }
   if (add.cargoReceiver.value =="Any")
   {
      if(RemoveSpace(add.cargoReceiverInput.value) == ""){  
        alert("收貨公司名稱不能為'Any Partner!'");
        add.cargoReceiver.focus();
        return;
      }
   }
   if (add.cargoReceiverPhoneNo.value =="")
   {
     alert("收貨公司電話號碼不能為空!");
     add.cargoReceiverPhoneNo.focus();
     return;
   }
   if (add.cargoReceiverAddr1.value =="")
   {
     alert("收貨公司地址不能為空!");
     add.cargoReceiverAddr1.focus();
     return;
   }
   if(add.remark.value.length > 200){
      alert("備注不能超過200個字符!");
      add.remark.focus();
      return;
   }
   add.submit();
 }  

 function cargoQty_onchange(){
   var inputvar = add.cargoQty.value;
   var obj = document.add.cargoQty;   
   if(!isFloat(RemoveSpace(inputvar),obj,"只能輸入數字!")){
      obj.focus();
      return false;
   }
 }

function cargoWeight_onchange(){
   var inputvar = add.cargoWeight.value;
   var obj = document.add.cargoWeight;
   if(!isFloat(RemoveSpace(inputvar),obj,"只能輸入數字!")){
      obj.focus();
      return false;
   }
 }

 function cargoIssuer_onchange() {
   add.onChance.value = "Issuer";
   add.action = "FMatch.jsp#3";
   add.submit();
 }

 function cargoReceiver_onchange() {
   add.onChance.value = "Receiver";
   add.action = "FMatch.jsp#3";
   add.submit();
 }

function isFloat(inputval,obj,instr){
   var inputstr = inputval.toString();
   var str = RemoveSpace(inputstr);
   for (var i = 0;i < str.length;i++){
       var onechar = str.charAt(i);
              if ((onechar < "0") || (onechar > "9" )) {
                  if(onechar != '.'){
                     window.alert (instr);
                     str = str.substr(0,i);
                     obj.value = str;
                     obj.focus();
                     return false;
                  }
              }
   }
   obj.value = str
   return true;
 }

 function deliveryTimeId_onChange(){
     chgDnCombobox(add.deliveryTimeId,add.deliveryTimeSlot,timeSlotClass,1);
 }
</SCRIPT>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>

<form action="MatchConfirm.jsp" name="add" method = "post">
<input type="hidden" name="truckCapacityNum" value="<%=truckCapacityNum%>">
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>     
      <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>發貨要求</b></font></font></td>
      <td width="57%"> 
        
      <div align="right"><a href="JavaScript:history.back()"><font
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
<input type="hidden" name="mode" value="Insert">
<input type="hidden" name="path" value="<%= request.getParameter("path") %>">
<input type="hidden" name="onChance" >
<input type="hidden" name="hongKongId" value="<%= cbtbConstant.HONGKONG_CITY_ID %>">
<input type="hidden" name="companyId" value="<%= companyId %>">
<input type="hidden" name="companyName" value="<%=companyName%>">
<input type="hidden" name="rootPath" value = "<%= request.getParameter("rootPath") %>">
<input type="hidden" name="currentDate" value="<%= strDate %>">
<div align="left"> 
  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr> 
    <td>付貨人編號：</td>
    <td><%= companyId %>&nbsp;</td>
    <td>付貨人名稱：</td>
    <td><%=companyName %>&nbsp;</td>
  </tr>
  <tr> 
      <td>出發地城市：</td>
      <td> 
        <select name="originCityId" size="1">
          <%= dbList.getCityList(originCityId,sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
      <td>目的地城市：</td>
      <td> 
        <select name="destinationCityId" size="1">
          <%= dbList.getCityList(destinationCityId,sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
	
    </tr>
    <tr> 
      <td>發貨日期(yyyy-mm-dd)：</td>
      <td> 
        <input type="text" maxlength="10" size="10" value="<%= deliveryDate%>" name="deliveryDate" >
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
            onClick="fPopUpCalendarDlg(deliveryDate);return false" > 
 	<font color=#ff0033>*</font>
     </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>發貨時閒：</td>
      <td> 
        <select name="deliveryTimeId" size="1" Language="javascript" onChange="deliveryTimeId_onChange()">
          <%= dbList.getDeliveryTimeList(deliveryTimeId,sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
      <td>發貨時閒段：</td>
      <td> 
        <select name="deliveryTimeSlot" size="1">
          <%= dbList.getDeliveryTimeSlotList(request.getParameter("deliveryTimeSlot"),sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>貨物種類：</td>
      <td> 
        <select name="cargoId" size="1">
             <%= dbList.getCargoCategoryList(request.getParameter("cargoId"),sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
      <td>要求貨櫃檯種類：</td>
      <td> 
        <select name="requestContainerId" size="1">
            <%= dbList.getContainerTypeList(request.getParameter("requestContainerId"),sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td height="20">數量：</td>
      <td height="20"> 
        <input type="text" maxlength="9" size="20" name="cargoQty" value="<%= request.getParameter("cargoQty") %>"  javascript  onchange="return cargoQty_onchange()">
	<font color=#ff0033>*</font>
      </td>
      <td height="20">度量單位：</td>
      <td height="20"> 
        <select name="cargoUom" size="1">
             <%= dbList.getPackageList(request.getParameter("cargoUom"),sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>重量：</td>
      <td> 
        <input type="text" maxlength="10" size="20" name="cargoWeight" value="<%= request.getParameter("cargoWeight") %>" javascript  onchange="return cargoWeight_onchange()">
	<font color=#ff0033>*</font>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>航運公司：</td>
      <td> 
        <select name="shippingLineId" size="1">
          <%= dbList.getShippingLineList(request.getParameter("shippingLineId"),sMarkLanguage) %>
        </select>
	<font color=#ff0033>*</font>
      </td>
      <td>落貨紙號碼/提貨單號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="shippingOrderNo" value="<%= request.getParameter("shippingOrderNo") %>">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
<%
   if(request.getParameter("onChance") == null)
   {
%>
    <tr> 
      <td height="20">發貨公司名稱：</td>
      <td height="20"> 
         <input type="text" maxlength="50" size="20" name="cargoIssuerInput">
      </td>
      <td height="20">收貨公司名稱：</td>
      <td height="20">
         <input type="text" maxlength="50" size="20" name="cargoReceiverInput">
      </td>
    </tr>
<%
   }
   else
       {
         if(request.getParameter("onChance").equals("Issuer"))
         {
 %>
     <tr>
       <td height="20">發貨公司名稱：</td>
       <td height="20"> 
            <input type="text" maxlength="50" size="20" name="cargoIssuerInput">
       </td>
       <td height="20">收貨公司名稱：</td>
       <td height="20">
            <input type="text" maxlength="50" size="20" name="cargoReceiverInput" value="<%= request.getParameter("cargoReceiverInput") %>" >
       </td>
    </tr>
<%
         } 
         else
             {
%>
             <tr>
                 <td height="20">發貨公司名稱：</td>
                 <td height="20">    
                     <input type="text" maxlength="50" size="20" name="cargoIssuerInput" value="<%= request.getParameter("cargoIssuerInput") %>" >
                 </td>
                 <td height="20">收貨公司名稱：</td>
                 <td height="20">   
                     <input type="text" maxlength="50" size="20" name="cargoReceiverInput">
                 </td>
             </tr>
      <%
            }
       }
      %>


    <a name="3">    
    <tr> 
      <td height="20"></td>
      <td height="20"> 
        <select name="cargoIssuer" size="1"  LANGUAGE=javascript  onchange="return cargoIssuer_onchange()">
             <%= dbList.getTradingPartnerList(companyId,request.getParameter("cargoIssuer"),sMarkLanguage) %>
        </select>
      </td>
      <td height="20"></td>
      <td height="20">
        <select name="cargoReceiver" size="1" LANGUAGE=javascript  onchange="return cargoReceiver_onchange()">
            <%= dbList.getTradingPartnerList(companyId,request.getParameter("cargoReceiver"),sMarkLanguage) %>
        </select>
      </td>
    </tr>
 <%
   if(request.getParameter("onChance") == null)
   {
%>
    <tr> 
      <td>發貨公司聯絡人電話號碼：</td>
      <td> 
          </a><input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo">
	<font color=#ff0033>*</font>
      </td>
      <td>收貨公司聯絡人電話號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo">
	<font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>發貨地詳細地址：</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1">
	<font color=#ff0033>*</font>
      </td>
      <td>目的地詳細地址：</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1">
	<font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr2">
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr2">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr3">
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr3">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr4">
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr4">
      </td>
    </tr> 
<%
  }
    else
        {
        if(request.getParameter("onChance").equals("Issuer"))
        {
          if(!request.getParameter("cargoIssuer").equals("Any"))
          {  
              tradingPartnerValue = dbList.findTradingPartner(request.getParameter("cargoIssuer"));
   %>  
            <tr> 
               <td>發貨公司聯絡人電話號碼：</td>
               <td> 
                 <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= tradingPartnerValue.telephoneNo %>">
               </td>
               <td>收貨公司聯絡人電話號碼：</td>
               <td> 
                  <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= request.getParameter("cargoReceiverPhoneNo")  %>">
               </td>
           </tr>
           <tr> 
           <td>發貨地詳細地址：</td>
           <td> 
                 <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1" value="<%= tradingPartnerValue.tradingPartnerAddr1 %>">
           </td>
           <td>目的地詳細地址：</td>
           <td> 
              <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1" value="<%= request.getParameter("cargoReceiverAddr1") %>">
           </td>
         </tr>
         <tr> 
            <td>&nbsp;</td>
            <td> 
               <input type="text" maxlength="50" size="20" name="cargoIssuerAddr2" value="<%= tradingPartnerValue.tradingPartnerAddr2 %>">
           </td>
           <td>&nbsp;</td>
           <td> 
              <input type="text" maxlength="50" size="20" name="cargoReceiverAddr2" value="<%= request.getParameter("cargoReceiverAddr2") %>">
           </td>
        </tr>
        <tr> 
           <td>&nbsp;</td>
           <td> 
              <input type="text" maxlength="50" size="20" name="cargoIssuerAddr3" value="<%= tradingPartnerValue.tradingPartnerAddr3 %>">
           </td>
           <td>&nbsp;</td>
           <td> 
              <input type="text" maxlength="50" size="20" name="cargoReceiverAddr3" value="<%= request.getParameter("cargoReceiverAddr3") %>">
           </td>
        </tr>
        <tr> 
            <td>&nbsp;</td>
            <td> 
               <input type="text" maxlength="50" size="20" name="cargoIssuerAddr4" value="<%= tradingPartnerValue.tradingPartnerAddr4 %>">
            </td>
            <td>&nbsp;</td>
            <td> 
               <input type="text" maxlength="50" size="20" name="cargoReceiverAddr4" value="<%= request.getParameter("cargoReceiverAddr4") %>">
           </td>
        </tr> 
    <%
       } else if(request.getParameter("cargoIssuer").equals("Any")) {
    %>
         <tr> 
           <td>發貨公司聯絡人電話號碼：</td>
           <td> 
              <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" >
           </td>
           <td>收貨公司聯絡人電話號碼：</td>
           <td> 
              <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= request.getParameter("cargoReceiverPhoneNo")  %>">
           </td>
        </tr>
        <tr> 
           <td>發貨地詳細地址：</td>
           <td> 
              <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1">
           </td>
           <td>目的地詳細地址：</td>
           <td> 
             <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1"  value="<%= request.getParameter("cargoReceiverAddr1")  %>">
            </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td> 
             <input type="text" maxlength="50" size="20" name="cargoIssuerAddr2">
          </td>
          <td>&nbsp;</td>
          <td> 
            <input type="text" maxlength="50" size="20" name="cargoReceiverAddr2" value="<%= request.getParameter("cargoReceiverAddr2")  %>">
          </td>
      </tr>
      <tr> 
         <td>&nbsp;</td>
         <td> 
          <input type="text" maxlength="50" size="20" name="cargoIssuerAddr3">
        </td>
        <td>&nbsp;</td>
        <td> 
          <input type="text" maxlength="50" size="20" name="cargoReceiverAddr3" value="<%= request.getParameter("cargoReceiverAddr3")  %>">
        </td>
      </tr>
     <tr> 
       <td>&nbsp;</td>
       <td> 
         <input type="text" maxlength="50" size="20" name="cargoIssuerAddr4">
       </td>
       <td>&nbsp;</td>
       <td> 
         <input type="text" maxlength="50" size="20" name="cargoReceiverAddr4" value="<%= request.getParameter("cargoReceiverAddr4")  %>">
       </td>
     </tr> 

 <%      
         }
    }
    else
        {
          if(!request.getParameter("cargoReceiver").equals("Any"))
          {
             tradingPartnerValue = dbList.findTradingPartner(request.getParameter("cargoReceiver"));
        %>
             <tr> 
                <td>發貨公司聯絡人電話號碼：</td>
                <td> 
                   <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= request.getParameter("cargoIssuerPhoneNo") %>">
                </td>
                <td>收貨公司聯絡人電話號碼：</td>
                <td> 
                  <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= tradingPartnerValue.telephoneNo  %>">
               </td>
            </tr>
            <tr> 
               <td>發貨地詳細地址：</td>
               <td> 
                 <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1" value="<%= request.getParameter("cargoIssuerAddr1") %>">
               </td>
               <td>目的地詳細地址：</td>
               <td> 
                 <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1" value="<%= tradingPartnerValue.tradingPartnerAddr1 %>">
               </td>
           </tr>
           <tr> 
              <td>&nbsp;</td>
              <td> 
                 <input type="text" maxlength="50" size="20" name="cargoIssuerAddr2" value="<%= request.getParameter("cargoIssuerAddr2") %>">
              </td>
              <td>&nbsp;</td>
              <td> 
                 <input type="text" maxlength="50" size="20" name="cargoReceiverAddr2" value="<%= tradingPartnerValue.tradingPartnerAddr2 %>">
              </td>
          </tr>
          <tr> 
             <td>&nbsp;</td>
             <td> 
                <input type="text" maxlength="50" size="20" name="cargoIssuerAddr3" value="<%= request.getParameter("cargoIssuerAddr3") %>">
             </td>
             <td>&nbsp;</td>
             <td> 
                <input type="text" maxlength="50" size="20" name="cargoReceiverAddr3" value="<%= tradingPartnerValue.tradingPartnerAddr3 %>">
             </td>
          </tr>
          <tr> 
             <td>&nbsp;</td>
             <td> 
                <input type="text" maxlength="50" size="20" name="cargoIssuerAddr4" value="<%= request.getParameter("cargoIssuerAddr4") %>">
             </td>
             <td>&nbsp;</td>
             <td> 
                <input type="text" maxlength="50" size="20" name="cargoReceiverAddr4" value="<%= tradingPartnerValue.tradingPartnerAddr4 %>">
             </td>
           </tr> 
    
    <%
       } else if(request.getParameter("cargoReceiver").equals("Any")){
    %>
                <tr> 
                   <td>發貨公司聯絡人電話號碼：</td>
                   <td> 
                      <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= request.getParameter("cargoIssuerPhoneNo")  %>">
                   </td>
                   <td>收貨公司聯絡人電話號碼：</td>
                   <td> 
                     <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" >
                   </td>
               </tr>
               <tr> 
                  <td>發貨地詳細地址：</td>
                  <td> 
                     <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1"  value="<%= request.getParameter("cargoIssuerAddr1") %>">
                  </td>
                  <td>目的地詳細地址：</td>
                  <td> 
                     <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1"  >
                 </td>
              </tr>
              <tr> 
                 <td>&nbsp;</td>
                 <td> 
                    <input type="text" maxlength="50" size="20" name="cargoIssuerAddr2" value="<%= request.getParameter("cargoIssuerAddr2")  %>">
                 </td>
                 <td>&nbsp;</td>
                 <td> 
                   <input type="text" maxlength="50" size="20" name="cargoReceiverAddr2" >
                 </td>
             </tr>
             <tr>
                 <td>&nbsp;</td>
                 <td> 
                    <input type="text" maxlength="50" size="20" name="cargoIssuerAddr3" value="<%= request.getParameter("cargoIssuerAddr3")  %>">
                 </td>
                 <td>&nbsp;</td>
                 <td> 
                    <input type="text" maxlength="50" size="20" name="cargoReceiverAddr3" >
                 </td>
             </tr>
             <tr> 
                 <td>&nbsp;</td>
                 <td> 
                    <input type="text" maxlength="50" size="20" name="cargoIssuerAddr4" value="<%= request.getParameter("cargoIssuerAddr4")  %>">
                 </td>
                 <td>&nbsp;</td>
                 <td> 
                    <input type="text" maxlength="50" size="20" name="cargoReceiverAddr4" >
                 </td>
             </tr> 



     <%
         }
     }
  }
 %>  
  <tr> 
    <td>備注：</td>
        <td height="110"> 
          <textarea  rows="5" cols="15" style="width:200px" name="remark"><%= request.getParameter("remark") %></textarea>
        </td>
    <td>&nbsp;</td>
    <td>&nbsp; </td>
  </tr>
</table>

</div>
    
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
			<td>
				<a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a>
				<img src="../images/good.jpg" width="10" height="10">
				<a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
			</td>

  </tr>
</table></form>
<p align="left">&nbsp;</p>
<hr>     
<%@ include file = "../include/end.jsp" %>
<%}%>
</body>
</html>


