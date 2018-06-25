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
<%@ include file="Init.jsp"%>
<%
//webOperator.clearPermissionContext();  //清除以前检查的内容
//webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
//webOperator.putPermissionContext("action", "edit"); //加入检查的内容
//if (webOperator.checkPermission())
//  out.print("You have Edit TRUCKER Context");
//else
//  out.print("You can't Edit TRUCKER Context");
%>

<script language="javascript">
function doPost()
{
  form.action = "TruckerInfoEditConfirm.jsp";
  form.submit();
}
</script>
</head>
<%
  tdm = (TruckerDataModel)session.getAttribute("truckerDataModel");
  session.setAttribute("truckerDataModel",tdm);
%>
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
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨櫃車信息<font face="Arial, Helvetica, sans-serif" size="2" color="#667852"><b><b></b></b></font></font></b></font></b></font></td>
    <td>
      <div align="right"><a href="TruckerInfoEditConfirm.jsp"><font
color="#003366" face="Arial, Helvetica, sans-serif">更新</font></a>| <a href="indexTrucking.jsp"><font
color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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
      <div align="right">創建日期： 2001/01/01</div>
    </td>
  </tr>
</table>
<form name="form" action="">
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td>運輸公司名稱：</td>
      <td><%=dbList.getCompanyName(tdm.getCompanyId(),"EN")%></td>
      <td>香港身份證號碼 / 護照號碼：</td>
      <td><%=tdm.getHkId()%></td>
    </tr>
    <tr>
      <td>貨櫃車編號：</td>
      <td><%=tdm.getTruckerId()%></td>
      <td>貨櫃車型號：</td>
       <td><%=tdm.getTruckModelNo()%></td>
    </tr>
    <tr>
      <td>貨櫃車司機英文姓名：</td>
       <td><%=tdm.getTruckerName()%></td>
      <td>顔色：</td>
       <td><%=tdm.getTruckColor()%></td>
    </tr>
    <tr>
      <td>貨櫃車司機中文姓名：</td>
       <td><%=tdm.getTruckerChineseName()%></td>
      <td>重量： (公斤)</td>
       <td><%=tdm.getCarryWeight()%></td>
    </tr>
    <tr>
      <td>地址：</td>
       <td><%=tdm.getTruckerAddr1()%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
       <td><%=tdm.getTruckerAddr2()%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
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
      <td>
        <input type="text" size="20" maxlength="20" name="inlandTelephoneNo" value="<%=tdm.getInlandTelephoneNo()%>">
      </td>
      <td>香港電話號碼：</td>
      <td>
        <input type="text" size="20" maxlength="20" name="hkTelephoneNo" value="<%=tdm.getHkTelephoneNo()%>">
      </td>
    </tr>
    <tr>
      <td>内地手提電話號碼：</td>
      <td>
        <input type="text" size="20" maxlength="20" name="inlandMobileNo" value="<%=tdm.getInlandMobileNo()%>">
      </td>
      <td>香港手提電話號碼：</td>
      <td>
        <input type="text" size="20" maxlength="20" name="hkMobileNo" value="<%=tdm.getHkMobileNo()%>">
      </td>
    </tr>
    <tr>
      <td>内地傳呼機號碼：</td>
      <td>
        <input type="text" size="20" maxlength="20" name="inlandPagerNo" value="<%=tdm.getInlandPagerNo()%>">
      </td>
      <td>香港傳呼機號碼：</td>
      <td>
        <input type="text" size="20" maxlength="20" name="hkPagerNo" value="<%=tdm.getHkPagerNo()%>">
      </td>
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
    <tr>
      <td>狀況：</td>
      <td>
        <select name="truckerStatus">
        <%=dbList.getTruckCapacityStatusList(tdm.getTruckStatus(),"EN")%>
        </select>
      </td>
      <td>備注：</td>
      <td><%=tdm.getRemark()%></td>
    </tr>
  </table>
    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td height="40"> <a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a><img src="../images/good.jpg" width="10" height="10"><a href="javascript:form.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
      </td>
    </tr>
  </table>
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
<div align="right"></div>
</body>
</html>






