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
<h2>All Office Profiles</h2>
<%
		UPMAdaptorHome		adaptorh;
		UPMAdaptor			adaptor;
		officeObject		officeObj;
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
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Office<br>
        ID</font></b></font></div>
    </td>
    <td bgcolor="#003366"><b><font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif" size="-3">Region</font></b></td>
    <td bgcolor="#003366"><b><font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif" size="-3">Country</font></b></td>
    <td bgcolor="#003366"> 
      <p align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Created<br>
        By </font></b></font></p>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Status</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Desc</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Address</font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Billing<br>
        Address </font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Shipping<br>
        Address </font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Main<br>
        Phone </font></b></font></div>
    </td>
    <td bgcolor="#003366"> 
      <div align="center"><font color="#FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="-3">Fax<br>
        Phone </font></b></font></div>
    </td>
  </tr>
  <%			
			vec = adaptor.searchOffice( currUserID, currUserOrgID, null, null, 0, 0 );
			for (a=0; a < vec.size(); a++)	{
				officeObj = (officeObject) vec.elementAt(a);
%> 
  <tr valign="top" <% if ( a % 2 == 1 ) { out.print("bgcolor=#FFFFDD");}; %>> 
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><a href="../show/pgShowOfficeP.jsp?l=<%=officeObj.getL()%>"><%=officeObj.getL()%>&nbsp;</a></font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=officeObj.getLocationRegion()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=officeObj.getLocationCountry()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=officeObj.getCreator()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=officeObj.getStatus()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%=officeObj.getDescription()%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( officeObj.getAddrLine1() != null )
			out.print( 
			officeObj.getAddrLine1() + "<br>" 
			+ officeObj.getAddrLine2() + "<br>" 
			+ officeObj.getAddrLine3() + "<br>"
			+ officeObj.getAddrLine4() + "<br>"
			+ officeObj.getAddrLine5() + "<br>"
			+ officeObj.getAddrCity() + "<br>"
			+ officeObj.getAddrState() + ", "
			+ officeObj.getAddrPostalCode() + "<br>"
			+ officeObj.getAddrCountry() );
			%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%		
		if ( officeObj.getBillingAddrLine1() != null )
			out.print( 
			officeObj.getBillingAddrLine1() + "<br>" 
			+ officeObj.getBillingAddrLine2() + "<br>" 
			+ officeObj.getBillingAddrLine3() + "<br>"
			+ officeObj.getBillingAddrLine4() + "<br>"
			+ officeObj.getBillingAddrLine5() + "<br>"
			+ officeObj.getBillingAddrCity() + "<br>"
			+ officeObj.getBillingAddrState() + ", "
			+ officeObj.getBillingAddrPostalCode() + "<br>"
			+ officeObj.getBillingAddrCountry() );
			%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( officeObj.getShippingAddrLine1() != null )
			out.print( 
			officeObj.getShippingAddrLine1() + "<br>" 
			+ officeObj.getShippingAddrLine2() + "<br>" 
			+ officeObj.getShippingAddrLine3() + "<br>"
			+ officeObj.getShippingAddrLine4() + "<br>"
			+ officeObj.getShippingAddrLine5() + "<br>"
			+ officeObj.getShippingAddrCity() + "<br>"
			+ officeObj.getShippingAddrState() + ", "
			+ officeObj.getShippingAddrPostalCode() + "<br>"
			+ officeObj.getShippingAddrCountry() );
			%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( officeObj.getMainPhoneCountryCode() != null )
			out.print( 
			officeObj.getMainPhoneCountryCode() + "-" 
			+ officeObj.getMainPhoneAreaCode() + "-" 
			+ officeObj.getMainPhoneLocalNo() );
			%>&nbsp;</font></td>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="-3"><%
		if ( officeObj.getFaxPhoneCountryCode() != null )
			out.print( 
			officeObj.getFaxPhoneCountryCode() + "-" 
			+ officeObj.getFaxPhoneAreaCode() + "-" 
			+ officeObj.getFaxPhoneLocalNo() );
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
