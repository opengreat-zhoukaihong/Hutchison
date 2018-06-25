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
<%@ page import="java.sql.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "edit");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");
CompanyManager companyManager =  webOperator.getCompanyManager();
String backPage = "CapacitySearch.jsp";
if(companyManager.updateTruckCapacity(truckCapacityModel))
{
  System.out.println("CapacityStatusUpdate.jsp is ok!");
}
else
{
  System.out.println("CapacityStatusUpdate.jsp is fail!");
	response.sendRedirect("ErrorPage.jsp?errorMessage=ER_0001");
}
System.out.println("backpage:"+backPage);
%>
<jsp:forward page="<%=backPage%>"/>