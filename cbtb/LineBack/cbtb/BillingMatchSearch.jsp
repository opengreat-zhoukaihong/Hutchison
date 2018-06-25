<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="mcrm" scope="page" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<jsp:useBean id="pagLt" scope="session"  class="com.cbtb.util.NewPagination"/>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
  if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
      String language="CN";
      String url=request.getParameter("url");  
      String matchNum="";
      String companyName = request.getParameter("companyName");
      String companyID = request.getParameter("companyID");
      String truckerName = request.getParameter("truckerName");
      String deliveryDate = request.getParameter("deliveryDate");
      String deliveryTimeID = request.getParameter("deliveryTimeID");
      String originCityID = request.getParameter("originCityID");
      String destinationCityID = request.getParameter("destinationCityID");
      String matchStatus = request.getParameter("matchStatus");
      String matchNumber = request.getParameter("matchNumber");
      String orderByField = request.getParameter("orderByField");
      String closePage="BillingMatchSearch.jsp";
      session.setAttribute("closePage",closePage);
      matchNum=request.getParameter("matchNum");
      MatchManager mm=webOperator.getMatchManager();
      if (url!=null && url.equalsIgnoreCase("billingMatchStatu")) {
        webOperator.clearPermissionContext();  //清除以前检查的内容
        webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
        webOperator.putPermissionContext("action", "approve"); //加入检查的内容
        if (!webOperator.checkPermission())
          response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
        else
        {
        if(!mm.updateMatchStatus(matchNum,constant.MATCH_STATUS_APPROVE))
          response.sendRedirect("ErrorPage.jsp?errorMessage=ER_0001");
         }
       }
%>
<html>
<head>
<title>Untitled Document</title>

<link rel="stylesheet" href="../css/line.css" type="text/css">
<script src=../js/calendarShow.js></script>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/JsLib.js></script>
<SCRIPT LANGUAGE=javascript>
function doSubmit()
{
    if(!isDate(matchSearch.deliveryDate.value) && matchSearch.deliveryDate.value!=0)
     {
	alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
	matchSearch.deliveryDate.focus();
	return;
     }
    matchSearch.action="BillingMatchSearch.jsp"
    matchSearch.submit();
}
function doPost(matchNum,deliveryNo,truckNo)
{
    matchSearch.action="BillingMatchSearch.jsp?url=billingMatchStatu&matchNum="+matchNum;
    matchSearch.submit();

}
</Script>
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
    <td><font face="Arial, Helvetica, sans-serif">配對記錄列表</font></td>
    <td>
      <div align="right"><a href="Billing.jsp"><font
color="#003366">關閉</font></a></div>
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

<form name="matchSearch" method="POST" action="BillingMatchSearch.jsp">
<table border="0" width="100%">
    <tr>
        <td>公司編號：</td>
        <td>公司名稱：</td>
        <td>配對編號：</td>
        <td>貨櫃車司機姓名：</td>
        <td>送貨日期：</td>
        <td>送貨時間：</td>
    </tr>
    <tr>
        <td><input type="text" size="10" name="companyID" maxlength="10" value="<%=companyID%>"></td>
        <td><input type="text" size="20" name="companyName" maxlength="20" value="<%=companyName%>"> </td>
        <td><input type="text" size="10" name="matchNumber" maxlength="10" value="<%=matchNumber%>"></td>
        <td><input type="text" size="10" name="truckerName" maxlength="10" value="<%=truckerName%>"> </td>
    <td >
      <input type="text" maxlength="10" size="10" value="<%=deliveryDate%>" name="deliveryDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
     </td>
        <td><select name="deliveryTimeID" size="1">
          <%=dbList.getDeliveryTimeList(deliveryTimeID,language)%>
        </select></td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td>目的地城市：</td>
        <td>狀況：</td>
        <td>排序：</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><select name="originCityID" size="1">
         <%=dbList.getCityList(originCityID,language)%>
        </select></td>
        <td><select name="destinationCityID" size="1">
          <%=dbList.getCityList(destinationCityID,language)%>
        </select></td>
        <td><select name="matchStatus" size="1">
          <%=dbList.getMatchStatusList(matchStatus,language)%>
        </select></td>
        <td><select name="orderByField" size="1">
            <option value="">按默認順序</option>
            <option value="Company_ID">按公司編號</option>
            <option value="Match_Number">按配對編號</option>
            <option value="Delivery_Date">按送貨日期</option>
            <option value="Delivery_Time_ID">按送貨時間</option>
            <option value="Origin_City_ID">按出發地城市</option>
            <option value="Destination_City_ID">按目的地城市</option>
        </select></td>
        <td><input type="button" name="Submit" onClick="JavaScript:doSubmit()" value="查詢"></td>
        <td><input type="reset" name="reset" value="重設"></td>
    </tr>
</table>

<hr>
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
String init=request.getParameter("init");
if (!(init==null))
 {
%>
<table border="1" width="98%" align="center">
  <tr>
    <td width="7%">配對編號</td>
    <td width="11%">送貨要求編號</td>
    <td width="9%">付貨人名稱</td>
    <td width="11%">登記空車編號</td>
    <td width="11%">運輸公司名稱</td>
    <td width="12%">貨櫃車司機姓名</td>
    <td width="7%">航運公司</td>
    <td width="7%">送貨日期</td>
    <td width="7%">送貨時間</td>
    <td>狀況</td>
    <td>操作</td>
  </tr>

<%
 String type = request.getParameter("type"); 
   ArrayList matchList=new ArrayList();
 try{


     if (type == null  )
        {
           
 if(companyName!=null && companyName.trim().length()==0)
    companyName=null;
 if(companyID!=null && companyID.trim().length()==0)
    companyID=null;
 if(truckerName!=null && truckerName.trim().length()==0)
    truckerName=null;
 if(deliveryDate!=null && deliveryDate.trim().length()==0)
    deliveryDate=null;
 if(deliveryTimeID!=null && deliveryTimeID.equals("Any"))
    deliveryTimeID=null;
 if(originCityID!=null && originCityID.equals("Any"))
    originCityID=null;
 if(destinationCityID!=null && destinationCityID.equals("Any"))
    destinationCityID=null;
 if(matchStatus!=null && matchStatus.equals("Any"))
    matchStatus=null;
 if(matchNumber!=null && matchNumber.trim().length()==0)
    matchNumber=null;
 if(orderByField!=null && orderByField.trim().length()==0)
    orderByField=null;
          pagLt.setPageNo(0);
          pagLt.setRecords(mm.searchMatchInfo(companyID, companyName, matchNumber,truckerName, deliveryDate, deliveryTimeID, originCityID,destinationCityID,matchStatus,orderByField));

          matchList =(ArrayList)pagLt.nextPage();
         }
     else
        {
         if (type.equals("N"))
             {
              matchList=null;
              matchList = (ArrayList)pagLt.nextPage();
             }
         else if (type.equals("P"))
             {
              matchList = new ArrayList(pagLt.previousPage());
             }
         else if (type.equals("F"))
             {
              matchList =new ArrayList(pagLt.firstPage());
             }
         else if (type.equals("E"))
             {
              matchList =new ArrayList(pagLt.endPage());
             }
         else if (type.equals("T"))
             {
               matchList =new ArrayList(pagLt.toPage(Integer.parseInt(request.getParameter("page"))));
             }
          }

     for (int i = 0;  (!matchList.isEmpty()) && i < matchList.size(); i++) {
        mcrm = (MatchModel)matchList.get(i);
      if(!mcrm.getMatchStatus().equals(constant.MATCH_STATUS_CANCELLED))
      {
%>

  <tr>
    <td width="7%"><a href="MatchView.jsp?type=search&matchNumber=<%=mcrm.getMatchNum()%>"><%=mcrm.getMatchNum()%>&nbsp;</a></td>
    <td width="11%"><a href="MatchDeliveryRequestView.jsp?deliveryRequestNum=<%=mcrm.getDeliveryRequestNum()%>"><%=mcrm.getDeliveryRequestNum()%>&nbsp;</a></td>
    <td width="9%"><a href="MatchRegShipperView.jsp?companyId=<%=mcrm.getDeliveryRequestModel().getCompanyId()%>"><%=dbList.getCompanyName(mcrm.getDeliveryRequestModel().getCompanyId(),language)%>&nbsp;</a></td>
    <td width="11%"><a href="CapacityViewMatch.jsp?truckCapacityNum=<%=mcrm.getTruckCapacityNum()%>"><%=mcrm.getTruckCapacityNum()%>&nbsp;</a></td>
    <td width="11%"><a href="MatchRegTruckerView.jsp?companyId=<%=mcrm.getTruckCapacityModel().getCompanyId()%>"><%=dbList.getCompanyName(mcrm.getTruckCapacityModel().getCompanyId(),language)%>&nbsp;</a></td>
    <td width="12%"><a href="TruckerViewMatch.jsp?companyId=<%=mcrm.getTruckCapacityModel().getCompanyId()%>&companyName=<%=dbList.getCompanyName(mcrm.getTruckCapacityModel().getCompanyId(),language)%>&truckerName=<%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%>&truckerId=<%=mcrm.getTruckCapacityModel().getTruckerId()%>"><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%>&nbsp;</a></td>
    <td width="7%"><%=dbList.getShippingLineDesc(mcrm.getDeliveryRequestModel().getShippingLineId(),language)%>&nbsp;</td>
    <td width="7%"><%=(mcrm.getTruckCapacityModel().getDeliveryDate().toString()).substring(0,10)%>&nbsp;</td>
    <td width="7%"><%=dbList.getDeliveryTimeDesc(mcrm.getTruckCapacityModel().getDeliveryTimeId(),language)%>&nbsp;</td>
    <td width="8%"><%=dbList.getMatchStatusDesc(mcrm.getMatchStatus(),language)%>&nbsp;</td>
    <td width="10%">
    <%
    if(mcrm.getMatchStatus().equals(constant.MATCH_STATUS_CONTAINER_DELIVERED))
     {
    %>
      <input type="button" name="button" onClick="JavaScript:doPost('<%=mcrm.getMatchNum()%>')" value="審核">
    <%
     }
    else
    {
    %>
      &nbsp;
    <%}}%>
    </td>
  </tr>
<%}}catch(Exception e){}%>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
  <tr>
    <td width="28%" class="unnamed1">
          <%
          if (pagLt.getPageNo() > 1)
          {
            %>
      <div align="left"><a href="BillingMatchSearch.jsp?type=F&init=tmd"><font color="#003366">第一頁</font></a> <a href="BillingMatchSearch.jsp?type=P&init=tmd"><font color="#003366">上一頁</font></a>
          <%
          }
          if (pagLt.getPageNo() < pagLt.getPageSum())
          {
            %>
        <a href="BillingMatchSearch.jsp?type=N&init=tmd"><font color="#003366">下一頁</font></a> <a href="BillingMatchSearch.jsp?type=E&init=tmd"><font color="#003366">最後一頁</font></a>
          <%
          }
          %>
      </div>
    <td width="55%" class="unnamed1">&nbsp;
    <td width="17%" class="unnamed1">
      <div align="right"><font color="#003366">第<%=pagLt.getPageNo()%>頁&nbsp;總數:<%=pagLt.getPageSum()%>頁</font></div>
    </td>
  </tr>
</table>

<p></p>
<%
}}
%>
<input type="hidden" name="init" value="notfirst">
</form>
</body>

</html>
