<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.util.*" %>
<jsp:useBean id="tradingPartnerValue"  scope="session"  class="com.cbtb.ejb.entity.TradingPartnerValue" />
<%
    webOperator.clearPermissionContext(); 
    webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
    webOperator.putPermissionContext("action", "edit"); //加入检查的内容
    if (!webOperator.checkPermission())
    {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
    }

     tradingPartnerValue.companyId = request.getParameter("companyId");
     tradingPartnerValue.tradingPartnerId = request.getParameter("tradingPartnerId");
     tradingPartnerValue.tradingPartnerName = request.getParameter("tradingPartnerName");
     tradingPartnerValue.tradingPartnerChineseName = request.getParameter("tradingPartnerChineseName");
     tradingPartnerValue.contactPerson = request.getParameter("contactPerson");
     tradingPartnerValue.contactChinesePerson = request.getParameter("contactChinesePerson");
     tradingPartnerValue.telephoneNo = request.getParameter("telephoneNo");
     tradingPartnerValue.tradingPartnerAddr1 = request.getParameter("tradingPartnerAddr1");
     tradingPartnerValue.tradingPartnerAddr2 = request.getParameter("tradingPartnerAddr2");
     tradingPartnerValue.tradingPartnerAddr3 = request.getParameter("tradingPartnerAddr3");
     tradingPartnerValue.tradingPartnerAddr4 = request.getParameter("tradingPartnerAddr4");
     String strBack = "";
     if(request.getParameter("action").equals("Insert"))
         strBack = "javascript:history.go(-2)";
     else
          strBack = "javascript:history.go(-3)";
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/head.jsp"%>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      
      
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2">貿易夥伴數據維護</font></td>
      <td width="57%"> 
      <div align="right"><a href="TradingPartnerInsert.jsp?action=<%=request.getParameter("action")%>&path=<%= request.getParameter("path")  %>"><font
color="#003366" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><font color="#003366"
face="Arial, Helvetica, sans-serif"><a href="javascript:history.back();"><font
color="#003366" face="Arial, Helvetica, sans-serif">取消</font></a></font><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font>| </font><a
href="<%= strBack %>"><font color="#003366"
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
<br>
<br>
<br>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
  <tr> 
    <td width="20%"><font face="Arial, Helvetica, sans-serif">公司編號：</font></td>
    <td width="30%"> <%= tradingPartnerValue.companyId %>&nbsp; </td>
    <td width="20%">貿易夥伴編號：</td>
    <td width="30%"><%= tradingPartnerValue.tradingPartnerId %>&nbsp; </td>
  </tr>
  <tr>
    <td width="20%">貿易夥伴英文名稱：</td>
    <td width="30%"><%=tradingPartnerValue.tradingPartnerName%>&nbsp;</td>
    <td width="20%">貿易夥伴中文名稱：</td>
    <td width="30%"><%=tradingPartnerValue.tradingPartnerChineseName%>&nbsp;</td>
  </tr>
  <tr> 
    <td width="20%">聯絡人英文姓名：</td>
    <td width="30%"><%=tradingPartnerValue.contactPerson%></td>
    <td width="02%">聯絡人中文姓名：</td>
    <td width="30%"><%=tradingPartnerValue.contactChinesePerson%>&nbsp;</td>
  </tr>  
  <tr> 
    <td width="20%">貿易夥伴地址：</td>
    <td width="30%"><%=tradingPartnerValue.tradingPartnerAddr1%>&nbsp;</td>
    <td width="20%">電話號碼：</td>
    <td width="30%"><%=tradingPartnerValue.telephoneNo%>&nbsp;</td>
  </tr>
<%
 if(tradingPartnerValue.tradingPartnerAddr2 != null){
%>
   <tr>
     <td width="20%"></td>
     <td width="30%" > 
      <%=tradingPartnerValue.tradingPartnerAddr2%>
     </td>
     <td width="20%"></td>
     <td width="30%"></td> 
   </tr>
<%
 }
 if(tradingPartnerValue.tradingPartnerAddr3 != null){
%>
   <tr>
      <td width="20%"></td>
      <td width="30%" > 
        <%=tradingPartnerValue.tradingPartnerAddr3%>
      </td>
      <td width="20%"></td>
      <td width="30%"></td>
    </tr>
<%
 }
 if(tradingPartnerValue.tradingPartnerAddr4 != null){
%>
    <tr>
      <td width="20%"></td>
      <td width="80%" colspan="3"> 
        <%=tradingPartnerValue.tradingPartnerAddr4%>
       </td>
    </tr>
<%
 }
%>

</table>  

<p>&nbsp;
<hr>
      
</body>
</html>


