﻿<html> <head> 
<title> CBTB Login</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %> <jsp:usebean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" /> 
<%
String organizationId = webOperator.getDomainID();
String userId = webOperator.getUserID();
String password = webOperator.getPassword();
%> 
<style>
.link
{
font-size: 9pt; color: #FFFFFF; text-decoration: none
}
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="28" width="30%" bgcolor="#ff6666">&nbsp;</td>
    <td height="28" width="54%" bgcolor="#ff6666"> 
      <div align="right"><img src="../images/crossborder.jpg" width="172" height="28"></div>
    </td>
    <td height="28" width="16%" bgcolor="#ff6666">&nbsp;</td>
  </tr>
  <tr> 
    <td height="33" bgcolor="#003366" width="30%"> 
      <div align="left"><font size="2"><font color="#FFFFFF">&nbsp;<a href="about.htm"><span class="link">關於我們</span></a> | <a href="Faq.htm"><span class="link">常見問題</span></a> | 
        </font><a 

href="mailto:webmaster@hutchtech.com.cn" class="link"><span class="link">聯絡我們</span></a></font></div>
    </td>
    <td height="33" bgcolor="#003366" width="54%">&nbsp;</td>
    <td height="33" bgcolor="#003366" width="16%"> 
      <div align="left"><img src="../images/Trucking.jpg" width="116" height="28"></div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="10" >
  <tr> 
    <td bgcolor="#FF6666"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="7" bgcolor="#FFFFFF">
  <tr> 
    <td></td>
  </tr>
</table>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="left">
  <tr> 
    <td  width="29%" height="100"> 
      <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td width="23%" height="21"> 
            <div align="center"></div>
          </td>
          <td width="77%" height="21"> 
           
          </td>
        </tr>        <tr> 
          <td width="23%" height="20"> 
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%" height="20"> 
            <div align="left"><a href="DeliveryMarketNoLogin.jsp" target="_parent"><font size="2" 

color="003366">貨運市集</font></a></div>
          </td>
        </tr>
        <tr> 
          <td width="23%" height="20"> 
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%" height="20"><a href="CapacityMarketNoLogin.jsp" target="_parent"><font size="2" color="003366">空車市集</font></a></td>
        </tr>
        <tr> 
          <td width="23%" height="20"> 
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%" height="20"><a 

href="ReturnToTL.jsp"><font size="2" 

color="003366">退出</font></a></td>
        </tr>
         <tr>
          <td height="36"></td>
          <td height="36"></td>
         </tr>
      </table>
    </td>
    <td rowspan="3" width="71%" valign="top"> 
      <table width="97%" border="0" cellspacing="0" cellpadding="0" bordercolor="#003366">
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
      <div id="Layer1" style="position:absolute; width:6px; height:201px; z-index:1; left: 219px; top: 
210px"><img src="../images/tiao.jpg" width="2" height="220"></div>
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
