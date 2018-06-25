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
    Vector vecGroup = new Vector();
    String userId = request.getParameter("userId");
    String[] group =  request.getParameterValues("groupId");
    if (!(group==null))
    {
     for (int i=0;i<group.length;i++)
     {
      vecGroup.addElement(group[i]);

     }
     out.println(vecGroup+"<br>");
     com.cbtb.ejb.session.SecurityManager sm = webOperator.getSecurityManager();
     if (webOperator.getSecurityManager().findUserGroup(userId).size() != 0)
         sm.removeCbtbGroupMembership(userId);
         sm.addCbtbGroupMembership(userId,vecGroup);
      response.sendRedirect("UserList.jsp");
    }
     else
        response.sendRedirect("UserGroupEdit.jsp?userId="+userId+"");
 }
%>

