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
<script language="javascript" src="../js/JsLib.js"></script>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.*" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.util.CbtbConstant" %>
<%@ page import="com.cbtb.model.DeliveryRequestModel" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination"/>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "search");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script language="javascript">
<!--
   function doPost(){
     if(RemoveSpace(search.deliveryDate.value) != "")
     {
      if(!isDate(search.deliveryDate.value))
      {
         alert("日期不合法或格式不為(YYYY-MM-DD)!");
         search.deliveryDate.focus();
         return;
      }
     }
     search.submit();
  }
//-->
</script>

</head>
<%
  String loginCompanyId = "A000001";
  String sMarkLanguage = "CH";
%>
<script src=../js/calendarShow.js></script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
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
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>貨運市集</b></font></font></td>
    <td>
      <div align="right"><a href="indexShipping.jsp"><font
color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<form method="post"  name = "search" action="ShipperDeliveryMarket.jsp">
<input type="hidden" name="init" value="notfirst">

  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>

    <td><font size="2">出發地城市：</font></td>
        <td>
        <select name="originCityId">
        <%=dbList.getCityList("",sMarkLanguage)%>
        </select>
        </td>

    <td><font size="2">目的地城市：</font></td>
        <td>
        <select name="destinationCityId">
        <%=dbList.getCityList("",sMarkLanguage)%>
        </select>
        </td>

    <td><font size="2">日期： </font></td>
         <td ><input type="text" maxlength="10" size="10"  name="deliveryDate"  >
		<img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"  onClick="fPopUpCalendarDlg(deliveryDate);return false" >　
        </td>
        <td><font size="2">時間： </font></td>
        <td><font size="2"> <select name="timeId">
              <%=dbList.getDeliveryTimeList("",sMarkLanguage)%>
            </select></font>
       </td>
    </tr>
    <tr>

    <td><font size="2">貨櫃種類：</font></td>
       <td>
        <select name="containerId">
        <%=dbList.getContainerTypeList("",sMarkLanguage)%>
        </select>
        </td>

    <td><font size="2">排序：</font></td>
    <%
        if( sMarkLanguage == "" )
        {
     %>
        <td><select name="orderByName" size="1">
              <option value="COMPANY_ID">Shipper ID</option>
              <option value="CARGO_ID">Cargo Category</option>
              <option value="ORIGIN_CITY_ID">Origin City</option>
              <option value="DESTINATION_CITY_ID">Destination City</option>
              <option value="REQUEST_CONTAINER_ID">Container Type</option>
              <option value="DELIVERY_DATE">Delivery Date</option>
              <option value="DELIVERY_TIME_ID">Delivery Time</option>
              <option value="Any" selected>No Preference</option>
            </select>
         </td>
     <%
         }
         else
             {
     %>
              <td><select name="orderByName" size="1">
                    <option value="COMPANY_ID">公司編號</option>
                    <option value="CARGO_ID">貨物種類</option>
                    <option value="ORIGIN_CITY_ID">出發地城市</option>
                    <option value="DESTINATION_CITY_ID">目的地城市</option>
                    <option value="REQUEST_CONTAINER_ID">貨物種類</option>
                    <option value="DELIVERY_DATE">發貨日期</option>
                    <option value="DELIVERY_TIME_ID">發貨時閒</option>
                    <option value="Any" selected>按默認順序</option>
                  </select>
             </td>
       <%
          }
       %>
   <td><a href="javascript:doPost()"><img src="../images/search.jpg" width="44" height="19" border="0"></a></td>
   <td><a href="javascript:search.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a></td>
     </tr>
</table>

<%
 String init=request.getParameter("init");
 if (init!=null)
 {
  String orderByName = null;
  String originCityId = null;
  String deliveryDate = null;
  String timeId = null;
  String destinationCityId = null;
  String containerId = null;
  ArrayList deliverys = new ArrayList();
  String type = request.getParameter("type");
  int i=0;
%>
<hr>
  <table cellpadding="4" cellspacing="" width="98%" align="center">
    <tr bgcolor="e0e0e0">
        <td>狀況</td>
        <td height="28">付貨人編號</td>
        <td>貨物種類</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>貨櫃種類</td>
        <td>送貨日期</td>
        <td>送貨時閒</td>
    </tr>
 <%
  if (type == null  )
  {
    if (request.getParameter("orderByName").trim().equals("Any"))
       orderByName = null;
    else
       orderByName = request.getParameter("orderByName").trim();

    if (request.getParameter("originCityId").trim().equals("Any"))
       originCityId = null;
    else
       originCityId = request.getParameter("originCityId").trim();

    if (request.getParameter("deliveryDate").trim().length() > 0)
       deliveryDate = request.getParameter("deliveryDate").trim();
    else
       deliveryDate = null;

    if (request.getParameter("timeId").trim().equals("Any"))
       timeId = null;
    else
       timeId = request.getParameter("timeId").trim();

    if (request.getParameter("destinationCityId").trim().equals("Any"))
       destinationCityId = null;
    else
       destinationCityId = request.getParameter("destinationCityId").trim();

    if (request.getParameter("containerId").trim().equals("Any"))
       containerId = null;
    else
       containerId = request.getParameter("containerId").trim();

    CompanyManager companyManager = webOperator.getCompanyManager();
    newPagination.setPageNo(0);
    newPagination.setRecords((Collection)companyManager.searchDeliveryRequest(null,null,null,originCityId,null,destinationCityId,null,containerId,deliveryDate,null,timeId,null,null,orderByName));
    //newPagination.setRecords(deliveryList);
    deliverys =(ArrayList)newPagination.nextPage();
  }
  else
     {
       if (type.equals("N"))
       {
          deliverys = (ArrayList)newPagination.nextPage();
       }
       else if (type.equals("P"))
            {
             deliverys = new ArrayList(newPagination.previousPage());
             }
             else if (type.equals("F"))
                  {
                    deliverys =new ArrayList(newPagination.firstPage());
                  }
                  else if (type.equals("E"))
                       {
                          deliverys = (ArrayList)newPagination.endPage();
                       }
                       else if (type.equals("T"))
                           {
                              deliverys =new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
                            }
      }

      DeliveryRequestModel deliveryRequestModel = new DeliveryRequestModel();
      for(i=0;(!deliverys.isEmpty())&&(i<deliverys.size());i++)
      {
        deliveryRequestModel = (DeliveryRequestModel)deliverys.get(i);
        if((i+1) % 2 == 0)
          {
             out.println("<tr bgcolor='#ddffdd'>");
          }
          else
              {
                out.println("<tr>");
              }
        %>
        <%
            if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_MATCH))
            {
        %>
             <td><font color="#FF0000"><%=dbList.getDeliveryStatusDesc(deliveryRequestModel.getRequestStatus(),sMarkLanguage) %>&nbsp;</td>
        <%
            }
            else
               {
        %>
                <td><%= dbList.getDeliveryStatusDesc(deliveryRequestModel.getRequestStatus(),sMarkLanguage) %>&nbsp;</td>
        <%
               }
        %>
<%
/**
*AmendId:01
*/
%>
             <td><%=deliveryRequestModel.getCompanyId() %>&nbsp</td>
             <td><%=dbList.getCargoCategoryDesc(deliveryRequestModel.getCargoId(),sMarkLanguage)%></td>
             <td><%=dbList.getCityDesc(deliveryRequestModel.getOriginCityId(),sMarkLanguage)%></td>
             <td><%=dbList.getCityDesc(deliveryRequestModel.getDestinationCityId(),sMarkLanguage)%></td>
             <td><%=dbList.getContainerTypeDesc(deliveryRequestModel.getContainerTypeId(),sMarkLanguage)%></td>
             <td><%=deliveryRequestModel.getDeliveryDate().toString().substring(0,10) %></td>
             <td><%=dbList.getDeliveryTimeDesc(deliveryRequestModel.getTimeId(),sMarkLanguage)%></td>
          </tr>
       <%
         } //end for
%>

</table>
</form>
    <table width="90%"  cellspacing="0" cellpadding="4" align="center">
       <tr>
          <td width="81%" class="unnamed1">
          <%
            if (newPagination.getPageNo() > 1)
            {
          %>
             <a href="ShipperDeliveryMarket.jsp?type=F&init=tmd"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>
             <img src="../images/good.jpg" width="20" height="10"><a href="ShipperDeliveryMarket.jsp?type=P&init=tmd"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>
          <%
           }
           if (newPagination.getPageNo() < newPagination.getPageSum())
           {
         %>
            <img src="../images/good.jpg" width="20" height="10"><a href="ShipperDeliveryMarket.jsp?type=N&init=tmd"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a><img src="../images/good.jpg" width="20" height="10"><a href="ShipperDeliveryMarket.jsp?type=E&init=tmd"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>
        <%
           }
        %>
       </td>
     <td width="19%" class="unnamed1">
       <div align="right"><font color="#003366">第<%=newPagination.getPageNo()%>頁&nbsp;總數：<%=newPagination.getPageSum()%>頁</font></div>
     </td>
   </tr>
  </table>
<%
  }
%>
</form>
<hr>
<%@ include file = "../include/end.jsp" %>
</body>
</html>