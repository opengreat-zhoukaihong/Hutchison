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
	UPMAdaptorHome		adaptorh;
	UPMAdaptor			adaptor;
	Cookie			demoAppCookie, cArray[];
	Hashtable		ht = new Hashtable();
	int				i;

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
	
	String fromApp = request.getParameter( CentralControl.FORMVAR_FROMAPP );
	String targetApp = request.getParameter( CentralControl.FORMVAR_TOAPP );
	String targetFunc = request.getParameter( CentralControl.FORMVAR_TARGETFUNC );

	System.out.println("SSOSender: " + targetApp + ", " + targetFunc );
	String redirPage = SSORedirector.redirectToAppPage( fromApp, targetApp, currUserID, currUserOrgID, targetFunc, null );
	//System.out.println("To Page: " + redirPage );
	out.println( redirPage );
%> 
