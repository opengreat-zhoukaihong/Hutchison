<%@ include file="Init.jsp"%>   
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>  
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="cpm" scope="page" class="com.cbtb.model.CompanyProfileModel" />



<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_REGISTRATION"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
    String operate = request.getParameter("operate");
    String back = request.getParameter("back");
    cpm=(CompanyProfileModel)session.getAttribute("companyProfileModel"); 
    boolean status=false;   
    String url=null;
    CompanyManager cm=webOperator.getCompanyManager();

if ("reg".equalsIgnoreCase(back))  {
  if (operate.equalsIgnoreCase("insert"))    
     {
       status = cm.addCompanyProfile(cpm);
     }
  if (operate.equalsIgnoreCase("update"))    
     {
       status = cm.updateCompanyProfile(cpm);
     }
if (status)
  {
     dbList.loadCompanyList();
  }
  if ((status) && (operate.equalsIgnoreCase("insert")))
     {
       session.removeAttribute("companyProfileModel"); 
%>
<jsp:forward page="RegistrationSearch.jsp" >

</jsp:forward>
<%   }
  if  ((status) && (operate.equalsIgnoreCase("update"))) 
     {
       session.removeAttribute("companyProfileModel"); 
   //<jsp:param name="companyId" value="<%=cpm.getCompanyId()%>"/>
%>
<jsp:forward page="RegistrationSearch.jsp" >

</jsp:forward>
<% 
     }
  if (!(status)) 
    {
       session.removeAttribute("companyProfileModel"); 
%>
<jsp:forward page="ErrorPage.jsp?errorMessage=ER_0001" />
<%  }

}


else {
  if (operate.equalsIgnoreCase("insert"))    
    {
      status = cm.addCompanyProfile(cpm);

    }
  if (operate.equalsIgnoreCase("update"))    
    {
      status = cm.updateCompanyProfile(cpm);

    }
if (status)
  {
     dbList.loadCompanyList();
  }

  if ((status) && (operate.equalsIgnoreCase("insert")))
    {
       session.removeAttribute("companyProfileModel"); 
%>

<jsp:forward page="SearchOrg.jsp" >

</jsp:forward>
<%  }
  if  ((status) && (operate.equalsIgnoreCase("update"))) 
    {
       session.removeAttribute("companyProfileModel"); 
      if (CbtbConstant.COMPANY_TYPE_TRUCKER.equalsIgnoreCase(cpm.getCompanyType()))
{
%>

<jsp:forward page="UserSearchCompany.jsp" >
   <jsp:param name="companyId" value="<%=cpm.getCompanyId()%>"/>
</jsp:forward>
<% 
}
 if (CbtbConstant.COMPANY_TYPE_SHIPPER.equalsIgnoreCase(cpm.getCompanyType()))
{
%>
<jsp:forward page="UserSearchCompanyShipper.jsp" >
   <jsp:param name="companyId" value="<%=cpm.getCompanyId()%>"/>
</jsp:forward>
<%
}
    }
  if (!(status)) {
       session.removeAttribute("companyProfileModel"); 
%>
<jsp:forward page="ErrorPage.jsp?errorMessage=ER_0001" />
<%  }
}
%>