<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ include file="Init.jsp"%>
<%@ page import="net.line.fortress.apps.system.security.Group"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
    String userId = request.getParameter("userId");

    Vector vecGroup = new Vector(webOperator.getSecurityManager().findCbtbGroup());
%>
<html>
<head>
<title>CBTB</title>
</head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<p align="left">&nbsp;</p>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">添加用戶組信息</font></b></font></td>
    <td>
      <div align="right"><a href="javascript:add.submit()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>
<form action="UserGroupInsert.jsp" name="add" method="post">
<table border="0" width="60%">
  <tr>
    <td><b>用戶編號：</b></td>
    <td><%=userId%>
      <input type="hidden" name="userId" value=<%=userId%>>
    </td>
    <td></td>
</tr>
  <tr>
    <td><b>加入組</b></td>
    <td><b>用戶組</b></td>
    <td><b>組描述</b></td>
</tr>

<%
for (int i=0;(!vecGroup.isEmpty() && i<vecGroup.size());i++)
{
net.line.fortress.apps.system.security.Group group = (Group)vecGroup.get(i);
%>
<tr>
  <td><input type="checkbox" name="groupId" value="<%=group.getGroupID()%>"></td>
  <td><%=group.getGroupName()%></td>
  <td><%=group.getDescription()%></td>
</tr>


<%}%>
</table>
</form>
<p>&nbsp;</p>
 <%}%>
</body>
</html>







