<%@ page contentType="text/html;charset=UTF-8"%>
<%@ language="java" errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="tradingPartnerBean" scope="page" class="com.cbtb.javabean.TradingPartnerJB" />
<%
  CbtbConstant cbtbConstant = new CbtbConstant();
  String backPageName = "";
  backPageName = request.getParameter("path");
  String arrayData[] = new String[12];
  arrayData[0]=request.getParameter("companyId");
  arrayData[1]=request.getParameter("tradingPartnerId");
  arrayData[2]=request.getParameter("tradingPartnerName");
  arrayData[3]=request.getParameter("tradingPartnerChineseName");
  arrayData[4]=request.getParameter("contactPerson");
  arrayData[5]=request.getParameter("contactChinesePerson");
  arrayData[6]=request.getParameter("telephoneNo");
  arrayData[7]=request.getParameter("tradingPartnerAddr1");
  arrayData[8]=request.getParameter("tradingPartnerAddr2");
  arrayData[9]=request.getParameter("tradingPartnerAddr3");
  arrayData[10]=request.getParameter("tradingPartnerAddr4");
  arrayData[11]=cbtbConstant.TRADING_PARTNER_EFFECTIVE;
  if (tradingPartnerBean.tradingPartnerUpdate(arrayData)){
     dbList.loadTradingPartnerList();
  }
  //for(int i=0;i<12;i++){
  //    out.println(i + " = " + arrayData[i]);
  //}

%>
<jsp:forward page="<%= backPageName %>" />



