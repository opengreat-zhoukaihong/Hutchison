<html>
<head>
	<title>Untitled</title>
</head>

<%@ page import="java.util.*" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="java.rmi.*" %>

<%@ page import="net.line.lcn.upm.adminApp.*" %>
<%@ page import="net.line.lcn.util.*" %>
<%@ page import="net.line.lcn.util.ldapUtil" %>
<%@ page import="net.line.lcn.upm.adminApp.dataobj.*" %>

<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.directory.*" %>

<%@ page import="netscape.ldap.*" %>

<%	Enumeration		paramEnum = request.getHeaderNames();
	String			param;
%>
<body>

<h2>The following are the parameter received:</h2>
<table border=1 width=100% halign=center>
<%	paramEnum = request.getParameterNames();
	
	while (paramEnum.hasMoreElements() )	{
%>
	<tr>
<%
		param = (String) paramEnum.nextElement();
%>
		<td width=20% align=right><pre><%=param%></pre></td>
		<td width=80%><pre><%=request.getParameter(param)%></pre></td>
<% System.out.println( "updateReceiver: " + param + "=" + request.getParameter(param)); %>
	</tr>
<%		} %>
</table>

<h2>Decrypted Information</h2>
<table width="100%" border="1" cellspacing="2" cellpadding="2">
  <tr>
    <td>FromApplication</td>
    <td><%=request.getParameter( CentralControl.FORMVAR_FROMAPP )%></td>
  </tr>
  <tr>
    <td>RequestData</td>
    <td><%=request.getParameter( CentralControl.FORMVAR_DATA )%></td>
  </tr>
</table>
<%
	System.out.println( "RequestData=[" + securityUtil.decryptAppData( "AdminApp", "DemoApp", request.getParameter( CentralControl.FORMVAR_DATA ) ) );
%>
<p>&nbsp;</p>
<h2>HTTP Header</h2>
<table border=1 width=100% halign=center>

<%
	while (paramEnum.hasMoreElements() )	{
%> 
  <tr> <%
		param = (String) paramEnum.nextElement();
%> 
    <td width=20% align=right> 
      <pre><%=param%></pre>
    </td>
    <td width=80%> 
      <pre><%=request.getHeader(param)%></pre>
    </td>
  </tr>
  <%		} %> 
</table>
<h2>-- End of List --</h2>
<p>&nbsp;</p>
</body>
</html>
