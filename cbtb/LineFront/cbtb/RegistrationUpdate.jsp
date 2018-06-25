<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cbtb.web.*"%>
<%@ page import="com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.model.*"%>
<%@ include file="Init.jsp"%>
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<%
String goPage="";
CompanyProfileModel companyProfileModel=new CompanyProfileModel();
companyProfileModel=(CompanyProfileModel) session.getAttribute("companyProfileModel");
CompanyManager companyManager = webOperator.getCompanyManager();
  if (companyManager.updateCompanyProfile(companyProfileModel))
   goPage="success.jsp";
 else
   goPage="ErrorPage.jsp";
%>
<jsp:forward page="<%=goPage%>" />