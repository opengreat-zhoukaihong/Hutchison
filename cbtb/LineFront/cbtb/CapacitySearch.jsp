<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<script src=../js/calendarShow.js></script>
<script src=../js/JsLib.js></script>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "search");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
String type = request.getParameter("type");
String init = request.getParameter("init");
ArrayList truckCapacityModels=new ArrayList();
if (type==null)
{
	if(init!=null)
	{
		CompanyManager companyManager =  webOperator.getCompanyManager();
		String originCityId=request.getParameter("originCityId");
		String destinationCityId=request.getParameter("destinationCityId");
		String deliveryDate=request.getParameter("deliveryDate");
		String deliveryTimeId=request.getParameter("deliveryTimeId");
		String truckCapacityStatus=request.getParameter("truckCapacityStatus");
		String trailerId=request.getParameter("trailerId");
		if (originCityId.length()==0 || originCityId.equals("Any"))  originCityId= null;
		if (destinationCityId.length()==0 || destinationCityId.equals("Any")) destinationCityId  = null;
		if (deliveryDate.length()==0) deliveryDate = null;
		if (deliveryTimeId.length()==0 || deliveryTimeId.equals("Any")) deliveryTimeId = null;
		if (truckCapacityStatus.length()==0 || truckCapacityStatus.equals("Any")) truckCapacityStatus = null;
		if (trailerId.length()==0 || trailerId.equals("Any")) trailerId = null;
		System.out.println("originCityId:"+originCityId);
		System.out.println("destinationCityId:"+destinationCityId);
		System.out.println("deliveryDate:"+deliveryDate);
		System.out.println("deliveryTimeId:"+deliveryTimeId);
		System.out.println("truckCapacityStatus:"+truckCapacityStatus);
		System.out.println("trailerId:"+trailerId);

	  newPagination.setPageNo(0);
		newPagination.setRecords(companyManager.searchTruckCapacity(null,null,companyProfileModel.getCompanyId(),
					  originCityId,destinationCityId,deliveryDate,deliveryTimeId,null,trailerId,
						null,null,truckCapacityStatus,"SUB_MISSION_DATETIME"));
		session.setAttribute("CapacitySearchPagination",newPagination);
		truckCapacityModels=new ArrayList(newPagination.nextPage());
	}
}
else
{
	newPagination = (NewPagination)session.getAttribute("CapacitySearchPagination");
	if (type.equals("N")) truckCapacityModels = new ArrayList(newPagination.nextPage());
	if (type.equals("P")) truckCapacityModels = new ArrayList(newPagination.previousPage());
	if (type.equals("F")) truckCapacityModels = new ArrayList(newPagination.firstPage());
	if (type.equals("E")) truckCapacityModels = new ArrayList(newPagination.endPage());
}
%>
<SCRIPT LANGUAGE=javascript>
function doPost()
{

	if(!isDate(search.deliveryDate.value) && search.deliveryDate.value!=0)
	{
		alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
		search.deliveryDate.focus();
		return;
	}
	if (search.originCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> && search.destinationCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'只能有一個為香港！");
		return;
	}
	if (search.originCityId.value!="Any" && search.destinationCityId.value!="Any")
	{
		if (search.originCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> && search.destinationCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> )
		{
			alert("'出發地城市','目的地城市'不可以都不為香港！");
			return;
		}
	}
	search.submit();
}
</Script>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/headtrucker.jsp"%>
<BR>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">查詢貨運紀錄</font></b></font></td>
		<td width="57%">
			<div align="right"><a href="indexTrucking.jsp"><font color="#003366">關閉</font></a></div>
		</td>
	</tr>
</table>
<form name="search" method="post" action="CapacitySearch.jsp">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
  <tr bgcolor="#FFFFFF">
    <td width="123">送貨日期：</td>
    <td width="112">
      <input type="text" maxlength="10" size="10" value="<%=request.getParameter("deliveryDate")%>" name="deliveryDate"  >
			<img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
			onClick="fPopUpCalendarDlg(deliveryDate);return false" >
    </td>
    <td width="71">送貨時間：</td>
    <td width="61">
			<select name="deliveryTimeId" size="1">
				<%=dbList.getDeliveryTimeList(request.getParameter("deliveryTimeId"),language)%>
			</select>
    </td>
    <td width="36">狀況：</td>
    <td width="376">
      <select name="truckCapacityStatus" size="1">
				<%=dbList.getTruckCapacityStatusList(request.getParameter("truckCapacityStatus"),language)%>
			</select>
    </td>
  </tr>
  <tr>
    <td width="123">出發地城市：</td>
    <td width="112">
      <select name="originCityId" size="1">
        <%=dbList.getCityList(request.getParameter("originCityId"),language)%>
			</select>
    </td>
    <td width="71">目的地城市：</td>
    <td width="61">
      <select name="destinationCityId" size="1">
        <%=dbList.getCityList(request.getParameter("destinationCityId"),language)%>
			</select>
    </td>
    <td width="36">拖架：</td>
    <td width="376">
      <select name="trailerId" size="1">
        <%=dbList.getTrailerTypeList(request.getParameter("trailerId"),language)%>
			</select>
    </td>
  </tr>
  <tr>
    <td width="123">
      <div align="left"> </div>
      <input type="hidden" name="init" value="notFirst">
			<a href="javascript:doPost()"><img src="../images/search.jpg" width="44" height="19" border="0"></a>
			<img src="../images/good.jpg" width="10" height="10">
			<a href="javascript:search.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
    </td>
    <td width="112">&nbsp; </td>
    <td width="71">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
  </tr>
</table>
<BR>
</form>
</div>
<%
if(init !=null)
{
%>
<div align="center"></div>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852"><font face="Arial, Helvetica, sans-serif">貨運紀錄列表</font> </font></b></font></td>
  </tr>
</table>
<BR>
<table cellpadding="4" cellspacing="" width="130%" align="center">
  <tr bgcolor="e0e0e0">
    <td>狀況</td>
    <td>提交日期</td>
    <td>空車編號</td>
    <td>貨櫃車編號</td>
    <td>貨櫃車司機姓名</td>
    <td>貨櫃車牌照號碼</td>
    <td>出發地城市</td>
    <td>目的地城市</td>
    <td>拖架種類</td>
    <td>送貨日期</td>
    <td>送貨時間</td>
    <td>運費</td>
    <td>配對編號</td>
    <td>貨物種類</td>
    <td>貨櫃種類</td>
  </tr>
	<%
		boolean color = true;
		for(int i=0;i<truckCapacityModels.size();i++)
		{
			truckCapacityModel= new TruckCapacityModel();
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
			%>
		<td><%=truckCapacityModel.getSubMissionDatetime().toString().substring(0,10)%></td>
		<td><a href="CapacityView.jsp?truckCapacityNum=<%=truckCapacityModel.getTruckCapacityNum()%>"><font color="#003366"><%=truckCapacityModel.getTruckCapacityNum()%></font></a></td>
		<td><a href="TruckerUpdateView.jsp?update=N&truckerId=<%=truckCapacityModel.getTruckerId()%>"><font color="#003366"><%=truckCapacityModel.getTruckerId()%></font></a></td>
		<td><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)%></td>
		<td><a href="TruckerUpdateView.jsp?update=N&truckerId=<%=truckCapacityModel.getTruckerId()%>"><font color="#003366"><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%></font></a></td>
		<td><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%>&nbsp;</td>
		<td><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%>&nbsp;</td>
		<td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%></td>
		<td><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
		<td><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%></td>
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
		<td><%=truckCapacityModel.getMatchNumber()%>&nbsp;</td>
		<td><%=dbList.getCargoCategoryDesc(truckCapacityModel.getCargoId(),language)%>&nbsp;</td>
		<td><%=dbList.getContainerTypeDesc(truckCapacityModel.getCargoId(),language)%>&nbsp;</td>
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
				<a href="CapacitySearch.jsp?type=F&init=1"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="CapacitySearch.jsp?type=P&init=1"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      if (newPagination.getPageNo() < newPagination.getPageSum())
      {
      %>
				<a href="CapacitySearch.jsp?type=N&init=1"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="CapacitySearch.jsp?type=E&init=1"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      %>
				<td width="16%" class="unnamed1">
        <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
    </td>
  </tr>
</table>
<%
}
%>
<%@ include file="../include/food.jsp"%>
</body>
</html>