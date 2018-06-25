<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="idm" scope="page" class="com.cbtb.model.InvoiceDataModel" />
<jsp:useBean id="iphm" scope="page" class="com.cbtb.model.InvoicePaymentHistoryModel" />



<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","BILLING"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
String invoiceNo = request.getParameter("invoiceNo");
%>
<html>
<head>
<title>Untitled Document</title>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/DateValidLt.js></script>
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<link rel="stylesheet" href="../css/line.css" type="text/css">

<script language="JavaScript">

function confirm_invoice(i)

{ 

if(!isFloat(invoice.payAmount.value))
       {
         alert("請輸入正確的數據類型！");
         return;
       } 
   if (invoice.paymentDate.value=="")
   {
         alert("付款日期不能為空!");
         return;
   } 
if(!isDate(invoice.paymentDate.value))
       {
         alert("請輸入正確的日期類型！");
         return;
       } 
  if (invoice.payAmount.value=="")
   {
         alert("付款金額不能為空!");
         return;
   } 
   if (invoice.ref.value=="")
   {
         alert("參考編號不能為空!");
         return;
   } 
  else{
   if(i==1)
   {
      invoice.action="PaymentInsert.jsp";   
      invoice.submit();
   } 
     else
   {   
      invoice.action="PaymentInsertExit.jsp";   
      invoice.submit();   
   }
     }
}
</script>
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
    <td height="11">付款</td>
    <td height="11"> 
      <div align="right"><a href="billing.htm"></a></div>
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
<form name="invoice" action=""  method="post">
<table border="0">
<input type="hidden" name="invoiceNo" value="<%=invoiceNo%>">
    <tr>
        <td>發票編號：</td>
        <td><%=invoiceNo%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>付款日期：</td>
        <td>
      <input type="text" size="20" name="paymentDate" value="<%=UtilTool.getCurrentDateTime().substring(0,10)%>">
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(paymentDate);return false" > 
    </td>
        <td>付款金額(港幣)：</td>
        <td><input type="text" size="20" name="payAmount" maxlength="9"></td>
    </tr>
    <tr>
        <td>付款方式：</td>
        <td><select  size="1" name="paidBy">
            <option value="<%=CbtbConstant.COMPANY_PAYMENT_TERMS_CASH%>" selected>現金</option>
            <option value="<%=CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT%>">信用</option>
        </select></td>
        <td> 參考編號：</td>
        <td><input type="text" size="20" name="ref" maxlength="20"></td>        
    </tr>

    <tr>
        <td><input type="submit" name="B1"
        value="保存&增加" onclick="javasrcipt:confirm_invoice(1)"></td>
        <td><input type="submit" name="B1"
        value="保存&退出"  onclick="javasrcipt:confirm_invoice(2)" ></td>
        <td><input type="reset" name="B1" value="取消"></td>
</form>
        <td>&nbsp;</td>
    </tr>

</table>

<p align="right">&nbsp;</p>

<p>&nbsp;</p>
</body>

</html>








