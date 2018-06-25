<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="net.line.fortress.apps.system.*"%>
<%@ page import="com.cbtb.web.WebOperator"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="cbtbConstant" scope="page" class="com.cbtb.util.CbtbConstant" />
<%


  String organizationId = request.getParameter("domainId");
  String userId   = request.getParameter("userId");
  String password = "";
  WebOperator webOperator = new WebOperator();
  out.println(organizationId+userId+password);

          String goPage = "";

	  if(webOperator.testLogin(organizationId,userId,password))
	  {
	  companyProfileModel = webOperator.getCompanyProfileModel();
	  session.setAttribute("companyProfileModel",companyProfileModel);
	  String companyType = companyProfileModel.getCompanyType();
	  //out.println(companyName);
   
	    if (companyType.equalsIgnoreCase(cbtbConstant.COMPANY_TYPE_SHIPPER))
                 	goPage = "indexshipping.jsp";
 	   else if (companyType.equalsIgnoreCase(cbtbConstant.COMPANY_TYPE_TRUCKER))
         		goPage = "indexTrucking.jsp";
    	   else
                goPage = "ErrorPage.jsp";
  	   }
          else
           {
                 goPage = "ErrorPage.jsp";
    	   }
// 	out.println(goPage);
	session.setAttribute("webOperator",webOperator); 
	response.sendRedirect(goPage);

 	
%>