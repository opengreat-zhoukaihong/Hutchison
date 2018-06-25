<%-- import section --%>
<%@ page import="net.line.fortress.apps.system.*" %>

<%-- page request section --%>
<%
  String contextPath = (String)request.getContextPath();
  String gotoPage = (String)request.getParameter("gotoPage");
  gotoPage = (gotoPage == null)? ConfigManager.getInstance().getProperty("net.line.system.indexPage"): gotoPage;
  String errorPage = ConfigManager.getInstance().getProperty("net.line.system.errorPage");
  String changePasswordPage = ConfigManager.getInstance().getProperty("net.line.system.changePasswordPage");
%>

<html>
<head><title>Change Password</title>
<SCRIPT>
<!--
function apply() {
  pageFields = new Array(document.changePassword.currentPwd, 'Current Password', 'checkNull', document.changePassword.newPwd, 'New Password', 'checkNull', document.changePassword.confirmPwd, 'Confirm Password', 'checkNull');
  if (validation(pageFields)) {
    if (document.changePassword.newPwd.value == document.changePassword.confirmPwd.value) {
      document.changePassword.submit();
    } else {
      alert('Your New Password does not match to Re-enter Password');
    }
  }
}
function cancel() { window.location = '<%=contextPath%><%=gotoPage%>'; };
//-->
</SCRIPT>
<SCRIPT LANGUAGE='JavaScript' SRC='<%=contextPath%>/common/js/validator.js'></SCRIPT>

</head>
<body>
<H3>
Change Password
</H3>
<form name='changePassword' method='POST' ACTION='<%=contextPath%>/common/servlet/changePassword'>
<table>
<tr><td>Current Password:</td><td><INPUT TYPE='PASSWORD' NAME='currentPwd' SIZE='15'></td></tr>
<tr><td>New Password:</td><td><INPUT TYPE='PASSWORD' NAME='newPwd' SIZE='15'></td></tr>
<tr><td>Re-enter New Password:</td><td><INPUT TYPE='PASSWORD' NAME='confirmPwd' SIZE='15'></td></tr>
<tr><td></td>
    <td><INPUT TYPE='BUTTON' NAME='btnLogin' VALUE='Apply' onClick='apply();'>
        <INPUT TYPE='BUTTON' NAME='btnReset' VALUE='Cancel' onClick='cancel();'>
    </td>
</tr>
</table>
</form>
</body></html>
