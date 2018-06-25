<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryTimeSlotBean" scope="page" class="com.cbtb.javabean.DeliveryTimeSlotJB" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName="";
  String s_timeSlotId="";
  s_timeSlotId=request.getParameter("timeSlotId");
  if (deliveryTimeSlotBean.deliveryTimeSlotDelete(s_timeSlotId)){
      dbList.loadDeliveryTimeSlotList(); 
      backPageName = "SuccessPage.jsp?backPage=DeliveryTimeSlotList.jsp&mode=Delete";
  }
  else
    backPageName = "ErrorPage.jsp?backPage=DeliverySlotTime.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />