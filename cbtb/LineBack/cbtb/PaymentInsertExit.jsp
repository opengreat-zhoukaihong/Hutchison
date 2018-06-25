<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>  
<%@ page import="java.sql.*" %>
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

  String invoiceNo=request.getParameter("invoiceNo");
  String paymentDate=request.getParameter("paymentDate");
  paymentDate=paymentDate +" 00:00:00.00000000 ";
  String paidBy=request.getParameter("paidBy");
  String ref=request.getParameter("ref");
  String payAmount=request.getParameter("payAmount");
  if (payAmount!=null)  payAmount=payAmount.trim();
  BigDecimal amount = new BigDecimal(payAmount);
  Timestamp date = Timestamp.valueOf(paymentDate);
  BillingManager bm=webOperator.getBillingManager();
%>
<%
String gopage="";
  if (bm.addInvoicePaymentHistory(invoiceNo,date,paidBy,ref,amount))
  { 
      gopage="PaymentView.jsp";
%>
<jsp:forward page="<%=gopage%>" >
   <jsp:param name="invoiceNo" value="<%=invoiceNo%>" />
<jsp:forward  />
<%
  }
   else{
      gopage="ErrorPage.jsp?errorMessage=ER_0001";
       }
%>
<jsp:forward page="<%=gopage%>" />



