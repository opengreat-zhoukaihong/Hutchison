<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "view"); //加入检查的内容
  if (!webOperator.checkPermission())
  {
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  }
  else
  {
   String languageName ="CN";
   String init=request.getParameter("init");
   String  companyId=request.getParameter("companyId");
   String  matchNumber=request.getParameter("matchNumber");
   String  deliveryRequestNum=request.getParameter("deliveryRequestNum");
   String  truckCapacityNum=request.getParameter("truckCapacityNum");
   String  deliveryDate=request.getParameter("deliveryDate");
   String  deliveryTimeId=request.getParameter("deliveryTimeId");
   String  originCityId=request.getParameter("originCityId");
   String  destinationCityId=request.getParameter("destinationCityId");
   String  trailerTypeId=request.getParameter("trailerTypeId");
   String  containerTypeId=request.getParameter("containerTypeId");
   String  orderByName=request.getParameter("orderByName");
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script src=../js/calendarShow.js></script>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/JsLib.js></script>
<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
    if(!isDate(unMatchForm.deliveryDate.value) && unMatchForm.deliveryDate.value!=0)
     {
	alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
	unMatchForm.deliveryDate.focus();
	return;
     }
    unMatchForm.action="UnMatchList.jsp"
    unMatchForm.submit();
}
function doSubmit(matchNum)
{
    if(confirm("在重配對之前先取消配對，繼續嗎！"))
    {
    unMatchForm.action="rematch.jsp?matchNum="+matchNum
    unMatchForm.submit();
    }
}
function CheckAll(check_stat)
{
    for (var i=0; i < document.unMatchForm.elements.length; i++) {
                var e=document.unMatchForm.elements[i];
                if (e.name == 'unMatch') e.checked = check_stat;
    }
}

</SCRIPT>
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
    <td>取消配對列表</td>
    <td>
      <div align="right"><a
href="MatchFunctionList.jsp"><font color="#003366"
size="2">關閉</font></a></div>
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
<form method="POST" name="unMatchForm" action="UnMatchList.jsp">
<table border="0" width="90%">
    <tr>
        <td>公司編號：</td>
        <td>
      <input type="text" size="10" name="companyId" maxlength="10" value="<%=companyId%>">
       </td>
        <td>配對編號：</td>
        <td>
      <input type="text" size="10" name="matchNumber" maxlength="10" value="<%=matchNumber%>">
       </td>
    </tr>
    <tr>
        <td>送貨要求編號：</td>
        <td>
      <input type="text" size="10" name="deliveryRequestNum" maxlength="10" value="<%=deliveryRequestNum%>">
       </td>
        <td>登記空車編號： </td>
        <td><input type="text" size="10" name="truckCapacityNum" value="<%=truckCapacityNum%>"> </td>
    </tr>
    <tr>
        <td>送貨日期：</td>
        <td><input type="text" size="10" value="<%=deliveryDate%>" name="deliveryDate">  <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" ></td>
        <td>送貨時間：</td>
        <td>
      <select name="deliveryTimeId" size="1">
        <%=dbList.getDeliveryTimeList(deliveryTimeId,languageName)%>
        </select> </td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td>
      <select name="originCityId" size="1">
        <%=dbList.getCityList(originCityId,languageName)%>
        </select> </td>
        <td>目的地城市：</td>
        <td>
      <select name="destinationCityId" size="1">
        <%=dbList.getCityList(destinationCityId,languageName)%>
        </select> </td>
    </tr>
    <tr>
        <td>拖架種類：</td>
        <td>
      <select name="trailerTypeId" size="1">
        <%=dbList.getTrailerTypeList(trailerTypeId,languageName)%>
        </select> </td>
        <td>貨櫃車種類：</td>
        <td>
      <select name="containerTypeId" size="1">
        <%=dbList.getContainerTypeList(containerTypeId,languageName)%>
        </select> </td>
    </tr>
    <tr>
        <td>排序：</td>
        <td>
      <select name="orderByName" size="1">
          <option value="" >按默認排序</option>
          <option value="company_id">公司編號</option>
          <option value="match_number">配對編號</option>
          <option value="origin_city_id">出發地</option>
          <option value="destination_city_id">目的地</option>
          <option value="delivery_date">送貨日期</option>
         
        </select> </td>
        <td><input type="button" onClick="JavaScript:doPost()" name="Submit"  value="查詢">
      <input type="reset" name="Submit2" value="取消">
    </td>
    <td>&nbsp;</td>
    </tr>
</table>
<% 
 String  [] unMatchNum =null;
 if(deliveryTimeId!=null && deliveryTimeId.equals("Any"))deliveryTimeId=null;
 if(originCityId!=null && originCityId.equals("Any"))originCityId=null;
 if(destinationCityId!=null && destinationCityId.equals("Any"))destinationCityId=null;
 if(trailerTypeId!=null && trailerTypeId.equals("Any"))trailerTypeId=null;
 if(containerTypeId!=null && containerTypeId.equals("Any"))containerTypeId=null;
 MatchManager matchManager = webOperator.getMatchManager();
 unMatchNum = request.getParameterValues("unMatch");
 if (unMatchNum!=null)
 {
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
  if (!webOperator.checkPermission())
  {
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  }
  else
  {
    if (!matchManager.unmatch(unMatchNum))
        response.sendRedirect("ErrorPage.jsp?errorMessage=ER_0001");
   }
 }
 if (!(init==null))

  {
    try{
      ArrayList unMatchList =new ArrayList();
      String type = request.getParameter("type");
          //if (type == null && unMatchNum==null  )
	   if (type == null)
              {
              newPagination.setPageNo(0);
              newPagination.setRecords(matchManager.searchUnMatchInfo(companyId,matchNumber,deliveryRequestNum,truckCapacityNum,deliveryDate,deliveryTimeId,originCityId,destinationCityId,trailerTypeId,containerTypeId,orderByName));
              unMatchList = new ArrayList(newPagination.nextPage());
 
              }
           else
              {
               if (type.equals("N"))
                   {
                    unMatchList = new ArrayList(newPagination.nextPage());
                   }
               else if (type.equals("P"))
                   {
                    unMatchList = new ArrayList(newPagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    unMatchList =new ArrayList(newPagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    unMatchList =new ArrayList(newPagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     unMatchList =new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
	       MatchModel mcrm = null; 
%>
<hr>

<table border="1">
    <tr>
        <td>&nbsp;</td>
        <td>配對編號
        </td>
        <td>出發地</td>
        <td>目的地</td>
    <td>送貨日期</td>
    <td>送貨時間段</td>
    <td>送貨要求編號</td>
    <td>付貨人名稱</td>
    <td>空車編號</td>
    <td>貨櫃車公司名稱</td>
    <td>配對狀況</td>
    </tr>
 <%  //out.print("size="+unMatchList.size());
       for (int i = 0;  (!unMatchList.isEmpty()) && i < unMatchList.size(); i++)
       {
	  mcrm = new MatchModel();
	  mcrm =(MatchModel)unMatchList.get(i);
  %>

    <tr>
        <td>
<%	if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_MATCHED)){%>
<input type=checkbox name=unMatch value="<%=mcrm.getMatchNum()%>">
<%}%>
	&nbsp;
        </td>
        
      <td><a href="JavaScript:doSubmit('<%=mcrm.getMatchNum()%>')"><%=mcrm.getMatchNum()%></a>&nbsp;</td>
        <td><%=dbList.getCityDesc(mcrm.getDeliveryRequestModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mcrm.getDeliveryRequestModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=(mcrm.getDeliveryRequestModel().getDeliveryDate().toString()).substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mcrm.getDeliveryRequestModel().getTimeId(),languageName)%>&nbsp;</td>
        <td><%=mcrm.getDeliveryRequestNum()%>&nbsp;</td>
        <td><%=dbList.getCompanyName(mcrm.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=mcrm.getTruckCapacityNum()%>&nbsp;</td>
        <td><%=dbList.getCompanyName(mcrm.getTruckCapacityModel().getCompanyId(),languageName)%>&nbsp;</td>
	<td><%
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_CANCELLED))out.print("已取消");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_MATCHED))out.print("已配對");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_CONFIRM))out.print("已確認");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_CONTAINER_PICKUP))out.print("已裝箱");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED))out.print("已送貨");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_APPROVE))out.print("APPROVED");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_INVOICE))out.print("INVOICE");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_STATEMENT))out.print("STATEMENT");
if(mcrm.getMatchStatus().equals(CbtbConstant.MATCH_STATUS_ALLINVOICESTATEMENT))out.print("ALLINVOICESTATEMENT");
%>&nbsp;</td>
    </tr>
 <%}	//for() end
}//try() end
catch(Exception e){
//out.print(e);
}
%> 

</table>
<table width="93%" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1"> 
          <%
          if (newPagination.getPageNo() > 1)
          {
            %>
          <a href="UnMatchList.jsp?type=F&init=p" class="unnamed1">第一頁</a> <a href="UnMatchList.jsp?type=P&init=p">前一頁</a> 
          <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
            %>
          <a href="UnMatchList.jsp?type=N&init=p">後一頁</a> <a href="UnMatchList.jsp?type=E&init=p">最後一頁</a> 
          <%
          }
          %>
          </td>     
        <td width="15%" class="unnamed1">
          <div align="right">第<%=newPagination.getPageNo()%>頁 &nbsp;&nbsp;&nbsp;總數：<%=newPagination.getPageSum()%>頁</div>
        </td>
      </tr>
    </table>
<%//if(!unMatchList.isEmpty()){%>
<input type="button" name="selectAll" value="全選" onclick="CheckAll('on')">
<input type="button" name="matchCancel" onClick="JavaScript:doPost()" value="取消配對">

<%
}}
%>
<br><input type="hidden" name="init" value="notfirst">

</form>
</body>

</html>
