<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="net.line.fortress.apps.system.security.User"%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
Vector vecUser = new Vector(webOperator.getSecurityManager().findUserByDomain("CBTB"));
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

    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">用戶列表</font></b></font></td>
      <td width="57%">

      <div align="right"><a
href="UserAdd.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">創建用戶</font></a><font
color="#003366" face="Arial, Helvetica, sans-serif"> | </font><a
href="indexTrucking.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
      </td>
    </tr>
  </table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>

<hr>
<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>用戶編號</td>
    <td>用戶密碼</td>
    <td>是否吊銷</td>
    <td>用戶描述</td>
    <td>更改用戶組</td>
  </tr>
<%
for (int i=0;(!vecUser.isEmpty() && i<vecUser.size());i++)
{
net.line.fortress.apps.system.security.User user = (User)vecUser.get(i);
String statusName = "";
%>
<form name="edit<%=i%>" action="UserEdit.jsp" method="post">
<tr>
<td>
<input type=hidden name=userId value="<%=user.getUserID()%>">
<input type=hidden name=userPassword value="<%=user.getPassword()%>">
<input type=hidden name=userStatus value="<%=user.isSuspended()%>">
<input type=hidden name=userDescription value="<%=user.getDescription()%>"><a href = "javascript:edit<%=i%>.submit()"><%=user.getUserID()%></a></td>
<td>********</td>
<td><%
if (user.isSuspended()==false)
   statusName = "正常";
else 
   statusName = "吊銷";%><%=statusName%></td>
<td><%=user.getDescription()%></td>
<td><a href="UserGroupEdit.jsp?userId=<%=user.getUserID()%>">進入更改</td>
</tr>
</form>

<%}%>
</table>
<p>&nbsp;</p>

<%}%>
</body>
</html>