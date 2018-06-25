<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%
  String closePage="DirectMatch.jsp";
  session.setAttribute("closePage",closePage);
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
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
    <td>根據空車和送貨要求配對</td>
    <td>
      <div align="right"><a href="MatchFunctionList.jsp"><font
color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<form method="POST" action="MatchView.jsp?type=match">
    <table border="0" width="50%">
        <tr>
            <td>送貨要求編號：</td>
            <td>
        <input type="text" size="10" name="deliveryRequestNum" maxlength="10">
         </td>


        </tr>
        <tr>
            <td>空車編號：</td>
            <td>
        <input type="text" size="10" name="truckCapacityNum" maxlength="10">
         </td>


        </tr>

    </table>
<input type="submit" value="配對">
<input type="reset" value="取消">
</form>

<p align="left">&nbsp;</p>

</body>

</html>