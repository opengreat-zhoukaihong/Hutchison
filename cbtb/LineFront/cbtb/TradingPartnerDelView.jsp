<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.util.*" %>
<jsp:useBean id="tradingPartnerValue"  scope="session"  class="com.cbtb.ejb.entity.TradingPartnerValue" />
<%
  webOperator.clearPermissionContext(); 
  webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
  webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
  if (!webOperator.checkPermission())
  {
     response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  }

  String s_status = tradingPartnerValue.recordStatus; 
  if(s_status.equals(CbtbConstant.TRADING_PARTNER_EFFECTIVE))
      s_status="正常";
   if(s_status.equals(CbtbConstant.TRADING_PARTNER_NOT_EFFECTIVE))
     s_status="刪除";
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/ShiperHead.jsp" %>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      
      
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>貿易夥伴數據維護</b></font></font></td>
      <td width="57%"> 
        
      <div align="right"><a
href="Trading_Partner_search.htm"></a><a href="TradingPartnerDelete.jsp?tradingPartnerId=<%= tradingPartnerValue.tradingPartnerId %>&path=<%= request.getParameter("path") + "?rootPath=" + request.getParameter("rootPath") %>"><font 
color=#003366 face="Arial, Helvetica, sans-serif">確定</font></a><font color=#003366 
face="Arial, Helvetica, sans-serif" size=2> | </font><font color=#003366 
face="Arial, Helvetica, sans-serif"><a 
href="javascript:history.back();"><font color=#003366 
face="Arial, Helvetica, sans-serif">取消</font></a><font 
color=#003366 face="Arial, Helvetica, sans-serif"></font></font><font color=#003366 
face="Arial, Helvetica, sans-serif" size=2><font 
color=#003366 face="Arial, Helvetica, sans-serif" size=2> </font>| </font><a 
href="javascript:history.go(-2)"><font color=#003366 
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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
    <td><font face="Arial, Helvetica, sans-serif"><font 
color=#ff0033>刪除這條紀錄?</font></font></td>
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
<TABLE border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <TBODY> 
  <TR> 
    <TD width="31%"><FONT 
      face="Arial, Helvetica, sans-serif">公司編號：</FONT></TD>
    <TD width="69%"><%= tradingPartnerValue.companyId %> <img src="../images/good.jpg" width="417" height="12"></TD>
  </TR>
  <TR> 
    <TD width="31%">貿易夥伴編號：</TD>
    <TD width="69%"><%= tradingPartnerValue.tradingPartnerId %>&nbsp;</TD>
  </TR>
  <TR> 
  <TR> 
    <TD width="31%">貿易夥伴英文名稱：</TD>
    <TD width="69%"><%=tradingPartnerValue.tradingPartnerName%>&nbsp;</TD>
  </TR>
  <TR> 
    <TD width="31%">貿易夥伴中文名稱：</TD>
    <TD width="69%"><%=tradingPartnerValue.tradingPartnerChineseName%>&nbsp;</TD>
  </TR>
  <TR> 
    <TD width="31%">聯絡人英文姓名：</TD>
    <TD width="69%"><%=tradingPartnerValue.contactPerson%></TD>
  </TR>
  <TR> 
    <TD width="31%">聯絡人中文姓名：</TD>
    <TD width="69%"><%=tradingPartnerValue.contactChinesePerson%></TD>
  </TR>
  <TR> 
    <TD width="31%">電話號碼：</TD>
    <TD width="69%"><%=tradingPartnerValue.telephoneNo%></TD>
  </TR>
  <TR> 
    <TD width="31%">貿易夥伴地址：</TD>
    <TD width="69%"><%=tradingPartnerValue.tradingPartnerAddr1%></TD>
  </TR>
  <%
 if(tradingPartnerValue.tradingPartnerAddr2 != null){
%>
   <tr>
     <td width="50%"></td>
     <td width="50%" colspan="3"> 
      <%=tradingPartnerValue.tradingPartnerAddr2%>
     </td>
   </tr>
<%
 }
 if(tradingPartnerValue.tradingPartnerAddr3 != null){
%>
   <tr>
      <td width="50%"></td>
      <td width="50%" colspan="3"> 
        <%=tradingPartnerValue.tradingPartnerAddr3%>
      </td>
    </tr>
<%
 }
 if(tradingPartnerValue.tradingPartnerAddr4 != null){
%>
    <tr>
      <td width="50%"></td>
      <td width="50%" colspan="3"> 
        <%=tradingPartnerValue.tradingPartnerAddr4%>
       </td>
    </tr>
<%
 }
%>
  <TR> 
    <TD width="31%">狀況：</TD>
    <TD width="69%"><%=s_status%></TD>
  </TR>
  </TBODY>
</TABLE>   


<P>&nbsp;</P>
<hr>
      
<%@ include file="../include/end.jsp" %>
</BODY>
</HTML>


