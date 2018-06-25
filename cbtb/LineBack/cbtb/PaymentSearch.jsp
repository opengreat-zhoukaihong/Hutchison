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
<jsp:useBean id="pagYwl" scope="session" class="com.cbtb.util.NewPagination" />

<jsp:useBean id="iphm" scope="page" class="com.cbtb.model.InvoicePaymentHistoryModel" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","BILLING"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>
<head>                        
<title>Untitled Document</title>

<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/DateValidLt.js></script>
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<SCRIPT LANGUAGE=javascript>
function doPost()
{
	
if (search.creationDate.value!="") {
if(!isDate(search.creationDate.value))
       {
         alert("請輸入正確的日期類型！");
         return;
       } 

}
   search.submit();
}
</SCRIPT>

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
    <td height="11"><font face="Arial, Helvetica, sans-serif">付款</font> </td>
    <td height="11"> 
      <div align="right"><a href="billing.htm"><font color="#003366">退出</font></a></div>
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

<%
String init = request.getParameter("init");
%>
<form action="PaymentSearch.jsp" name="search" >
<table border="0" width="90%">
<input type="hidden" name="init" value="search"> 
    <tr>
        <td>付款人編號： </td>
        <td>發票編號：</td>
        <td>發票日期：</td>
        <td>狀況：</td>
        <td>排序：</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><input type="text" size="10" name="shipperNo"></td>
        <td><input type="text" size="10" name="invoiceNo"></td>
    <td > 
      <input type="text" maxlength="10" size="10"  name="creationDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(creationDate);return false" > 
     </td>
        <td><select name="invoiceStatus" size="1">
            <option value="">任意</option>
            <option value="<%=CbtbConstant.INVOICE_STATUS_CANCELD%>">已取消</option>
            <option value="<%=CbtbConstant.INVOICE_STATUS_CREATE%>">創建</option>

            <option value="<%=CbtbConstant.INVOICE_STATUS_PRINTED%>">打印</option>
            <option value="<%=CbtbConstant.INVOICE_STATUS_PARTIALPAID%>">部分付款</option>
            <option value="<%=CbtbConstant.INVOICE_STATUS_FULLPAID%>">付清</option>
        </select></td>
        <td><select name="orderByName" size="1">
            <option value="Creation_Date">創建日期</option>
            <option value="Invoice_Status">發票狀態</option>
            <option value="Invoice_No">發票編號</option>
        </select></td>
        <td><input type="button" name="Submit" value="查詢" onClick="javascript:doPost()"></td>
        <td><input type="reset" name="Submit2" value="重設"></td>
    </tr>
</table>

<hr>
<%


if (init!=null)
{ 
 
String shipperNo = request.getParameter("shipperNo");
String invoiceNo = request.getParameter("invoiceNo");
String creationDate = request.getParameter("creationDate");
String invoiceStatus = request.getParameter("invoiceStatus");
String orderByName = request.getParameter("orderByName");

BillingManager bm = webOperator.getBillingManager();
ArrayList invoiceList=new ArrayList();
String type=  request.getParameter("type");
           if (type == null  )
              {
               pagYwl.setPageNo(0);
               pagYwl.setRecords(bm.searchInvoiceData(shipperNo,invoiceNo,creationDate,invoiceStatus,orderByName)); 
               invoiceList=new ArrayList(pagYwl.nextPage());
   }
           else
              {
               if (type.equals("N"))
                   {
                    invoiceList = new ArrayList(pagYwl.nextPage());
                   }
               else if (type.equals("P"))
                   {
                    invoiceList = new ArrayList(pagYwl.previousPage());
                   }
               else if (type.equals("F"))
                   {
                   invoiceList =new ArrayList(pagYwl.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    invoiceList =new ArrayList(pagYwl.endPage());
                   }

               }

%>
<table border="1" width="100%">
<input type="hidden" name="init" value="search"> 
  <tr> 
    <td width="11%">發票編號</td>
    <td width="13%">付款人編號</td>
    <td width="15%">總金額(港幣)</td>
    <td width="18%">付款方式</td>
    <td width="17%">未結/未付金額（港幣）</td>
    <td width="19%">狀況</td>
    
  </tr>
<%


     for (int i = 0;  (!invoiceList.isEmpty()) && i < invoiceList.size(); i++) {
        idm = (InvoiceDataModel)invoiceList.get(i);
     
%>

  <tr> 
    <td width="11%"><a href="PaymentView.jsp?invoiceNo=<%=idm.getInvoiceNo()%>&invoiceStatus=<%=idm.getInvoiceStatus()%>&creationDate=<%=idm.getCreationDate()%>&shipperNo=<%=idm.getShipperNo()%>&shipperName=<%=idm.getShipperName()%>&totalPrice=<%=idm.getTotalPrice()%>& paidAmount=<%=idm.getPaidAmount()%>"><%=idm.getInvoiceNo()%></td>
    <td width="13%"><%=idm.getShipperNo()%></td>
    <td width="15%"><%=idm.getTotalPrice()%></td>
    <td width="18%">
<%
String statusa=" " ;
statusa=idm.getPaymentTerms();
if (statusa!=null)
{
if (statusa.equals(CbtbConstant.COMPANY_PAYMENT_TERMS_CASH))
{ statusa="現金" ; }
if (statusa.equals(CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT))
{ statusa="信用" ; }}
else statusa=" ";
%>
<%=statusa%></td>
    <td width="17%"><%=idm.getOutstandingAmount()%></td>
    <td width="19%">
<%
String status ;
status=idm.getInvoiceStatus();
if (CbtbConstant.INVOICE_STATUS_CANCELD.equals(status))
{ status="已取消" ; }
if (CbtbConstant.INVOICE_STATUS_CREATE.equals(status))
{ status="創建" ; }

if (CbtbConstant.INVOICE_STATUS_PRINTED.equals(status))
{ status="打印" ; }
if (CbtbConstant.INVOICE_STATUS_PARTIALPAID.equals(status))
{ status="部分付款" ; }
if (CbtbConstant.INVOICE_STATUS_FULLPAID.equals(status))
{ status="付清" ; }
%>
<%=status%></td>

  </tr>

<%
}
%>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">

    <tr> 
      <td width="85%" class="unnamed1">
          <%
          if (pagYwl.getPageNo() > 1)
          {
            %>
   <a href="PaymentSearch.jsp?type=F&init=p">第一頁</a> 
   <a href="PaymentSearch.jsp?type=P&init=p">上一頁</a> 
          <%
          }
          if (pagYwl.getPageNo() < pagYwl.getPageSum())
          {
            %>
   <a href="PaymentSearch.jsp?type=N&init=p">下一頁</a> 
   <a href="PaymentSearch.jsp?type=E&init=p">最後一頁</a> 
          <%
          }
          %>
      <td width="80" class="unnamed1"> 
        <div align="right">第<%=pagYwl.getPageNo()%>頁&nbsp; 總數：<%=pagYwl.getPageSum()%>頁</div>
      </td>
    </tr>
  </table>

<%}%>
</form>

<p>&nbsp;</p>
</body>

</html>








