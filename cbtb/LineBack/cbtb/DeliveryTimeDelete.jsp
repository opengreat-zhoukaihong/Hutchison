<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryTimeBean" scope="page" class="com.cbtb.javabean.DeliveryTimeJB" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName = "";
  String deliveryTimeId; 
  deliveryTimeId=request.getParameter("deliveryTimeId");
  if (deliveryTimeBean.deliveryTimeDelete(deliveryTimeId)){
    dbList.loadDeliveryTimeList();
    backPageName = "SuccessPage.jsp?backPage=DeliveryTimeList.jsp&mode=Delete";
  }
  else
    backPageName = "ErrorPage.jsp?backPage=DeliveryTimeList.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />

