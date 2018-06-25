<html><!-- #BeginTemplate "/Templates/DEMOAPP_Main.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>DemoApp - </title>
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
    <td colspan="3"><font face="Courier New, Courier, mono" size="2"><a href="../pgMainMenu.jsp">[Main 
      Menu]</a></font></td>
    <td>
      <div align="right"><font face="Courier New, Courier, mono" size="2"><a href="../pgLogout.jsp">[Logout]</a></font></div>
    </td>
  </tr>
</table>

<!-- #BeginEditable "Body" --> <%@ page import "java.util.*" %> <%@ page import "javax.ejb.*" %> 
<%@ page import "java.rmi.*" %> <%@ page import "net.line.lcn.upm.adminApp.*" %> 
<%@ page import "net.line.lcn.util.ldapUtil" %> <%@ page import "net.line.lcn.upm.adminApp.dataobj.*" %> 
<%@ page import "javax.naming.*" %> <%@ page import "javax.naming.directory.*" %> 
<%@ page import "netscape.ldap.*" %> 
<h2 align="center">Your Own Organization Profile</h2>
<%
		organizationHome	orgh;
		organization		org;
		orgObject			orgObj;
	
		// Create a connection to WebLogic
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
		env.put(Context.PROVIDER_URL, "t3://localhost:7001");
	
		try {
		
			InitialContext ic = new InitialContext(env);

			orgh = (organizationHome) ic.lookup("net.line.lcn.upm.adminApp.organization");
			org = orgh.findByPrimaryKey( currUserOrgID );
			orgObj = org.getDO();
%> 
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr valign="top"> 
    <td> 
      <div align="right"><b> <%=orgObj.toString( "</td></tr><tr valign=top><td><div align=right><b>", " : <b></div></td><td><div>")%> 
      </div>
    </td>
    <td>&nbsp;</td>
  </tr>
</table>
<%
		} catch (Exception e) {
			out.println("---- EXCEPTION ------------------");
			out.println("Exception: " + e );
		}
%> 
<p>&nbsp;</p>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>
