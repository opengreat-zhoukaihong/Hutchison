<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
  String goPage = "";

  String deliveryFromDate = request.getParameter("deliveryFromDate");
  String deliveryToDate   = request.getParameter("deliveryToDate");
  Collection col = (Collection)session.getAttribute("GenInvoice");

  Vector vctMatchModel = null;
  if(col != null)
  {
  	  vctMatchModel = new Vector(col);
  }
  session.removeAttribute("GenInvoice");
  BillingManager bm = webOperator.getBillingManager();
  
  Collection colInvoiceDataModel =   bm.createInvoiceByColMatchModel(vctMatchModel,deliveryFromDate,deliveryToDate);
  if(colInvoiceDataModel != null && colInvoiceDataModel.size()>0)
	  session.setAttribute("InvoiceList",colInvoiceDataModel);
  goPage = "InvoiceGenerateList.jsp";
  response.sendRedirect(goPage);

//<jsp:forward page="<%=goPage%>" />
%>









