<%@ page import="java.util.*" %> 
<%@ page import="java.rmi.*" %> 
<%@ page import="javax.ejb.*" %> 
<%@ page import="net.line.lcn.upm.*"%>
<%@ page import="net.line.lcn.upm.adminApp.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.util.*"%>
<%@ page import="net.line.lcn.upm.adminApp.dataobj.*" %> 
<%@ page import="net.line.lcn.util.*" %> 
<%@ page import="javax.naming.*" %> 
<%@ page import="javax.naming.directory.*" %> 
<%@ page import="netscape.ldap.*" %> 
<%@ page import="net.line.lcn.upm.adminApp.a2a.*" %>
<h2>Pass-in Parameters</h2>
<table border=1 width=100% halign=center>
<%
	UPMAdaptorHome		adaptorh;
	UPMAdaptor			adaptor;
	Enumeration			paramEnum = request.getParameterNames();
	String				param;

	// Create a connection to WebLogic
	Hashtable env = new Hashtable();
	env.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
	env.put(Context.PROVIDER_URL, "t3://localhost:7001");
	
	InitialContext ic = new InitialContext(env);
	adaptorh = (UPMAdaptorHome) ic.lookup("net.line.lcn.upm.UPMAdaptor");

	if (adaptorh == null)	{
		out.println("Cannot locate UPMAdaptor" );
	}
	adaptor = adaptorh.create();

	while (paramEnum.hasMoreElements() )	{
%> 
  <tr> <%
		param = (String) paramEnum.nextElement();
%> 
    <td width=20% align=right>
      <pre><%=param%></pre>
    </td>
    <td width=80%>
      <pre><%=request.getParameter(param)%></pre>
    </td>
  </tr>
  <%		} %> 
</table>
<%
	String 		fromApp = null;
	String 		encryptedDataStr = null;
	String 		decryptedDataStr = null;
	Hashtable	dataHT = null;

	fromApp = request.getParameter( CentralControl.FORMVAR_FROMAPP );
	encryptedDataStr = request.getParameter( CentralControl.FORMVAR_DATA );
	decryptedDataStr = adaptor.decryptAppData( "AdminApp", "DemoApp", encryptedDataStr );
	dataHT = stringUtil.valuePair2Hashtable( decryptedDataStr );

	/* Creating session */
	String	currUserID = (String) dataHT.get( CentralControl.FORMVAR_REQID );
	String	currUserOrgID = (String) dataHT.get( CentralControl.FORMVAR_REQORGID );

	System.out.println( "Setting Cookie:" + "UserID=" + currUserID + ",UserOrgID=" + currUserOrgID );

	Cookie c = new Cookie( "demoAppCookie", "UserID=" + currUserID + ",UserOrgID=" + currUserOrgID );

	response.addCookie( c );

	/* Base on the target function, redirect to different page */
	if ( dataHT.get( CentralControl.FORMVAR_TARGETFUNC ).equals( "ChangeUserProfile" ) )
		response.sendRedirect( "admin/userAdmin.jsp?return=AdminApp&uid=" + dataHT.get("uid") );

	if ( dataHT.get( CentralControl.FORMVAR_TARGETFUNC ).equals( "ChangeOrgProfile" ) )
		response.sendRedirect( "admin/orgAdmin.jsp?return=AdminApp&uid=" + dataHT.get("uid") );

	if ( 1 == 0 )	
	{

	System.out.print( "pgMainMenu.jsp" );
%>
<h2>Decrypted Information</h2>
<table width="100%" border="1" cellspacing="2" cellpadding="2">
  <tr>
    <td>FromApplication</td>
    <td><%=request.getParameter( CentralControl.FORMVAR_FROMAPP )%></td>
  </tr>
  <tr>
    <td>RequestData</td>
    <td>
<%=decryptedDataStr %>
</td>
  </tr>
</table>
<h2>Data After Break Down</h2>
<table width="100%" border="1">
<%
	paramEnum = dataHT.keys();
	
	while (paramEnum.hasMoreElements() )	{
		param = (String) paramEnum.nextElement();
%> 
  <tr>
    <td><%=param%> </td>
    <td><%=dataHT.get( param )%></td>
  </tr>
<%
	}
%>
</table>
<p>&nbsp;</p>
<%	}	%>