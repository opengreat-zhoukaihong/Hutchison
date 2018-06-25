<html>
<head>
<title>DemoApp - Logout</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">

<%
	Cookie	c = new Cookie( "demoAppCookie", "" );
	response.addCookie( c );
	response.sendRedirect( "pgLogin.jsp" );
%>

</body>
</html>
