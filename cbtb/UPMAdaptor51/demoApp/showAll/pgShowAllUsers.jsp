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
<%@ page import="net.line.lcn.upm.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.util.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.dataobj.*" %>
<%@ page import="net.line.lcn.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.directory.*" %> 
<%@ page import="netscape.ldap.*" %>
<%@ include file="../include/init.jsp" %>
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
    <td colspan="3"><font face="Courier New, Courier, mono" size="2"><a href="../Menu/pgMainMenu.jsp">[Main 
      Menu]</a></font></td>
    <td>
      <div align="right"><font face="Courier New, Courier, mono" size="2"><a href="../pgLogout.jsp">[Logout]</a></font></div>
    </td>
  </tr>
</table>

<!-- #BeginEditable "Body" --> 
<h2>All User Profiles</h2>
<%
		UPMAdaptorHome		adaptorh;
		UPMAdaptor			adaptor;
		userObject			userObj;
		int					a;
		Vector				vec;
	
		// Create a connection to WebLogic
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
		env.put(Context.PROVIDER_URL, "t3://localhost:7001");
	
		try {
		
			InitialContext ic = new InitialContext(env);

			adaptorh = (UPMAdaptorHome) ic.lookup("net.line.lcn.upm.UPMAdaptor");
			
			if (adaptorh == null)	{
				out.println("Cannot locate UPMAdaptor" );
			}

			adaptor = adaptorh.create();
%> 
<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr> 
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">User<br>
        ID</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Title</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Region</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Country</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <p align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">user</font></b></font></p>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Status</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">timeZone</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Office 
        Phone </font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Mobile</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Fax</font></b></font></div>
    </td>
  </tr>
  <%			
			vec = adaptor.searchUser( currUserID, currUserOrgID, null, null, 0, 0 );
			for (a=0; a < vec.size(); a++)	{
				userObj = (userObject) vec.elementAt(a);
%> 
  <tr valign="top" <% if ( a % 2 == 1 ) { out.print("bgcolor=#FFFFDD");}; %>> 
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><a href="../show/pgShowUserP.jsp?uid=<%=userObj.getUid()%>"><%=userObj.getUid()%></a>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userObj.getTitle()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userObj.getLocationRegion()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userObj.getLocationCountry()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userObj.getLocationOffice()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userObj.getStatus()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userObj.getTimeZone()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( userObj.getOfficePhoneCountryCode() != null )
			out.print( 
			userObj.getOfficePhoneCountryCode() + "-" 
			+ userObj.getOfficePhoneAreaCode() + "-" 
			+ userObj.getOfficePhoneLocalNo() );
			%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( userObj.getMobilePhoneCountryCode() != null )
			out.print( 
			userObj.getMobilePhoneCountryCode() + "-" 
			+ userObj.getMobilePhoneAreaCode() + "-" 
			+ userObj.getMobilePhoneLocalNo() );
			%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( userObj.getFaxPhoneCountryCode() != null )
			out.print( 
			userObj.getFaxPhoneCountryCode() + "-" 
			+ userObj.getFaxPhoneAreaCode() + "-" 
			+ userObj.getFaxPhoneLocalNo() );
			%>&nbsp;</font></td>
  </tr>
  <%
			}

		} catch (Exception e) {
			out.println("---- EXCEPTION ------------------");
			out.println("Exception: " + e );
		}
%> 
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>
