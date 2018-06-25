<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="InvoiceGenerateListPagination" scope="session" class="com.cbtb.util.Pagination"/>
<html>
<head>
<title>--LINE--〖發票列表〗</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<script language="javascript">
function openpage(url)
{
  var 
newwin=window.open(url,"NewWin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes");
  return false; 
}
</script>
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
    <td height="11">發票列表</td>
    <td height="11"> 
      <div align="right"><a href="Billing.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<%
  Vector vctInvoiceDataModel = null;
  String type = request.getParameter("type");
  if(type == null)
  {
  	
        Collection colInvoiceDataModel = (Collection)session.getAttribute("InvoiceList");
        session.removeAttribute("InvoiceList");
  	BillingManager bm = webOperator.getBillingManager();
  	
  	if(colInvoiceDataModel != null)
  	{
	 InvoiceGenerateListPagination.setRecords(colInvoiceDataModel);
	 InvoiceGenerateListPagination.setPageNo(0);
	 vctInvoiceDataModel = new Vector(InvoiceGenerateListPagination.nextPage());
  	}
  }
  else 
  {
	if(type != null && type.equals("N"))
        {
         vctInvoiceDataModel = new Vector(InvoiceGenerateListPagination.nextPage());
         }
        else if( type != null && type.equals("P"))
        {
	 vctInvoiceDataModel = new Vector(InvoiceGenerateListPagination.previousPage());
        }
  }%>
<table border="1" width="80%">
  <tr> 
    <td width="15%">發票編號</td>
    <td width="7%">創建日期</td>
    <td width="20%">付貨人公司編號</td>
    <td width="25%">付貨人公司名稱</td>
    <td width="15%">總金額 (港幣)</td>
  </tr>
  <%
   InvoiceDataModel idm = null;
   for (int i = 0;  (vctInvoiceDataModel != null)&&(!(vctInvoiceDataModel.isEmpty())) && i < vctInvoiceDataModel.size(); i++)
   {
     idm = (InvoiceDataModel)vctInvoiceDataModel.elementAt(i);
  %>
  <tr>
    <td width="15%"><a href = "/servlets/com.cbtb.report.Invoice?invoiceNo=<%=idm.getInvoiceNo()%>" onClick='return openpage(this.href);' target=_blank><%=idm.getInvoiceNo()%></a></td>
    <td width="7%"><%=UtilTool.getStrFromTimestamp(idm.getCreationDate(),"yyyy-MM-dd")%></td>
    <td width="20%"><%=idm.getShipperNo()%></td>
    <td width="25%"><%=idm.getShipperChineseName()%></td>
    <td width="15%"><%=idm.getTotalPrice()%></td>
  </tr>
  <%}%>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
  <tr> 
    <td width="28%" class="unnamed1"> 
      <div align="left"> 
        <%if (InvoiceGenerateListPagination.getPageNo() > 1)
          {
            %>
          <a href="InvoiceList.jsp?type=P">前一页</a>
            <%
          }
          if (InvoiceGenerateListPagination.getPageNo() < InvoiceGenerateListPagination.getPageSum())
          {
            %>
            <a href="InvoiceList.jsp?type=N">后一页</a>
            <%
          }
          %>   </div>
    <td width="55%" class="unnamed1">&nbsp; 
    <td width="17%" class="unnamed1"> 
      <div align="right"><font color="#003366">第<%=InvoiceGenerateListPagination.getPageNo()%>页 &nbsp;
      总数：<%=InvoiceGenerateListPagination.getPageSum()%>页</font></div>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>

</html>






