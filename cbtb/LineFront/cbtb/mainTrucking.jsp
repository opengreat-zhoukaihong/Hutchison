﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />

<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title></title>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table border=0 cellpadding=0 cellspacing=0 width="100%">
  <tbody>
  <tr>
    <td height=10><img height=9 src="../images/photo_spacer.gif"
  width=9></td>
  </tr>
  <tr bgcolor=#003366>
    <td><img height=120 src="../images/photo.gif"
width=740></td>
  </tr>
  </tbody>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="398" align="left">
  <tr>
    <td height="236" width="29%">
      <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" height="218">
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="CapacityList.jsp" target="_parent"><font size="2" color="003366">空車登記</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%"><a href="CapacitySearch.jsp" target="_parent"><font size="2" color="003366">貨運追蹤/修改</font></a></td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="TruckerList.jsp" target="_parent"><font size="2" color="003366">建立/更改司機</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%"><a href="TruckRegistrationEdit.jsp" target="_parent"><font size="2" color="003366">修改註冊資料</font></a></td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="TruckPriceSearch.jsp" target="_parent"><font size="2" color="003366">運費查詢</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%"><a href="TruckCapacityMarket.jsp" target="_parent"><font size="2" color="003366">空車市集</font></a></td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="TruckDeliveryMarket.jsp" target="_parent"><font size="2" color="003366">貨運市集</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%"><a href="#" target="_parent"><font size="2" color="003366">建立/修改用戶</font></a></td>
        </tr>
        <tr>
          <td width="23%" height="22">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%" height="22"><font size="2" color="003366">培訓資料</font></td>
        </tr>
      </table>
    </td>
    <td height="332" rowspan="3" width="71%">
      <table width="97%" border="0" cellspacing="0" cellpadding="0" height="353" bordercolor="#003366">
        <tr>
          <td height="19"><img src="../images/good.jpg" width="40" height="27"></td>
          <td height="19"><img src="../images/welcome.jpg" width="162" height="19"></td>
        </tr>
        <tr>
          <td width="20" height="41"><img src="../images/good.jpg" width="40" height="10"></td>
          <td width="90%" height="41"><font color="#003366"><b>Transact Link</b>
            has been developed to enable Hong Kong businesses to reach existing
            and potential new customers around the world.</font></td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="52" width="29%"><img src="../images/line_logo.gif" width="193" height="32"></td>
  </tr>
  <tr>
    <td height="44" width="29%">
      <div align="left"><img src="../images/php.jpg" width="193" height="27"></div>
    </td>
  </tr>
  <tr>
    <td height="18" width="29%">
      <div id="Layer1" style="position:absolute; width:6px; height:201px; z-index:1; left: 209px; top: 147px"><img src="../images/tiao.jpg" width="2" height="220"></div>
    </td>
    <td height="18" width="71%">
      <div align="left"></div>
      <table width="331" border="0" align="center">
        <tr>
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>