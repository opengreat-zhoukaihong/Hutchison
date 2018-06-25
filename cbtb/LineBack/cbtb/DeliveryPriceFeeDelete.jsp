<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="deliveryPriceFeeBean" scope="page" class="com.cbtb.javabean.DeliveryPriceFeeJB" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String containerTypeId=request.getParameter("containerTypeId");
  String cityId=request.getParameter("cityId");
  String backPageName = "";
  if (deliveryPriceFeeBean.DeliveryPriceFeeDelete(containerTypeId,cityId))
	{
    backPageName = "SuccessPage.jsp?backPage=DeliveryPriceFeeList.jsp&mode=Delete";
	}
  else
    backPageName = "ErrorPage.jsp?backPage=DeliveryPriceFeetList.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />