<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<%
	String TL_url   = webOperator.getTLURL();
        String domainID = webOperator.getDomainID();
        String userID   = webOperator.getUserID();
        String encryptedPassword = webOperator.getEncrypedPassword();
        String skeyValue = webOperator.encryptCbtbToTL(domainID,userID,encryptedPassword );
	out.println("<html>");
	out.println("<body onload=\"javascript:setTimeout('document.SSOForm.submit()', 0);\">");
	out.println("<form name = SSOForm action="+TL_url+" method=post target=_top>");
	out.println("<INPUT name=RequestData type=hidden value=\""+skeyValue+"\">");
	out.println("/form>");
	out.println("/body>");
	out.println("</html>");

%>




