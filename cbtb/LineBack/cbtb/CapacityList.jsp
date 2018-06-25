<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "view");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = (String)session.getAttribute("language");
String type = request.getParameter("type");
CompanyManager companyManager =  webOperator.getCompanyManager();
ArrayList truckCapacityModels=new ArrayList();
if (type==null)
{
	String truckCapacityNum =request.getParameter("truckCapacityNum").trim();
	if (truckCapacityNum.length()==0)	truckCapacityNum = null;

	String originZoneId =request.getParameter("originZoneId").trim();
	if (originZoneId.length()==0 || originZoneId.equals("Any")) originZoneId = null;

	String destinationZoneId=request.getParameter("destinationZoneId").trim();
	if (destinationZoneId.length()==0 || destinationZoneId.equals("Any")) destinationZoneId = null;

	String companyId=request.getParameter("companyId").trim();
	if (companyId.length()==0) companyId = null;

	String originCityId=request.getParameter("originCityId").trim();
	if (originCityId.length()==0 || originCityId.equals("Any"))  originCityId= null;

	String destinationCityId=request.getParameter("destinationCityId").trim();
	if (destinationCityId.length()==0 || destinationCityId.equals("Any")) destinationCityId  = null;

	String deliveryDate=request.getParameter("deliveryDate").trim();
	if (deliveryDate.length()==0) deliveryDate = null;

	String deliveryTimeId=request.getParameter("deliveryTimeId").trim();
	if (deliveryTimeId.length()==0 || deliveryTimeId.equals("Any")) deliveryTimeId = null;

	String deliveryTimeSlot=request.getParameter("deliveryTimeSlot").trim();
	if (deliveryTimeSlot.length()==0 || deliveryTimeSlot.equals("Any")) deliveryTimeSlot = null;

	String containerTypeId=request.getParameter("containerTypeId").trim();
	if (containerTypeId.length()==0 || containerTypeId.equals("Any")) containerTypeId = null;

	String matchNumber=request.getParameter("matchNumber".trim());
	if (matchNumber.length()==0) matchNumber = null;

	String truckCapacityStatus=request.getParameter("truckCapacityStatus").trim();
	if (truckCapacityStatus.length()==0 || truckCapacityStatus.equals("Any")) truckCapacityStatus = null;

	String orderByName=request.getParameter("orderByName");
	if (orderByName.length()==0 || orderByName.equals("Any")) orderByName = null;

	newPagination.setPageNo(0);
	newPagination.setRecords(companyManager.searchTruckCapacityByContainer(truckCapacityNum,
													originZoneId,companyId,originCityId,destinationCityId,
													deliveryDate,deliveryTimeId,deliveryTimeSlot,containerTypeId,matchNumber,
													destinationZoneId,truckCapacityStatus,orderByName));
	session.setAttribute("CapacityListPagination",newPagination);
	truckCapacityModels=new ArrayList(newPagination.nextPage());
}
else
{
	newPagination = (NewPagination)session.getAttribute("CapacityListPagination");
	if (type.equals("N")) truckCapacityModels = new ArrayList(newPagination.nextPage());
	if (type.equals("P")) truckCapacityModels = new ArrayList(newPagination.previousPage());
	if (type.equals("F")) truckCapacityModels = new ArrayList(newPagination.firstPage());
	if (type.equals("E")) truckCapacityModels = new ArrayList(newPagination.endPage());
}
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/head.jsp"%>
<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11"><font face="Arial, Helvetica, sans-serif">登記空車列表</font> </td>
    <td height="11">
      <div align="right"><a href="CapacitySearch.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>
<table border="1" width="100%">
  <tr>
      <td>公司名稱</td>
      <td>公司號碼</td>
      <td>空車編號</td>
      <td>司機姓名</td>
      <td>司機號碼</td>
      <td>車牌照號碼</td>
      <td>出發地城市</td>
      <td>目的地城市</td>
      <td>拖架種類</td>
      <td>送貨日期</td>
      <td>送貨時間</td>
      <td>狀況</td>
  </tr>
<%
boolean color = true;
for(int i=0;i<truckCapacityModels.size();i++)
{
	truckCapacityModel= new TruckCapacityModel();
	truckCapacityModel=(TruckCapacityModel)truckCapacityModels.get(i);
	companyProfileModel = dbList.findCompany(truckCapacityModel.getCompanyId());
	if(color)
	{
		out.write("<tr>");
		color = false;
	}
	else
	{
		out.write("<tr bgcolor=\"#ddffdd\">");
		color = true;
	}
%>
    <td><%=companyProfileModel.getCompanyChineseName()%></td>
    <td><%=companyProfileModel.getCompanyId()%></td>
    <td><a href="CapacityView.jsp?truckCapacityNum=<%=truckCapacityModel.getTruckCapacityNum()%>"><%=truckCapacityModel.getTruckCapacityNum()%></a></td>
    <td><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%>&nbsp;</td>
    <td><%=truckCapacityModel.getTruckerId()%>&nbsp;</td>
    <td><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>&nbsp;</td>
    <td><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%>&nbsp;</td>
    <td><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%>&nbsp;</td>
    <td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%>&nbsp;</td>
    <td><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
    <td><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%>&nbsp;</td>
    <td><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%>&nbsp;</td>
    </tr>
<%
}
%>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="22" align="center">
  <tr>
    <td width="85%" class="unnamed1">
        <%
        if (newPagination.getPageNo() > 1)
        {
        %>
					 <a href="CapacityList.jsp?type=F">第一頁</a>
					 <a href="CapacityList.jsp?type=P">上一頁</a>
        <%
        }
        if (newPagination.getPageNo() < newPagination.getPageSum())
        {
        %>
				 <a href="CapacityList.jsp?type=N">下一頁</a>
				 <a href="CapacityList.jsp?type=E">最後一頁</a>
        <%
        }
        %>
      <td width="80" class="unnamed1">
      <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
    </td>
  </tr>
</table>
</body>
</html>