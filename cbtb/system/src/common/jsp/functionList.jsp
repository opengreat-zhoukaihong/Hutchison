<%-- import section --%>
<%@ page import="java.util.Iterator" %>
<%@ page import="net.line.fortress.apps.cbt.web.HyperLink" %>
<%-- page request section --%>
<%
    String contextPath = (String)request.getContextPath();
    java.util.Collection functionList = (java.util.Collection)request.getAttribute("functionList");
    if (functionList == null)  {
      response.sendRedirect("../../functionList.do");
      return;
    }
%>


<html>

<head>
<meta http-equiv="Content-Type"
content="text/html; charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage Express 2.0">
<title>CBT Function list</title>
</head>

<body bgcolor="#FFFFFF">

<p align="right">&nbsp;</p>

<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>

<blockquote>
  <%
    Iterator iterator = functionList.iterator();
    while (iterator.hasNext()) {
      HyperLink hyperLink = (HyperLink)iterator.next();
  %>
    <p>
  <% if (hyperLink.getHyperLink() != null && !"".equals(hyperLink.getHyperLink())) {%>
    <a href="<%=hyperLink.getHyperLink()%>">
  <% } %>
    <font
    color="#003366" size="2" face="Arial, Helvetica, sans-serif"><b><%=hyperLink.getDescription()%>
    </b></font>
  <% if (hyperLink.getHyperLink() != null && !"".equals(hyperLink.getHyperLink())) {%>
    </a>
  <% } %></p>
  <%
    }
  %>
</blockquote>
</body>
</html>
