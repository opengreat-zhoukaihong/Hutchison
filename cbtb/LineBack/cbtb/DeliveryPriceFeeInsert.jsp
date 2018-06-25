<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="deliveryPriceFeeBean" scope="page" class="com.cbtb.javabean.DeliveryPriceFeeJB" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String Data[] = new String[7];
  Data[0]=request.getParameter("containerTypeId");
  Data[1]=request.getParameter("cityId");
  Data[2]=request.getParameter("ibFeeToTruck");
  Data[3]=request.getParameter("obFeeToTruck");
  Data[4]=request.getParameter("ibPriceToShipper");
  Data[5]=request.getParameter("obPriceToShipper");
  Data[6]=constant.MASTER_CODE_ACTIVE;
  String backPageName = "";
  if (deliveryPriceFeeBean.DeliveryPriceFeeInsert(Data))
   {
       backPageName = "SuccessPage.jsp?backPage=DeliveryPriceFeeList.jsp&mode=Insert";
   }
  else
    backPageName = "ErrorPage.jsp?backPage=DeliveryPriceFeeList.jsp&mode=Insert";
%>
<jsp:forward page="<%=backPageName%>" />