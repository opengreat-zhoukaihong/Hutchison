<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<%@ include file="Init.jsp"%>
<%
//webOperator.clearPermissionContext();  //清除以前检查的内容
//webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
//webOperator.putPermissionContext("action", "creat"); //加入检查的内容
//if (webOperator.checkPermission())
//  out.print("You have creat trucker Context");
//else
//  out.print("You can't creat trucker Context");
%>

<SCRIPT LANGUAGE=javascript>
function doPost()
{
	if (add.truckerName.value=="")
	{
		alert("請輸入貨櫃車司機英文名！");
		return ;
	}
	if (add.truckerChineseName.value=="")
	{
		alert("請輸入司機姓名！");
		return;
	}
	if (add.hkId.value=="")
	{
		alert("請輸入香港身份證號碼 / 護照號碼！");
		return;
	}

   add.submit();
}
</SCRIPT>
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
  
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨櫃車信息</font></b></font></td>
    <td>
      <div align="right"><a href="indexTrucking.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>
<form action="TruckerInfoAddConfirm.jsp" name="add">
<input type="hidden" name="operate" value="insert">
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td>運輸公司名稱：</td>
      <td height="22"><%=dbList.getCompanyName("TRC001","EN")%></td>
      <input type="hidden" name="companyId" value="TRC001">   
      <td>香港身份證號碼 / 護照號碼：</td>
      <td><input type="text" size="20" name="hkId" maxlength="10"> </td>
    </tr>
    <tr> 
      <td>貨櫃車司機英文姓名：</td>
      <td> <input type="text" size="20" name="truckerName" maxlength="30" ></td>
      <td>貨櫃車型號：</td>
        <td><input type="text" size="20" name="truckModelNo" maxlength="20"> </td>
    </tr>
    <tr> 
      <td>貨櫃車司機中文姓名：</td>
        <td><input type="text" size="20" name="truckerChineseName" maxlength="30" > </td>
      <td>顔色：</td>
        <td><input type="text" size="20" name="truckColor" maxlength="10"> </td>
    </tr>
    <tr> 
      <td>地址：</td>
        <td><input type="text" size="20" name="truckerAddr1" maxlength="50"> </td>
      <td>重量 (公斤)：</td>
        <td><input type="text" size="20" name="carryWeight" maxlength="20"> </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><input type="text" size="20" name="truckerAddr2" maxlength="50"></td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><input type="text" size="20" name="truckerAddr3" maxlength="50"> </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><input type="text" size="20" name="truckerAddr4" maxlength="50"> </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>内地車牌號碼：</td>
      <td><input type="text" size="20" name="inlandPlateNo" maxlength="10"> </td>
      <td>香港車牌號碼：</td>
      <td><input type="text" size="20" name="hkPlateNo" maxlength="10"> </td>
    </tr>
    <tr> 
      <td>内地電話號碼：</td>
      <td><input type="text" size="20" name="inlandTelephoneNo" maxlength="20"> </td>
      <td>香港電話號碼：</td>
      <td><input type="text" size="20" name="hkTelephoneNo" maxlength="20"> </td>
    </tr>
    <tr> 
      <td>内地手提電話號碼：</td>
      <td><input type="text" size="20" name="inlandMobileNo" maxlength="20"> </td>
      <td>香港手提電話號碼：</td>
      <td><input type="text" size="20" name="hkMobileNo" maxlength="20"> </td>
    </tr>
    <tr> 
      <td>内地傳呼機號碼：</td>
      <td><input type="text" size="20" name="inlandPagerNo" maxlength="20"> </td>
      <td>香港傳呼機號碼：</td>
      <td><input type="text" size="20" name="hkPagerNo" maxlength="20"> </td>
    </tr>
    <tr> 
      <td>内地駕駛執照號碼：</td>
        <td><input type="text" size="20" name="inlandLicenseNo" maxlength="10"> </td>
      <td>香港駕駛執照號碼：</td>
      <td><input type="text" size="20" name="hkLicenseNo" maxlength="10"> </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>備注：</td>
      <td><textarea name="remark" rows="3" cols="18" maxlength="100"></textarea></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>&nbsp; </td>
    </tr>
  </table>
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td height="30"><a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a><img src="../images/good.jpg" width="10" height="10"><a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a> 
      </td>
    </tr>
  </table>
  <p>&nbsp; </p>
</form>


<p>&nbsp;</p>
<hr>
      <table width="400" border="0" align="center">
        <tr> 
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright 
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
</body>
</html>




