<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="../css/line.css" rel=stylesheet>
<title>CBTB Login</title>
<script language=javascript>
function checkNull(){
 if (document.login.userId.value=="")
    {
     alert ("請輸入登錄賬號！");
     return false;
    }

if (document.login.domainId.value=="")
    {
     alert ("請輸入公司編號！");
     return false;
    }
 else
  return true;
}
</script>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p>&nbsp;</p>

<p>&nbsp;</p>

<form name=login action="/line_front/cbtb/testVerify.jsp" method="post">
    <table border="0" width="35%">
        <tr>
            <td>公司帳號：</td>
            <td><input type="text" size="20" name="userId"> </td>
        </tr>
        <tr>
            <td>公司編號：</td>
            <td><input type="text" size="20" name="domainId"> </td>
        </tr>
    </table>
    <p><input type="submit" name="Submit" value="提交" onClick="return checkNull()">
       <input type="reset" name="Submit2" value="重設"> </p>
</form>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
</body>
</html>
