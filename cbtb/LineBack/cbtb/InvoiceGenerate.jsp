<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","BILLING");
webOperator.putPermissionContext("action", "search");
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="InvoiceGeneratePagination" scope="session" class="com.cbtb.util.Pagination" />
<%
  String shipperNo        = request.getParameter("shipperNo");
  String matchNum         = request.getParameter("matchNum");
  String deliveryFromDate = request.getParameter("deliveryFromDate");
  String deliveryToDate   = request.getParameter("deliveryToDate");
  String orderByField     = request.getParameter("orderByField");
  String type       = request.getParameter("type");
%>
<script language="JavaScript" src="../js/funStrTrim.js"></script>
<script language="JavaScript" src="../js/DateValid_big5.js"></script>
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script language ="JavaScript">
<!--
function  generateInvoice()
{
  if(document.all("tabList").rows.length ==1 )
  {
     alert("不能生成發票，因爲你沒有查詢出任何數據");
     return;
  }
  alert("現金付款的公司可以按照查詢條件生成發票，非現金付款的公司則要根據發票指定日期來生成")
  fmQuery.action =  "InvoiceInsert.jsp";
  fmQuery.submit();
}
function query()
{
 if(!validate()) return false;
 fmQuery.action = "InvoiceGenerate.jsp?type=search";
 fmQuery.submit();
}
function validate()
{
  errFound = false;
  with(document.fmQuery){
  if(Trim(matchNum.value).length > 0 )
  {
     shipperNo.value = "";
     deliveryFromDate.value = "";
     deliveryToDate.value = "";
     return true;
  }

  if(!errFound && Trim(deliveryFromDate.value).length>0 && !checkDateWithOneElem(deliveryFromDate))
      errFound=true;
  if(!errFound &&Trim(deliveryToDate.value).length>0 && !checkDateWithOneElem(deliveryToDate))
      errFound=true;
  if( !errFound && Trim(deliveryFromDate.value).length>0 &&Trim(deliveryToDate.value).length>0)
    if(compareDate(Trim(deliveryFromDate.value),Trim(deliveryToDate.value))==-1)
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
  with(document.fmQuery)
  {
     shipperNo.value ="<%=shipperNo%>";
     matchNum.value = "<%=matchNum%>";
     deliveryFromDate.value = "<%=deliveryFromDate%>";
     deliveryToDate.value = "<%=deliveryToDate%>";
     orderByField.value = "<%=orderByField%>";
  }
}
-->
</script>
<html>
<head>
<title>--LINE--〖生成發票〗</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" topmargin=0 marginheight=0 onload ="javascript:docLoad()">

<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11"><font face="Arial, Helvetica, sans-serif">生成發票</font> </td>
    <td height="11">
      <div align="right">
<%
	webOperator.clearPermissionContext();
	webOperator.putPermissionContext("document_type","BILLING");
	webOperator.putPermissionContext("action", "create");
	if (webOperator.checkPermission())
        {
%>
	<a href="javascript:generateInvoice();"><font color="#003366">生成</font></a>
       <font color="#003366"> | </font>
<%}%>
<a href="Billing.jsp"><font color="#003366">關閉</font></a></div>
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
<table border="0" width="98%" align="center">
  <tr>
    <td>付貨人公司編號：</td>
    <td>配對編號：</td>
    <td>送貨開始日期：</td>
    <td>送貨最后日期：</td>
    <td>排序：</td>
    <td>&nbsp;</td>
  </tr>

<form name="fmQuery" method="post" action = "InvoiceGenerate.jsp">
  <tr>
    <td>
      <input type="text" size="10" name="shipperNo" value="">
    </td>
    <td>
      <input type="text" size="10" name="matchNum" value="">
    </td>
    <td >
      <input type="text" maxlength="10" size="8" value="" name="deliveryFromDate"  title="日期格式:YYYY-MM-DD">
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryFromDate);return false" > </td>
    <td >
      <input type="text" maxlength="10" size="8" value="" name="deliveryToDate" title="日期格式:YYYY-MM-DD" >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryToDate);return false" > </td>
    <td>
	<select name="orderByField" size="1">
            <option value="">按默認順序</option>
            <option value="Company_ID">按公司編號</option>
            <option value="Match_Number">按配對編號</option>
            <option value="Delivery_Date">按送貨日期</option>
            <option value="Delivery_Time_ID">按送貨時間</option>
            <option value="Origin_City_ID">按出發地城市</option>
            <option value="Destination_City_ID">按目的地城市</option>
        </select>
    </td>
    <td>&nbsp;</td>
  </tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
      <input type="submit" name="Submit" value="查詢" onclick="javascript:return query();">
      <input type="reset" name="Submit2" value="重設">
    </td>
  </tr>
</form>
</table>
<hr>

<%
   Vector vctMatchModel = null;
   if(type != null && type.equals("search"))
   {

       BillingManager bm = webOperator.getBillingManager();
       Vector vctMatchNum = null;
       Vector vctMatchStatus = null;
       // if matchNum != null then search this matchnum,else,search matchstatus can generate invoice:approve,statement
       if(matchNum != null && matchNum.trim().length()>0)
	{
	 vctMatchNum = new Vector();
         vctMatchNum.addElement(matchNum);
         shipperNo = null;
         deliveryFromDate = null;
         deliveryToDate = null;
        }
        else
        {
         vctMatchStatus = new Vector();
         vctMatchStatus.addElement(CbtbConstant.MATCH_STATUS_APPROVE);
	 vctMatchStatus.addElement(CbtbConstant.MATCH_STATUS_STATEMENT);
        }

        Collection colMatchModel = bm.searchMatchForInvoice(shipperNo,vctMatchNum ,
                                   deliveryFromDate,deliveryToDate,vctMatchStatus,orderByField);
	if(colMatchModel != null)
	{

         InvoiceGeneratePagination.setRecords(colMatchModel);
	 InvoiceGeneratePagination.setPageNo(0);
	 vctMatchModel = new Vector(InvoiceGeneratePagination.nextPage());

	 session.setAttribute("GenInvoice",colMatchModel);
        }
    }
    else
    {
      if(type != null && type.equals("N"))
      {
        vctMatchModel = new Vector(InvoiceGeneratePagination.nextPage());
      }
      else if( type != null && type.equals("P"))
      {
	vctMatchModel = new Vector(InvoiceGeneratePagination.previousPage());
      }
    }
%>
<% if(type !=null)
   {%>
<table border="1" cellSpacing="1" width="100%"  name="tabList" id="tabList">
    <tr >
        <td >配對編號</td>
        <td >付貨人公司名稱</td>
        <td >送貨要求編號</td>
        <td >貨櫃車司機姓名</td>
        <td >車牌號碼</td>
        <td >出發地城市</td>
        <td >目的地城市</td>
        <td >拖架種類</td>
        <td >送貨日期</td>
        <td >送貨時間</td>
        <td >狀況</td>
    </tr>
 <%
     MatchModel  mm = null;

     for (int i = 0;  (vctMatchModel != null)&&(!vctMatchModel.isEmpty()) && i < vctMatchModel.size(); i++)
    {
        mm = (MatchModel)vctMatchModel.elementAt(i);%>
    <tr >

    <td ><%=mm.getMatchNum()%></td>
    <td ><%=dbList.getCompanyName(mm.getDeliveryRequestModel().getCompanyId(),"BIG5")%></td>
    <td ><%=mm.getDeliveryRequestNum()%></td>
    <td ><%=dbList.getTruckerName(mm.getTruckCapacityModel().getTruckerId(),"BIG5")%></td>
    <td ><%=dbList.findTrucker(mm.getTruckCapacityModel().getTruckerId()).getHkPlateNo()%></td>
    <td ><%=dbList.getCityDesc(mm.getDeliveryRequestModel().getOriginCityId(),"BIG5")%></td>
    <td ><%=dbList.getCityDesc(mm.getDeliveryRequestModel().getDestinationCityId(),"BIG5")%></td>
    <td ><%=dbList.getTrailerTypeDesc(mm.getTruckCapacityModel().getTrailerId(),"BIG5")%></td>
    <td ><%=UtilTool.getStrFromTimestamp(mm.getDeliveryRequestModel().getDeliveryDate(),"yyyy-MM-dd")%></td>
    <td ><%=dbList.getDeliveryTimeDesc(mm.getDeliveryRequestModel().getTimeId(),"BIG5")%></td>
    <td ><%=dbList.getMatchStatusDesc(mm.getMatchStatus(),"BIG5")%></td>
    </tr>
   <%}%>


</table>

<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
  <tr>
    <td width="28%" class="unnamed1">
      <div align="left"><%
          if (InvoiceGeneratePagination.getPageNo() > 1)
          {
            %>
          <a href="InvoiceGenerate.jsp?type=P&shipperNo=<%=shipperNo%>&matchNum=<%=matchNum%>&deliveryFromDate=<%=deliveryFromDate%>
                                      &deliveryToDate=<%=deliveryToDate%>&orderByField=<%=orderByField%>" >前一页</a>
            <%
          }
          if (InvoiceGeneratePagination.getPageNo() < InvoiceGeneratePagination.getPageSum())
          {
            %>
            <a href="InvoiceGenerate.jsp?type=N&shipperNo=<%=shipperNo%>&matchNum=<%=matchNum%>&deliveryFromDate=<%=deliveryFromDate%>
                                      &deliveryToDate=<%=deliveryToDate%>&orderByField=<%=orderByField%>" >后一页</a>
            <%
          }
          %>
      </div>
    <td width="55%" class="unnamed1">&nbsp;
    <td width="17%" class="unnamed1">
      <div align="right"><font color="#003366">第<%=InvoiceGeneratePagination.getPageNo()%>页 &nbsp;
      总数：<%=InvoiceGeneratePagination.getPageSum()%>页</font></div>
    </td>
  </tr>
</table>
<%}//end if%>
<p>&nbsp;</p>
</body>

</html>
