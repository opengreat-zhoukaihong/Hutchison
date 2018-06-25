<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="shippingLineBean" scope="page" class="com.cbtb.javabean.ShippingLineJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","SHIPPING_LINE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String shippingLineId ;
  String backPageName = "";
  shippingLineId=request.getParameter("shippingLineId");
  if (shippingLineBean.shippingLineDelete(shippingLineId))
    {
    backPageName = "SuccessPage.jsp?backPage=ShippingLineList.jsp&mode=Delete";
    dbList.loadShippingLineList();
     }
  else
    backPageName = "ErrorPage.jsp?backPage=ShippingLineList.jsp&mode=Delete";
%>
<jsp:forward page="<%=backPageName%>" />

