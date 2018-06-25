<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="containerTypeBean" scope="page" class="com.cbtb.javabean.ContainerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%

  String backPageName="";
String containerTypeId=request.getParameter("containerTypeId");
String trailerTypeId=request.getParameter("trailerTypeId");
  if (containerTypeBean.containerTypeDelete(containerTypeId,trailerTypeId))
    {
    backPageName = "SuccessPage.jsp?backPage=ContainerTypeList.jsp&mode=Delete";
    dbList.loadContainerTypeList();
     }
  else
    backPageName = "ErrorPage.jsp?errorMessage=ER_0001";
%>
<jsp:forward page="<%=backPageName%>" />
