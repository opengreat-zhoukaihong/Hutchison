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
<h2>All User Group Profiles</h2>
<%
		UPMAdaptorHome		adaptorh;
		UPMAdaptor			adaptor;
		userGroupObject		userGroupObj;
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
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif"><b><font color="#FFFFFF" size="1">userGroup<br>
        ID</font></b></font></div>
    </td>
    <td bgcolor="#003366"><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1" color="#FFFFFF">Status</font></b></font></td>
    <td bgcolor="#003366"><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1" color="#FFFFFF">Category</font></b></font></td>
    <td bgcolor="#003366"><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1" color="#FFFFFF">Sub-Cat</font></b></font></td>
    <td bgcolor="#003366"><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1" color="#FFFFFF">Desc</font></b></font></td>
    <td bgcolor="#003366"><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1" color="#FFFFFF">Owner</font></b></font></td>
  </tr>
  <%			
			vec = adaptor.searchUserGroup( currUserID, currUserOrgID, null, null, 0, 0 );
			for (a=0; a < vec.size(); a++)	{
				userGroupObj = (userGroupObject) vec.elementAt(a);
%> 
  <tr valign="top" <%=( a % 2 == 1 ) ? "bgcolor=#FFFFDD" : "" %>> 
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><a href="../show/pgShowUserGroupP.jsp?gid=<%=userGroupObj.getGid()%>"><%=userGroupObj.getGid()%></a></font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userGroupObj.getStatus()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userGroupObj.getCategory()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userGroupObj.getSubCategory()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userGroupObj.getDescription()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=userGroupObj.getOwner()%>&nbsp;</font> 
    </td>
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
