<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ include file="Init.jsp"%>
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
    String truckUserStatus = request.getParameter("truckUserStatus");
    String truckUserStatusTmp = request.getParameter("truckUserStatusTmp");
    String truckUserType = cbtbConstant.EXTERNAL_USER_OPERATOR;
    String companyType = webOperator.getCompanyManager().findCompanyProfile(companyId).companyType;
    out.println(companyId
                +"---<BR>"+truckUserId
                +"---<BR>"+truckUserPassword
                +"---<BR>"+truckUserDescription
                +"---<BR>"+truckUserStatus
                +"---<BR>"+truckUserStatusTmp
                +"---<BR>"+companyType);

    com.cbtb.ejb.session.SecurityManager sm = webOperator.getSecurityManager();

    if (!truckUserPassword.equals("**********"))
    {
     sm.changePassword(companyId,truckUserId,truckUserPassword,false);
    }

     if (truckUserStatus.equals("false"))
         sm.updateUser(companyId,truckUserId,"N",null,truckUserDescription);
        // sm.activeUser(companyId,truckUserId);
     if (truckUserStatus.equals("true"))
         sm.updateUser(companyId,truckUserId,"Y",null,truckUserDescription);
         //sm.suspendUser(companyId,truckUserId);
     response.sendRedirect("UserList.jsp");
}
    %>

