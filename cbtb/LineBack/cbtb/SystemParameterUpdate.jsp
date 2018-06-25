<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="parameterBean" scope="page" class="com.cbtb.javabean.SystemParameterJB" />
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","SYSTEM_PARAMETER"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String backPageName = "";
  String arrayData[] = new String[9]; 
  arrayData[0]=request.getParameter("recordId");
  arrayData[1]=request.getParameter("processLeadTime");
  arrayData[2]=request.getParameter("maxUserForTruck");
  arrayData[3]=request.getParameter("maxUserForShippe");
  arrayData[4]=request.getParameter("invoiceSpecificDay1");
  arrayData[5]=request.getParameter("invoiceSpecificDay2");
  arrayData[6]=request.getParameter("invoiceSpecificDay3");
  arrayData[7]=request.getParameter("invoiceSpecificDay4");
  arrayData[8]=request.getParameter("invoiceDuedays");
  if ((arrayData[5].trim()).length()==0)
     arrayData[5]="0";
  if ((arrayData[6].trim()).length()==0)
     arrayData[6]="0";
  if ((arrayData[7].trim()).length()==0)
     arrayData[7]="0";
  if (parameterBean.systemParameterUpdate(arrayData)){
      backPageName = "SuccessPage.jsp?backPage=MasterDataMaintenance.jsp&mode=Update";
  }
  else
     backPageName = "ErrorPage.jsp?backPage=MasterDataMaintenance.jsp&mode=Update";
%>
<jsp:forward page="<%=backPageName%>" />