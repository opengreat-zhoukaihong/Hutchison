<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="net.line.fortress.apps.system.security.*"%>
<%@ page import="com.cbtb.web.WebOperator" %> 
<%
WebOperator wo = new WebOperator();
String domainID = request.getParameter("organizationId");
String userID = request.getParameter("userId");
String password = request.getParameter("password");
out.print(domainID+userID+password);
out.close();
String encrypedText = wo.encryptTLToCbtb(domainID ,userID ,SecurityUtil.encrypt(password ));
response.sendRedirect("Verify.jsp?RequestData="+encrypedText);
%>
