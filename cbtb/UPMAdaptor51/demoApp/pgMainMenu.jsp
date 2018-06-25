<html><!-- #BeginTemplate "/Templates/DEMOAPP_Main.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>DemoApp - Main Menu</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="Expire" CONTENT="now">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="Mon, 01 Jan 1990 00:00:01 GMT">
</head>

<body bgcolor="#FFFFFF">
<%@ page import="java.util.*" %>
<%@ page import="java.rmi.*" %>
<%@ page import="javax.ejb.*" %> 
<%@ page import="net.line.lcn.upm.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.util.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.dataobj.*" %>
<%@ page import="net.line.lcn.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.directory.*" %> 
<%@ page import="netscape.ldap.*" %>
<%
	Cookie			demoAppCookie, cArray[];
	Hashtable		ht = new Hashtable();
	int				i;

	cArray = request.getCookies();
	for (i=0; i < cArray.length; i++)	{
		demoAppCookie = cArray[i];
		if ( demoAppCookie.getName().equals( "demoAppCookie" ))	{
			ht = stringUtil.valuePair2Hashtable( demoAppCookie.getValue() );
			}
		}

	String currUserID = (String) ht.get("UserID");
	String currUserOrgID = (String) ht.get("UserOrgID");

	if (currUserID == null)	{
		response.sendRedirect( "pgLogin.jsp" );
	}
%> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="4"> <b><font face="Arial, Helvetica, sans-serif" size="2">LCN 
      User Profile Management</font></b></td>
  </tr>
  <tr> 
    <td width="100" bgcolor="#003366"><font face="Arial, Helvetica, sans-serif" size="2"></font> 
    </td>
    <td colspan="2" bgcolor="#003366"><b><font color="#FFFFFF" face="Arial, Helvetica, sans-serif" size="2">AdminApp 
      Demo Application<br>
      &nbsp;<br>
      </font></b></td>
    <td bgcolor="#003366"> 
      <div align="right"><b><font face="Arial, Helvetica, sans-serif" size="2" color=#ffffff><%=currUserID%>/<%=currUserOrgID%></font></b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="3"><font face="Courier New, Courier, mono" size="2"><a href="pgMainMenu.jsp">[Main 
      Menu]</a></font></td>
    <td>
      <div align="right"><font face="Courier New, Courier, mono" size="2"><a href="pgLogout.jsp">[Logout]</a></font></div>
    </td>
  </tr>
</table>

<!-- #BeginEditable "Body" --> 
<h1 align="center">Main Menu</h1>
<table width="80%" border="0" cellspacing="3" cellpadding="3" align="center">
  <tr valign="top" bgcolor="#003366"> 
    <td colspan="2" bgcolor="#003366"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif"><b><font color="#FFFFFF">Reading 
        from LDAP</font></b></font></div>
    </td>
    <td width="33%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif"><b><font color="#FFFFFF">A2A 
        / SSO</font></b></font></div>
    </td>
  </tr>
  <tr valign="top"> 
    <td width="33%"> 
      <ul>
        <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="show/pgShowUserP.jsp">Show 
          your own user profile</a></font></li>
        <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="show/pgShowOrgP.jsp">Show 
          your own organization profile</a></font></li>
      </ul>
    </td>
    <td width="33%"> 
      <ul>
        <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="showAll/pgShowAllUsers.jsp">Show 
          all users</a></font></li>
        <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="showAll/pgShowAllOffices.jsp">Show 
          all offices</a></font></li>
        <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="showAll/pgShowAllUserGroups.jsp">Show 
          all user groups</a></font></li>
      </ul>
    </td>
    <td width="33%"> 
      <ul>
        <li><font face="Arial, Helvetica, sans-serif" size="2"><a href="a2a/editOwnProfile.jsp">Edit 
          your own AdminApp user profile</a></font></li>
        <li><a href="admin/userAdmin.jsp"><font face="Arial, Helvetica, sans-serif" size="2">Edit 
          Your DemoApp user profile</font></a></li>
        <li><a href="admin/orgAdmin.jsp"><font face="Arial, Helvetica, sans-serif" size="2">Edit 
          Your DemoApp org profile</font></a></li>
      </ul>
      <table width="100%" border="1" cellspacing="2" cellpadding="2">
        <tr> 
          <td> 
            <form name="SSOSendForm" method=Post action="a2a/SSORedirector.jsp">
              <p><font face="Arial, Helvetica, sans-serif" size="1">To App: 
                <select name="<%=CentralControl.FORMVAR_TOAPP%>">
                  <option value="DemoApp">DemoApp</option>
                  <option value="AdminApp">AdminApp</option>
                </select>
                <br>
                <input type="hidden" name="<%=CentralControl.FORMVAR_FROMAPP%>" value="DemoApp">
                </font></p>
              <p align="center"> <font face="Arial, Helvetica, sans-serif" size="1"> 
                <input type="submit" name="Submit" value="Submit">
                </font></p>
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<p align="center"><a href="pgLogout.jsp">Logout</a></p>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>
