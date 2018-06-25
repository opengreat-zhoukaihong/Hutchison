<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*" %>
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
    out.println(userId
                +"---<BR>"+userPassword
                +"---<BR>"+userDescription);


     com.cbtb.ejb.session.SecurityManager sm = webOperator.getSecurityManager();
     sm.createCbtbUser(userId,userPassword,userDescription);
    if (!userId.equals(""))
    {
      response.sendRedirect("UserAddGroup.jsp?userId="+userId+"");
    }
} %>

