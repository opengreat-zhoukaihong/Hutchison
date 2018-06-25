<%@ include file="Init.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.ejb.session.*"%>
<%@ page import="com.cbtb.model.*"%>
<jsp:useBean id="matchModel" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope = "session" class = "com.cbtb.util.Pagination" />
<%


 String companyIdTmp  = request.getParameter("companyId");
  if (companyIdTmp == null)
      companyIdTmp = "";
 String  matchNum   = request.getParameter("matchNum");
  if (matchNum == null)
     matchNum = "";
 String  beginDate  = request.getParameter("beginDate");
  if (beginDate == null)
      beginDate = "";
 String  endDate    = request.getParameter("endDate");
  if (endDate == null)
     endDate = "";
 String  status     = request.getParameter("status");
   if (status == null)
       status = "";
  else if(!(matchNum.equalsIgnoreCase("")))
       status = "Any";
  else 
       status = "state";

 String  orderByName= request.getParameter("orderByName");
   if (orderByName ==null)
       orderByName = "";
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script Language="JavaScript" src="../js/funStrTrim.js"></script>
<script language=javascript>
function checkNull(){
 if ((document.search.companyId.value=="")&&(document.search.matchNum.value=="")) 
  {   if ((document.search.beginDate.value=="") && (document.search.endDate.value==""))
   {
    alert ("开始日期和结束日期必须选填一个");
    return false;
   }
   return true;
  }
  else
 return true;
}
function docLoad()
{
  with(document.search)
  {
     companyId.value ="<%=companyIdTmp%>";
     matchNum.value = "<%=matchNum%>";
     beginDate.value = "<%=beginDate%>";
     endDate.value = "<%=endDate%>";
     orderByName.value = "<%=orderByName%>";
     status.value = "<%=status%>";
  }
}
</script>

</head>
<body bgcolor="#FFFFFF" text="#000000" onload ="javascript:docLoad()">
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
    <td><font face="Arial, Helvetica, sans-serif">生成服務報表</font></td>
    <td>
      <div align="right"><a href="StatementGenerateResult.jsp?beginDate=<%=beginDate%>&endDate=<%=endDate%>&companyId=<%=companyIdTmp%>&matchNum=<%=matchNum%>"><font color="#003366">生成</font></a></div>
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
<form name=search action="StatementGenerate.jsp" method=post >
<table border="0" width="100%">
  <tr>
    <td width="22%">運輸公司編號：</td>
    <td width="19%">配對編號：</td>
    <td width="19%">送貨開始日期：</td>
    <td width="19%">送貨最后日期：</td>
    <td width="19%">排序：</td>
  </tr>
  <tr>
    <td width="22%">
      <input type="text" size="10" name="companyId" value="">
    </td>
    <td width="19%">
      <input type="text" size="10" name="matchNum" value="">
    </td>
    <td width="19%" >
      <input type="text" maxlength="10" size="8" value="" name="beginDate" value="">
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(beginDate);return false" > </td>
    <td width="19%" >
      <input type="text" maxlength="10" size="8" value="" name="endDate" value="">
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(endDate);return false" > </td>
    <td width="13%">
      <select name="orderByName" size="1">
        <option value="MCR.MATCH_NUMBER">配對編號</option>
        <option value="MCR.TRUCK_CAPACITY_NUM">運輸公司編號</option>
        <option value="MCR.DELIVERY_REQUEST_NUM">付貨人公司編號</option>
        <option value="TC.DELIVERY_DATE">送貨日期</option>
      </select>
    </td>
    <td width="19%" >
      <input type=hidden name=type value=search>
      <input type=hidden name=status value="">  
      <input type="submit" name="Submit" value="查詢" onClick="return checkNull()">
        <input type="reset" name="Submit22" value="重設">
      </td> 
  </tr>
</table>
</form>
<hr>

<%
try{

 Vector matchList=null;
 String type = request.getParameter("type");
  if (!(type == null)&& type.equals("search"))
  {

    BillingManager billingManager = webOperator.getBillingManager();
    pagination.setPageNo(0);

    pagination.setRecords(billingManager.searchMatchForStatement(companyIdTmp,matchNum,beginDate,endDate,status,orderByName));
    matchList = new Vector(pagination.nextPage());
  }
  else
  {
    if (type.equals("N"))
    {
      matchList = new Vector(pagination.nextPage());
    }
    else if (type.equals("P"))
    {
      matchList = new Vector(pagination.previousPage());
    }
  }
%>
<table border="1" width="100%">
    <tr>
        <td>配對編號</td>
        <td>運輸公司名稱</td>
        <td>送貨要求編號</td>
        <td>貨櫃車司機姓名</td>
        <td>車牌號碼</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>拖架種類</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>狀況</td>
    </tr>
<%

for(int i=0;(!matchList.isEmpty()) && i<matchList.size();i++)
{
 matchModel = (MatchModel)matchList.get(i);
 TruckCapacityModel tcm = matchModel.getTruckCapacityModel();

 String companyId = tcm.getCompanyId();
 String truckerId = tcm.getTruckerId();
 String companyName = dbList.getCompanyName(companyId,"");
 String truckerName = dbList.getTruckerName(truckerId,"");
 String hkLicenseNo = dbList.getTruckerHKPlate(truckerId);
 String originCity = dbList.getCityDesc(tcm.getMatchOriginCityId(),"");
 String destinationCity = dbList.getCityDesc(tcm.getMatchDestCityId(),"");
 String trailer = dbList.getTrailerTypeDesc(tcm.getTrailerId(),"");
 String date = tcm.getDeliveryDate().toString().substring(0,10);
 String deliveryTime = dbList.getDeliveryTimeDesc(tcm.getDeliveryTimeId(),"");
 String statusName = dbList.getMatchStatusDesc(matchModel.getMatchStatus(),"");
 %>
   <tr>
      <td><%=matchModel.getMatchNum()%></td>
      <td><%=companyName%></td>
      <td><%=matchModel.getDeliveryRequestNum()%></td>
      <td><%=truckerName%></td>
      <td><%=hkLicenseNo%></td>
      <td><%=originCity%></td>
      <td><%=destinationCity%></td>
      <td><%=trailer%></td>
      <td><%=date%></td>
      <td><%=deliveryTime%></td>
      <td><%=statusName%></td>
    </tr>
<%}%>
    </table>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td >
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="StatementGenerate.jsp?type=P&beginDate=<%=beginDate%>&endDate=<%=endDate%>&status=<%=status%>">前一页</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="StatementGenerate.jsp?type=N&beginDate=<%=beginDate%>&endDate=<%=endDate%>&status=<%=status%>">后一页</a>
          <%
          }
          %>
        </td>
        <td >
          <div align="left">第<%=pagination.getPageNo()%>页 </div>
        </td>
        <td >
          <div align="right">总数：<%=pagination.getPageSum()%>页</div>
        </td>
      </tr>

    </table>
</form>

<%
}
catch(Exception e)
{
 //response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
}
%>
</body>

</html>








