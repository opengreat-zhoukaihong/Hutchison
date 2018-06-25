<%@ include file="Init.jsp"%>        
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

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","TRUCKER"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
String back=request.getParameter("back");
String companyId=request.getParameter("companyId");
tdm=(TruckerDataModel)session.getAttribute("truckerDataModel");

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
    
   if (Trim(truckerName.value).length == 0)
   {
     alert("請輸入貨櫃車司機英文姓名!");
     return false;
   }
   if (Trim(truckerChineseName.value).length == 0)
   {
     alert("請輸入司機中文姓名!");
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

     if ((Trim(truckStatus.value) != 1) && Trim(reasonId.value).length == 0)
   {
     alert("請輸入原因代碼!");
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
if ((truckStatus.value=="<%=CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS%>") || (truckStatus.value=="<%=CbtbConstant.TRUCKER_ACTIVE%>"))
  {     
      if(reasonId.value!="Any")
       { alert("司機狀況在註冊中和正常時，不能輸入原因!");
            return; 
       }
       

  }
if ((truckStatus.value!="<%=CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS%>") && (truckStatus.value!="<%=CbtbConstant.TRUCKER_ACTIVE%>"))
  {      if(reasonId.value=="Any")
       { alert("司機狀況在暫停或已刪除時，請輸入明確的原因");
            return; 
        }
  }
}

   edit.submit();
}
</SCRIPT>
<form action="TruckerView.jsp" method="POST" name="edit">
<table border="0" width="90%">
<input type="hidden" name="companyName" value="<%=dbList.getCompanyName(companyId,"CN")%>">   
<input type="hidden" name="companyId" value="<%=companyId%>">
<input type="hidden" name="operate" value="update">
<input type="hidden" name="back" value="<%=back%>">
<input type="hidden" name="truckerId" value="<%=tdm.getTruckerId()%>">
   <tr>
        
    <td height="22">運輸公司名稱：</td>
        
    <td height="22"><%=dbList.getCompanyName(companyId,"CN")%></td>
    <td height="22">運輸公司編號：</td>
        
    <td height="22"><%=companyId%></td>
    </tr>
<tr>
    <td>貨櫃車編號：</td>
    <td><%=tdm.getTruckerId()%></td>
        

        <td>香港身份證號碼 / 護照號碼：</td>
        <td><input type="text" size="20" name="hkId" value="<%=tdm.getHkId()%>" maxlength="10" tabindex=1> 
              <font color="red">*</font></td>
    </tr>
    <tr>
    <td>貨櫃車司機英文姓名：</td>
        
    <td>
      <input type="text" size="20" name="truckerName" value="<%=tdm.getTruckerName()%>" maxlength="30" tabindex=2>
              <font color="red">*</font>
    </td>

        <td>貨櫃車型號：</td>
        <td><input type="text" size="20" name="truckModelNo" value="<%=tdm.getTruckModelNo()%>" maxlength="20" tabindex=3> 
              <font color="red">*</font></td>
    </tr>
    <tr>
        <td>貨櫃車司機中文姓名：</td>
        <td><input type="text" size="20" name="truckerChineseName" value="<%=tdm.getTruckerChineseName()%>" maxlength="10" tabindex=4> 
              <font color="red">*</font></td>

        <td>顔色：</td>
        <td><input type="text" size="20" name="truckColor" value="<%=tdm.getTruckColor()%>" maxlength="10" tabindex=5>
              <font color="red">*</font> </td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><input type="text" size="20" name="truckerAddr1" value="<%=tdm.getTruckerAddr1()%>" maxlength="16" tabindex=6> </td>
        <td>重量 (公斤)：</td>
        <td><input type="text" size="20" name="carryWeight" value="<%=tdm.getCarryWeight()%>" maxlength="20" tabindex=10>
              <font color="red">*</font> </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><input type="text" size="20" name="truckerAddr2" value="<%=tdm.getTruckerAddr2()%>" maxlength="16" tabindex=7> </td>
    <td>註冊日期：</td>
    <td><%=tdm.getCreationDate()%>&nbsp; </td>
<input type="hidden" name="creationDate" value="<%=tdm.getCreationDate()%>" tabindex=11>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><input type="text" size="20" name="truckerAddr3" value="<%=tdm.getTruckerAddr3()%>" maxlength="16" tabindex=8> </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><input type="text" size="20" name="truckerAddr4" value="<%=tdm.getTruckerAddr4()%>" maxlength="16" tabindex=9> </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>内地車牌號碼：</td>
        <td><input type="text" size="20" name="inlandPlateNo" value="<%=tdm.getInlandPlateNo()%>" maxlength="10" tabindex=12> 
              <font color="red">*</font></td>
        <td>香港車牌號碼：
</td>
        <td><input type="text" size="20" name="hkPlateNo" value="<%=tdm.getHkPlateNo()%>" maxlength="10" tabindex=13> 
              <font color="red">*</font></td>
    </tr>
    <tr>
        <td>内地電話號碼：</td>
        <td><input type="text" size="20" name="inlandTelephoneNo" value="<%=tdm.getInlandTelephoneNo()%>" maxlength="20" tabindex=14> </td>
        <td>香港電話號碼：</td>
        <td><input type="text" size="20" name="hkTelephoneNo" value="<%=tdm.getHkTelephoneNo()%>" maxlength="20" tabindex=15> </td>
    </tr>
    <tr>
        <td>内地手提電話號碼：</td>
        <td><input type="text" size="20" name="inlandMobileNo" value="<%=tdm.getInlandMobileNo()%>" maxlength="20" tabindex=16> </td>
        <td>香港手提電話號碼：</td>
        <td><input type="text" size="20" name="hkMobileNo" value="<%=tdm.getHkMobileNo()%>" maxlength="20" tabindex=17> </td>
    </tr>
    <tr>
        <td>内地傳呼機號碼：</td>
        <td><input type="text" size="20" name="inlandPagerNo" value="<%=tdm.getInlandPagerNo()%>" maxlength="20" tabindex=18> </td>
        <td>香港傳呼機號碼：</td>
        <td><input type="text" size="20" name="hkPagerNo" value="<%=tdm.getHkPagerNo()%>" maxlength="20" tabindex=19> </td>
    </tr>
    <tr>
        <td>内地駕駛執照號碼：</td>
        <td><input type="text" size="20" name="inlandLicenseNo" value="<%=tdm.getInlandLicenseNo()%>" maxlength="10" tabindex=20> 
              <font color="red">*</font></td>
        <td>香港駕駛執照號碼：</td>
        <td><input type="text" size="20" name="hkLicenseNo" value="<%=tdm.getHkLicenseNo()%>" maxlength="10" tabindex=21> 
              <font color="red">*</font></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
 <% String ts=null;
if (CbtbConstant.TRUCKER_ACTIVE.equalsIgnoreCase(tdm.getTruckStatus())) ts="selected";
 %>   
    <tr>
        <td>狀況：</td>
        <td><select name="truckStatus" size="1" tabindex=22>
            <option value="<%=CbtbConstant.TRUCKER_ACTIVE%>" <%=ts%>>正常</option>
 <%  ts=null;
if (CbtbConstant.TRUCKER_DELETE.equalsIgnoreCase(tdm.getTruckStatus())) ts="selected";
 %> 
            <option value="<%=CbtbConstant.TRUCKER_DELETE%>" <%=ts%>>已刪除</option>
 <%  ts=null;
if (CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(tdm.getTruckStatus())) ts="selected";
 %> 
            <option value="<%=CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS%>" <%=ts%>>注冊中</option>
 <%  ts=null;
if (CbtbConstant.TRUCKER_SUSPEND.equalsIgnoreCase(tdm.getTruckStatus())) ts="selected";
 %> 
            <option value="<%=CbtbConstant.TRUCKER_SUSPEND%>" <%=ts%>>停用</option>
        </select> </td>
        <td>備注：</td>
        <td><textarea name="remark" rows="3" cols="18"  maxlength="33" tabindex=23><%=tdm.getRemark()%></textarea></td>
    </tr>
    <tr>
        <td>原因代碼：</td>
        <td><select name="reasonId" size="1" tabindex=24>
            <%=dbList.getReasonCodeList(tdm.getReasonId(), "CN")%>

        </select> </td>
        
    <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>

    <p><input type="button" name="sub" value="提 交" onclick="javascript:doPost()">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>

</html>




