<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "cancel");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");
String backPage = "CapacitySearch.jsp";
CompanyManager companyManager =  webOperator.getCompanyManager();
if(companyManager.updateTruckCapacityStatus(truckCapacityModel.getTruckCapacityNum(),com.cbtb.util.CbtbConstant.TRUCK_CAPACITY_CANCEL))
{
  System.out.println("CapacityStatusUpdate.jsp is ok!");
}
else
{
  System.out.println("CapacityStatusUpdate.jsp is falie!");
	backPage = "fail.jsp";
}
%>
<jsp:forward page="<%=backPage%>"/>