<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
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
<SCRIPT LANGUAGE=javascript>
function doPost()
{
   if (this.document.add.userPassword.value.length == 0)
   {
     alert("請輸入用戶密碼!");
     return ;
   }
   if ((this.document.add.userPassword.value)!=(this.document.add.ruserPassword.value))
   {
     alert("您兩次輸入的密碼不一致!");
     return ;
   }
   add.submit();
}
</SCRIPT>

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
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">修改用戶信息</font></b></font></td>
    <td>
      <div align="right"><a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>

<form action="UserUpdate.jsp" name="add" method="post">
<table border="0" width="70%" >
<br>
    <tr>
    <td>用戶編號：</td>
    <td><%=userId%>
	<input type=hidden name=userId value=<%=userId%>>
    </tr>
    <tr>
        <td>用戶密碼：</td>
        <td><input type="password"  name="userPassword" value="**********" maxlength="20">
    </tr>
   <tr>
        <td>確認密碼：</td>
        <td><input type="password"  name="ruserPassword" value="**********" maxlength="20"> </td>
   </tr>
 
    <tr>
    <td>用戶狀態:</td>
    <td>
<select name=userStatus>
<option <%if (userStatus.equals("false")) out.print("selected");%> value="false">正常</option>
<option <%if (userStatus.equals("true")) out.print("selected");%> value="true">吊銷</option>
</select>
<input type=hidden name=userStatusTmp value=<%=userStatus%>>
</td>
</tr>
  <tr>
        <td>用戶描述：</td>
        <td><input type="text" size=50 name="userDescription" value="<%=userDescription%>" maxlength="20"> </td>
   </tr>
</table>
</form>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
			<a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a>
			<img src="../images/good.jpg" width="10" height="10">
			<a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
    </td>
  </tr>
</table>
      <%}%>
</body>
</html>







