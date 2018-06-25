<%@ page errorPage="ErrorPage.jsp"%>

<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<%
  if(!webOperator.checkLogin())
     response.sendRedirect("index.jsp");
  //out.print("test");
%>


