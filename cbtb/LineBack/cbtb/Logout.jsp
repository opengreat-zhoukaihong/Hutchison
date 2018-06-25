<%@ page errorPage="ErrorPage.jsp"%>
<%@page import="net.line.fortress.apps.system.*"%>
<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<%
  webOperator.logout();
  String goPage = "index.jsp";
  response.sendRedirect(goPage);
%>