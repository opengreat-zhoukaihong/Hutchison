<%@ include file="Init.jsp"%>  


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*" %>

<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_USER"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
 String languageName ="CN";
String type = request.getParameter("type");
 String companyId = request.getParameter("companyId");
//if(type == null){
  CompanyManager companyManager = webOperator.getCompanyManager();
  CompanyProfileModel companyProfileModel =  companyManager.findCompanyProfile(companyId);
  if(type == null)
     session.setAttribute("companyProfileModel",companyProfileModel);
//  else
//     companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
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
    <td height="11"><font face="Arial, Helvetica, sans-serif">登記送貨要求列表</font> </td>
    <td height="11"> 
      <div align="right"><a href="DeliveryRequestAdd.jsp?path=UserSearchCompanyShipper.jsp"><font color="#003366">貨運要求登記</font></a> | <a href="TradingPartnerList.jsp?path=UserSearchCompanyShipper.jsp&companyId=<%= companyId %>"><font color="#003366">貿易夥伴</font></a><font color="#003366"> | <a href="RegEdit.jsp?update=true">更新註冊資料</a> | <a href="SearchOrg.jsp">關閉 </a></font></div>
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
<p align="left"><font size="2"
face="Arial, Helvetica, sans-serif"><em>公司編號：  <%=companyId%> </em></font></p>

<table border="0" width="90%">
    <tr>
        <td><font size="2"><em>公司名稱： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%>&nbsp;</em></font></td>
        <td><font size="2"><em>公司聯絡人： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%>&nbsp;</em></font></td>
    </tr>
    <tr>
        <td><font size="2"><em>電話號碼：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%>&nbsp; </em></font></td>
        <td><font size="2"><em>傳真號碼：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getFaxNo()%>&nbsp;</em></font></td>
    </tr>
    <tr>
        <td><font size="2"><em>手提電話號碼： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getMobileNo()%>&nbsp;</em></font></td>
        <td><font size="2"><em>電郵地址：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getEmailAddr()%>&nbsp; </em></font></td>
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
 DeliveryRequestModel  deliveryRequestModel=new DeliveryRequestModel();
 ArrayList deliveryRequests = new ArrayList();

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


%>


<table border="1" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="30" width="10%">送貨要求號碼</td>
    <td width="10%">發貨公司名稱</td>
    <td width="7%">收貨公司名稱</td>
    <td width="6%">航運公司</td>
    <td width="6%">貨物種類</td>
    <td width="8%">出發地城市</td>
    <td width="8%">目的地城市</td>
    <td width="6%">貨櫃種類</td>
    <td width="8%">送貨日期</td>
    <td width="6%">送貨時閒</td>
    <td width="8%">運費</td>
    <td width="17%">狀況</td>
  </tr>
  <%  //out.print("size="+deliveryRequests.size());
       for (int i = 0;  (!deliveryRequests.isEmpty()) && i < deliveryRequests.size(); i++)
       {
	  deliveryRequestModel =(DeliveryRequestModel)deliveryRequests.get(i);

  %> 
  <tr> 
    <td height="30" width="8%"><a href="DeliveryRequestView.jsp?path=UserSearchCompanyShipper.jsp&deliveryRequestNum=<%=deliveryRequestModel.getDeliveryRequestNum()%>"><%=deliveryRequestModel.getDeliveryRequestNum()%></a>&nbsp;</td>
    <td width="4%"><%=deliveryRequestModel.getCargoIssuer()%>&nbsp;</td>
    <td width="9%"><%=deliveryRequestModel.getCargoReceiver()%>&nbsp;</td>
    <td width="2%"><%=dbList.getShippingLineDesc(deliveryRequestModel.getShippingLineId(),languageName)%>&nbsp;</td>
    <td width="6%"><%=dbList.getCargoCategoryDesc(deliveryRequestModel.getCargoId(),languageName)%>&nbsp;</td>
    <td width="6%"><%=dbList.getCityDesc(deliveryRequestModel.getOriginCityId(),languageName)%>&nbsp;</td>
    <td width="2%"><%=dbList.getCityDesc(deliveryRequestModel.getDestinationCityId(),languageName)%>&nbsp;</td>
    <td width="10%"><%=dbList.getContainerTypeDesc(deliveryRequestModel.getContainerTypeId(),languageName)%>&nbsp;</td>
    <td width="12%"><%=deliveryRequestModel.getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
    <td width="10%"><%=dbList.getDeliveryTimeDesc(deliveryRequestModel.getTimeId(),languageName)%>&nbsp;</td>
    <td width="11%"><%=deliveryRequestModel.getDeliveryFee()%>&nbsp;</td>
    <td width="20%"> <%if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_CANCEL))out.print("已取消");
if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_POST))out.print("已發佈");
if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_MATCH))out.print("已配對");
if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_CONFIRM))out.print("已確認");
if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_CONTAINER_PICKUP))out.print("已裝箱");
if(deliveryRequestModel.getRequestStatus().equals(CbtbConstant.DELIVERY_REQUEST_CONTAINER_DELIVERED))out.print("已送貨");
%>&nbsp;</td>
  </tr>
  <%}	//for() end
    	%> 
</table>

 <table width="750" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="75%" class="unnamed1"> 
          <%
          if (newPagination.getPageNo() > 1)
          {
            %>
          <a href="UserSearchCompanyShipper.jsp?type=F&init=tmd&companyId=<%=companyId%>" class="unnamed1">第一頁</a>&nbsp;<a href="UserSearchCompanyShipper.jsp?type=P&init=tmd&companyId=<%=companyId%>">前一頁</a> 
          <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
            %>
          &nbsp;<a href="UserSearchCompanyShipper.jsp?type=N&init=tmd&companyId=<%=companyId%>">後一頁</a>&nbsp;<a href="UserSearchCompanyShipper.jsp?type=E&init=tmd&companyId=<%=companyId%>">最後一頁</a> 
          <%
          }
          %>
          </td>     
      
        <td width="25%" class="unnamed1">
          <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp;&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
        </td>
      </tr>
  </table>

<p>&nbsp;</p>
</body>

</html>








