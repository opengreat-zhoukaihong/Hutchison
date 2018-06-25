<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="shippingLineBean" scope="page" class="com.cbtb.javabean.ShippingLineJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","SHIPPING_LINE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String shippingLineData[] = new String[4];
  String backPageName="";
  shippingLineData[0]=request.getParameter("shippingLineId");
  shippingLineData[1]=request.getParameter("desc");
  shippingLineData[2]=request.getParameter("chineseDesc");
  shippingLineData[3]=constant.MASTER_CODE_ACTIVE;
if (shippingLineBean.shippingLineInsert(shippingLineData))
    {
    backPageName = "SuccessPage.jsp?backPage=ShippingLineList.jsp&mode=Insert";
    dbList.loadShippingLineList();
     }
  else
    backPageName = "ErrorPage.jsp?backPage=ShippingLineList.jsp&mode=Insert";
%>
<jsp:forward page="<%=backPageName%>" />