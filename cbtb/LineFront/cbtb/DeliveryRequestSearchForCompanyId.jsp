<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.model.*" %>
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
 CbtbConstant cbtbConstant = new CbtbConstant();
 String path = request.getParameter("path");
 //if(path == null)
 path = "DeliveryRequestSearchForCompanyId.jsp";
 String rootPath = request.getParameter("rootPath");
 String type = request.getParameter("type");
 CompanyProfileModel companyProfileModel=new CompanyProfileModel();
 companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
 String companyId=companyProfileModel.getCompanyId(); 
 CompanyManager companyManager = webOperator.getCompanyManager();    
%>

<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
<input type="hidden" name="rootPath" value="<%= rootPath %>">
<input type="hidden" name="path" value="<%= path %>">

<table width="75%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="../images/good.jpg" width="10" height="10"></td>
    </tr>
  </table>
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨運要求列表</font></b></font></td>
      <td width="57%"> 
        
      <div align="right"><a href="DeliveryRequestAdd.jsp?path=DeliveryRequestSearchForCompanyId.jsp"><font
color="#003366">新建</font></a><font color="#003366"> | </font><a href="indexShipping.jsp"><font color="#003366">關閉</font></a></div>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font size="2"
face="Arial, Helvetica, sans-serif">公司編號： <%=companyProfileModel.getCompanyId()%>&nbsp; </font></td>
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
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22"><font size="2">公司名稱： </font></td>
    <td height="22"><font size="2"><%=companyProfileModel.getCompanyChineseName()%>&nbsp;</font></td>
    <td height="22"><font size="2">聯絡人： </font></td>
    <td height="22"><font size="2"><%=companyProfileModel.getContactChinesePerson()%>&nbsp;</font></td>
    <td height="22"><font size="2">手提號碼： </font></td>
    <td height="22"><font size="2"><%=companyProfileModel.getMobileNo()%>&nbsp;</font></td>
  </tr>
  <tr> 
    <td><font size="2">電話號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getTelephoneNo()%>&nbsp; </font></td>
    <td><font size="2">傳真號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getFaxNo()%>&nbsp;</font></td>
    <td><font size="2">電郵地址：</font></td>
    <td><font size="2"><%=companyProfileModel.getEmailAddr()%>&nbsp; </font></td>
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
<table cellpadding="4" cellspacing="0" width="102%">
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
 DeliveryRequestModel  deliveryRequestModel=new DeliveryRequestModel();
 ArrayList deliveryRequests = new ArrayList();
 int i = 0;
 if(type == null  )
     {    
       newPagination.setPageNo(0);
       newPagination.setRecords((Collection)companyManager.searchDeliveryRequest(companyId));
       deliveryRequests = (ArrayList)newPagination.nextPage();
    }
    else
    {
        if(type.equals("N"))
        { 
           deliveryRequests = null;
           deliveryRequests = (ArrayList)newPagination.nextPage();
        }
        else if(type.equals("P"))
             {
                deliveryRequests = new ArrayList(newPagination.previousPage());
             }
             else if (type.equals("F"))
                  {
                      deliveryRequests =new ArrayList(newPagination.firstPage());
                  }
                  else if(type.equals("E"))
                       {
                          deliveryRequests = new ArrayList(newPagination.endPage());
                       }
                       else if (type.equals("T"))
                            {
                               deliveryRequests = new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
                             }
   }
   for (i = 0;  (!deliveryRequests.isEmpty()) && i < deliveryRequests.size(); i++)
       {
	  deliveryRequestModel =(DeliveryRequestModel)deliveryRequests.get(i);
          if((i+1) % 2 == 0)
          {
             out.println("<tr bgcolor='#ddffdd'>"); 
          }
          else
              {
                out.println("<tr>"); 
              }     
              if(deliveryRequestModel.getRequestStatus().equals(cbtbConstant.DELIVERY_REQUEST_MATCH)) 
              {
        %>
                  <td><font color="#FF0000"><%=dbList.getDeliveryStatusDesc(deliveryRequestModel.getRequestStatus(),sMarkLanguage) %>&nbsp;</td>
       <%
             }
             else
                {
       %>
                 <td><%=dbList.getDeliveryStatusDesc(deliveryRequestModel.getRequestStatus(),sMarkLanguage) %>&nbsp;</td>         
       <%   
               }
       %>

                <td><%=deliveryRequestModel.getSubMissionDatetime().toString().substring(0,10) %>&nbsp;</td>
                <td><a href="DeliveryRequestView.jsp?path=DeliveryRequestSearchForCompanyId.jsp&deliveryRequestNum=<%=deliveryRequestModel.getDeliveryRequestNum()%>"><font color="#003366"><%=deliveryRequestModel.getDeliveryRequestNum()%></font></td>
                <td><%=dbList.getCargoCategoryDesc(deliveryRequestModel.getCargoId(),sMarkLanguage)%>&nbsp;</td>
                <td><%=dbList.getCityDesc(deliveryRequestModel.getOriginCityId(),sMarkLanguage) %>&nbsp;</td>
                <td><%=dbList.getCityDesc(deliveryRequestModel.getDestinationCityId(),sMarkLanguage)%>&nbsp;</td>
                <td><%=dbList.getContainerTypeDesc(deliveryRequestModel.getContainerTypeId(),sMarkLanguage)%>&nbsp;</td>
                <td><%=deliveryRequestModel.getDeliveryFee()%>&nbsp;</td>
                <td><%=deliveryRequestModel.getDeliveryDate().toString().substring(0,10) %>&nbsp;</td>
                <td><%=dbList.getDeliveryTimeDesc(deliveryRequestModel.getTimeId(),sMarkLanguage)%>&nbsp;</td>
                <td><%=deliveryRequestModel.getMatchNumber() %>&nbsp;</td>
      </tr>
 <%
      }	//for() end
 %>   
</table>
<hr>

<table width="750" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
         <td width="84%" class="unnamed1">
        <%
          if (newPagination.getPageNo() > 1)
          {
        %>
           <a href="DeliveryRequestSearchForCompanyId.jsp?type=F&init=tmd"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>
           <img src="../images/good.jpg" width="20" height="10"><a href="DeliveryRequestSearchForCompanyId.jsp?type=P&init=tmd"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>
        <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
       %> 
           <img src="../images/good.jpg" width="20" height="10"><a href="DeliveryRequestSearchForCompanyId.jsp?type=N&init=tmd"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a><img src="../images/good.jpg" width="20" height="10"><a href="DeliveryRequestSearchForCompanyId.jsp?type=E&init=tmd"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a> 
       <%
          }
       %>
    </td>     
    <td width="16%" class="unnamed1"> 
      <div align="right"><font color="#003366">第<%=newPagination.getPageNo()%>頁&nbsp;總數：<%=newPagination.getPageSum()%>頁</font></div>
    </td>
      </tr>
  </table>
<p>&nbsp;</p>

<%@ include file = "../include/end.jsp" %>  
</body>
</html>
