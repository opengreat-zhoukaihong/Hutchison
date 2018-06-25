<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%@page import="com.cbtb.util.*"%>
<%@page import="com.cbtb.ejb.session.*"%>
<%@page import="com.cbtb.model.*"%>
<jsp:useBean id="statementDataModel" scope="session" class="com.cbtb.model.StatementDataModel" />
<jsp:useBean id="pagination" scope = "session" class = "com.cbtb.util.Pagination" />
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
webOperator.putPermissionContext("action", "approve"); //加入检查的内容

int  i  = Integer.parseInt(request.getParameter("i"));
int pageNo = pagination.getPageNo();
pagination.setPageNo(pageNo-1);
Vector  statementList = new Vector(pagination.nextPage());
statementDataModel = (StatementDataModel)statementList.get(i);
String statementNo = statementDataModel.getStatementNo();
String oldStatus = statementDataModel.getStatementStatus();
String status = request.getParameter(statementNo+"Status");
int iStatus = Integer.parseInt(status);
int iOldStatus = Integer.parseInt(oldStatus);
if (iStatus>iOldStatus)
	{
	webOperator.putPermissionContext("action", "change_status_up"); //加入检查的内容
	}
else 
	{
	webOperator.putPermissionContext("action", "change_status_down"); //加入检查的内容 	
	}
if (webOperator.checkPermission())
{
BillingManager billingManager = webOperator.getBillingManager();
String goPage="";

 
     if (billingManager.updateStatementDataStatus(statementNo,status))
     {
      statementDataModel.setStatementStatus(status);
      pagination.setPageNo(pageNo-1);
      goPage = "StatementManage.jsp?type=N";
      }
      else
      goPage = "ErrorPage.jsp";
    
 response.sendRedirect(goPage);
}
else
 {
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
 }
%>
