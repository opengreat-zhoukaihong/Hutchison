<%@ page errorPage="ErrorPage.jsp"%>
<%@page import="net.line.fortress.apps.system.*"%>
<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<%
  String domainId = request.getParameter("domainId");
  String userId   = request.getParameter("userId");
  String password = request.getParameter("password");
  String goPage = "";
  out.println(domainId+userId+password);
  if(webOperator.login(domainId,userId,password))
  {
    goPage = "index.jsp";
  }
  else
   {
     goPage = "ErrorPage.jsp";
    }
  out.println(goPage);
  response.sendRedirect(goPage);
%>