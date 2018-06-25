<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryTimeBean" scope="page" class="com.cbtb.javabean.DeliveryTimeJB" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName = "";
  String arrayData[] = new String[4]; 
  arrayData[0]=request.getParameter("deliveryTimeId");
  arrayData[1]=request.getParameter("deliveryTimeDesc");
  arrayData[2]=request.getParameter("chineseDesc");
  arrayData[3]=constant.MASTER_CODE_ACTIVE;
  if (deliveryTimeBean.deliveryTimeUpdate(arrayData)){
     dbList.loadDeliveryTimeList();
     backPageName = "SuccessPage.jsp?backPage=DeliveryTimeList.jsp&mode=Update";
  }
  else
     backPageName = "ErrorPage.jsp?backPage=DeliveryTimeList.jsp&mode=Update";
%>
<jsp:forward page="<%=backPageName%>" />

