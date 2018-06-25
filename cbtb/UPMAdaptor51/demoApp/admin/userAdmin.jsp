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
<h2 align="center">
<%	
	boolean		isFromAdminApp = false;

	if (request.getParameter("uid")==null)	{	
%>
Your
<%	} else	{	
	isFromAdminApp = true;
%>
<%=request.getParameter("uid")%>'s
<%	}	%>
 DemoApp-specific User Administration</h2>
<form name="MainForm" action="adminOps.jsp" method="post" >
  <input type="hidden" name="uid" value="<%=request.getParameter("uid")%>">
  <table width="300" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <p> 
          <input type="checkbox" name="checkbox" value="checkbox" checked>
          Show People Profile</p>
        <p> 
          <input type="checkbox" name="checkbox2" value="checkbox" checked>
          Show Organization Profile </p>
        <p> 
          <input type="checkbox" name="checkbox22" value="checkbox" checked>
          Can Kill Pigs </p>
      </td>
    </tr>
  </table>
  <p align="center"> 
<%	if ( isFromAdminApp )	{	%>
    <input type="submit" name="pbOk" value="Ok">
    <input type="submit" name="pbCancel" value="Cancel">
<%	} else {	%>
    <input type="button" name="pbOk" value="Ok" onClick="history.go(-1)">
    <input type="button" name="pbCancel" value="Cancel" onClick="history.go(-1)">
<%	}	%>
  </p>
</form>
<p>&nbsp;</p>
<!-- #EndEditable --> 
</body>
<!-- #EndTemplate --></html>
