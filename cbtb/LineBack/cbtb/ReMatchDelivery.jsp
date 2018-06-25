<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryRequestModel" scope="page" class="com.cbtb.model.DeliveryRequestModel"/>
<jsp:useBean id="truckCapacityModel" scope="page" class="com.cbtb.model.TruckCapacityModel"/>
<jsp:useBean id="pagDelivery" scope="session"  class="com.cbtb.util.NewPagination"/>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  CompanyManager cm = webOperator.getCompanyManager();
    String bothShow=request.getParameter("threeShow");
  String language="CN";
  String originCityId="";
  String destinationCityId="";
  String deliveryDate="";
  String deliveryTimeId="";
  String deliveryRequestNum="";
  String companyName="";
  String containerTypeId="";
  String orderByName="";
  ArrayList matchTruck=new  ArrayList();
  deliveryRequestNum=request.getParameter("deliveryNumber");
  companyName=request.getParameter("companyName");
  originCityId=request.getParameter("originCityId");
  destinationCityId=request.getParameter("destinationCityId");
  deliveryDate=request.getParameter("deliveryDate");
  deliveryTimeId=request.getParameter("deliveryTimeId");
  containerTypeId=request.getParameter("containerTypeId");
  orderByName=request.getParameter("orderByName");
  String change=request.getParameter("t_change");
  String init=request.getParameter("deliveryInit");
  String truckCapacityNum=request.getParameter("truckCapacityNum");
  String oldDeliveryNo=request.getParameter("oldDeliveryNo");  
  if(oldDeliveryNo==null)
     oldDeliveryNo="";  
  if(truckCapacityNum==null)
     truckCapacityNum="";

if( change!=null)
 {
 if(truckCapacityNum.trim().length()!=0)
  {

   truckCapacityModel=cm.findTruckCapacity(truckCapacityNum);
     originCityId=truckCapacityModel.getOriginCityId();
     destinationCityId=truckCapacityModel.getDestinationCityId();
     deliveryDate=truckCapacityModel.getDeliveryDate().toString();
     deliveryDate=deliveryDate.substring(0,10);
     deliveryTimeId=truckCapacityModel.getDeliveryTimeId();
     init="yes";
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

<SCRIPT LANGUAGE="JavaScript">
function radioClicked()
 {
  matchUpdate.check.value="1";
 }
function doPost(i)
{

  if(i==2)
   {
    if(matchUpdate.check.value!="1")
    {
     alert("請選擇送貨要求編號");
     return;
     }

    matchUpdate.action="rematch.jsp?type=match&whereFrom=D"
    matchUpdate.submit();
   }
  if(i==3)
  {
  if(!isDate(matchUpdate.deliveryDate.value) && matchUpdate.deliveryDate.value!=0)
   {
	alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
	matchUpdate.deliveryDate.focus();
	return;
   }
   matchUpdate.action="ReMatchDelivery.jsp"
   matchUpdate.submit();
  }
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>根據送貨要求配對</td>
    <td>
      <div align="right"><a
href="MatchFunctionList.jsp"><font color="#003366">關閉</font></a><a href="matching_list.htm"></a></div>
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
<form method="POST" name="matchUpdate" >
    <table border="0" width="90%">
        <tr>
            <td>要求編號：</td>
            <td>付貨人名稱：</td>
            <td>出發地城市：</td>
            <td>目的地城市：</td>
            <td>排序：</td>
        </tr>
        <tr>

      <td>
        <input type="text" size="10" name="deliveryNumber" maxlength="10" value="<%=request.getParameter("deliveryNumber")%>">
      </td>
            <td>
        <input type="text" size="20" name="companyName" maxlength="20" value="<%=request.getParameter("companyName")%>">
         </td>
            <td>
      <select name="originCityId" size="1">
        <%=dbList.getCityList(originCityId,language)%>
      </select>
        <td>
      <select name="destinationCityId" size="1">
        <%=dbList.getCityList(destinationCityId,language)%>
        </select></td>
            <td>
        <select name="orderByName" size="1">
          <option>要求編號</option>
                <option value="Any" selected>按默認順序</option>
                <option value="Company_Id">按公司編號</option>
                <option value="Delivery_Request_Num">按送貨要求編號</option>
                <option value="Delivery_Date">按送貨日期</option>
                <option value="Origin_City_Id">按出發地城市</option>
                <option value="Destination_City_Id">按目的地城市</option>
            </select> </td>
        </tr>
        <tr>
            <td>送貨日期：</td>
            <td>送貨時間：</td>
            <td>貨櫃種類：</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
    <td >
        <input type="text" maxlength="10" size="10" value="<%=deliveryDate%>" name="deliveryDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
     </td>
            <td>
      <select name="deliveryTimeId" size="1">
       <%=dbList.getDeliveryTimeList(deliveryTimeId,language)%>
      </select></td>
        <td>
      <select name="containerTypeId" size="1">
       <%=dbList.getContainerTypeList(containerTypeId,language)%>
        </select></td>
            <td><input type="button" onClick="JavaScript:doPost(3)" name="button" value="查詢">
        <input type="reset" name="B13" value="重設">
      </td>

      <td>&nbsp;</td>
        </tr>
    </table>

<hr>
<%

if (!(init==null))
 {

MatchManager matchManager = webOperator.getMatchManager();
%>

<table border="1">
    <tr>
        <td>&nbsp;</td>
        <td>送貨要求編號</td>
        <td>付貨人名稱</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>貨櫃種類</td>
        <td>航運公司</td>
    </tr>
  <%
   String type = request.getParameter("type");

  if (type == null  )
   {
   pagDelivery.setPageNo(0);
  if(init.equals("yes"))
  {
   pagDelivery.setRecords(matchManager.searchDeliveryRequest(null,null,originCityId,destinationCityId,deliveryDate,deliveryTimeId,null,null));
   matchTruck =(ArrayList)pagDelivery.nextPage();
  }
  else
  {

  if(deliveryRequestNum.trim().length()==0)
   deliveryRequestNum=null;
  if(companyName.trim().length()==0)
   companyName=null;
  if(originCityId.equals("Any"))
   originCityId=null;
  if(destinationCityId.equals("Any"))
   destinationCityId=null;
  if(deliveryDate.trim().length()==0)
   deliveryDate=null;
  if(deliveryTimeId.equals("Any"))
   deliveryTimeId=null;
  if(containerTypeId.equals("Any"))
   containerTypeId=null;
  if(orderByName.equals("Any"))
    orderByName=null;

   pagDelivery.setRecords(matchManager.searchDeliveryRequest(deliveryRequestNum,companyName,originCityId,destinationCityId,deliveryDate,deliveryTimeId,containerTypeId,orderByName));
   matchTruck =(ArrayList)pagDelivery.nextPage();
    }
   }
     else
        {
         if (type.equals("N"))
             {
              matchTruck=null;
              matchTruck = (ArrayList)pagDelivery.nextPage();
             }
         else if (type.equals("P"))
             {
              matchTruck = new ArrayList(pagDelivery.previousPage());
             }
         else if (type.equals("F"))
             {
              matchTruck =new ArrayList(pagDelivery.firstPage());
             }
         else if (type.equals("E"))
             {
              matchTruck =new ArrayList(pagDelivery.endPage());
             }
         else if (type.equals("T"))
             {
               matchTruck =new ArrayList(pagDelivery.toPage(Integer.parseInt(request.getParameter("page"))));
             }
 }
             for (int i = 0;  (!matchTruck.isEmpty()) && i < matchTruck.size(); i++)
               {
               deliveryRequestModel=(DeliveryRequestModel)matchTruck.get(i);
               deliveryRequestNum=deliveryRequestModel.getDeliveryRequestNum();
               if(!deliveryRequestNum.equals(oldDeliveryNo))
               {               
               companyName=dbList.getCompanyName(deliveryRequestModel.getCompanyId(),language);
               originCityId=dbList.getCityDesc(deliveryRequestModel.getOriginCityId(),language);
               destinationCityId=dbList.getCityDesc(deliveryRequestModel.getDestinationCityId(),language);
               if(deliveryRequestModel.getDeliveryDate()==null)
                deliveryDate="";
               else
                deliveryDate=(deliveryRequestModel.getDeliveryDate()).toString();
                deliveryDate=deliveryDate.substring(0,10);
               
               String shippingLineName=dbList.getShippingLineDesc(deliveryRequestModel.getShippingLineId(),language);
               deliveryTimeId=dbList.getDeliveryTimeDesc(deliveryRequestModel.getTimeId(),language);
               containerTypeId=dbList.getContainerTypeDesc(deliveryRequestModel.getContainerTypeId(),language);
  %>
    <tr>
        <td><input type="radio"  name="deliveryRequestNum" onClick="JavaScript:radioClicked()"
        value="<%=deliveryRequestNum%>"> </td>
        <td><%=deliveryRequestNum%>&nbsp;</td>
        <td><%=companyName%>&nbsp;</td>
        <td><%=deliveryDate%>&nbsp;</td>
        <td><%=deliveryTimeId%>&nbsp;</td>
        <td><%=originCityId%>&nbsp;</td>
        <td><%=destinationCityId%>&nbsp;</td>
        <td><%=containerTypeId%>&nbsp;</td>
        <td><%=shippingLineName%>&nbsp;</td>
    </tr>
<%
 }}
%>

</table>

<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22" align="left">
  <tr>
    <td width="28%" class="unnamed1">
          <%
          if (pagDelivery.getPageNo() > 1)
          {
            %>
      <div align="left"><a href="ReMatchDelivery.jsp?type=F&deliveryInit=tmd"><font color="#003366">第一頁</font></a> <a href="ReMatchDelivery.jsp?type=P&deliveryInit=tmd"><font color="#003366">上一頁</font></a>
          <%
          }
          if (pagDelivery.getPageNo() < pagDelivery.getPageSum())
          {
            %>
        <a href="ReMatchDelivery.jsp?type=N&deliveryInit=tmd"><font color="#003366">下一頁</font></a> <a href="ReMatchDelivery.jsp?type=E&deliveryInit=tmd"><font color="#003366">最後一頁</font></a>
          <%
          }
          %>
      </div>
    <td width="55%" class="unnamed1">&nbsp;
    <td width="17%" class="unnamed1">
      <div align="right"><font color="#003366">第<%=pagDelivery.getPageNo()%>頁&nbsp;總數:<%=pagDelivery.getPageSum()%>頁</font></div>
    </td>
  </tr>
</table>
  <br>
<p align="left">&nbsp;</p>
<input type="button" name="button" onClick="JavaScript:doPost(2)" value="配對">
<input type="reset" value="取消">

<%
}
%>
<input type="hidden" name="check" value="0">
<input type="hidden" name="deliveryInit" value="notfirst">
<input type="hidden" name="truckCapacityNum" value="<%=truckCapacityNum%>">
<input type="hidden" name="d_change" value="ReMatchDelivery.jsp">
<input type="hidden" name="oldDeliveryNo" value="<%=oldDeliveryNo%>">
<input type="hidden" name="bothShow" value="<%=bothShow%>">

  </form>
</body>

</html>