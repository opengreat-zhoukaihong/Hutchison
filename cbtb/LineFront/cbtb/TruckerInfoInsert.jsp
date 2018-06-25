<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />
<%
    tdm=(TruckerDataModel)session.getAttribute("truckerDataModel");
    String backPageName = "";
    CompanyManager cm=webOperator.getCompanyManager();
  if (cm.addTruckerData(tdm))
    {
    backPageName = "SuccessPage.jsp?backPage=Trucker_index.htm&mode=Insert";}
  else{
    backPageName = "ErrorPage.jsp?backPage=Trucker_index.htm&mode=Insert";
      }
%>

<jsp:forward page="<%=backPageName%>" />
