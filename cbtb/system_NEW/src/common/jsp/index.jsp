<%-- import section --%>
<%@ page import="net.line.fortress.apps.system.*" %>

<%-- page request section --%>
<%
  String errorMessage = (String)session.getAttribute("net.line.system.error.message");
  session.removeAttribute("net.line.system.error.message");
  String contextPath = (String)request.getContextPath();
  String gotoPage = "/common/jsp/functionList.jsp";
  String errorPage = "/common/jsp/index.jsp";
  String changePasswordPage = ConfigManager.getInstance().getProperty("net.line.system.changePasswordPage");
%>
<script>
  <% if (errorMessage != null) { %>
      alert("<%=errorMessage%>");
  <% } %>
</script>
<HTML>
<HEAD>
<TITLE>
Logon Page
</TITLE>
</HEAD>
<BODY>
<H3>
Logon Page
</H3>
<FORM NAME="logon" METHOD="POST" ACTION="<%=contextPath%>/common/servlet/authentication">
<table>
<tr><td>User ID:</td><td><INPUT TYPE="TEXT" NAME="userID" SIZE="15"></td></tr>
<tr><td>Password:</td><td><INPUT TYPE="PASSWORD" NAME="password" SIZE="15"></td></tr>
<tr><td>Organization ID:</td><td><INPUT TYPE="TEXT" NAME="domainID" SIZE="15"></td></tr>
<tr><td><INPUT TYPE="HIDDEN" NAME="gotoPage" VALUE="<%=contextPath%><%=gotoPage%>">
        <INPUT TYPE="HIDDEN" NAME="errorPage" VALUE="<%=contextPath%><%=errorPage%>">
        <INPUT TYPE="HIDDEN" NAME="changePasswordPage" VALUE="<%=contextPath%><%=changePasswordPage%>">
    </td>
    <td><INPUT TYPE="SUBMIT" NAME="btnLogin" VALUE="Login">
        <INPUT TYPE="RESET" NAME="btnReset" VALUE="Reset">
    </td>
</tr>
</table>
</form>

</BODY>
</HTML>
