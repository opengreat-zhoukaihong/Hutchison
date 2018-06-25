<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="InvoiceMaintainPagination" scope="session" class="com.cbtb.util.Pagination" />
<%
  
  String goPage = "";
  String shipperNo        = request.getParameter("shipperNo");
  String invoiceNo        = request.getParameter("invoiceNo");
  String creationFromDate = request.getParameter("creationFromDate");
  String creationToDate   = request.getParameter("creationToDate");
  String invoiceStatus    = request.getParameter("invoiceStatus");

  String updateInvoiceNo  = request.getParameter("updateInvoiceNo");
  String updateIndex      = request.getParameter("updateIndex");
  String newStatus        = request.getParameter("newStatus");
  String oldStatus        = request.getParameter("oldStatus");
  int step = Integer.parseInt(newStatus) - Integer.parseInt(oldStatus) ;
  
  boolean down = false;
  boolean up   = false;
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
  webOperator.putPermissionContext("action", "change_status_down"); //加入检查的内容
  down = webOperator.checkPermission();
 
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
  webOperator.putPermissionContext("action", "change_status_up"); //加入检查的内容
  
  up = webOperator.checkPermission();

  if (!(step == 1 && up || step == -1 && down))
     response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  
  BillingManager bm = webOperator.getBillingManager();
  boolean blnUpdateResult = false;
  if(updateInvoiceNo != null && updateInvoiceNo.trim().length()>0)
  {
    blnUpdateResult =  bm.updateInvoiceDataStatus(updateInvoiceNo,newStatus);
    //if succeeded ,then update the index's invoice status
    InvoiceMaintainPagination.setPageNo(InvoiceMaintainPagination.getPageNo()-1);
    Vector vctCurrentPage = new Vector(InvoiceMaintainPagination.nextPage());
    InvoiceDataModel idm = (InvoiceDataModel)vctCurrentPage.elementAt(Integer.parseInt(updateIndex));
    idm.setInvoiceStatus(newStatus.trim());
    InvoiceMaintainPagination.setPageNo(InvoiceMaintainPagination.getPageNo()-1);
     goPage = "InvoiceMaintain.jsp?type=N"+"&shipperNo=" + shipperNo + "&invoiceNo="+invoiceNo+"&creationFromDate="+creationFromDate
            +"&creationToDate="+creationToDate+"&invoiceStatus="+invoiceStatus;

    }
  response.sendRedirect(goPage);
  //<jsp:forward page="<%=goPage%>" />
%>










