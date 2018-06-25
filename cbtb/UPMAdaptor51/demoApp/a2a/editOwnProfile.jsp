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
<%@ page import="net.line.lcn.upm.adminApp.a2a.*" %>
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

	String redirPage = UIRedirector.redirectToAppPage( "DemoApp", currUserID, currUserOrgID, "changeUserProfile" );
	out.println( redirPage );
%> 
