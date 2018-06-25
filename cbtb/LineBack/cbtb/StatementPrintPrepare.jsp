<%@ include file="Init.jsp"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
webOperator.putPermissionContext("action", "print"); //加入检查的内容
if (webOperator.checkPermission())
{
%>

<%@ page import="com.cbtb.ejb.session.*"%>
<%@ page import="com.cbtb.model.*"%>
<jsp:useBean id="cbtbConstant" scope="session" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="statementDataModel" scope="session" class="com.cbtb.model.StatementDataModel" />
<%
   String statementNo = request.getParameter("statementNo");
   String goPage = "";
      if (statementNo!=null)
       {
        BillingManager bm = webOperator.getBillingManager();
        String printStatus = cbtbConstant.STATEMENT_STATUS_PRINT;
        String generated = cbtbConstant.STATEMENT_STATUS_GENERATED;
        String nowStatus = bm.findStatementDataModel(statementNo).getStatementStatus();



        if (nowStatus.equals(generated))
        {try{
         bm.updateStatementDataStatus(statementNo,printStatus);
         }
         catch(Exception e)
         {}
         goPage = "/servlets/com.cbtb.report.ServiceReport?serviceNo="+statementNo+"" ;
         }
        else
        {
           goPage = "/servlets/com.cbtb.report.ServiceReport?serviceNo="+statementNo+"" ;
        }
       }
 out.print(goPage);
response.sendRedirect(goPage);
}
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

 %>
