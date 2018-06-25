<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>  
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","TRUCKER"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
    String operate = request.getParameter("operate");
    String back = request.getParameter("back");
    tdm=(TruckerDataModel)session.getAttribute("truckerDataModel"); 
    boolean status=false;   
    String url=null;
    CompanyManager cm=webOperator.getCompanyManager();

if ("reg".equalsIgnoreCase(back))  {
  if (operate.equalsIgnoreCase("insert"))    
     {
       status = cm.addTruckerData(tdm);
     }
  if (operate.equalsIgnoreCase("update"))    
     {
       status = cm.updateTruckerData(tdm);
     }
if (status)
  {
     dbList.loadTruckerList();
  }
  if ((status) && (operate.equalsIgnoreCase("insert")))
     {
       session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="RegistrationTruckerView.jsp" >
   <jsp:param name="companyId" value="<%=tdm.getCompanyId()%>"/>
</jsp:forward>
<%   }
  if  ((status) && (operate.equalsIgnoreCase("update"))) 
     {
       session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="RegistrationSearch.jsp" >

</jsp:forward>
<% 
     }
  if (!(status)) 
    {
       session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="ErrorPage.jsp?errorMessage=ER_0001" />
<%  }

}


else {
  if (operate.equalsIgnoreCase("insert"))    
    {
      status = cm.addTruckerData(tdm);
      if (status) url="SearchOrg.jsp";
    }
  if (operate.equalsIgnoreCase("update"))    
    {
      status = cm.updateTruckerData(tdm);
      if (status) url="SearchOrg.jsp"; 
    }

if (status)
  {
     dbList.loadTruckerList();
  }

  if ((status) && (operate.equalsIgnoreCase("insert")))
    {
      session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="UserSearchCompany.jsp" >
   <jsp:param name="companyId" value="<%=tdm.getCompanyId()%>"/>
</jsp:forward>
<%  }
  if  ((status) && (operate.equalsIgnoreCase("update"))) 
    {
      session.removeAttribute("truckerDataModel"); 
%>

<jsp:forward page="CapacityListbyTrucker.jsp" >
   <jsp:param name="truckerId" value="<%=tdm.getTruckerId()%>" />
   <jsp:param name="companyId" value="<%=tdm.getCompanyId()%>" />



</jsp:forward>
<% 
    }
  if (!(status)) {
     session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="ErrorPage.jsp?errorMessage=ER_0001" />
<%  }
}
%>