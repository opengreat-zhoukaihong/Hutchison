<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.DeliveryRequestModel" %>
<jsp:useBean id="mcrm" scope="page" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<%
  DeliveryRequestModel  deliveryRequestModel  = (DeliveryRequestModel)session.getAttribute("deliveryRequestModel");
  String deliveryRequestNum="",strPath;
  String truckCapacityNum=request.getParameter("truckCapacityNum");
  strPath = request.getParameter("path");
  session.setAttribute("deliveryRequestMode",deliveryRequestModel);
  if(request.getParameter("mode").equals("Insert")){
     if(webOperator.getCompanyManager().addDeliveryRequest(deliveryRequestModel)){
       if(truckCapacityNum!=null)
         {
          strPath="ShipperCapacityMarket.jsp?init=Y&truckCapacityNum="+truckCapacityNum;
          MatchManager matchManager = webOperator.getMatchManager();
          mcrm=matchManager.match(deliveryRequestModel.getDeliveryRequestNum(),truckCapacityNum);

          
         }
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
 if(truckCapacityNum==null || truckCapacityNum.trim().length() ==0)
 {

 if(request.getParameter("reAddpath") == null){
    strPath = strPath+ "?companyId=" + deliveryRequestModel.getCompanyId();
  }
 else{
       strPath = request.getParameter("reAddpath") + "?path=" +  request.getParameter("path");
  }

 }
else
 {
  strPath="ShipperCapacityMarket.jsp?init=Y&truckCapacityNum="+truckCapacityNum;
}

 %>
 <jsp:forward page="<%= strPath %>" />
