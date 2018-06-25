<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "view");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

session.setAttribute("language","CH");
String language = (String)session.getAttribute("language");
String type = request.getParameter("type");
ArrayList truckCapacityModels= new ArrayList();
String truckerId = request.getParameter("truckerId");
String companyId = request.getParameter("companyId");
CompanyManager companyManager =  webOperator.getCompanyManager();
TruckerDataModel truckerDataModel = new TruckerDataModel();
CompanyProfileModel companyProfileModel = new CompanyProfileModel();

if (type==null)
{
	String backPage = "CapacityListbyTrucker.jsp?truckerId="+truckerId+"&companyId="+companyId;
	System.out.println("backpage:"+backPage);
	session.setAttribute("backPage",backPage);
	truckerDataModel = companyManager.findTruckerData(truckerId);

	companyProfileModel = companyManager.findCompanyProfile(companyId);
	session.setAttribute("truckerDataModel",truckerDataModel);
	session.setAttribute("companyProfileModel",companyProfileModel);
	newPagination.setPageNo(0);
	newPagination.setRecords(companyManager.searchTruckCapacity(truckerId,companyId));
	truckCapacityModels=new ArrayList(newPagination.nextPage());
	session.setAttribute("CapacityListbyTruckerPagination",newPagination);
}
else
{
	truckerDataModel = (TruckerDataModel)session.getAttribute("truckerDataModel");
	companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
	newPagination = (NewPagination)session.getAttribute("CapacityListbyTruckerPagination");
	if (type.equals("N")) {truckCapacityModels = new ArrayList(newPagination.nextPage());}
	if (type.equals("P")) {truckCapacityModels = new ArrayList(newPagination.previousPage());}
	if (type.equals("F")) {truckCapacityModels = new ArrayList(newPagination.firstPage());}
	if (type.equals("E")) {truckCapacityModels = new ArrayList(newPagination.endPage());}
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
      <div align="right"><a href="CapacityAddbyTrucker.jsp"><font color="#003366">空車登記</font></a><font color="#003366">|<a href="TruckerEdit.jsp?truckerId=<%=truckerId%>&companyId=<%=companyId%>&companyName=<%=companyProfileModel.getCompanyChineseName()%>">更新註冊資料</a>|</font><a href="SearchOrg.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>
<p align="left"><font size="2" face="Arial, Helvetica, sans-serif">
貨櫃車編號：<%=truckerDataModel.getTruckerId()%>
  &nbsp;&nbsp;司機姓名：<%=truckerDataModel.getTruckerChineseName()%></font></p>

<table border="0" width="90%">
    <tr>
        <td><font size="2"><em>公司名稱： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%></em></font></td>
        <td><font size="2"><em>公司聯絡人： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%></em></font></td>
    </tr>
    <tr>
      <td><font size="2"><em>電話號碼：</em></font></td>
      <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%></em></font></td>
		  <td><font size="2"><em>手提電話號碼：</em></font></td>
      <td><font size="2"><em><%=companyProfileModel.getMobileNo()%></em></font></td>
    </tr>
    <tr>
			<td><font size="2">貨櫃車牌照號碼</font></td>
			<td><font size="2"><em><%=truckerDataModel.getHkPlateNo()%></em></font></td>
			<td><font size="2">香港駕照號<em>：</em></font></td>
      <td><font size="2"><em><%=truckerDataModel.getHkLicenseNo()%></em></font></td>
    </tr>
</table>
<BR>
<table border="1" width="100%">
  <tr>
    <td>空車編號</td>
    <td>出發地城市</td>
    <td>目的地城市</td>
    <td>送貨日期</td>
    <td>送貨時間</td>
    <td>狀況</td>
  </tr>

<%
boolean color = true;
for(int i=0;i<truckCapacityModels.size();i++)
{
	TruckCapacityModel truckCapacityModel= new TruckCapacityModel();
	truckCapacityModel=(TruckCapacityModel)truckCapacityModels.get(i);
	System.out.println("getTruckerId:"+truckCapacityModel.getTruckerId());
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
    <td><a href="CapacityView.jsp?truckCapacityNum=<%=truckCapacityModel.getTruckCapacityNum()%>"><%=truckCapacityModel.getTruckCapacityNum()%></a></td>
    <td><%=dbList.getCityDesc(truckCapacityModel.getOriginCityId(),language)%>&nbsp;</td>
    <td><%=dbList.getCityDesc(truckCapacityModel.getDestinationCityId(),language)%>&nbsp;</td>
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
					 <a href="CapacityListbyTrucker.jsp?truckerId=<%=truckerId%>&companyId=<%=companyId%>&type=F">第一頁</a>
					 <a href="CapacityListbyTrucker.jsp?truckerId=<%=truckerId%>&companyId=<%=companyId%>&type=P">上一頁</a>
        <%
        }
        if (newPagination.getPageNo() < newPagination.getPageSum())
        {
        %>
				 <a href="CapacityListbyTrucker.jsp?truckerId=<%=truckerId%>&companyId=<%=companyId%>&type=N">下一頁</a>
				 <a href="CapacityListbyTrucker.jsp?truckerId=<%=truckerId%>&companyId=<%=companyId%>&type=E">最後一頁</a>
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