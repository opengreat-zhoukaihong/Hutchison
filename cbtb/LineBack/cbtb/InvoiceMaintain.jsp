<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","BILLING"); 
webOperator.putPermissionContext("action", "edit"); 
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
<jsp:useBean id="InvoiceMaintainPagination" scope="session" class="com.cbtb.util.Pagination" />
<%
  String shipperNo        = request.getParameter("shipperNo");
  String invoiceNo        = request.getParameter("invoiceNo");
  String creationFromDate = request.getParameter("creationFromDate");
  String creationToDate   = request.getParameter("creationToDate");
  String invoiceStatus    = request.getParameter("invoiceStatus");
  
  String type       	  = request.getParameter("type");
  String updateInvoiceNo  = request.getParameter("updateInvoiceNo");
  String newStatus        = request.getParameter("newStatus");
  
  //if invoiceStatus not select,then select any
  if(invoiceStatus == null)
    invoiceStatus = "Any";
%>
<script language=javascript src="../js/funStrTrim.js"></script>
<script language=javascript src="../js/DateValid_big5.js"></script>
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script language ="javascript">
<!--

function selchange(invoiceNo)
{

 //paid
 var oldStatus = document.all(invoiceNo+"OldStatus").value;
 var canChange = true;
 newStatus = document.all(invoiceNo+"Status").value
 step = parseInt(newStatus,10) - parseInt(oldStatus,10) 
 absStep = Math.abs(parseInt(newStatus,10) - parseInt(oldStatus,10))
 if( oldStatus =="3" || oldStatus == "3")
   {
    alert("該發票已經付款，不能修改狀態")
    canChange = false;
   }

 if( newStatus == "3"|| newStatus == "4")
   {
    alert("不能直接改變發票的狀態為付款狀態")
    canChange = false;
   }
 
 //cancelld
 
 if(canChange && oldStatus == "0")
  {
   alert("該發票已經取消，不能改變狀態");
   canChange = false;
  } 
 if(canChange && absStep>1)
  {
    alert("發票狀態只能一步一步修改，不能多步修改")
    canChange = false
  }
 if(!canChange)
  {
   document.all(invoiceNo+"Status").value=oldStatus;
  }
 return canChange
 }

function query()
{
 if(!validate()) return false;
 fmQuery.action = "InvoiceMaintain.jsp?type=search";
 fmQuery.submit();
}
function updateMe(me,index)
{
 if(document.all(me+"Status").value == document.all(me+"OldStatus").value)
 {
  alert("發票狀態沒有改變");
  return
 }
 document.all("updateInvoiceNo").value = me;
 document.all("newStatus").value = document.all(me+"Status").value;
 document.all("oldStatus").value = document.all(me+"OldStatus").value;
 document.all("updateIndex").value = index;

 fmQuery.action = "InvoiceStatusUpdate.jsp";
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
      alert("開始日期不能大於結束日期")
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
  
  document.all("updateInvoiceNo").value="";
  document.all("newStatus").value = "";
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

-->
</script>
<html>
<head>
<title>--LINE--〖發票維護〗</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" onload = "javascript:docLoad();">
<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11"><font face="Arial, Helvetica, sans-serif">審核 / 更新發票</font>
    </td>
    <td height="11">
      <div align="right"><a href="Billing.jsp"><font color="#003366">關閉</font></a></div>
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
<form name="fmQuery" method="post" action = "InvoiceStatusUpdate.jsp">
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
<input type = hidden name ="updateInvoiceNo" value="<%=updateInvoiceNo%>">
<input type = hidden name ="newStatus" value="<%=newStatus%>">
<input type = hidden name = "oldStatus"  value="">
<input type = hidden name ="updateIndex"  value ="">
</form>
</table>

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
	  InvoiceMaintainPagination.setRecords(colInvoiceDataModel);
	  InvoiceMaintainPagination.setPageNo(0);
	  vctInvoiceDataModel = new Vector(InvoiceMaintainPagination.nextPage());
	}
    }
    else
    {
      if(type != null && type.equals("N"))
      {
        vctInvoiceDataModel = new Vector(InvoiceMaintainPagination.nextPage());
      }
      else if( type != null && type.equals("P"))
      {
	vctInvoiceDataModel = new Vector(InvoiceMaintainPagination.previousPage());
      }
    }
%>
<% if(type !=null)
   {%>
<table border="1" width="98%" align="center">
  <tr>
    <td width="16%">發票編號</td>
    <td width="26%">付貨人公司名稱</td>
    <td width="14%">發票日期</td>
    <td width="15%">總金額</td>
    <td width="15%">狀況</td>
    <td width="6%">操作</td>
  </tr>
  <%        
	InvoiceDataModel idm = null;
	for(int i=0;(vctInvoiceDataModel != null)&&(!vctInvoiceDataModel.isEmpty()) && i < vctInvoiceDataModel.size(); i++)
        { 
	  idm = (InvoiceDataModel) vctInvoiceDataModel.elementAt(i);
  %>
  <tr>
    <td width="16%"><a href = "/servlets/com.cbtb.report.Invoice?invoiceNo=<%=idm.getInvoiceNo()%>" onClick='return openpage(this.href);' target=_blank><%=idm.getInvoiceNo()%></a></td>
    <td width="26%"><%=idm.getShipperChineseName()%></td>
    <td width="14%"><%=UtilTool.getStrFromTimestamp(idm.getCreationDate(),"yyyy-MM-dd")%></td>
    <td width="15%"><%=idm.getTotalPrice()%></td>
    <td width="15%">
      <select name="<%=idm.getInvoiceNo()%>Status" size="1" style="width:100px"  onchange = "return selchange('<%=idm.getInvoiceNo()%>')">
      <%=dbList.getInvoiceStatusList(idm.getInvoiceStatus(),"BIG5",false)%>
      </select>
    <input type= hidden name ="<%=idm.getInvoiceNo()%>OldStatus" value = "<%=idm.getInvoiceStatus()%>">
    </td>
    <td width="6%">
      <a href="javascript:updateMe('<%=idm.getInvoiceNo()%>',<%=i%>);">更新</a>
    </td>
  </tr>
 <%}%>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
  <tr>
    <td width="28%" class="unnamed1">
      <div align="left">
      <% if (InvoiceMaintainPagination.getPageNo() > 1)
          {
            %>
          <a href="InvoiceMaintain.jsp?type=P&shipperNo=<%=shipperNo%>&invoiceNo=<%=invoiceNo%>&creationFromDate=<%=creationFromDate%>
                                    &creationToDate=<%=creationToDate%>&invoiceStatus=<%=invoiceStatus%>">前一页</a>
            <%
          }
          if (InvoiceMaintainPagination.getPageNo() < InvoiceMaintainPagination.getPageSum())
          {
            %>
            <a href="InvoiceMaintain.jsp?type=N&shipperNo=<%=shipperNo%>&invoiceNo=<%=invoiceNo%>&creationFromDate=<%=creationFromDate%>
                                    &creationToDate=<%=creationToDate%>&invoiceStatus=<%=invoiceStatus%>">后一页</a>
            <%
          }
          %>      
      </div>
    <td width="55%" class="unnamed1">&nbsp;
    <td width="17%" class="unnamed1">
      <div align="right"><font color="#003366">第<%=InvoiceMaintainPagination.getPageNo()%>页 &nbsp;
      总数：<%=InvoiceMaintainPagination.getPageSum()%>页</font></div>
    </td>
  </tr>
</table>
<%}//end if%>
<p>&nbsp;</p>
</body>

</html>








