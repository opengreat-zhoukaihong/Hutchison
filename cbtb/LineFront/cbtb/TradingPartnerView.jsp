<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.ejb.entity.TradingPartnerValue" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
     webOperator.clearPermissionContext(); 
     webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
     webOperator.putPermissionContext("action", "view"); //加入检查的内容
     if (!webOperator.checkPermission())
     {
        response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
     } 

     TradingPartnerValue tradingPartnerValue = dbList.findTradingPartner(request.getParameter("tradingPartnerId"));
     session.removeAttribute("tradingPartnerValue");
     session.setAttribute("tradingPartnerValue",tradingPartnerValue);
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
        
      <div align="right"><a href="TradingPartnerEdit.jsp?path=<%= request.getParameter("path") %>&rootPath=<%= request.getParameter("rootPath") %>"><font
color="#003366" face="Arial, Helvetica, sans-serif">更新</font></a> | <a href="TradingPartnerDelView.jsp?path=<%= request.getParameter("path") %>&rootPath=<%= request.getParameter("rootPath") %>"><font
color="#003366" face="Arial, Helvetica, sans-serif">刪除</font></a> | <a
href="javascript:history.back()"><font color="#003366"
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
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="29%"><font face="Arial, Helvetica, sans-serif">公司編號：</font></td>
    <td width="71%"> <%= request.getParameter("companyId") %> <img src="../images/good.jpg" width="414" height="12"></td>
  </tr>
  <tr> 
    <td width="29%">貿易夥伴編號：</td>
    <td width="71%"><%= tradingPartnerValue.tradingPartnerId %></td>
  </tr>
  <tr> 
    <td width="29%">貿易夥伴英文名稱：</td>
    <td width="71%"><%=tradingPartnerValue.tradingPartnerName%></td>
  </tr>
  <tr> 
    <td width="29%">貿易夥伴中文名稱：</td>
    <td width="71%"><%=tradingPartnerValue.tradingPartnerChineseName%></td>
  </tr>
  <tr> 
    <td width="29%">聯絡人英文姓名：</td>
    <td width="71%"><%=tradingPartnerValue.contactPerson%></td>
  </tr>
  <tr> 
    <td width="29%">聯絡人中文姓名：</td>
    <td width="71%"><%=tradingPartnerValue.contactChinesePerson%></td>
  </tr>
  <tr> 
    <td width="29%">電話號碼：</td>
    <td width="71%"><%=tradingPartnerValue.telephoneNo%></td>
  </tr>
  <tr> 
    <td width="29%">貿易夥伴地址：</td>
    <td width="71%"><%=tradingPartnerValue.tradingPartnerAddr1%></td>
  </tr>
<%
 if(tradingPartnerValue.tradingPartnerAddr2 != null){
%>
   <tr>
     <td width="29%"></td>
     <td width="71%" colspan="3"> 
      <%= tradingPartnerValue.tradingPartnerAddr2 %>
     </td>
   </tr>
<%
 }
 if(tradingPartnerValue.tradingPartnerAddr3 != null){
%>
   <tr>
      <td width="29%"></td>
      <td width="71%" colspan="3"> 
        <%= tradingPartnerValue.tradingPartnerAddr3 %>
      </td>
    </tr>
<%
 }
 if(tradingPartnerValue.tradingPartnerAddr4 != null){
%>
    <tr>
      <td width="29%"></td>
      <td width="71%" colspan="3"> 
        <%=tradingPartnerValue.tradingPartnerAddr4%>
       </td>
    </tr>
<%
 }
%>
</table>


<p>
<hr>    
<%@ include file="../include/end.jsp" %>
</BODY>
</HTML>


