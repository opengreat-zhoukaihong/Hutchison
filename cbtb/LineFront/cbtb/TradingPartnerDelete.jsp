<%@ page contentType="text/html;charset=UTF-8"%>
<%@ language="java" errorPage="ErrorPage.jsp" %>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="tradingPartnerBean" scope="page" class="com.cbtb.javabean.TradingPartnerJB" />
<%
  webOperator.clearPermissionContext(); 
  webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
  webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
  if (!webOperator.checkPermission())
  {
     response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  }

  String backPageName = "";
  String tradingPartnerId; 
  String zbackPageName = "";
  CbtbConstant cbtbConstant = new CbtbConstant();
  backPageName = request.getParameter("path");
  tradingPartnerId=request.getParameter("tradingPartnerId");
  if (tradingPartnerBean.tradingPartnerDelete(tradingPartnerId,cbtbConstant.TRADING_PARTNER_NOT_EFFECTIVE)){
      dbList.loadTradingPartnerList();
  }
%>
<jsp:forward page="<%=backPageName%>" />