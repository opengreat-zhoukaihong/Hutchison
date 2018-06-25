<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryTimeSlotBean" scope="page" class="com.cbtb.javabean.DeliveryTimeSlotJB" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName = "";
  String arrayData[] = new String[7]; 
  arrayData[0]=request.getParameter("timeSlotId");
  arrayData[1]=request.getParameter("deliveryTimeId");
  arrayData[2]=request.getParameter("fromTime");
  arrayData[3]=request.getParameter("toTime");
  arrayData[4]=request.getParameter("slotDesc");
  arrayData[5]=request.getParameter("slotChineseDesc");
  arrayData[6]=constant.MASTER_CODE_ACTIVE;
  if (deliveryTimeSlotBean.deliveryTimeSlotInsert(arrayData)){
      dbList.loadDeliveryTimeSlotList();
      backPageName = "SuccessPage.jsp?backPage=DeliveryTimeSlotList.jsp&mode=Insert";
  }
  else
     backPageName = "ErrorPage.jsp?backPage=DeliveryTimeSlotList.jsp&mode=Insert";
%>
<jsp:forward page="<%=backPageName%>" />