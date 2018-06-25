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
<%@ page import="com.cbtb.model.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPaginationSSY" scope="session" class="com.cbtb.util.NewPagination" />
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "search");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String language = "CH";
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
	if(!isDate(search.deliveryDate.value) && search.deliveryDate.value!=0)
	{
		alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
		search.deliveryDate.focus();
		return;
	}
	search.submit();
}
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/headtrucker.jsp"%>
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">空車市集</font></b></font></td>
      <td width="57%">
        <div align="right"><a href="indexTrucking.jsp"><font color="#003366">關閉</font></a></div>
      </td>
    </tr>
  </table>
<form name="search" method="post" action="TruckCapacityMarket.jsp">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
  <tr bgcolor="#FFFFFF">
    <td width="123">送貨日期：</td>
    <td width="112">
      <input type="text" maxlength="10" size="10" name="deliveryDate"  >
			<img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
			onClick="fPopUpCalendarDlg(deliveryDate);return false" >
    </td>
    <td width="71">送貨時間：</td>
    <td width="61">
			<select name="deliveryTimeId" size="1">
				<%=dbList.getDeliveryTimeList("",language)%>
			</select>
    </td>
    <td width="36">貨櫃種類：</td>
    <td width="376">
      <select name="containerType" size="1">
				<%=dbList.getContainerTypeList("",language)%>
			</select>
    </td>
  </tr>
  <tr>
    <td width="123">出發地城市：</td>
    <td width="112">
      <select name="originCityId" size="1">
        <%=dbList.getCityList("",language)%>
			</select>
    </td>
    <td width="71">目的地城市：</td>
    <td width="61">
      <select name="destinationCityId" size="1">
        <%=dbList.getCityList("",language)%>
			</select>
    </td>
    <td width="36">排序：</td>
    <td width="376">
      <select name="orderByName" size="1">
		<%
		if(!language.equals("CH"))
		{
		%>
			<option selected value ="">NO Preference</option>
			<option value ="COMPANY_ID">Trcuking Organization ID</option>
			<option value ="TRUCKER_ID">Truck Plate Number</option>
			<option value ="ORIGIN_CITY_ID">Origin City</option>
			<option value ="DESTINATION_CITY_ID">Destination City</option>
			<option value ="TRAILER_ID">Trail Type</option>
			<option value ="DELIVERY_DATE">Delivery_Date</option>
			<option value ="DELIVERY_TIME_ID">Delivery Time(am/pm)</option>
		<%
		}
		else
		{
		%>
			<option selected value ="">默認排序</option>
			<option value ="COMPANY_ID">公司名稱</option>
			<option value ="TRUCKER_ID">車牌號碼</option>
			<option value ="ORIGIN_CITY_ID">出發地城市</option>
			<option value ="DESTINATION_CITY_ID">目的地城市</option>
			<option value ="TRAILER_ID">拖架種類</option>
			<option value ="DELIVERY_DATE">送貨日期</option>
			<option value ="DELIVERY_TIME_ID">送貨時間</option>
		<%
		}
		%>
			</select>
    </td>
  </tr>
</table>
<BR>
<input type="hidden" name="init" value="notFirst">
<a href="javascript:doPost()"><img src="../images/search.jpg" width="44" height="19" border="0"></a>&nbsp;&nbsp;&nbsp;
<a href="javascript:search.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
</form>
</div>
<%
String type = request.getParameter("type");
String init = request.getParameter("init");
System.out.println(type);
System.out.println(init);
ArrayList truckCapacityModels = new ArrayList();
if (type==null)
{
	if(init!=null)
	{
		CompanyManager companyManager =  webOperator.getCompanyManager();
		String originCityId=request.getParameter("originCityId");
		String destinationCityId=request.getParameter("destinationCityId");
		String deliveryDate=request.getParameter("deliveryDate");
		String deliveryTimeId=request.getParameter("deliveryTimeId");
		String containerType=request.getParameter("containerType");
		String orderByName=request.getParameter("orderByName");
		if (originCityId !=null)
		{
			if(originCityId.equals("Any"))
			originCityId= null;
		}
		if (destinationCityId !=null)
		{
			if(destinationCityId.equals("Any"))
			destinationCityId = null;
		}
		if (deliveryDate !=null)
		{
			if(deliveryDate.length()==0)
			deliveryDate = null;
		}
		if(deliveryTimeId !=null)
		{
			if(deliveryTimeId.equals("Any"))
			deliveryTimeId = null;
		}
		if(containerType !=null)
		{
			if(containerType.equals("Any"))
			containerType = null;
		}
		if(orderByName !=null)
		{
			if(orderByName.equals("Any"))
			orderByName = null;
		}
		if(request.getParameter("pageNo")!=null)
			newPaginationSSY.setPageNo(Integer.parseInt(request.getParameter("pageNo")));
		else
			newPaginationSSY.setPageNo(0);
		newPaginationSSY.setRecords(companyManager.searchTruckCapacityByContainer(null,null,null,
						originCityId,destinationCityId,deliveryDate,deliveryTimeId,null,containerType,
						null,null,null,orderByName));

		session.setAttribute("CapacityMarketPagination",newPaginationSSY);
		truckCapacityModels=new ArrayList(newPaginationSSY.nextPage());
	}
}
else
{
	if (type.equals("N")) truckCapacityModels = new ArrayList(newPaginationSSY.nextPage());
	if (type.equals("P")) truckCapacityModels = new ArrayList(newPaginationSSY.previousPage());
	if (type.equals("F")) truckCapacityModels = new ArrayList(newPaginationSSY.firstPage());
	if (type.equals("E")) truckCapacityModels = new ArrayList(newPaginationSSY.endPage());
}

if(init !=null)
{
%>
<form method="post" name = "match" action = "MatchDelivery.jsp">
<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>狀況</td>
    <td>運輸公司名稱</td>
    <td>貨櫃車牌照號碼</td>
    <td>出發地城市</td>
    <td>目的地城市</td>
    <td>拖架種類</td>
    <td>送貨日期</td>
    <td>送貨時間</td>
  </tr>
	<%
		boolean color = true;
		for(int i=0;i<truckCapacityModels.size();i++)
		{
			truckCapacityModel= new TruckCapacityModel();
			truckCapacityModel=(TruckCapacityModel)truckCapacityModels.get(i);
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
				CompanyManager companyManager =  webOperator.getCompanyManager();
			%>
		<td><%=truckCapacityModel.getCompanyId()%></td>
		<%
		//AmondId:
		%>
		<td><%=companyManager.findTruckerData(truckCapacityModel.getTruckerId()).getHkPlateNo()%></td>
		<td><%=dbList.getCityDesc(truckCapacityModel.getMatchOriginCityId(),language)%>&nbsp;</td>
		<td><%=dbList.getCityDesc(truckCapacityModel.getMatchDestCityId(),language)%>&nbsp;</td>
		<td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),language)%></td>
		<td><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%></td>
		<td><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),language)%></td>
  </tr>
<%
}
%>
</table>
<input type="hidden" name="check" value="0">
<input type="hidden" name="pageNo" value="<%=newPaginationSSY.getPageNo()%>">
</form>

<table width="98%"  cellspacing="0" cellpadding="4" align="center">
  <tr>
    <td width="84%" class="unnamed1">
      <%
      if (newPaginationSSY.getPageNo() > 1)
      {
      %>
				<a href="TruckCapacityMarket.jsp?type=F&init=1"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="TruckCapacityMarket.jsp?type=P&init=1"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      if (newPaginationSSY.getPageNo() < newPaginationSSY.getPageSum())
      {
      %>
				<a href="TruckCapacityMarket.jsp?type=N&init=1"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="TruckCapacityMarket.jsp?type=E&init=1"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
      }
      %>
				<td width="16%" class="unnamed1">
        <div align="right">第<%=newPaginationSSY.getPageNo()%>頁&nbsp; 總數：<%=newPaginationSSY.getPageSum()%>頁</div>
    </td>
  </tr>
</table>
<%
}
%>
<%@ include file="../include/food.jsp"%>
</body>
</html>
