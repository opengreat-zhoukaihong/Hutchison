<%@ include file="Init.jsp"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%
webOperator.clearPermissionContext();  //�����ǰ��������
webOperator.putPermissionContext("document_type","BILLING"); //�����������
webOperator.putPermissionContext("action", "print"); //�����������
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
