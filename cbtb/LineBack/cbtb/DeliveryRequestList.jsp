<!--   remove some  columns       --!>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%> 
<%@ page import="com.cbtb.model.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestModelList" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<%
  webOperator.clearPermissionContext();  
  webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
  if (webOperator.checkPermission())
    out.print("");
  else
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
   

   String sMarkLanguage = "CH";
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp" %>
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
    <td height="11">貨運要求列表</td>
    <td height="11"> 
      <div align="right"><font color="#003366"><a href="DeliveryRequestSearch.jsp">關閉</a></font></div>
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

<table border="1" width="100%">
<!--   remove some  columns       --!>
    <tr>
        <td>送貨要求號碼</td>
        <td>付貨人編號</td>
        <td>公司名稱</td>
        <td>航運公司</td>
        <td>貨物種類</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>貨櫃種類</td>
        <td>送貨日期</td>
        <td>送貨時閒</td>
    </tr>
    
    <%
    String companyId=null,matchNumber=null,originZoneId=null,originCityId=null,destinationZoneId=null,destinationCityId=null,requestStatus=null;
    String containerTypeId=null,deliveryDate=null,deliveryNum=null,deliveryTime=null,timeSlotId=null,shippingOrderNo=null, orderByName=null;
    String type = request.getParameter("type");
    String sqlString = "";
    int i = 0;
    int iMarkNumber = 0;
    ArrayList arrayList = new ArrayList();
    Vector vectors =new Vector();
    try{ 
        if (type == null  )
        {   
	  if(request.getParameter("companyId").trim().length() > 0){
            companyId = request.getParameter("companyId").trim();
          }
          else
              companyId = null;

          if(request.getParameter("matchNumber").trim().length() > 0){
             matchNumber = request.getParameter("matchNumber").trim();
          }
          else
              matchNumber =  null;

          if(!request.getParameter("originZoneId").equals("Any")){
             originZoneId = request.getParameter("originZoneId").trim();
          } 
          else
              originZoneId = null;

          if(!request.getParameter("originCityId").equals("Any")){
	    originCityId =  request.getParameter("originCityId").trim();
          }
          else
               originCityId = null;
          if(!request.getParameter("destinationZoneId").equals("Any")){
	     destinationZoneId =  request.getParameter("destinationZoneId").trim();
          }
          else
              destinationZoneId =  null;
          if(!request.getParameter("destinationCityId").equals("Any")){
             destinationCityId =  request.getParameter("destinationCityId");
          }
          else
              destinationCityId  =  null;
        
          if(!request.getParameter("requestStatus").equals("Any")){
            requestStatus  =  request.getParameter("requestStatus");
          } 
          else
              requestStatus  =  null;
       
          if(!request.getParameter("containerTypeId").equals("Any")){
	     containerTypeId =  request.getParameter("containerTypeId");
          }
          else
               containerTypeId = null;
        
         if(request.getParameter("deliveryDate").trim().length() > 0){
	   deliveryDate = request.getParameter("deliveryDate");
         }
         else
             deliveryDate =  null; 
         if(request.getParameter("deliveryRequestNum").trim().length() > 0){
	   deliveryNum = request.getParameter("deliveryRequestNum");
         }
         else
             deliveryNum =  null; 
         if(!request.getParameter("deliveryTime").equals("Any")){
	   deliveryTime = request.getParameter("deliveryTime").trim();
         }
         else
             deliveryTime =  null; 
         if(!request.getParameter("timeSlotId").equals("Any")){
	   timeSlotId = request.getParameter("timeSlotId").trim();
         }
         else
             timeSlotId =  null; 
         if(request.getParameter("shippingOrderNo").trim().length() > 0){
	   shippingOrderNo = request.getParameter("shippingOrderNo").trim();
         }
         else
             shippingOrderNo =  null;
         if(!request.getParameter("orderByName").equals("Any")){
	   orderByName = request.getParameter("orderByName");
         }
         else
             orderByName  =  null; 
             
             
            newPagination.setPageNo(0);
            newPagination.setRecords((Collection)webOperator.getCompanyManager().searchDeliveryRequest(companyId,matchNumber,originZoneId,originCityId,destinationZoneId,destinationCityId,requestStatus,containerTypeId,deliveryDate,deliveryNum,deliveryTime,timeSlotId,shippingOrderNo, orderByName));       
 //     newPagination.setRecords((Collection)webOperator.getCompanyManager().searchDeliveryRequest(null,null,null,null,null,null,null,null,null,"DR00000051",null,null,null, null));       
            arrayList =(ArrayList)newPagination.nextPage();
        }
        else
        {
              if (type.equals("N"))
              { 
                    arrayList = null;
                    arrayList = (ArrayList)newPagination.nextPage();
              }
              else if (type.equals("P"))
                   {
                    arrayList = new ArrayList(newPagination.previousPage());
                   }
                   else if (type.equals("F"))
                        {
                         arrayList =new ArrayList(newPagination.firstPage());
                        }
                       else if (type.equals("E"))
                            {
                              arrayList = new ArrayList(newPagination.endPage());
                            }
                           else if (type.equals("T"))
                                {
                                  arrayList = new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
                                }
           }

           for(i = 0;(!arrayList.isEmpty()) && (i < arrayList.size());i++)
           {
               deliveryRequestModelList = (DeliveryRequestModel)arrayList.get(i);
               String s_status = deliveryRequestModelList.getRequestStatus();
               String RequestNum = deliveryRequestModelList.getDeliveryRequestNum();
            
       %>    
         
      <tr>
        <td><a href="DeliveryRequestView.jsp?path=self&deliveryRequestNum=<%= RequestNum  %>"><%= RequestNum  %></a></td>
        <td><a href="RegistrationShipperView.jsp?companyId=<%= deliveryRequestModelList.getCompanyId() %>"><%= deliveryRequestModelList.getCompanyId() %></a>&nbsp;</td>
        <td><%= dbList.getCompanyName(deliveryRequestModelList.getCompanyId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getShippingLineDesc(deliveryRequestModelList.getShippingLineId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getCargoCategoryDesc(deliveryRequestModelList.getCargoId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getCityDesc(deliveryRequestModelList.getOriginCityId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getCityDesc(deliveryRequestModelList.getDestinationCityId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getContainerTypeDesc(deliveryRequestModelList.getContainerTypeId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= deliveryRequestModelList.getDeliveryDate().toString().substring(0,10) %>&nbsp;</td>
        <td><%= dbList.getDeliveryTimeDesc(deliveryRequestModelList.getTimeId(),sMarkLanguage) %>&nbsp;</td>
      </tr>
      <%
           }
      }
      catch(Exception e){
      }
  %>
  </table>  
  <table width="750" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="75%" class="unnamed1"> 
          <%
          if (newPagination.getPageNo() > 1)
          {
            %>
          <a href="DeliveryRequestList.jsp?type=F&init=tmd" class="unnamed1">第一頁</a>&nbsp;<a href="DeliveryRequestList.jsp?type=P&init=tmd">前一頁</a> 
          <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
            %>
          &nbsp;<a href="DeliveryRequestList.jsp?type=N&init=tmd">後一頁</a>&nbsp;<a href="DeliveryRequestList.jsp?type=E&init=tmd">最後一頁</a> 
          <%
          }
          %>
          </td>     
      
        <td width="25%" class="unnamed1">
          <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp;&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
        </td>
      </tr>
  </table>
  
 </body>
 
</html>
