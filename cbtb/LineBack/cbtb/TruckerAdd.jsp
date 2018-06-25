<%@ include file="Init.jsp"%>   


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />

<jsp:useBean id="idm" scope="session" class="com.cbtb.model.TruckerDataModel" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","TRUCKER"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
String back=request.getParameter("back");
String companyId=request.getParameter("companyId");
%>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/DateValidLt.js></script>
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<SCRIPT LANGUAGE=javascript>
function doPost()
{
    with(document.add)
  {
    
   if (Trim(truckerName.value).length == 0)
   {
     alert("請輸入貨櫃車司機英文名!");
     return false;
   }
   if (Trim(truckerChineseName.value).length == 0)
   {
     alert("請輸入司機姓名!");
     return false;
   }
   if (Trim(hkId.value).length == 0)
   {
     alert("請輸入香港身份證號碼 / 護照號碼!");
     return false;
   }
    if (Trim(hkLicenseNo.value).length == 0)
   {
     alert("請輸入香港駕駛執照號碼!");
     return  false;
   }
    if (Trim(inlandLicenseNo.value).length == 0)
   {
     alert("請輸入内地駕駛執照號碼!");
      return  false;
   }
    if (Trim(hkPlateNo.value).length == 0)
   {
     alert("請輸入香港車牌號碼!");
     return  false;
   }
    if (Trim(inlandPlateNo.value).length == 0)
   {
     alert("請輸入内地車牌號碼!");
     return  false;
   }
     if (Trim(truckModelNo.value).length == 0)
   {
     alert("請輸入貨櫃車型號!");
     return  false;
   }
     if (Trim(truckColor.value).length == 0)
   {
     alert("請輸入貨櫃車顔色!");
     return  false;
   }
     if (Trim(carryWeight.value).length == 0)
   {
     alert("請輸入貨櫃車重量!");
     return  false;
   }
     if (Trim(hkTelephoneNo.value).length != 0)
   {
     if (!isInt(Trim(hkTelephoneNo.value) ))
   {
     alert("請輸入正確的香港電話號碼!");
     return  false;
   }
   }
     if (!isInt(Trim(inlandTelephoneNo.value) ) && Trim(inlandTelephoneNo.value).length != 0)
   {
     alert("請輸入正確的内地電話號碼!");
     return  false;
   }
     if (!isInt(Trim(hkMobileNo.value) ) && Trim(hkMobileNo.value).length != 0)
   {
     alert("請輸入正確的香港手提電話號碼!");
     return  false;
   }
     if (!isInt(Trim(inlandMobileNo.value) ) && Trim(inlandMobileNo.value).length != 0)
   {
     alert("請輸入正確的内地手提電話號碼!");
     return  false;
   }
     if (!isInt(Trim(hkPagerNo.value) ) && Trim(hkPagerNo.value).length != 0)
   {
     alert("請輸入正確的香港呼機號碼!");
     return  false;
   }
     if (!isInt(Trim(inlandPagerNo.value) )  && Trim(inlandPagerNo.value).length != 0)
   {
     alert("請輸入正確的内地呼機號碼!");
     return  false;
   }
     if (!isInt(Trim(carryWeight.value) ) && Trim(carryWeight.value).length != 0)
   {
     alert("請輸入正確的重量!");
     return  false;
   }
}

   add.submit();
}
</SCRIPT>
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
    <td height="11">貨櫃車司機信息</td>
    <td height="11"> 
      <div align="right"><a href="javascript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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

<form action="TruckerView.jsp" name="add" method="post">
<table border="0" width="90%">
<input type="hidden" name="companyName" value="<%=dbList.getCompanyName(companyId,"CN")%>">   
<input type="hidden" name="companyId" value="<%=companyId%>">
<input type="hidden" name="operate" value="insert">
<input type="hidden" name="back" value="<%=back%>">
   <tr>
        
    <td height="22">運輸公司名稱：</td>
        
    <td height="22"><%=dbList.getCompanyName(companyId,"CN")%></td>
    <td height="22">運輸公司編號：</td>
        
    <td height="22"><%=companyId%></td>
    </tr>
    <tr>
        
    <td>貨櫃車司機英文姓名：</td>
        
    <td>
      <input type="text" size="20" name="truckerName" maxlength="30" tabindex=1 > <font color="red">*</font>
    </td>
        <td>香港身份證號碼 / 護照號碼：</td>
        <td><input type="text" size="20" name="hkId" maxlength="10" tabindex=2 >
          <font color="red">*</font> 
        </td>

    </tr>
    <tr>
        <td>貨櫃車司機中文姓名：</td>
        <td><input type="text" size="20" name="truckerChineseName" maxlength="10" tabindex=3 >           <font color="red">*</font> </td>
        <td>貨櫃車型號：</td>
        <td><input type="text" size="20" name="truckModelNo" maxlength="20" tabindex=4 > 
          <font color="red">*</font> </td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><input type="text" size="20" name="truckerAddr1" maxlength="16" tabindex=5> </td>
        <td>顔色：</td>
        <td><input type="text" size="20" name="truckColor" maxlength="10" tabindex=9> 
          <font color="red">*</font> </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><input type="text" size="20" name="truckerAddr2" maxlength="16" tabindex=6></td>
        <td>重量 (公斤)：</td>
        <td><input type="text" size="20" name="carryWeight" maxlength="20" tabindex=10> 
          <font color="red">*</font> </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><input type="text" size="20" name="truckerAddr3" maxlength="16" tabindex=7> </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><input type="text" size="20" name="truckerAddr4" maxlength="16" tabindex=8> </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>内地車牌號碼：</td>
        <td><input type="text" size="20" name="inlandPlateNo" maxlength="10" tabindex=11 > 
          <font color="red">*</font> </td>
        <td>香港車牌號碼：</td>
        <td><input type="text" size="20" name="hkPlateNo" maxlength="10" tabindex=12 >
          <font color="red">*</font>  </td>
    </tr>
    <tr>
        <td>内地電話號碼：</td>
        <td><input type="text" size="20" name="inlandTelephoneNo" maxlength="20" tabindex=13 > </td>
        <td>香港電話號碼：</td>
        <td><input type="text" size="20" name="hkTelephoneNo" maxlength="20" tabindex=14 > </td>
    </tr>
    <tr>
        <td>内地手提電話號碼：</td>
        <td><input type="text" size="20" name="inlandMobileNo" maxlength="20" tabindex=15 > </td>
        <td>香港手提電話號碼：</td>
        <td><input type="text" size="20" name="hkMobileNo" maxlength="20" tabindex=16 > </td>
    </tr>
    <tr>
        <td>内地傳呼機號碼：</td>
        <td><input type="text" size="20" name="inlandPagerNo" maxlength="20" tabindex=17> </td>
        <td>香港傳呼機號碼：</td>
        <td><input type="text" size="20" name="hkPagerNo" maxlength="20" tabindex=18 > </td>
    </tr>
    <tr>
        <td>内地駕駛執照號碼：</td>
        <td><input type="text" size="20" name="inlandLicenseNo" maxlength="10" tabindex=19 >           <font color="red">*</font> </td>
        <td>香港駕駛執照號碼：</td>
        <td><input type="text" size="20" name="hkLicenseNo" maxlength="10" tabindex=20 > 
          <font color="red">*</font> </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>備注：</td>
        <td><textarea name="remark" rows="3" cols="18" maxlength="33" tabindex=21 ></textarea></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>

    <p><input type="button" name="den" onClick="javascript:doPost()" value="提 交">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>

</html>








