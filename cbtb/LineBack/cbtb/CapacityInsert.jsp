<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "create");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

TruckCapacityModel theTruckCapacityModel = new TruckCapacityModel();
ArrayList truckCapacityModels = (ArrayList)session.getAttribute("truckCapacityModels");
for(int i=0; i<truckCapacityModels.size();i++)
{
	theTruckCapacityModel = new TruckCapacityModel();
	theTruckCapacityModel = (TruckCapacityModel)truckCapacityModels.get(i);
	System.out.print("theTruckCapacityModel.getDeliveryDate" + i +":");
	System.out.println(theTruckCapacityModel.getDeliveryDate());
}

CompanyManager companyManager =  webOperator.getCompanyManager();
String backPage = (String)session.getAttribute("backPage");
companyManager.addTruckCapacity(truckCapacityModels);
%>
<jsp:forward page="<%=backPage%>"/>