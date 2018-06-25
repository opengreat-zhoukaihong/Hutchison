<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="tradingPartnerValue"  scope="session"  class="com.cbtb.ejb.entity.TradingPartnerValue" />
<jsp:useBean id="tradingPartnerBean" scope="page" class="com.cbtb.javabean.TradingPartnerJB" />
<%
  webOperator.clearPermissionContext(); 
  webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
  webOperator.putPermissionContext("action", "edit"); //加入检查的内容
  if (!webOperator.checkPermission())
  {
     response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  }

  int ww = 0;
  String backPageName ="";
  backPageName = request.getParameter("path");
  CbtbConstant cbtbConstant = new CbtbConstant();
  String arrayData[] = new String[12]; 
  arrayData[0]=tradingPartnerValue.companyId;
  arrayData[1]=tradingPartnerValue.tradingPartnerId;
  arrayData[2]=tradingPartnerValue.tradingPartnerName;
  arrayData[3]=tradingPartnerValue.tradingPartnerChineseName;
  arrayData[4]=tradingPartnerValue.contactPerson;
  arrayData[5]=tradingPartnerValue.contactChinesePerson;
  arrayData[6]=tradingPartnerValue.telephoneNo;
  arrayData[7]=tradingPartnerValue.tradingPartnerAddr1;
  arrayData[8]=tradingPartnerValue.tradingPartnerAddr2;
  arrayData[9]=tradingPartnerValue.tradingPartnerAddr3;
  arrayData[10]=tradingPartnerValue.tradingPartnerAddr4;
  arrayData[11]=cbtbConstant.TRADING_PARTNER_EFFECTIVE;

  if(request.getParameter("action").equals("Insert"))
  {
    ww = 1;
   if (tradingPartnerBean.tradingPartnerInsert(arrayData)){
       dbList.loadTradingPartnerList();
       ww = 2;
    }
  }
  else
      {
      if (tradingPartnerBean.tradingPartnerUpdate(arrayData)){
          dbList.loadTradingPartnerList();
          ww = 2;
      } 
  }
%>
<jsp:forward page="<%= backPageName %>" />
