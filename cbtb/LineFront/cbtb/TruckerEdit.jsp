     
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />

<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />
<%@ include file="Init.jsp"%>
<%
String language = "CH";
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
else
  {
    tdm=(TruckerDataModel)session.getAttribute("truckerDataModel"); 
    CompanyProfileModel companyProfileModel=new CompanyProfileModel();
    companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
    String companyId=companyProfileModel.getCompanyId();
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/headtrucker.jsp"%>
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
    <td height="11"><b><font color="#667852">貨櫃車司機信息</font></b></td>
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
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/DateValidLt.js></script>
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<SCRIPT LANGUAGE=javascript>
function doPost()
{
    with(document.edit)
  {
    
     if (Trim(hkTelephoneNo.value).length != 0)
   {
     if (!isInt(Trim(hkTelephoneNo.value) ))
   {
     alert("請輸入正確的香港電話號碼!");
     return;
   }
   }
     if (!isInt(Trim(inlandTelephoneNo.value) ) && Trim(inlandTelephoneNo.value).length != 0)
   {
     alert("請輸入正確的内地電話號碼!");
     return;
   }
     if (!isInt(Trim(hkMobileNo.value) ) && Trim(hkMobileNo.value).length != 0)
   {
     alert("請輸入正確的香港手提電話號碼!");
     return;
   }
     if (!isInt(Trim(inlandMobileNo.value) ) && Trim(inlandMobileNo.value).length != 0)
   {
     alert("請輸入正確的内地手提電話號碼!");
     return ;
   }
     if (!isInt(Trim(hkPagerNo.value) ) && Trim(hkPagerNo.value).length != 0)
   {
     alert("請輸入正確的香港呼機號碼!");
     return ;
   }
     if (!isInt(Trim(inlandPagerNo.value) )  && Trim(inlandPagerNo.value).length != 0)
   {
     alert("請輸入正確的内地呼機號碼!");
     return;
   }

}

   edit.submit();
}
</SCRIPT>
<form action="TruckerEditView.jsp" method="POST" name="edit">
<table border="0" width="90%">
<input type="hidden" name="companyName" value="<%=dbList.getCompanyName(companyId,language)%>">   
<input type="hidden" name="companyId" value="<%=companyId%>">

<input type="hidden" name="truckerId" value="<%=tdm.getTruckerId()%>">
   <tr>
        
    <td height="22">運輸公司名稱：</td>
        
    <td height="22"><%=dbList.getCompanyName(companyId,language)%></td>
    <td height="22">運輸公司編號：</td>
        
    <td height="22"><%=companyId%></td>
    </tr>
<tr>
    <td>貨櫃車編號：</td>
    <td><%=tdm.getTruckerId()%></td>
        

        <td>香港身份證號碼 / 護照號碼：</td>
        <td><%=tdm.getHkId()%></td>
    </tr>
    <tr>
    <td>貨櫃車司機英文姓名：</td>
        
    <td>
      <%=tdm.getTruckerName()%>
    </td>

        <td>貨櫃車型號：</td>
        <td><%=tdm.getTruckModelNo()%></td>
    </tr>
    <tr>
        <td>貨櫃車司機中文姓名：</td>
        <td><%=tdm.getTruckerChineseName()%></td>

        <td>顔色：</td>
        <td><%=tdm.getTruckColor()%></td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><%=tdm.getTruckerAddr1()%></td>
        <td>重量 (公斤)：</td>
        <td><%=tdm.getCarryWeight()%></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr2()%></td>
    <td>註冊日期：</td>
    <td><%=tdm.getCreationDate()%>&nbsp; </td>

    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr3()%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr4()%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>内地車牌號碼：</td>
        <td><%=tdm.getInlandPlateNo()%></td>
        <td>香港車牌號碼：</td>
        <td><%=tdm.getHkPlateNo()%></td>
    </tr>
    <tr>
        <td>内地電話號碼：</td>
        <td><input type="text" size="20" name="inlandTelephoneNo" value="<%=tdm.getInlandTelephoneNo()%>" maxlength="20" ></td>
        <td>香港電話號碼：</td>
        <td><input type="text" size="20" name="hkTelephoneNo" value="<%=tdm.getHkTelephoneNo()%>" maxlength="20" ></td>
    </tr>
    <tr>
        <td>内地手提電話號碼：</td>
        <td><input type="text" size="20" name="inlandMobileNo" value="<%=tdm.getInlandMobileNo()%>" maxlength="20"> </td>
        <td>香港手提電話號碼：</td>
        <td><input type="text" size="20" name="hkMobileNo" value="<%=tdm.getHkMobileNo()%>" maxlength="20" > </td>
    </tr>
    <tr>
        <td>内地傳呼機號碼：</td>
        <td><input type="text" size="20" name="inlandPagerNo" value="<%=tdm.getInlandPagerNo()%>" maxlength="20" > </td>
        <td>香港傳呼機號碼：</td>
        <td><input type="text" size="20" name="hkPagerNo" value="<%=tdm.getHkPagerNo()%>" maxlength="20" > </td>
    </tr>
    <tr>
        <td>内地駕駛執照號碼：</td>
        <td><%=tdm.getInlandLicenseNo()%></td>
        <td>香港駕駛執照號碼：</td>
        <td><%=tdm.getHkLicenseNo()%></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
   <% String ts="";
String theTruckerStatus=tdm.getTruckStatus();
if (CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(theTruckerStatus)) ts="註冊中";
if (CbtbConstant.TRUCKER_ACTIVE.equalsIgnoreCase(theTruckerStatus)) ts="正常";
if (CbtbConstant.TRUCKER_DELETE.equalsIgnoreCase(theTruckerStatus)) ts="已刪除";
if (CbtbConstant.TRUCKER_SUSPEND.equalsIgnoreCase(theTruckerStatus)) ts="停用";

 %> 
    <tr>
        <td>狀況：</td>
        <td><%=ts%>&nbsp;</td>
        <td>備注：</td>
        <td><%=tdm.getRemark()%></td>
    </tr>


      <td>
				<a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a>
				<img src="../images/good.jpg" width="10" height="10">
				<a href="javascript:reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
			</td>
</table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<%}%>
</body>

</html>




