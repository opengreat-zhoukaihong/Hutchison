<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>  
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagSjf" scope="session" class="com.cbtb.util.NewPagination" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","GUANLAN"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
String companyId = request.getParameter("companyId");
String companyName = request.getParameter("companyName");
String truckerName = request.getParameter("truckerName");
String matchNumber = request.getParameter("matchNumber");
String hkPlateNo = request.getParameter("hkPlateNo");
String deliveryDate = request.getParameter("deliveryDate");
String deliveryTimeId = request.getParameter("deliveryTimeId");
String orderByField = request.getParameter("orderByField");    
int pageNum =Integer.parseInt(request.getParameter("pageNum"));
//mcrm=(MatchModel)session.getAttribute("matchModel"); 
    ArrayList guanLan = (ArrayList)session.getAttribute("guanLan");     
    //boolean updateStatus=false;   


    

    MatchManager mm=webOperator.getMatchManager();

if (mm.updateGuanLan(guanLan))  

{
session.removeAttribute("guanLan");
pagSjf.setRecords(mm.searchMatchInfo(companyId, companyName, matchNumber,    truckerName, deliveryDate, deliveryTimeId,hkPlateNo,orderByField));
pagSjf.setPageNo(pageNum);
%>
<jsp:forward page="GUpdateStatus.jsp" >
   <jsp:param name="init" value="search" />
   <jsp:param name="type" value="N" />


</jsp:forward>
<%}
else{
%>
<jsp:forward page="ErrorPage.jsp?errorMessage=ER_0001" />
<%}
%>