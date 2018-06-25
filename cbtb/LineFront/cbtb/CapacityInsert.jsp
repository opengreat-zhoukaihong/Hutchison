<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

ArrayList truckCapacityModels = (ArrayList)session.getAttribute("truckCapacityModels");
CompanyManager companyManager =  webOperator.getCompanyManager();
String backPage = "CapacityList.jsp";
if(companyManager.addTruckCapacity(truckCapacityModels))
{
  System.out.println("CapacityInsert.jsp is ok!");
}
else
{
  System.out.println("CapacityInsert.jsp is fail!");
	response.sendRedirect("ErrorPage.jsp?errorMessage=ER_0001");
}
System.out.println("backpage:"+backPage);

%>
<jsp:forward page="<%=backPage%>"/>