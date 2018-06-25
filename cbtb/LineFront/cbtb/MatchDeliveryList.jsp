<%--
/**
 * AmendDate:2001/06/22
 * Author:T_Liang
 * Reason01:ShipperID column has displayed ShipperID
 * AmendId:01
 */
--%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryRequestModel" scope="page" class="com.cbtb.model.DeliveryRequestModel"/>
<jsp:useBean id="newPagination" scope="session"  class="com.cbtb.util.NewPagination"/>
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>

<%
  String language="CN";
  String companyId="";
  String originCityId="";
  String destinationCityId="";
  String deliveryDate="";
  String deliveryTimeId="";
  String deliveryRequestNum="";
  String companyName="";
  String containerTypeId="";
  String orderByName="";
  String deliveryTimeSlot="";
  String bgColor="#ddffdd";
  ArrayList matchTruck=new  ArrayList();
  String truckCapacityNum=request.getParameter("truckCapacityNum");
  if(truckCapacityNum==null)
     truckCapacityNum="";
  CompanyProfileModel companyProfileModel=new CompanyProfileModel();
  companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
  companyId=companyProfileModel.getCompanyId();
 CompanyManager cm = webOperator.getCompanyManager();
 if(truckCapacityNum.trim().length()!=0)
  {

     TruckCapacityModel truckCapacityModel=new TruckCapacityModel();
     truckCapacityModel=cm.findTruckCapacity(truckCapacityNum);
     originCityId=truckCapacityModel.getOriginCityId();
     destinationCityId=truckCapacityModel.getDestinationCityId();
     deliveryDate=truckCapacityModel.getDeliveryDate().toString();
     deliveryDate=deliveryDate.substring(0,10);
     deliveryTimeId=truckCapacityModel.getDeliveryTimeId();
     deliveryTimeSlot=truckCapacityModel.getDeliveryTimeSlot();
  }
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
function radioClicked()
 {
  matchDeliveryList.check.value="1";
 }
function doPost()
{
    if(matchDeliveryList.check.value!="1")
    {
     alert("請選擇送貨要求編號");
     return;
     }

    matchDeliveryList.action="MatchUpdate.jsp"
    matchDeliveryList.submit();
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/ShiperHead.jsp" %>
</table><table width="75%" border="0" cellspacing="0" cellpadding="0">
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
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852"><font face="Arial, Helvetica, sans-serif" size="2" color="#667852"><b><b></b></b></font></font></b></font></b></font></td>
    <td>
      <div align="right"><a href="FMatch.jsp?truckCapacityNum=<%=truckCapacityNum%>&originCityId=<%=originCityId%>&destinationCityId=<%=destinationCityId%>&deliveryDate=<%=deliveryDate%>&deliveryTimeId=<%=deliveryTimeId%>&deliveryTimeSlot=<%=deliveryTimeSlot%>"><font color="#003366">新建</font></a>&nbsp;|&nbsp;<a href="JavaScript:history.back()"><font
color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<form method="post" name="matchDeliveryList">
 <hr>
  <table cellpadding="4" cellspacing="" width="98%" align="center">
    <tr bgcolor="e0e0e0">
      <td>&nbsp;</td>
      <td height="28">付貨人編號</td>
        <td>貨物種類</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>貨櫃種類</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>狀況</td>
    </tr>
    <%
 String type = request.getParameter("type");
      if (type==null)
       {

           newPagination.setPageNo(0);
           newPagination.setRecords(cm.searchDeliveryRequest(companyId,null,null,originCityId,null,destinationCityId,constant.DELIVERY_REQUEST_POST,null,deliveryDate,null,deliveryTimeId,null,null,null));
           matchTruck =(ArrayList)newPagination.nextPage();
       }
     else if (type.equals("N"))
             {
              matchTruck=null;
              matchTruck = (ArrayList)newPagination.nextPage();
             }
         else if (type.equals("P"))
             {
              matchTruck = new ArrayList(newPagination.previousPage());
             }
         else if (type.equals("F"))
             {
              matchTruck =new ArrayList(newPagination.firstPage());
             }
         else if (type.equals("E"))
             {
              matchTruck =new ArrayList(newPagination.endPage());
             }
         else if (type.equals("T"))
             {
               matchTruck =new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
             }

             for (int i = 0;  (!matchTruck.isEmpty()) && i < matchTruck.size(); i++)
               {
               deliveryRequestModel=(DeliveryRequestModel)matchTruck.get(i);
               deliveryRequestNum=deliveryRequestModel.getDeliveryRequestNum();
               companyName=dbList.getCompanyName(deliveryRequestModel.getCompanyId(),language);
               originCityId=dbList.getCityDesc(deliveryRequestModel.getOriginCityId(),language);
               destinationCityId=dbList.getCityDesc(deliveryRequestModel.getDestinationCityId(),language);
               if(deliveryRequestModel.getDeliveryDate()==null)
                deliveryDate="";
               else
                deliveryDate=(deliveryRequestModel.getDeliveryDate()).toString();
                deliveryDate=deliveryDate.substring(0,10);
               String requestStatus=dbList.getDeliveryStatusDesc(deliveryRequestModel.getRequestStatus(),language);
               String cargoId=dbList.getCargoCategoryDesc(deliveryRequestModel.getCargoId(),language);
               deliveryTimeId=dbList.getDeliveryTimeDesc(deliveryRequestModel.getTimeId(),language);
               containerTypeId=dbList.getContainerTypeDesc(deliveryRequestModel.getContainerTypeId(),language);
               if(bgColor.equals("#ddffdd"))
                  bgColor="";
               else
                  bgColor="#ddffdd";
  %>
    <tr bgcolor="<%=bgColor%>">
    <td >
      <input type="radio"  name="deliveryRequestNum" onClick="JavaScript:radioClicked()"
        value="<%=deliveryRequestNum%>">
    </td>
<%
/**
*AmendId:01
*/
%>
      <td height="28"><%=companyId%></td>
        <td><%=cargoId%></td>
        <td><%=originCityId%></td>
        <td><%=destinationCityId%></td>
        <td><%=containerTypeId%></td>
        <td ><%=deliveryDate%></td>
        <td ><%=deliveryTimeId%></td>
        <td><%=requestStatus%></td>
    </tr>
    <%}%>

</table>
<table width="98%"  cellspacing="0" cellpadding="4" align="center">
  <tr>
    <td width="84%" class="unnamed1">
      <%
      if (newPagination.getPageNo() > 1)
      {
      %>
				<a href="MatchDeliveryList.jsp?type=F&init=1"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="MatchDeliveryList.jsp?type=P&init=1"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      if (newPagination.getPageNo() < newPagination.getPageSum())
      {
      %>
				<a href="MatchDeliveryList.jsp?type=N&init=1"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="MatchDeliveryList.jsp?type=E&init=1"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      %>
				<td width="16%" class="unnamed1">
        <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
    </td>
  </tr>
</table>
<input type="hidden" name="check" value="0">
<input type="hidden" name="truckCapacityNum" value="<%=truckCapacityNum%>">
<p align="left">&nbsp;</p>
<a href="javascript:onclick=doPost()">
	<img src="../images/match.jpg" width="44" height="19" border="0">
</a>
<img src="../images/good.jpg" width="10" height="10">
<a href="javascript:matchDeliveryList.reset()">
	<img src="../images/cancel.jpg" width="44" height="19" border="0">
</a>
<hr>
<%@ include file="../include/end.jsp"%>
</form>
</body>
</html>






