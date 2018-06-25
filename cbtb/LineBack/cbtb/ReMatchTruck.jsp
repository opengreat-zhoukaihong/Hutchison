<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="truckCapacityModel" scope="application" class="com.cbtb.model.TruckCapacityModel"/>
<jsp:useBean id="utilTool" scope="application" class="com.cbtb.util.UtilTool"/>
<jsp:useBean id="drm" scope="page" class="com.cbtb.model.DeliveryRequestModel"/>
<jsp:useBean id="pagTruck" scope="session"  class="com.cbtb.util.NewPagination"/>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  String language="CN";
  CompanyManager cm = webOperator.getCompanyManager();
  String bothShow=request.getParameter("threeShow");
  String originCityId="";
  String destinationCityId="";
  String deliveryDate="";
  String deliveryTimeId="";
  String truckCapacityNum="";
  String companyName="";
  String trailerId="";
  String orderByName="";
  String truckerName="";
  originCityId=request.getParameter("originCityId");
  destinationCityId=request.getParameter("destinationCityId");
  deliveryDate=request.getParameter("deliveryDate");
  deliveryTimeId=request.getParameter("deliveryTimeId");
  truckCapacityNum=request.getParameter("truckNumber");
  companyName=request.getParameter("companyName");
  trailerId=request.getParameter("trailerId");
  orderByName=request.getParameter("orderByName");
  ArrayList matchTruck=new ArrayList();
  String init=request.getParameter("matchInit");
  String deliveryRequestNum=request.getParameter("deliveryRequestNum");
  String change=request.getParameter("d_change");
  String oldTruckNo=request.getParameter("oldTruckNo");
  if(oldTruckNo==null)
    oldTruckNo="";
  if(deliveryRequestNum==null)
    deliveryRequestNum="";
  if( change!=null)
   {
   if(deliveryRequestNum.trim().length()!=0)
    {
     drm=cm.findDeliveryRequest(deliveryRequestNum);
       originCityId=drm.getOriginCityId();
       destinationCityId=drm.getDestinationCityId();
       deliveryDate=drm.getDeliveryDate().toString();
       deliveryDate=deliveryDate.substring(0,10);
       deliveryTimeId=drm.getTimeId();
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
     alert("請選擇空車編號");
     return;
     }
    matchUpdate.action="rematch.jsp?type=match&whereFrom=T"
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
   matchUpdate.action="ReMatchTruck.jsp"
   matchUpdate.submit();
  }
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>根據空車配對</td>
    <td>
      <div align="right"><a
href="JavaScript:history.back()"><font color="#003366">關閉</font></a></div>
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
<form action="MatchTruck.jsp" method="POST" name="matchUpdate">

<table border="0" width="98%" cellpadding="0" cellspacing="0">
  <tr>
        <td>空車編號：</td>
        <td>運輸公司名稱：</td>
        <td>出發地城市：</td>
        <td>目的地城市：</td>
        <td>排序：</td>
    </tr>
    <tr>
        <td>
      <input type="text" size="10" name="truckNumber" maxlength="10" value="<%=request.getParameter("truckNumber")%>">
    </td>
        <td>
      <input type="text" size="20" name="companyName" maxlength="20" value="<%=request.getParameter("companyName")%>">
       </td>
        <td>
      <select name="originCityId"  size="1">
        <%=dbList.getCityList(originCityId,language)%>
      </select>
        <td>
      <select name="destinationCityId" size="1">
        <%=dbList.getCityList(destinationCityId,language)%>
        </select></td>
        <td>
      <select name="orderByName" size="1">
        <option value="Any">按默認順序</option>
        <option value="Company_Id">按公司編號</option>
        <option value="Truck_Capacity_Num">按空車編號</option>
        <option value="Delivery_Date">按送貨日期</option>
        <option value="Delivery_Time_Id">按送貨時間</option>
        <option value="Origin_City_Id">按出發地城市</option>
        <option value="Destination_City_Id">按目的地城市</option>
        </select></td>
    </tr>
    <tr>
        <td>送貨日期：</td>
        <td>送貨時間：</td>
        <td>拖架種類：</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
    <td >
      <input type="text" maxlength="10" size="10" value="<%=deliveryDate%>" name="deliveryDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
     </td>
        <td>
      <select name="deliveryTimeId"  size="1">
       <%=dbList.getDeliveryTimeList(deliveryTimeId,language)%>
      </select></td>
        <td>
      <select name="trailerId" size="1">
       <%=dbList.getTrailerTypeList(trailerId,language)%>
        </select></td>
        <td><input type="button" name="Submit" onClick="JavaScript:doPost(3)" value="查詢">
      <input type="reset" name="Submit2" value="重設">
    </td>

    <td>&nbsp;</td>
    </tr>
</table>
<%



if (!(init==null))
 {

MatchManager matchManager = webOperator.getMatchManager();
%>
<hr>


<table border="1">

    <tr>
        <td>&nbsp;</td>
        <td>登記空車編號</td>
        <td>公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>拖架種類</td>
        <td>司機姓名</td>
    </tr>
  <%
 String type = request.getParameter("type");

  if (type == null  )
   {
   pagTruck.setPageNo(0);
          if(init.equals("yes"))
          {
           pagTruck.setRecords(matchManager.searchTruckCapacity(null,null,originCityId,destinationCityId,deliveryDate,deliveryTimeId,null,null));
           matchTruck =(ArrayList)pagTruck.nextPage();
          }
          else
          {

        
          if(truckCapacityNum.trim().length()==0)
           truckCapacityNum=null;
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
          if(trailerId.equals("Any"))
           trailerId=null;
          if(orderByName.equals("Any"))
           orderByName=null;
           pagTruck.setRecords(matchManager.searchTruckCapacity(truckCapacityNum,companyName,originCityId,destinationCityId,deliveryDate,deliveryTimeId,trailerId,orderByName));
           matchTruck =(ArrayList)pagTruck.nextPage();
         }
        }
     else
        {
         if (type.equals("N"))
             {
              matchTruck=null;
              matchTruck = (ArrayList)pagTruck.nextPage();
             }
         else if (type.equals("P"))
             {
              matchTruck = new ArrayList(pagTruck.previousPage());
             }
         else if (type.equals("F"))
             {
              matchTruck =new ArrayList(pagTruck.firstPage());
             }
         else if (type.equals("E"))
             {
              matchTruck =new ArrayList(pagTruck.endPage());
             }
         else if (type.equals("T"))
             {
               matchTruck =new ArrayList(pagTruck.toPage(Integer.parseInt(request.getParameter("page"))));
             }
 }
             for (int i = 0;  (!matchTruck.isEmpty()) && i < matchTruck.size(); i++)
               {

               truckCapacityModel=(TruckCapacityModel)matchTruck.get(i);
               truckCapacityNum=truckCapacityModel.getTruckCapacityNum();
               if(!truckCapacityNum.equals(oldTruckNo))
               {
               companyName=dbList.getCompanyName(truckCapacityModel.getCompanyId(),language);
               originCityId=dbList.getCityDesc(truckCapacityModel.getOriginCityId(),language);
               destinationCityId=dbList.getCityDesc(truckCapacityModel.getDestinationCityId(),language);
               deliveryDate=(truckCapacityModel.getDeliveryDate()).toString().substring(0,10);
               deliveryTimeId=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language);
               trailerId=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language);
               truckerName=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language);
  %>
    <tr>
        <td><input type="radio"   name="truckCapacityNum" onClick="JavaScript:radioClicked()"
        value="<%=truckCapacityNum%>"> </td>
        <td><%=truckCapacityNum%>&nbsp;</td>
        <td><%=companyName%>&nbsp;</td>
        <td><%=originCityId%>&nbsp;</td>
        <td><%=destinationCityId%>&nbsp;</td>
        <td><%=deliveryDate%>&nbsp;</td>
        <td><%=deliveryTimeId%>&nbsp;</td>
        <td><%=trailerId%>&nbsp;</td>
        <td><%=truckerName%></td>
    </tr>
<%
 }}
%>

</table>


<table width="80%" border="0" cellspacing="0" cellpadding="0" height="22" align="left">
  <tr>
    <td width="28%" class="unnamed1">
          <%
          if (pagTruck.getPageNo() > 1)
          {
            %>
      <div align="left"><a href="ReMatchTruck.jsp?type=F&matchInit=tmd"><font color="#003366">第一頁</font></a> <a href="ReMatchTruck.jsp?type=P&matchInit=tmd"><font color="#003366">上一頁</font></a>
          <%
          }
          if (pagTruck.getPageNo() < pagTruck.getPageSum())
          {
            %>
        <a href="ReMatchTruck.jsp?type=N&matchInit=tmd"><font color="#003366">下一頁</font></a> <a href="ReMatchTruck.jsp?type=E&matchInit=tmd"><font color="#003366">最後一頁</font></a>
          <%
          }
          %>
      </div>
    <td width="45%" class="unnamed1">&nbsp;
    <td width="17%" class="unnamed1">
      <div align="right"><font color="#003366">第<%=pagTruck.getPageNo()%>頁&nbsp;總數:<%=pagTruck.getPageSum()%>頁</font></div>
    </td>
  </tr>
</table>
  <p>&nbsp;</p>
  <br>
<input type="button" name="button" onClick="JavaScript:doPost(2)" value="配對">
<input type="reset" value="取消">

<%
}
%>
<input type="hidden" name="check" value="0">
<input type="hidden" name="matchInit" value="notfirst">
<input type="hidden" name="t_change" value="MatchView.jsp">
<input type="hidden" name="deliveryRequestNum" value="<%=deliveryRequestNum%>">
<input type="hidden" name="oldTruckNo" value="<%=oldTruckNo%>">
<input type="hidden" name="bothShow" value="<%=bothShow%>">
<p>&nbsp;</p>
</form>
</body>

</html>