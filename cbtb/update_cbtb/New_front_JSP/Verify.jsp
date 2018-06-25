<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="net.line.fortress.apps.system.*"%>
<%@ page import="com.cbtb.web.WebOperator"%>
<%@ page import="com.cbtb.exception.*"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="cbtbConstant" scope="page" class="com.cbtb.util.CbtbConstant" />
<%
  session.removeAttribute("webOperator");
  WebOperator webOperator = new WebOperator();

  // now get domainID,userID,encryptedPassword,and these value stored in WebOperator field
  webOperator.decryptTLToCbtb(request.getParameter("RequestData"));
  String domainID = webOperator.getDomainID();
  String userID = webOperator.getUserID();
  String encrypedPassword = webOperator.getEncrypedPassword();

  String goPage = "";
        try{
	  if(webOperator.TLFrontLogin(domainID,userID,encrypedPassword))
	  {
	  companyProfileModel = webOperator.getCompanyProfileModel();
	  session.setAttribute("companyProfileModel",companyProfileModel);
	  String companyType = companyProfileModel.getCompanyType();

          if (companyType.equalsIgnoreCase(cbtbConstant.COMPANY_TYPE_SHIPPER))
                 	goPage = "indexShipping.jsp";
 	   else if (companyType.equalsIgnoreCase(cbtbConstant.COMPANY_TYPE_TRUCKER))
         		goPage = "indexTrucking.jsp";
    	   else
                goPage = "index.jsp";
  	   }
          else
           {
                 goPage = "index.jsp";
    	   }
          }catch(CbtbException ce)
	  {
	  if(ce.getErrorCode().equalsIgnoreCase("SE_0001")    //user not found
             ||ce.getErrorCode().equalsIgnoreCase("SE_0003")  )  // invalid password
            goPage ="UserNotFound.jsp";
          else if (ce.getErrorCode().equalsIgnoreCase("SEC_1003")) //domain not found
            goPage = "DomainNotFound.jsp";
	  }catch(Exception e)
          {
            goPage ="Index.jsp";
          }
	session.setAttribute("webOperator",webOperator);
	response.sendRedirect(goPage);
%>