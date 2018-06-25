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
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.cbtb.util.CbtbConstant " %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestMode" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<%
   webOperator.clearPermissionContext(); 
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "edit"); //加入检查的内容
   if (!webOperator.checkPermission())
   {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
   }

   String sMarkLanguage = "CH";
   CompanyProfileModel companyProfileModel=new CompanyProfileModel();
   companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
   String companyId=companyProfileModel.getCompanyId(); 
   String companyName = companyProfileModel.getCompanyChineseName();
   TradingPartnerValue  tradingPartnerValue  = new TradingPartnerValue();
   CbtbConstant cbtbConstant = new CbtbConstant();
   deliveryRequestMode = (DeliveryRequestModel)session.getAttribute("deliveryRequestMode");

   String strIssuer = "";
   String strIssuerID = "";
   String strReceive = "" ;
   String strReceiveID = "" ;
   
  if(dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoIssuer(),sMarkLanguage).length() >0)
  { 
     strIssuer =  "";
     strIssuerID = deliveryRequestMode.getCargoIssuer();
  } 
  else
      {
        strIssuer = deliveryRequestMode.getCargoIssuer();
        strIssuerID = "";
       }

  if(dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoReceiver(),sMarkLanguage).length() >0)
  { 
    strReceive = "";
    strReceiveID = deliveryRequestMode.getCargoReceiver();
 }
 else
     {
       strReceive = deliveryRequestMode.getCargoReceiver();
       strReceiveID = "";
     }

 SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); //initialize the current date
 String strDate = date.format(new Date());                   //get current date
 String redStarInTextBox = "<font color=#ff0033>*</font>";
 String redStarLeft = "";
 String redStarRight = "";
  
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{   
   if (add.originCityId.value =="Any")
   {
     alert("出發地城市不能為任何城市!");
     add.originCityId.focus();
     return;
   }
   if (add.destinationCityId.value =="Any")
   {
     alert("目的地城市不能為任何城市!");
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
     alert("發貨時閒不能為任何時閒!");
     add.deliveryTimeId.focus();
     return;
   }
   if (add.deliveryTimeSlot.value =="Any")
   {
     alert("發貨時閒段不能為任何時閒段!");
     add.deliveryTimeSlot.focus();
     return;
   }
   if (add.cargoId.value == "Any")
   {
     alert("貨物種類不能為任何貨物種類!");
     add.cargoId.focus();
     return;
   }
   if (add.requestContainerId.value == "Any")
   {
     alert("要求貨櫃種類不能為任何貨櫃種類!");
     add.requestContainerId.focus();
     return;
   }
   if (add.cargoQty.value =="")
   {
     alert("貨物數量不能為空!");
     add.cargoQty.focus();
     return;
   }
   else
      {
         if(add.cargoQty.value < 1)
         {
            alert("貨物數量不能小於 '1'");
            add.cargoQty.focus();
            return;
         }
         var inputvar = add.cargoQty.value;  
         var number = 0; 
         for(var i=0;i<RemoveSpace(inputvar).length;i++)
         {
            var oneChar = inputvar.charAt(i);
            if(oneChar == '.')
             number = number + 1;
        
          }
          if(number >= 2){
            alert("貨物數量輸入不能有兩個以上 '.'!");
            add.cargoQty.focus();
            return;
          }    
      }
   if (add.cargoUom.value =="Any")
   {
     alert("度量單位不能為任何度量單位!");
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
     alert("航運公司不能為任何航運公司!");
     add.shippingLineId.focus();
     return;
   }
   if (add.cargoIssuer.value =="Any" && RemoveSpace(add.cargoIssuerInput.value) == "")
   {
     if(add.cargoIssuer.length != 1){ 
        alert("發貨公司名稱不能為任何發貨公司!"); 
        add.cargoIssuer.focus();
     }
     else
         {
          alert("發貨公司名稱不能為空!"); 
          add.cargoIssuerInput.focus();
         }
     return;      
   }
   if (add.cargoIssuerPhoneNo.value =="")
   {
       alert("發貨公司電話號碼不能為空!");
       add.cargoIssuerPhoneNo.focus();
       return;
   }
   else
       {
        if(!isPostTel(add.cargoIssuerPhoneNo.value,add.cargoIssuerPhoneNo,"電話號碼只能是數字和 '-'"))
          return;
        }

   if (add.cargoIssuerAddr1.value =="")
   {
     alert("發貨公司地址不能為空!");
     add.cargoIssuerAddr1.focus();
     return;
   }
   if (add.cargoReceiver.value =="Any" && RemoveSpace(add.cargoReceiverInput.value) == "")
   {
      if(add.cargoReceiver.length != 1){  
        alert("收貨公司名稱不能為任何收貨公司!");
        add.cargoReceiver.focus();
      }
      else
         {
          alert("收貨公司名稱不能為空!"); 
          add.cargoReceiverInput.focus();
         }
      return;      
   }
   if (add.cargoReceiverPhoneNo.value =="")
   {
     alert("收貨公司電話號碼不能為空!");
     add.cargoReceiverPhoneNo.focus();
     return;
   }
   else
       {
        if(!isPostTel(add.cargoReceiverPhoneNo.value,add.cargoReceiverPhoneNo,"電話號碼只能是數字和 '-'"))
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
    if(add.cargoIssuerPhoneNo.value == add.cargoReceiverPhoneNo.value){
       alert("發貨公司電話號碼不能等於收貨公司電話號碼!");
       add.cargoIssuerPhoneNo.focus();
       return;
   }
   if (add.cargoIssuerAddr1.value == add.cargoReceiverAddr1.value)
   {
     alert("發貨公司地址 '" + add.cargoIssuerAddr1.value + "' 不能等於收貨公司地址 '" + add.cargoReceiverAddr1.value + "'!");
     add.cargoReceiverAddr1.focus();
     return;
   }
   
   if (add.cargoIssuerAddr2.value != ""){
     
      if (add.cargoIssuerAddr2.value == add.cargoReceiverAddr2.value)
      {
         alert("收貨公司地址 '" + add.cargoReceiverAddr2.value + "' 不能等於發貨公司地址 '" + add.cargoIssuerAddr2.value + "' !");
         add.cargoReceiverAddr2.focus();
         return;
      }
   }
   if (add.cargoIssuerAddr3.value != ""){
      
      if (add.cargoIssuerAddr3.value == add.cargoReceiverAddr3.value)
      {
         alert("收貨公司地址 '" + add.cargoReceiverAddr3.value + "' 不能等於發貨公司地址 '" + add.cargoIssuerAddr3.value + "' !");
         add.cargoReceiverAddr3.focus();
         return;
      }
   }
   if (add.cargoIssuerAddr4.value != ""){
      if (add.cargoIssuerAddr4.value == add.cargoReceiverAddr4.value)
      {
         alert("收貨公司地址 '" + add.cargoReceiverAddr4.value + "' 不能等於發貨公司地址 '" + add.cargoIssuerAddr4.value + "' !");
         add.cargoReceiverAddr4.focus();
         return;
      }
   }
   add.submit();
 }  

 function RemoveSpace(inputstr){
   var Str;
   Str = "";
   for (i = 0;i < inputstr.length;i++){
       var onechar = inputstr.charAt(i);
           if ((onechar != " ") || (onechar = "-")){
              if((onechar != " ") || (onechar = "/"))
                 Str = Str  + inputstr.charAt(i);
        }
   }
   return  Str;
  }
  
  function ispositiveinteger(inputval,obj,instr){
   var inputstr = inputval.toString();
   var str = RemoveSpace(inputstr);
//  window.alert (str)
   for (var i = 0;i < str.length;i++){
       var onechar = str.charAt(i);
              if ((onechar < "0") || (onechar > "9" )) {
                 window.alert (instr);
                 str = str.substr(0,i);
                 obj.value = str;
                 obj.focus();
                 return false;
              }
   }
   obj.value = str
   return true;
 }
 
 function cargoQty_onchange(){
   var inputvar = add.cargoQty.value;
   var obj = document.add.cargoQty;
   if(!isFloat(RemoveSpace(inputvar),obj,"只能輸入數字!")){
      obj.focus();
      return false;
   }
 }
 

function cargoIssuer_onchange() {
  add.onChance.value = "Issuer";
  add.action = "DeliveryRequestEdit.jsp#3";
  add.submit();
}

function cargoReceiver_onchange() {
  add.onChance.value = "Receiver";
  add.action = "DeliveryRequestEdit.jsp#3";
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

function isPostTel(inputval,obj,instr){
   var inputstr = inputval.toString();
   var str = RemoveSpace(inputstr);
   for (var i = 0;i < str.length;i++){
       var onechar = str.charAt(i);
              if ((onechar < "0") || (onechar > "9" )) {
                  if(onechar != '-'){
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

function deliveryTimeSlot_onChange(){
     correspondAction(add.deliveryTimeId,add.deliveryTimeSlot,timeSlotClass);
}

  function aClass(aData, aValue, aText) {
    if (aClass.arguments.length < 3)
      alert("传入的参数错误！")
    else {
      this.Data  = aData;
      this.Value = aValue;
      this.Text  = aText;
    }
  }

  function chgDnCombobox(aSrc, aDes, aClass, aRemain){
    if (chgDnCombobox.arguments.length < 3)
alert("传入的参数错误！")
    else if (aSrc.type != "select-one")
      alert("传入的参数错误！")
    else if (aClass == null)
      alert("aClass未定义错误！")
    else {
      if (aRemain==null)
        aRemain = 1;
      chgDnComboboxItem(aSrc.options[aSrc.selectedIndex].value, aDes, aClass, aRemain);
    }
  }

  function chgDnComboboxItem(aValue, aDes, aClass, aRemain){
    if (chgDnComboboxItem.arguments.length<3)
      alert("参数传入错误！")
    else if (aClass==null)
      alert("错误！aClass没有定义！")
    else{
      if (aRemain==null)
        aRemain = 1;
      deleteAllComboboxItem(aDes, aRemain);
      if(aValue=="Any")
        {
      for (var i=0; i<aClass.length; i++)
          if (aClass[i].Data!="Any")
          {
            if (aClass[i].Data!="End")
            addComboboxItem(aDes, aClass[i].Text, aClass[i].Value);
          }
        }
      else
       {
      for (var i=0; i<aClass.length; i++)
        if (aClass[i].Data==aValue)  /* check aClass[i].Data */
          if (aClass[i].Data!="")
            addComboboxItem(aDes, aClass[i].Text, aClass[i].Value);
       }
    }
  }

  function deleteAllComboboxItem(aList, aRemain) {
    for (var i=aList.options.length; i > aRemain-1; i--)
      aList.options[i] = null;
  }    

  function addComboboxItem(aList, aText, aValue) {
    var aOption = new Option(aText, aValue);
    eval("aList.options[aList.options.length]=aOption");
  }
  function correspondAction(aSrc, aDes, aClass)
  {
    if (correspondAction.arguments.length<3)
      alert("参数传入错误！")
    else if (aClass==null)
      alert("错误！aClass没有定义！")
    else
    {
       for (var i=0; i<aClass.length; i++)
        {
          if (aDes.options[aDes.selectedIndex].value == "Any")
          {
            aSrc.options[0].selected = true;
          }
          else if (aClass[i].Value==aDes.options[aDes.selectedIndex].value)
          {
            for (var j=0;j<aSrc.length;j++)
            {
              if (aSrc.options[j].value ==aClass[i].Data)
              {
                aSrc.options[j].selected=true;
                break;              
              }
            }
          }
        }
    }
  }

</SCRIPT>
<%
   out.println(dbList.getTimeSlotClass(sMarkLanguage));
%>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
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
<form action="DeliveryRequestConfirm.jsp" method="POST" name="add">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>   
      <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>送貨要求細節</b></font></font></td>
      <td width="57%">  
       <div align="right"><a href="DeliveryRequestSearch.jsp?rootPath=mainShippering.jsp"><font color="#003366">關閉</font></a></div>
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

<input type="hidden" name="rootPath" value="<%= request.getParameter("rootPath") %>">
<input type="hidden" name="path" value="<%= request.getParameter("path") %>">
<input type="hidden" name="status" value ="<%= deliveryRequestMode.getRequestStatus() %>">
<input type="hidden" name="onChance" >
<input type="hidden" name="mode" value ="Update">
<input type="hidden" name="deliveryRequestNum" value ="<%= deliveryRequestMode.getDeliveryRequestNum() %>">
<input type="hidden" name="matchNumber"   value ="<%= deliveryRequestMode.getMatchNumber() %>">
<input type="hidden" name="hongKongId" value="<%= cbtbConstant.HONGKONG_CITY_ID %>">
<input type="hidden" name="companyId" value ="<%= companyId %>">
<input type="hidden" name="companyName"   value ="<%= companyName %>">
<input type="hidden" name="currentDate" value="<%= strDate %>">

<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td>付貨人編號：</td>
      <td><%= companyId %></td>
      <td>付貨人姓名：</td>
      <td><%= companyName %></td>
   </tr>
<%
  if(request.getParameter("onChance") == null)
  {
%>
  <tr> 
      <td>出發地城市：</td>
      <td> 
        <select name="originCityId" size="1">
          <%= dbList.getCityList(deliveryRequestMode.getOriginCityId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
      <td>目的地城市：</td>
      <td> 
        <select name="destinationCityId" size="1">
          <%= dbList.getCityList(deliveryRequestMode.getDestinationCityId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>發貨日期：</td>
      <td> 
        <input type="text" maxlength="10" size="10" value="<%= deliveryRequestMode.getDeliveryDate().toString().substring(0,10)  %>" name="deliveryDate"  >
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
            onClick="fPopUpCalendarDlg(deliveryDate);return false" ><font color=#ff0033>*</font> 
     </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>發貨時閒：</td>
      <td> 
        <select name="deliveryTimeId" size="1" Language="javascript" onChange="deliveryTimeId_onChange()">
          <%= dbList.getDeliveryTimeList(deliveryRequestMode.getTimeId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
      <td>發貨時閒段：</td>
      <td> 
        <select name="deliveryTimeSlot" size="1" Language="javascript" onChange="deliveryTimeSlot_onChange()">
          <%= dbList.getDeliveryTimeSlotList(deliveryRequestMode.getTimeSlotId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>貨物種類：</td>
      <td> 
        <select name="cargoId" size="1">
             <%= dbList.getCargoCategoryList(deliveryRequestMode.getCargoId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
      <td>要求貨櫃檯種類：</td>
      <td> 
        <select name="requestContainerId" size="1">
            <%= dbList.getContainerTypeList(deliveryRequestMode.getContainerTypeId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td height="20">數量：</td>
      <td height="20"> 
        <input type="text" maxlength="8" size="20" name="cargoQty" value=<%= deliveryRequestMode.getCargoQty() %> LANGUAGE=javascript  onchange="return cargoQty_onchange()"><font color=#ff0033>*</font>
      </td>
      <td height="20">度量單位：</td>
      <td height="20"> 
        <select name="cargoUom" size="1">
             <%= dbList.getPackageList(deliveryRequestMode.getCargoUom(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>重量：</td>
      <td> 
        <input type="text" maxlength="30" size="20" name="cargoWeight" value="<%= deliveryRequestMode.getCargoWeight() %>" ><font color=#ff0033>*</font>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>航運公司：</td>
      <td> 
        <select name="shippingLineId" size="1">
          <%= dbList.getShippingLineList(deliveryRequestMode.getShippingLineId(),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
      <td>落貨紙號碼/提貨單號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="shippingOrderNo" value="<%= deliveryRequestMode.getShippingOrderNo() %>">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
     <tr> 
      <td height="20">發貨公司名稱：</td>
      <td height="20"> 
         <input type="text" maxlength="50" size="20" name="cargoIssuerInput" value="<%= deliveryRequestMode.getCargoIssuer() %>"><%= redStarInTextBox %>
      </td>
      <td height="20">收貨公司名稱：</td>
      <td height="20">
         <input type="text" maxlength="50" size="20" name="cargoReceiverInput" value="<%= deliveryRequestMode.getCargoReceiver() %>"><%= redStarInTextBox %>
      </td>
    </tr>
<a name="3">
    <tr> 
      <td height="20"></td>
      <td height="20"> 
        <select name="cargoIssuer" size="1" LANGUAGE=javascript  onchange="return cargoIssuer_onchange()">
             <%= dbList.getTradingPartnerList(companyId,deliveryRequestMode.getCargoIssuer(),sMarkLanguage) %>
        </select>
      </td>
      <td height="20"></td>
      <td height="20">
        <select name="cargoReceiver" size="1" LANGUAGE=javascript  onchange="return cargoReceiver_onchange()">
            <%= dbList.getTradingPartnerList(companyId,deliveryRequestMode.getCargoReceiver(),sMarkLanguage) %>
        </select>
      </td>
    </tr>    
    <tr> 
      <td>發貨公司聯絡人電話號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= deliveryRequestMode.getCargoIssuerPhoneNo() %>"><font color=#ff0033>*</font>
      </td>
      <td>收貨公司聯絡人電話號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= deliveryRequestMode.getCargoReceiverPhoneNo() %>"><font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>發貨地詳細地址：</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1" value="<%= deliveryRequestMode.getCargoIssuerAddr1() %>"><font color=#ff0033>*</font>
      </td>
      <td>目的地詳細地址：</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1" value="<%= deliveryRequestMode.getCargoReceiverAddr1() %>"><font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr2" value="<%= deliveryRequestMode.getCargoIssuerAddr2() %>">
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr2" value="<%= deliveryRequestMode.getCargoReceiverAddr2() %>">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr3" value="<%= deliveryRequestMode.getCargoIssuerAddr3() %>" >
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr3" value="<%= deliveryRequestMode.getCargoReceiverAddr3() %>">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr4" value="<%= deliveryRequestMode.getCargoIssuerAddr4() %>">
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr4" value="<%= deliveryRequestMode.getCargoReceiverAddr4() %>">
      </td>
    </tr>
    <tr> 
      <td>備注：</td>
      <td width="150px"> 
        <textarea name="remark" maxlength="200" size="20" rows="5" cols="15" style="width:200px"><%= deliveryRequestMode.getRemark() %></textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
   </tr>
</table>
  
<%
}
else   //the change's event happen!
{
%>
    <tr> 
      <td>出發地城市：</td>
      <td> 
        <select name="originCityId" size="1">
          <%= dbList.getCityList(request.getParameter("originCityId"),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
      <td>目的地城市：</td>
      <td> 
        <select name="destinationCityId" size="1">
          <%= dbList.getCityList(request.getParameter("destinationCityId"),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>發貨日期：</td>
      <td> 
        <input type="text" maxlength="10" size="10" value="<%= request.getParameter("deliveryDate")  %>" name="deliveryDate"  >
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
            onClick="fPopUpCalendarDlg(deliveryDate);return false" ><font color=#ff0033>*</font> 
     </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>發貨時閒：</td>
      <td> 
        <select name="deliveryTimeId" size="1" Language="javascript" onChange="deliveryTimeId_onChange()">
          <%= dbList.getDeliveryTimeList(request.getParameter("deliveryTimeId"),sMarkLanguage) %>
        </select>
        <font color=#ff0033>*</font>
      </td>
      <td>發貨時閒段：</td>
      <td> 
        <select name="deliveryTimeSlot" size="1" Language="javascript" onChange="deliveryTimeSlot_onChange()">
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
        <input type="text" maxlength="8" size="20" name="cargoQty" value="<%= request.getParameter("cargoQty") %>"  javascript  onchange="return cargoQty_onchange()"><font color=#ff0033>*</font>
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
        <input type="text" maxlength="30" size="20" name="cargoWeight" value="<%= request.getParameter("cargoWeight") %>"><font color=#ff0033>*</font>
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
    <tr>       
       <%
           if(request.getParameter("onChance").equals("Issuer"))
           {
              redStarLeft = "<font color=#ff0033>*</font>";
              if(request.getParameter("cargoReceiverInput").trim().length() == 0){
                 redStarInTextBox = "";
                  redStarRight = "<font color=#ff0033>*</font>";
              }
              else
                  {
                    redStarInTextBox = "<font color=#ff0033>*</font>";
                     redStarRight = "";
                  }
       %>
       <td height="20">發貨公司名稱：</td>
       <td height="20"> 
            <input type="text" maxlength="50" size="20" name="cargoIssuerInput">
       </td>
       <td height="20">收貨公司名稱：</td>
       <td height="20">
            <input type="text" maxlength="50" size="20" name="cargoReceiverInput" value="<%= request.getParameter("cargoReceiverInput") %>" ><%= redStarInTextBox %>
       </td>
      <%
          }
          else
             {
                redStarRight = "<font color=#ff0033>*</font>";
                if(request.getParameter("cargoIssuerInput").trim().length() == 0){
                  redStarInTextBox = "";
                  redStarLeft = "<font color=#ff0033>*</font>";
                }
                else{
                     redStarInTextBox = "<font color=#ff0033>*</font>";
                     redStarLeft = "";
                    }
      %>
       <td height="20">發貨公司名稱：</td>
       <td height="20">    
           <input type="text" maxlength="50" size="20" name="cargoIssuerInput" value="<%= request.getParameter("cargoIssuerInput") %>" ><%= redStarInTextBox %>
       </td>
       <td height="20">收貨公司名稱：</td>
       <td height="20">   
           <input type="text" maxlength="50" size="20" name="cargoReceiverInput">
       </td>
      <%
         }
      %>
    </tr>
<a name="3">
    <tr> 
      <td height="20"></td>
      <td height="20"> 
        <select name="cargoIssuer" size="1"  LANGUAGE=javascript  onchange="return cargoIssuer_onchange()">
             <%= dbList.getTradingPartnerList(companyId,request.getParameter("cargoIssuer"),sMarkLanguage) %>
        </select>
        <%= redStarLeft%>
      </td>
      <td height="20"></td>
      <td height="20">
        <select name="cargoReceiver" size="1" LANGUAGE=javascript  onchange="return cargoReceiver_onchange()">
            <%= dbList.getTradingPartnerList(companyId,request.getParameter("cargoReceiver"),sMarkLanguage) %>
        </select>
        <%= redStarRight %>
      </td>
    </tr>
 
<%
    //The chance's event of method of the cargoIssuer happen!
    if(request.getParameter("onChance").equals("Issuer"))
    {
      if(!request.getParameter("cargoIssuer").equals("Any"))
          {  
           tradingPartnerValue = dbList.findTradingPartner(request.getParameter("cargoIssuer"));
  %>  
   <tr> 
      <td>發貨公司聯絡人電話號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= tradingPartnerValue.telephoneNo %>"><font color=#ff0033>*</font>
      </td>
      <td>收貨公司聯絡人電話號碼：</td>
      <td> 
        <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= request.getParameter("cargoReceiverPhoneNo")  %>"><font color=#ff0033>*</font>
      </td>
    </tr>
    <tr> 
      <td>發貨地詳細地址：</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1" value="<%= tradingPartnerValue.tradingPartnerAddr1 %>"><font color=#ff0033>*</font>
      </td>
      <td>目的地詳細地址：</td>
      <td> 
        <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1" value="<%= request.getParameter("cargoReceiverAddr1") %>"><font color=#ff0033>*</font>
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
                     <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" ><font color=#ff0033>*</font>
                  </td>
                  <td>收貨公司聯絡人電話號碼：</td>
                  <td> 
                     <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= request.getParameter("cargoReceiverPhoneNo")  %>"><font color=#ff0033>*</font>
                  </td>
                  </tr>
                  <tr> 
                     <td>發貨地詳細地址：</td>
                     <td> 
                        <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1"><font color=#ff0033>*</font>
                    </td>
                    <td>目的地詳細地址：</td>
                    <td> 
                      <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1"  value="<%= request.getParameter("cargoReceiverAddr1")  %>"><font color=#ff0033>*</font>
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
   else   //the chance's event of method of the cargoReceiver happen!
       {
          if(!request.getParameter("cargoReceiver").equals("Any"))
          {
              tradingPartnerValue = dbList.findTradingPartner(request.getParameter("cargoReceiver"));
       %>
              <tr> 
                 <td>發貨公司聯絡人電話號碼：</td>
                 <td> 
                    <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= request.getParameter("cargoIssuerPhoneNo") %>"><font color=#ff0033>*</font>
                 </td>
                 <td>收貨公司聯絡人電話號碼：</td>
                 <td> 
                     <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" value="<%= tradingPartnerValue.telephoneNo  %>"><font color=#ff0033>*</font>
                 </td>
             </tr>
             <tr> 
                <td>發貨地詳細地址：</td>
                <td> 
                   <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1" value="<%= request.getParameter("cargoIssuerAddr1") %>"><font color=#ff0033>*</font>
                </td>
                <td>目的地詳細地址：</td>
                <td> 
                    <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1" value="<%= tradingPartnerValue.tradingPartnerAddr1 %>"><font color=#ff0033>*</font>
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
                      <input type="text" maxlength="20" size="20" name="cargoIssuerPhoneNo" value="<%= request.getParameter("cargoIssuerPhoneNo")  %>"><font color=#ff0033>*</font>
                   </td>
                   <td>收貨公司聯絡人電話號碼：</td>
                   <td> 
                     <input type="text" maxlength="20" size="20" name="cargoReceiverPhoneNo" ><font color=#ff0033>*</font>
                   </td>
               </tr>
               <tr> 
                  <td>發貨地詳細地址：</td>
                  <td> 
                     <input type="text" maxlength="50" size="20" name="cargoIssuerAddr1"  value="<%= request.getParameter("cargoIssuerAddr1") %>"><font color=#ff0033>*</font>
                  </td>
                  <td>目的地詳細地址：</td>
                  <td> 
                     <input type="text" maxlength="50" size="20" name="cargoReceiverAddr1"  ><font color=#ff0033>*</font>
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
           }  //match the else if(request.getParameter("cargoReceiver").equals("Any")){
       }     //match the second else
%>
    
   <tr> 
     <td>備注：</td>
      <td width="150px"> 
        <textarea name="remark" maxlength="200" size="20" rows="5" cols="15" style="width:200px"><%= request.getParameter("remark") %></textarea>
      </td>
     <td>&nbsp;</td>
     <td>&nbsp; </td>
   </tr>
</table>
<%
  }  //match the first else
%>


 <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td height="30"> <a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a><img src="../images/good.jpg" width="10" height="10"><a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a> 
      </td>
    </tr>
</table>
</form>
<p align="left">&nbsp;</p>
<hr>
      
<%@ include file = "../include/end.jsp" %>
</body>
</html>


