<%@ page errorPage="ErrorPage.jsp"%>

<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<%
  if(!webOperator.checkLogin())
     response.sendRedirect("Login.jsp");
  //out.print("test");
%>


