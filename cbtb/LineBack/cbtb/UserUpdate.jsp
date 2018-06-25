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
    String userId = request.getParameter("userId");
    String userPassword = request.getParameter("userPassword");
    String userDescription = request.getParameter("userDescription");
    String userStatus = request.getParameter("userStatus");
    String userStatusTmp = request.getParameter("userStatusTmp");
    out.println(userId
                +"---<BR>"+userPassword
                +"---<BR>"+userDescription
                +"---<BR>"+userStatus);
    com.cbtb.ejb.session.SecurityManager sm = webOperator.getSecurityManager();

    if (!userPassword.equals("**********"))
    {
     sm.changePassword("CBTB",userId,userPassword,false);
    }

     if (userStatus.equals("false"))
         sm.updateUser("CBTB",userId,"N",null,userDescription);
        // sm.activeUser(companyId,userId);
     if (userStatus.equals("true"))
         sm.updateUser("CBTB",userId,"Y",null,userDescription);
         //sm.suspendUser(companyId,userId);

     response.sendRedirect("UserList.jsp");
}
    %>

