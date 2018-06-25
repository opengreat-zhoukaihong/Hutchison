<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
    String userId = request.getParameter("userId");
    String userPassword = request.getParameter("userPassword");
    String userStatus = request.getParameter("userStatus"); 
    String userDescription = request.getParameter("userDescription");
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
      <td><img src="../images/good.jpg" width="10" height="10"></td>
    </tr>
  </table>
  <table width="75%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="../images/good.jpg" width="10" height="10"></td>
    </tr>
  </table>
  
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">用戶詳細信息</font></b></font></td>
    <td>
      <div align="right"><a href="javascript:add.submit()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>

<form action="UserInsert.jsp" name="add" method="post">
<p>&nbsp;</p>
<table border="0" width="60%">
  <tr>
    <td>用戶編號：</td>
    <td>
      <input type="hidden" name="userId" value=<%=userId%>><%=userId%>
    </td>
</tr>
  <tr>
    <td></td>
    <td>

    </td>
</tr>
<tr>
    <td>用戶密碼：</td>
    <td>
<input type=hidden name="userPassword" value=<%=userPassword%>>**********
    </td>
</tr>
  <tr>
    <td></td>
    <td>

    </td>
</tr>
<tr>   
     <td>用戶描述：</td>
        <td><input type="hidden" name="userDescription" value=<%=userDescription%>><%=userDescription%> 
</td>
    </tr>
</table>
</form>
<p>&nbsp;</p>


      <%}%>
</body>
</html>







