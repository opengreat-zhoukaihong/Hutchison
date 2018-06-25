<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%
String organizationId = webOperator.getDomainID();
String userId = webOperator.getUserID();
String password = webOperator.getPassword();
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ff6666">
  <tr> 
    <td height="28" width="30%">&nbsp;</td>
    <td height="28" width="54%"> 
      <div align="right"><img src="../images/crossborder.jpg" width="172" height="28"></div>
    </td>
    <td height="28" width="16%">&nbsp;</td>
  </tr>
  <tr> 
    <td height="33" bgcolor="#003366" width="30%">  
      <div align="left"><font size="2"><font color="#FFFFFF">&nbsp;<a href="about.htm"><span class="link">關於我們</span></a> 
        | <a href="Faq.htm"><span class="link">常見問題</span></a> | </font><a href="mailto:webmaster@hutchtech.com.cn" class="link"><span class="link">聯絡我們</span></a></font></div>
    </td>
    <td height="33" bgcolor="#003366" width="54%">&nbsp;</td>
    <td height="33" bgcolor="#003366" width="16%"> 
      <div align="left"><img src="../images/Trucking.jpg" width="116" height="28"></div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td bgcolor="#FF6666" height="20"></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width="100%">
  <tr bgcolor=#003366>
    <td><img height=120 src="../images/photo.gif"
width=740></td>
  </tr>
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
            <div align="left"><a href="DeliveryRequestSearchForCompanyId.jsp" target="_parent"><font size="2" color="003366">貨運登記</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%"><a href="DeliveryRequestSearch.jsp" target="_parent"><font size="2" color="003366">貨運追蹤/修改</font></a></td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="TradingPartnerList.jsp" target="_parent"><font size="2" color="003366">貿易夥伴</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="ShipperPriceSearch.jsp" target="_parent"><font size="2" color="003366">運費查詢</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%"><a href="ShipperCapacityMarket.jsp" target="_parent"><font size="2" color="003366">空車市集</font></a></td>
        </tr>
        <tr>
          <td width="23%">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%">
            <div align="left"><a href="ShipperDeliveryMarket.jsp" target="_parent"><font size="2" color="003366">貨運市集</font></a></div>
          </td>
        </tr>
        <tr>
          <td width="23%" height="22">
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%" height="22"><font size="2" color="003366">培訓資料</font></td>
        </tr>
<tr> 
          <td width="23%" height="22"> 
            <div align="center"><img src="../images/dot.jpg" width="9" height="15"></div>
          </td>
          <td width="77%" height="22"><a 

href="ReturnToTL.jsp"><font size="2" 

color="003366">退出</font></a></td>
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
    <td height="18" width="29%">     <div id="Layer1" style="position:absolute; width:6px; height:201px; z-index:1; left: 211px; top: 223px"><img src="../images/tiao.jpg" width="2" height="220"></div>
    
    </td>
    <td height="18" width="71%">
      <div align="left"></div>
      <%@ include file = "../include/end.jsp" %>
    </td>
  </tr>
</table>
</body>
</html>
