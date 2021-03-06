﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.ejb.entity.TradingPartnerValue" %>
<script Language="JavaScript" src="../js/JsLib.js"></script>
<%
  webOperator.clearPermissionContext(); 
  webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
  webOperator.putPermissionContext("action", "edit"); //加入检查的内容
  if (!webOperator.checkPermission())
  {
     response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  }
  TradingPartnerValue tradingPartnerValue = (TradingPartnerValue)session.getAttribute("tradingPartnerValue");
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (frmEdit.tradingPartnerName.value =="")
   {
     alert("貿易夥伴英文名稱不能為空!");
     frmEdit.tradingPartnerName.focus();
     return;
   }
   if (frmEdit.tradingPartnerChineseName.value =="")
   {
     alert("貿易夥伴中文名稱不能為空!");
     frmEdit.tradingPartnerChineseName.focus();
     return;
   }
    if (frmEdit.contactPerson.value =="")
   {
     alert("聯絡人英文姓名!");
     frmEdit.contactPerson.focus();
     return;
   }
   if (frmEdit.telephoneNo.value =="")
   {
     alert("電話號碼不能為空!");
     frmEdit.telephoneNo.focus();
     return;
   }
   if(RemoveSpace(frmEdit.tradingPartnerAddr1.value).length == 0)
   {
     alert("貿易夥伴地址不能為空!");
     frmEdit.tradingPartnerAddr1.focus();
     return;
   }
   if(ispositiveinteger(frmEdit.telephoneNo.value,frmEdit.telephoneNo,"電話號碼只能是數字和 '-'")){
      frmEdit.submit();
  }
}

function ispositiveinteger(inputval,obj,instr){
   var inputstr = inputval.toString();
   var str = RemoveSpace(inputstr);
//  window.alert (str)
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

</SCRIPT>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
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
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2">貿易夥伴數據維護</font></td>
      <td width="57%">    
      <div align="right"><a
href="Trading_Partner_search.htm"></a><a
href="javascript:history.go(-2)"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
      </td>
    </tr>
  </table>
  
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>

<form name="frmEdit" action="TradingPartnerConfirm.jsp" method="POST">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="path" value="<%= request.getParameter("path") %>">
  <HR>
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
    <td width="50%">公司編號：</td>
    <td width="50%"><%= tradingPartnerValue.companyId %></td>
    <input type="hidden" name="companyId"  value="<%= tradingPartnerValue.companyId %>">
  </tr>
  <tr> 
    <td width="50%">貿易夥伴編號：</td>
    <td width="50%">
        <%= tradingPartnerValue.tradingPartnerId %>
        <input type="hidden" name="tradingPartnerId"  value="<%= tradingPartnerValue.tradingPartnerId %>">
    </td>
 </tr>
  <tr> 
    <td width="50%">貿易夥伴英文名稱：</td>
    <td width="50%"> 
      <input type="text" maxlength="100" name="tradingPartnerName" value="<%= tradingPartnerValue.tradingPartnerName %>"><font color=#ff0033>*</font>
      </td>
  </tr>
  <tr> 
    <td width="50%">貿易夥伴中文名稱：</td>
    <td width="50%"> 
      <input type="text" maxlength="100" name="tradingPartnerChineseName" value="<%= tradingPartnerValue.tradingPartnerChineseName %>"><font color=#ff0033>*</font>
      </td>
  </tr>
  <tr> 
    <td width="50%">聯絡人英文姓名：</td>
    <td width="50%"> 
      <input type="text"  maxlength="30" name="contactPerson" value="<%= tradingPartnerValue.contactPerson %>"><font color=#ff0033>*</font>
    </td>
  </tr>
  <tr> 
    <td width="50%">聯絡人中文姓名：</td>
    <td width="50%">
      <input type="text"  maxlength="30" name="contactChinesePerson" value="<%= tradingPartnerValue.contactChinesePerson %>" >
    </td>
  </tr>
  <tr> 
    <td width="50%">電話號碼：</td>
    <td width="50%"> 
      <input type="text" maxlength="20" size = "20"  name="telephoneNo" value="<%= tradingPartnerValue.telephoneNo %>"><font color=#ff0033>*</font>
    </td>
  </tr>
  <tr> 
    <td width="50%">貿易夥伴地址：</td>
    <td width="50%"> 
      <input type="text" maxlength="50" size = "50" name="tradingPartnerAddr1" value="<%= tradingPartnerValue.tradingPartnerAddr1 %>"><font color=#ff0033>*</font>
    </td>
  </tr>
  <tr>
     <td width="50%">&nbsp;</td>
     <td width="50%" > 
      <input type="text" maxlength="50" size = "50" name="tradingPartnerAddr2" value="<%= tradingPartnerValue.tradingPartnerAddr2 %>">
     </td>
   </tr>
   <tr>
      <td width="50%">&nbsp;</td>
      <td width="50%" > 
        <input type="text" maxlength="50" size="50" name="tradingPartnerAddr3" value="<%= tradingPartnerValue.tradingPartnerAddr3 %>">
       </td>
    </tr>
    <tr>
      <td width="50%">&nbsp;</td>
      <td width="50%" > 
        <input type="text" maxlength="50" size="50" name="tradingPartnerAddr4" value="<%= tradingPartnerValue.tradingPartnerAddr4 %>">
       </td>
    </tr>
</table>

   
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
      <div align="left"></div>
      <p> 
        <input type="button" name="denglu  3" value="提 交" LANGUAGE=javascript  onclick="return doPost()">
        <input type="reset" name="denglu  32" value="重 設">
      </p>
     </td>
    </tr>
 </table>
</form>
</body>
</html>


