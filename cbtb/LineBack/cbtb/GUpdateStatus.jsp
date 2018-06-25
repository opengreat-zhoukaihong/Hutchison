<%@ include file="Init.jsp"%>          
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="mcrm" scope="page" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagSjf" scope="session" class="com.cbtb.util.NewPagination" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","GUANLAN"); 
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
  if (search.matchNumber.value=="")
  {	
    if (search.deliveryDate.value!="") 
    {

      if(!isDate(search.deliveryDate.value))
       {
         alert("請輸入正確的日期類型！");
         return;
       } 
     } 
 //   if (search.deliveryTimeId.value=="Any")
	//{
	//	alert("請輸入查詢時間！");
	//	return;
//	}
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="11" width="18%"><font size="2">觀蘭更改狀況</font></td>
    <td height="11" width="82%"> 
      <div align="right"><a href="index.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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
<form action="GUpdateStatus.jsp" name="search"  method="post">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<input type="hidden" name="init" value="search"> 
  <tr> 
    <td>公司編號：</td>
    <td>公司名稱：</td>
    <td>配對編號：</td>
    <td>貨櫃車司機姓名：</td>
    <td>車牌號碼：</td>
  </tr>
  <tr> 
    <td> 
      <input type="text" size="20" name="companyId">
    </td>
    <td> 
      <input type="text" size="20" name="companyName">
    </td>
    <td> 
      <input type="text" size="20" name="matchNumber">
    </td>
    <td> 
      <input type="text" size="20" name="truckerName">
    </td>
    <td> 
      <input type="text" size="20" name="hkPlateNo">
    </td>
  </tr>
  <tr> 
    <td width="18%">日期 ： </td>
    <td width="15%">送貨時間：</td>
    <td width="19%">排序：</td>
    <td width="23%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="18%">
      <input type="text" maxlength="10" size="10"  name="deliveryDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" > </td>
    <td width="15%">
      <select name="deliveryTimeId" size="1">
      <%=dbList.getDeliveryTimeList("Any", "CN")%>
      </select>
    </td>
    <td width="19%">
      <select name="orderByField" size="1">
        <option value="Delivery_Request_Num">送貨要求編號</option>
        <option value="<%=CbtbConstant.SEARCH_MATCH_ORDER_FIELD_DELIVERY_DATE%> ">送貨日期</option>
      </select>
    </td>
    <td width="23%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<p>
    <input type="button" name="Sub"  value="查詢"  onClick="javascript:doPost()">
    <input type="reset" name="Subm"  value="重設" >
</p>
</form>
  <hr>
<%


if (init!=null)
{ 

String companyId = request.getParameter("companyId");
String companyName = request.getParameter("companyName");
String truckerName = request.getParameter("truckerName");
String matchNumber = request.getParameter("matchNumber");
String hkPlateNo = request.getParameter("hkPlateNo");
String deliveryDate = request.getParameter("deliveryDate");
String deliveryTimeId = request.getParameter("deliveryTimeId");
String orderByField = request.getParameter("orderByField");


if ("any".equalsIgnoreCase(deliveryTimeId)) deliveryTimeId="";

MatchManager mm=webOperator.getMatchManager();
ArrayList matchList=new ArrayList();
String type=  request.getParameter("type");
           if (type == null  )
              {
               pagSjf.setPageNo(0);
               pagSjf.setRecords(mm.searchMatchInfo(companyId, companyName, matchNumber,    truckerName, deliveryDate, deliveryTimeId,hkPlateNo,orderByField)); 
     matchList=new ArrayList(pagSjf.nextPage());
   }
           else
              {
               if (type.equals("N"))
                   {
                    matchList = new ArrayList(pagSjf.nextPage());
                   }
               else if (type.equals("P"))
                   {
                    matchList = new ArrayList(pagSjf.previousPage());
                   }
               else if (type.equals("F"))
                   {
                   matchList =new ArrayList(pagSjf.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    matchList =new ArrayList(pagSjf.endPage());
                   }

               }

%>


<SCRIPT LANGUAGE=javascript>
function doCheck()
{
   var containerNum = "containerNum";
   var matchStatus="matchStatus";
   var counter=<%=matchList.size()%>;
   for (var i=0; i<parseInt(counter); i++) {
     
    containerNum=containerNum+i;
    matchStatus=matchStatus+i;
    if (document.confirm.matchStatus.checked) 
    {

      if((document.confirm.containerNum.value)=="")
       {
         alert("請輸入貨櫃編號！");
         return;
       } 
     }
   containerNum = "containerNum";
   matchStatus="matchStatus";
 
  }

 

   document.confirm.submit();
}
</SCRIPT>


<form action="GUpdateStatusConfirm.jsp"  name="confirm"  method="post">

<input type="hidden" name="companyId" value="<%=companyId%>">
<input type="hidden" name="companyName" value="<%=companyName%>">
<input type="hidden" name="truckerName" value="<%=truckerName%>">
<input type="hidden" name="matchNumber" value="<%=matchNumber%>">
<input type="hidden" name="hkPlateNo" value="<%=hkPlateNo%>">
<input type="hidden" name="deliveryDate" value="<%=deliveryDate%>">
<input type="hidden" name="deliveryTimeId" value="<%=deliveryTimeId%>">
<input type="hidden" name="orderByField" value="<%=orderByField%>">




  <p><font face="Arial, Helvetica, sans-serif">未結/未付配對記錄列表</font></p>
  <table border="1" width="100%">
    <tr> 
      <td><font size="2" width="10%">配對編號</font></td>
      <td><font size="2" width="10%">送貨要求編號</font></td>
      <td><font size="2" width="10%">登記空車編號</font></td>
      <td><font size="2" width="10%">貨櫃車司機姓名</font></td>
      <td><font size="2" width="10%">送貨日期</font> <font
        size="2">送貨時間</font> </td>
      <td><font size="2" width="10%">車牌號碼</font></td>
      <td><font size="2" width="10%">貨櫃編號</font></td>
      <td><font size="2" width="10%">落貨紙/提貨單</font></td>
      <td><font size="2" width="18%">狀況更新</font></td>
    </tr>

<%

      String containerNum="containerNum";
      String matchStatus="matchStatus";
      String shippingOrderNo="shippingOrderNo";
      String num = String.valueOf(matchList.size());
      session.removeAttribute("matchList");
      session.setAttribute("matchList",matchList);
     for (int i = 0;  (!matchList.isEmpty()) && i < matchList.size(); i++) {
        mcrm = (MatchModel)matchList.get(i);
     
%>

    <tr> 
      <td rowspan="2"><%=mcrm.getMatchNum()%>&nbsp;</td>
      <td rowspan="2"><%=mcrm.getDeliveryRequestNum()%>&nbsp;</td>
      <td rowspan="2"><%=mcrm.getTruckCapacityNum()%>&nbsp;</td>
      <td rowspan="2"><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),"CN")%>&nbsp;</td>
      <td rowspan="2"><%=mcrm.getTruckCapacityModel().getDeliveryDate().toString().substring(0,10)%>&nbsp;<%=dbList.getDeliveryTimeDesc(mcrm.getTruckCapacityModel().getDeliveryTimeId(),"CN")%>&nbsp;</td>
      <td rowspan="2"><%=dbList.getTruckerHKPlate(mcrm.getTruckCapacityModel().getTruckerId())%>&nbsp;</td>
      <td rowspan="2"> 
        <input type="text" size="20" name="<%=containerNum+String.valueOf(i)%>" value="<%=mcrm.getContainerNum()%>"  maxlength="40">
      </td>
      <td rowspan="2"> 
      <%=mcrm.getDeliveryRequestModel().getShippingOrderNo()%>&nbsp;
      </td>

        <input type="hidden"  name="<%=shippingOrderNo+String.valueOf(i)%>" value="<%=mcrm.getDeliveryRequestModel().getShippingOrderNo()%>"  >

<% String status=mcrm.getMatchStatus();
 String check=null;
  if ((CbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED).equalsIgnoreCase(status))
   check="checked";
%>      
    
   <td> 
        <input type="radio" <%=check%> name="<%=matchStatus+String.valueOf(i)%>" value="<%=CbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED%>" >
        已送貨</td>
    </tr>
<% 
 check=null;
  if ((CbtbConstant.MATCH_STATUS_CONTAINER_PICKUP).equalsIgnoreCase(status))
  check="checked";
%> 
    <tr> 
      <td>
        <input type="radio" <%=check%> name="<%=matchStatus+String.valueOf(i)%>" value="<%=CbtbConstant.MATCH_STATUS_CONTAINER_PICKUP%>"  >
        已裝箱 
      </td>
    </tr>

<%}%>

  </table>

    
  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
    <tr> 
      <td width="85%" class="unnamed1">
          <%
          if (pagSjf.getPageNo() > 1)
          {
            %>
   <a href="GUpdateStatus.jsp?type=F&init=p">第一頁</a> 
   <a href="GUpdateStatus.jsp?type=P&init=p">上一頁</a> 
          <%
          }
          if (pagSjf.getPageNo() < pagSjf.getPageSum())
          {
            %>
   <a href="GUpdateStatus.jsp?type=N&init=p">下一頁</a> 
   <a href="GUpdateStatus.jsp?type=E&init=p">最後一頁</a> 
          <%
          }
          %>
      <td width="80" class="unnamed1"> 
        <div align="right">第<%=pagSjf.getPageNo()%>頁&nbsp; 總數：<%=pagSjf.getPageSum()%>頁</div>
      </td>
    </tr>
  </table>
<input type="hidden" name="pageNum" value="<%=pagSjf.getPageNo()%>">

  <p>
    <input type="button" name="B12" value="提交"  onClick="javascript:doCheck()">
    <input
    type="reset" name="B2" value="重設">
  </p>
</form>

<%
}%>
  <p align="left">&nbsp;</p>

</body>

</html>








