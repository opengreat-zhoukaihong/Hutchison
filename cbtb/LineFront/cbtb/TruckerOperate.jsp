
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>  
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />


<%

    tdm=(TruckerDataModel)session.getAttribute("truckerDataModel"); 


    CompanyManager cm=webOperator.getCompanyManager();


  if ( cm.addTruckerData(tdm)) {
  
       dbList.loadTruckerList();
       session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="TruckerList.jsp" >
   <jsp:param name="companyId" value="<%=tdm.getCompanyId()%>"/>
</jsp:forward>

<% 
     }
 else
    {
       session.removeAttribute("truckerDataModel"); 
%>
<jsp:forward page="ErrorPage.jsp?errorMessage=ER_0001" />
<%  }


%>