<html><!-- #BeginTemplate "/Templates/DEMOAPP_Login.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>DemoApp - Login</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="Expire" CONTENT="now">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="Mon, 01 Jan 1990 00:00:01 GMT">
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="3"> <font face="Arial, Helvetica, sans-serif" size="2"><b>LCN 
      User Profile Management</b></font></td>
  </tr>
  <tr bgcolor="#003366"> 
    <td width="100">&nbsp; </td>
    <td colspan="2"><font color="#FFFFFF" face="Arial, Helvetica, sans-serif" size="2"><b>AdminApp 
      Demo Application<br>
      &nbsp; </b></font></td>
  </tr>
</table>
<!-- #BeginEditable "Body" --> <%
	String					pUserID, pUserOrgID;

	pUserID = request.getParameter( "UserID" );
	pUserOrgID = request.getParameter( "UserOrgID" );

	if ( pUserID != null )	{
		Cookie c = new Cookie( "demoAppCookie", "UserID=" + pUserID + ",UserOrgID=" + pUserOrgID );

		response.addCookie( c );
		response.sendRedirect( "Menu/pgMainMenu.jsp" );
		}
%> 
<p>&nbsp;</p>
<form method="post" action="pgLogin.jsp">
<!form method="post" action="pgLogin.jsp?key=<%=(new Date()).getTime()%>">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="50%"> 
        <div align="right">User ID:</div>
      </td>
      <td width="50%"> 
        <input type="text" name="UserID" value="jim.lai">
      </td>
    </tr>
    <tr> 
      <td width="50%"> 
        <div align="right">Organization:</div>
      </td>
      <td width="50%"> 
        <input type="text" name="UserOrgID" value="demoApp">
      </td>
    </tr>
    <tr> 
      <td width="50%"> 
        <div align="right">Password:</div>
      </td>
      <td width="50%"> 
        <input type="password" name="UserPassword" value="demo">
      </td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Login" value="Login">
  </p>
</form>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>
