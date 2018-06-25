<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%> 
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="deliveryRequestModel" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<jsp:useBean id="deliveryRequestMode" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<%
   webOperator.clearPermissionContext();  
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "edit"); //加入检查的内容
   if (webOperator.checkPermission())
      out.print("");
   else
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  

  String deliveryRequestNum="",strPath; 
  strPath = request.getParameter("path"); 
  session.setAttribute("deliveryRequestMode",deliveryRequestModel);
  companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfile");
  if(request.getParameter("mode").equals("Insert")){
     deliveryRequestModel.setRequestStatus("1");
     if(!webOperator.getCompanyManager().addDeliveryRequest(deliveryRequestModel)){
     ;
      }
  } 
  else {
        if(request.getParameter("mode").equals("UpdateStatus")){
            deliveryRequestNum = request.getParameter("deliveryRequestNum");
            String status = request.getParameter("recordStatus");
            if (webOperator.getCompanyManager().updateDeliveryRequestStatus(deliveryRequestNum,status))
                ;
         }
         else {
              if (webOperator.getCompanyManager().updateDeliveryRequest(deliveryRequestModel))              
                ;
         }
 }
 if(request.getParameter("reAddpath") == null){   
    if(strPath.equals("self")){
 %>
        <jsp:forward page="DeliveryRequestSearch.jsp" />
 <%
    }
    else{
         if(request.getParameter("mode").equals("UpdateStatus")){
           strPath = strPath+ "?companyId=" + request.getParameter("companyId");
          }
          else{
              strPath = strPath+ "?companyId=" + deliveryRequestModel.getCompanyId();
          }
        }
 }
 else{
        strPath = request.getParameter("reAddpath");
 }
 %>
 <jsp:forward page="<%= strPath %>" />