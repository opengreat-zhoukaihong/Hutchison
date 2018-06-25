<%@ include file="Init.jsp"%>         
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="ejbUtil" scope="page" class="com.cbtb.util.EjbUtil" />
<jsp:useBean id="idm" scope="page" class="com.cbtb.model.InvoiceDataModel" />
<jsp:useBean id="iphm" scope="page" class="com.cbtb.model.InvoicePaymentHistoryModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","BILLING"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<script language="JavaScript">

function confirm_invoice()

{
  
   if (invoice.status.value=="<%=CbtbConstant.INVOICE_STATUS_PRINTED%>" || invoice.status.value=="<%=CbtbConstant.INVOICE_STATUS_PARTIALPAID%>" )
   {
       invoice.submit();     
   }   
      else{
           alert("请檢查發票狀態!");
          }     
 }

</script>

<html>
<head>
<title>Untitled Document</title>

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
    <td height="11"><font face="Arial, Helvetica, sans-serif">付款</font>歷史</td>
    <td height="11"> 
      <div align="right"><a href=javascript:confirm_invoice()><font color="#003366">付款</font></a><font
color="#003366"> | </font><a href="PaymentSearch.jsp"><font
color="#003366">關閉</font></a><a href="billing.jsp"></a></div>
    </td>
  </tr>
</table>
<form name="invoice" action="PaymentAdd.jsp">
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


<%


String invoiceNo = request.getParameter("invoiceNo");


BillingManager bm=webOperator.getBillingManager();
//ArrayList al=(ArrayList)bm.searchInvoiceData(null,invoiceNo,null,null,null); 
//if (!al.isEmpty())

//idm=(InvoiceDataModel)al.get(0);
idm = bm.findInvoiceDataModel(invoiceNo);
//else idm=new InvoiceDataModel(); 
String invoiceStatus = idm.getInvoiceStatus();  
%>


<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td width="40%" height="30">發票編號： <%=invoiceNo%></td>
    <td width="39%">發票日期： <%=idm.getCreationDate()%></td>
    <td width="21%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="40%" height="30">付貨人公司： <%=dbList.getCompanyName(idm.getShipperNo(),"CH")%></td>
    <td width="39%">公司編號： <%=idm.getShipperNo()%></td>
    <td width="21%" rowspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td width="40%" height="30">發票金額(港幣）： <%=idm.getTotalPrice()%></td>
    <td width="39%">已付金額：<%=idm.getPaidAmount()%></td>
  </tr>
  <tr> 
    <td width="40%" height="30">聯絡人： <%=idm.getContactChinesePerson()%></td>
    <td width="39%"></td>
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
<table border="1">
    <tr>
        <td>付款日期</td>
        <td>付款總額（港幣）</td>
        <td> 付款方式</td>
        <td>參考編號</td> 
        <td>未結/未付金額(港幣）</td>
    </tr>

<%

ArrayList invoiceList = (ArrayList) bm.searchInvoicePaymentHistory(invoiceNo); 

     for (int i = 0;  (!invoiceList.isEmpty()) && i < invoiceList.size(); i++) {
        iphm = (InvoicePaymentHistoryModel)invoiceList.get(i);
%>

    <tr>
        <td><%=iphm.getPaymentDate().toString().substring(0,10)%>&nbsp;</td>
        <td><%=iphm.getPayAmount()%>&nbsp;</td>
        <%
String status ="";
status=iphm.getPaidBy();
if (CbtbConstant.COMPANY_PAYMENT_TERMS_CASH.equals(status))
{ status="現金" ; }
if (CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT.equals(status))
{ status="信用" ; }
%>
<td><%=status%>&nbsp;</td>
        <td><%=iphm.getRef()%>&nbsp;</td>

        <td><%=iphm.getOutstandingAmount()%>&nbsp;</td>
    </tr>
<%
}
%>
</table>

<input type="hidden" name="status" value="<%=invoiceStatus%>"> 
<input type="hidden" name="invoiceNo" value="<%=invoiceNo%>"> 
</form>

<p>&nbsp;</p>
<p>&nbsp;</p>

</body>

</html>








