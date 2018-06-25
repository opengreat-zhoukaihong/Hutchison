<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "view");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
companyProfileModel =(CompanyProfileModel)session.getAttribute("companyProfileModel");

String type = request.getParameter("type");
ArrayList truckCapacityModels=new ArrayList();
if (type==null)
{
	CompanyManager companyManager =  webOperator.getCompanyManager();
	newPagination.setPageNo(0);
	newPagination.setRecords(companyManager.searchTruckCapacity(companyProfileModel.getCompanyId()));
	String backPage = "CapacityList.jsp";
	session.setAttribute("backPage",backPage);
	session.setAttribute("CapacityListPagination",newPagination);
	truckCapacityModels = new ArrayList(newPagination.nextPage());
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
<title></title>
</head>
<%@ include file="../include/headtrucker.jsp"%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="102">
      <div align="left">
				<font face="Arial, Helvetica, sans-serif" size="2" color="#667852">空車列表</font>
			</div>
    </td>
    <td width="678">
      <div align="right"><a href="CapacityAdd.jsp"><font color="#003366">新建</font></a>
			<font color="#003366"><b> |</b> </font><a href="indexTrucking.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>
<div align="left">
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td><font size="2" face="Arial, Helvetica, sans-serif">貨運公司編號：<%=companyProfileModel.getCompanyId()%></font> </td>
    </tr>
  </table>
</div>
<table border="0" width="98%" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="10%"><font size="2">公司名稱：</font></td>
    <td width="26%"><font size="2"><%=companyProfileModel.getCompanyChineseName()%></font></td>
    <td width="19%"><font size="2">公司聯絡人： </font></td>
    <td width="13%"><font size="2"><%=companyProfileModel.getContactChinesePerson()%></font></td>
    <td width="12%"><font size="2">手提電話號碼： </font></td>
    <td width="20%"><font size="2"><%=companyProfileModel.getMobileNo()%></font></td>
  </tr>
  <tr>
    <td width="10%"><font size="2">電話號碼：</font></td>
    <td width="26%"><font size="2"><%=companyProfileModel.getTelephoneNo()%> </font></td>
    <td width="19%"><font size="2">傳真號碼：</font></td>
    <td width="13%"><font size="2"><%=companyProfileModel.getFaxNo()%></font></td>
    <td width="12%"><font size="2">電郵地址：</font></td>
    <td width="20%"><font size="2"><%=companyProfileModel.getEmailAddr()%></font></td>
  </tr>
</table>
<BR>
<table cellpadding="4" cellspacing="0"  width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>狀況</td>
    <td>空車編號</td>
    <td height="23">貨櫃車司機姓名</td>
    <td>貨櫃車牌照號碼</td>
    <td>出發地城市</td>
    <td>目的地城市</td>
    <td>拖架種類</td>
    <td>送貨日期</td>
    <td>送貨時間</td>
    <td>運費</td>
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
	if(truckCapacityModel.getTruckCapacityStatus().equalsIgnoreCase(com.cbtb.util.CbtbConstant.TRUCK_CAPACITY_MATCH))
	{
	%>
		<td><font color="#FF6666"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></font></td>
	<%
		}
		else
		{
	%>
		<td><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%></td>
	<%
		}
		if(truckCapacityModel.getMatchOriginCityId()==null) truckCapacityModel.setMatchOriginCityId("");
		if(truckCapacityModel.getMatchDestCityId()==null) truckCapacityModel.setMatchDestCityId(""); ;
		if(truckCapacityModel.getMatchRequestFee()==null) truckCapacityModel.setMatchRequestFee("0");
	%>
    <td><%=truckCapacityModel.getTruckCapacityNum()%></td>
    <td><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%>&nbsp;</td>
    <td><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>&nbsp;</td>
    <td><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%>&nbsp;</td>
    <td><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%>&nbsp;</td>
    <td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%>&nbsp;</td>
    <td><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
    <td><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%>&nbsp;</td>
		<td><%
					BigDecimal deliveryFee = new BigDecimal("0");
					if(truckCapacityModel.getMatchRequestFee().equals(deliveryFee))
					{
						out.write("&nbsp");
					}
					else
					{
						out.write(truckCapacityModel.getMatchRequestFee().toString());
					}
				%>
			</td>
    </tr>
<%
}
%>
</table>

<table width="98%"  cellspacing="0" cellpadding="4" align="center">
  <tr>
    <td width="84%" class="unnamed1">
      <%
      if (newPagination.getPageNo() > 1)
      {
      %>
				<a href="CapacityList.jsp?type=F"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="CapacityList.jsp?type=P"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      if (newPagination.getPageNo() < newPagination.getPageSum())
      {
      %>
				<a href="CapacityList.jsp?type=N"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="CapacityList.jsp?type=E"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      %>
				<td width="16%" class="unnamed1">
        <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
    </td>
  </tr>
</table>
<%@ include file="../include/food.jsp"%>
</body>
</html>
