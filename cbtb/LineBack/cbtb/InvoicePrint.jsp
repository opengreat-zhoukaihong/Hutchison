<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","BILLING"); 
webOperator.putPermissionContext("action", "print"); 
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="InvoicePrintPagination" scope="session" class="com.cbtb.util.Pagination" />
<%
  String shipperNo        = request.getParameter("shipperNo");
  String invoiceNo        = request.getParameter("invoiceNo");
  String creationFromDate = request.getParameter("creationFromDate");
  String creationToDate   = request.getParameter("creationToDate");
  String invoiceStatus    = request.getParameter("invoiceStatus");
  
  String type       	  = request.getParameter("type");
  
  //if invoiceStatus not select,then select any
  if(invoiceStatus == null)
    invoiceStatus = "Any";
%>
<script language=javascript src="../js/funStrTrim.js"></script>
<script language=javascript src="../js/DateValid_big5.js"></script>
<script Language="JavaScript" src="../js/calendarShow.js"></script>

<script language ="javascript">
function query()
{
 if(!validate()) return false;
 fmQuery.action = "InvoicePrint.jsp?type=search";
 fmQuery.submit();
}
function validate()
{ 
  errFound = false;
  with(document.fmQuery){

  if(!errFound && Trim(creationFromDate.value).length >0 && !checkDateWithOneElem(creationFromDate))
     errFound = true;
  if(!errFound && Trim(creationToDate.value).length>0  && !checkDateWithOneElem(creationToDate))
      errFound=true;
  if( !errFound && Trim(creationFromDate.value).length >0 && Trim(creationToDate.value).length>0
      && compareDate(Trim(creationFromDate.value),Trim(creationToDate.value))<0)
   {
      errFound = true;
      alert("發票開始日期不能大於發票最後日期")
    }
  }
  return !errFound;
}

function Error(elem,ErrStr)
{
  if(errFound) return;
  window.alert(ErrStr);
  elem.select();
  errFound=true;
}
function docLoad()
{
  with(document.fmQuery)
  {
    shipperNo.value        = "<%=shipperNo%>";
    invoiceNo.value 	   = "<%=invoiceNo%>";
    creationFromDate.value = "<%=creationFromDate%>";
    creationToDate.value   = "<%=creationToDate%>";
    invoiceStatus.value    = "<%=invoiceStatus%>";
  }
  
}
function openpage(url)
{
  var 
newwin=window.open(url,"NewWin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes");
  return false; 
}
function doPrint()
{
   document.invoicePrint.submit();
}

</script>
<html>
<head>
<title>--LINE--〖打印發票〗</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>


<body bgcolor="#FFFFFF" text="#000000" onload="javascript:docLoad()">
<%@ include file="../include/head.jsp"%>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="11">
     <div align="right">
      <font face="Arial, Helvetica, sans-serif">
	<a href="javascript:doPrint();">打印發票 </a> |
      </font>
     <a href="Billing.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>

<form name="fmQuery" method="post" action = "InvoicePrint.jsp">
<table border="0" width="100%">
    <tr>
        <td>付貨人公司編號：</td>
        <td>發票編號：</td>
        <td>發票開始日期：</td>
        <td>發票最后日期：</td>
        <td>狀況：</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>

    <tr>
        <td><input type="text" size="12" name="shipperNo" value=""></td>
        <td><input type="text" size="12" name="invoiceNo" value= ""></td>
    <td >
      <input type="text" maxlength="10" size="10" value="" name="creationFromDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(creationFromDate);return false" >
     </td>
    <td >
      <input type="text" maxlength="10" size="10" value="" name="creationToDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(creationToDate);return false" >
     </td>
        <td><select name="invoiceStatus" size="1">
        <%=dbList.getInvoiceStatusList("Any","BIG5",true)%>
        </select></td>
        <td><input type="submit" name="Submit1" value="查詢" onclick="javascript:return query();"></td>
        <td><input type="reset" name="Submit2" value="重设"></td>
    </tr>

</table>
</form>

<hr>

<% 
   Vector vctInvoiceDataModel = null;
   if(type != null && type.equals("search"))
   {
	
       BillingManager bm = webOperator.getBillingManager();
       Vector vctInvoiceStatus = null;
       if(invoiceStatus != null)
	{
         if(invoiceStatus.trim().length()>0 && !invoiceStatus.trim().equalsIgnoreCase("Any"))
	  {
           vctInvoiceStatus = new Vector();
           vctInvoiceStatus.addElement(invoiceStatus);
          }
	}     
        Collection colInvoiceDataModel = bm.searchInvoiceSimple(shipperNo,invoiceNo,creationFromDate,creationToDate,vctInvoiceStatus);

	
	if(colInvoiceDataModel != null)
	{
	  InvoicePrintPagination.setRecords(colInvoiceDataModel);
	  InvoicePrintPagination.setPageNo(0);
	  vctInvoiceDataModel = new Vector(InvoicePrintPagination.nextPage());
	}
    }
    else
    {
      if(type != null && type.equals("N"))
      {
        vctInvoiceDataModel = new Vector(InvoicePrintPagination.nextPage());
      }
      else if( type != null && type.equals("P"))
      {
	vctInvoiceDataModel = new Vector(InvoicePrintPagination.previousPage());
      }
    }
%>
<% if(type !=null)
   {%>
<form name="invoicePrint" method="post" action = "/servlets/com.cbtb.report.InvoicePrint" target=_blank>
<table border="1" width="100%">
  <tr> 
    <td width="6%">&nbsp;</td>
    <td width="12%">發票編號</td>
    <td width="19%">交貨人公司名稱</td>
    <td width="14%">發票日期</td>
    <td width="18%">總金額(港幣）</td>
    <td width="12%">聯係人</td>
    <td width="11%">狀況</td>
    <td width="8%">發票種類</td>
  </tr>
  <%        
	InvoiceDataModel idm = null;
	for(int i=0;(vctInvoiceDataModel != null)&&(!vctInvoiceDataModel.isEmpty()) && i < vctInvoiceDataModel.size(); i++)
        {
	  idm = (InvoiceDataModel) vctInvoiceDataModel.elementAt(i);
	  String paymentTerms = idm.getPaymentTerms();
	  String thisStatus = idm.getInvoiceStatus();
  %>
  <tr> 
    <td width="6%"> 
      <input type="checkbox" name="chkInvoiceNo" value ="<%=idm.getInvoiceNo()%>" >
    </td>
    <td width="12%"><a href = "/servlets/com.cbtb.report.Invoice?invoiceNo=<%=idm.getInvoiceNo()%>" onClick='return openpage(this.href);' target=_blank><%=idm.getInvoiceNo()%></a></td>
    <td width="19%"><%=idm.getShipperChineseName()%></td>
    <td width="14%"><%=UtilTool.getStrFromTimestamp(idm.getCreationDate(),"yyyy-MM-dd")%></td>
    <td width="18%"><%=idm.getTotalPrice()%></td>
    <td width="12%"><%=idm.getContactChinesePerson()%></td>
    <td width="11%"><%=dbList.getInvoiceStatusDesc(thisStatus,"BIG5")%></td>
    <td width="8%"><% if(paymentTerms.equalsIgnoreCase(CbtbConstant.COMPANY_PAYMENT_TERMS_CASH)) out.print("現金");
		   else if(paymentTerms.equalsIgnoreCase(CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT)) out.print("信用");
                   else out.print("");%></td>
  </tr>
 <%}%>
</table>
</form>
<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
  <tr> 
    <td width="28%" class="unnamed1"> 
      <div align="left">
        <% if (InvoicePrintPagination.getPageNo() > 1)
          {
            %>
  String shipperNo        = request.getParameter("shipperNo");
  String invoiceNo        = request.getParameter("invoiceNo");
  String creationFromDate = request.getParameter("creationFromDate");
  String creationToDate   = request.getParameter("creationToDate");
  String invoiceStatus    = request.getParameter("invoiceStatus");
          <a href="InvoicePrint.jsp?type=P&shipperNo=<%=shipperNo%>&invoiceNo=<%=invoiceNo%>&creationFromDate=<%=creationFromDate%>
                                    &creationToDate=<%=creationToDate%>&invoiceStatus=<%=invoiceStatus%>">前一页</a>
            <%
          }
          if (InvoicePrintPagination.getPageNo() < InvoicePrintPagination.getPageSum())
          {
            %>
            <a href="InvoicePrint.jsp?type=N&shipperNo=<%=shipperNo%>&invoiceNo=<%=invoiceNo%>&creationFromDate=<%=creationFromDate%>
                                    &creationToDate=<%=creationToDate%>&invoiceStatus=<%=invoiceStatus%>">后一页</a>
            <%
          }
          %>          </div>
    <td width="55%" class="unnamed1">&nbsp; 
    <td width="17%" class="unnamed1"> 
      <div align="right"><font color="#003366">第<%=InvoicePrintPagination.getPageNo()%>页 &nbsp;
      总数：<%=InvoicePrintPagination.getPageSum()%>页</font></div>
    </td>
  </tr>
</table>
<%}//end if%>

<p>&nbsp;</p>
</body>

</html>









