<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="cbtbConstant" scope="session" class="com.cbtb.util.CbtbConstant" />
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
{
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
}
else{ 
    String companyId = request.getParameter("companyId");
    String truckUserId = request.getParameter("truckUserId");
    String truckUserPassword = request.getParameter("truckUserPassword");
    String truckUserDescription = request.getParameter("truckUserDescription");
    String truckUserType = cbtbConstant.EXTERNAL_USER_OPERATOR;
    String companyType = webOperator.getCompanyManager().findCompanyProfile(companyId).companyType;
    out.println(companyId
                +"---<BR>"+truckUserId
                +"---<BR>"+truckUserPassword
                +"---<BR>"+truckUserDescription
                +"---<BR>"+truckUserType
                +"---<BR>"+companyType);
    com.cbtb.ejb.session.SecurityManager sm = webOperator.getSecurityManager();

    sm.createUser(companyId,companyType,truckUserId,truckUserPassword,truckUserType,truckUserDescription);
    response.sendRedirect("UserList.jsp");

} %>

