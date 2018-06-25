<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script Language="JavaScript" src="../js/JsLib.js"></script>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.CbtbConstant" %>
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="deliveryRequestModelList" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
  
   webOperator.clearPermissionContext(); 
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "search"); //加入检查的内容
   if (!webOperator.checkPermission())
   {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
   }

   String sMarkLanguage = "CH";
   CompanyProfileModel companyProfileModel=new CompanyProfileModel();
   companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
   String companyId=companyProfileModel.getCompanyId(); 
   String companyName = companyProfileModel.getCompanyChineseName();
   if(companyName == null){
      companyName = dbList.getCompanyName(companyId,sMarkLanguage);
   }
   String rootPath = request.getParameter("rootPath");
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
   <tr> 
      <td><img src="../images/good.jpg" width="10" height="10"></td>
   </tr>
</table>
  
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>查詢貨運紀錄</b></font></font></td>
    <td width="57%"> 
      <div align="right"><a href="indexShipping.jsp"><font color="#003366">關閉</font></a></div>
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

<form name="add" action="DeliveryRequestSearch.jsp" method="post">
<input type="hidden" name="companyId" value="<%= request.getParameter("companyId") %>">
<input type="hidden" name="companyName" value="<%= companyName %>">
<input type="hidden" name="rootPath" value="<%= rootPath %>">

<table border="0" align="center" width="98%"  cellpadding="1" cellspacing="1">
  <tr> 
     <td width="10%">出發地城市：</td>
    <td><select name="originCityId" size="1">
            <%= dbList.getCityList("",sMarkLanguage) %>
        </select>
    </td>
    <td>目的地城市：</td>
    <td><select name="destinationCityId" size="1">
             <%= dbList.getCityList("",sMarkLanguage) %>
        </select>
    </td>
   <td width="17%">貨櫃種類： </td>
   <td><select name="containerTypeId" size="1">
           <%= dbList.getContainerTypeList("",sMarkLanguage) %>
        </select>
   </td>
   </tr>
   <tr> 
    <td width="22%">送貨日期：</td>
    <td width="30%" > 
      <input type="text" maxlength="10" size="10" value="" name="deliveryDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" > 
    </td>
    <td width="17%">送貨時間：</td>
    <td><select name="deliveryTime" size="1">
              <%= dbList.getDeliveryTimeList("",sMarkLanguage) %>
        </select>
    </td>
    <td width="22%">狀況：</td>
    <td><select name="requestStatus" size="1">
            <%= dbList.getDeliveryStatusList("",sMarkLanguage) %>
        </select>
    </td>
  </tr>
  <tr> 
    <td width="22%"> 
      <a href="javascript:add.submit()"><img src="../images/search.jpg" width="44" height="19" border="0"></a>
      <img src="../images/good.jpg" width="10" height="10"><a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a> 
    </td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>
<hr>

<%

  String init=request.getParameter("init");
  if (!(init==null))
  {


%>

<table cellpadding="4" cellspacing="0" width="98%" align="center">
  <tr bgcolor="e0e0e0">
        <td>狀況</td>
        <td>提交日期</td>
        <td height="28">送貨要求號碼</td>
        <td>貨物種類</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>貨櫃種類</td>
        <td>運價</td>
        <td>送貨日期</td>
        <td>送貨時閒</td>
        <td>配對編號</td>
    </tr>

  <%
    
    String originZoneId=null,originCityId=null,destinationZoneId=null,destinationCityId=null,requestStatus=null;
    String containerTypeId=null,deliveryDate=null,deliveryNum=null,deliveryTime=null,timeSlotId=null,shippingOrderNo=null, orderByName=null;
    String type = request.getParameter("type");
    int i = 0;
    CbtbConstant cbtbConstant = new CbtbConstant();
    ArrayList arrayList = new ArrayList();  
    if (type == null)
        {  
          if(!request.getParameter("originCityId").equals("Any"))
	    originCityId =  request.getParameter("originCityId").trim();
          else 
               originCityId = null;

          if(!request.getParameter("destinationCityId").equals("Any"))
             destinationCityId =  request.getParameter("destinationCityId");
          else
              destinationCityId  =  null;

          if(!request.getParameter("requestStatus").equals("Any"))
            requestStatus  =  request.getParameter("requestStatus");
          else
              requestStatus  =  null;
    
          if(!request.getParameter("containerTypeId").equals("Any"))
	     containerTypeId =  request.getParameter("containerTypeId");
          else
               containerTypeId = null;

         if(request.getParameter("deliveryDate").trim().length() > 0)
	   deliveryDate = request.getParameter("deliveryDate");
         else
             deliveryDate =  null; 

         if(!request.getParameter("deliveryTime").equals("Any"))
	   deliveryTime = request.getParameter("deliveryTime").trim();
         else
             deliveryTime =  null; 

         //if(!request.getParameter("orderByName").equals("Any"))
	 //  orderByName = request.getParameter("orderByName");
         //else
             orderByName  =  "SUB_MISSION_DATETIME" ;
 
            newPagination.setPageNo(0);
            newPagination.setRecords((Collection)webOperator.getCompanyManager().searchDeliveryRequest(companyId,null,null,originCityId,null,destinationCityId,requestStatus,containerTypeId,deliveryDate,null,deliveryTime,null,null, orderByName));       
      //newPagination.setRecords((Collection)webOperator.getCompanyManager().searchDeliveryRequest(null,null,null,null,null,null,null,null,null,null,null,null,null, null));       
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
               if((i+1) % 2 == 0)
               {
                 out.println("<tr bgcolor='#ddffdd'>"); 
               }
               else
                  out.println("<tr>");
            
              if(deliveryRequestModelList.getRequestStatus().equals(cbtbConstant.DELIVERY_REQUEST_MATCH)) 
              {
         %>
                <td><font color="#FF0000"><%=dbList.getDeliveryStatusDesc(deliveryRequestModelList.getRequestStatus(),sMarkLanguage) %>&nbsp;</td>
         <%
              }
              else
                 {
         %>
                  <td><%= dbList.getDeliveryStatusDesc(deliveryRequestModelList.getRequestStatus(),sMarkLanguage) %>&nbsp;</td>
         <%   
                 }
         %>
	<td height="28"><%= deliveryRequestModelList.getSubMissionDatetime().toString().substring(0,10) %>&nbsp;</td> 
        <td><a href="DeliveryRequestView.jsp?path=DeliveryRequestSearch.jsp&deliveryRequestNum=<%= RequestNum  %>&rootPath=<%= rootPath %>"><font color="#003366"><%= RequestNum  %></font></a></td>
        <td><%= dbList.getCargoCategoryDesc(deliveryRequestModelList.getCargoId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getCityDesc(deliveryRequestModelList.getOriginCityId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getCityDesc(deliveryRequestModelList.getDestinationCityId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= dbList.getContainerTypeDesc(deliveryRequestModelList.getContainerTypeId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= deliveryRequestModelList.getDeliveryFee() %></td>
        <td><%= deliveryRequestModelList.getDeliveryDate().toString().substring(0,10) %>&nbsp;</td>
	<td><%= dbList.getDeliveryTimeDesc(deliveryRequestModelList.getTimeId(),sMarkLanguage) %>&nbsp;</td>
        <td><%= deliveryRequestModelList.getMatchNumber() %>&nbsp;</td>
    </tr>
  <%
           }
  %>
</table>
<hr> 

<table width="750"  cellspacing="0" cellpadding="4" align="center">
  <tr> 
     <td width="84%" class="unnamed1">
        <%
          if (newPagination.getPageNo() > 1)
          {
        %>
           <a href="DeliveryRequestSearch.jsp?type=F&init=tmd"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>
           <img src="../images/good.jpg" width="20" height="10"><a href="DeliveryRequestSearch.jsp?type=P&init=tmd"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>
        <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
       %> 
           <img src="../images/good.jpg" width="20" height="10"><a href="DeliveryRequestSearch.jsp?type=N&init=tmd"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a><img src="../images/good.jpg" width="20" height="10"><a href="DeliveryRequestSearch.jsp?type=E&init=tmd"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a> 
       <%
          }
       %>
    </td>     
    <td width="16%" class="unnamed1"> 
      <div align="right"><font color="#003366">第<%=newPagination.getPageNo()%>頁&nbsp;總數：<%=newPagination.getPageSum()%>頁</font></div>
    </td>
  </tr>
</table> 
<%}%>

<input type="hidden" name="init" value="notfirst">
</form>
 
<table width="337" border="0" align="center">
  <%@ include file = "../include/end.jsp" %>
</body>
</html>


