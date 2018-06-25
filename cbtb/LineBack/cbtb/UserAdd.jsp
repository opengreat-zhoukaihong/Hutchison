<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ include file="Init.jsp"%>
<%webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
   %>
<html>
<head>
<title>CBTB</title>
</head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<SCRIPT LANGUAGE=javascript>
function doPost()
{
   if (this.document.add.userId.value.length == 0)
   {
     alert("請輸入用戶編號!");
     return false;
   }
   if (this.document.add.userPassword.value.length == 0)
   {
     alert("請輸入用戶密碼!");
     return false;
   }
   if ((this.document.add.userPassword.value)!=(this.document.add.ruserPassword.value))
   {
     alert("您兩次輸入的密碼不一致!");
     return false;
   }
  return true;
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
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">創建用戶信息</font></b></font></td>
    <td>
      <div align="right"><a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>

<form action="UserView.jsp" name="add" method="post" onsubmit="return doPost()">
<table border="0" width="70%" >
    <tr>
        <td>用戶編號：</td>
        <td><input type="text" size="20" name="userId" maxlength="20"></td>
    </tr>
    <tr>
        <td>用戶密碼：</td>
        <td><input type="password" size="20" name="userPassword" maxlength="20"></td>
    </tr>
    <tr>
        <td>確認密碼：</td>
        <td><input type="password" size="20" name="ruserPassword" maxlength="20"></td>
   </tr>
   <tr>
        <td>用戶描述：</td>
        <td><input type="text" size=50 name="userDescription" maxlength="20"></td>
   </tr>
  <tr>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <td><input type=submit name=submit value="提交"></td>
   <td><input type=reset name=reset value="重設"></td> 
  </tr>
</table>
</form>
 <%}%>
</body>
</html>
