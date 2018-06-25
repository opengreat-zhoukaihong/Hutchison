<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.cbtb.web.*" %>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","MANAGEMENT_REPORT"); 
webOperator.putPermissionContext("action", "create"); 
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String userId=webOperator.getUserID();
%>

<html>
<head>
<title>Registeration Report</title>
<%@ include file="../include/head.jsp"%>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script language="JavaScript">
function postForm()
{
   user="<%=userId%>"; 
   window.open("/servlets/com.cbtb.report.Report01a?user="+user,null, "height=550,width=800,top=0,left=0,scrollbars=yes");
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td>
      <div align="right"><a href="Reports.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>

<form name="Report01a">
<table border="0" width="50%">
<tr>
 <td><font face="Arial, Helvetica, sans-serif" size="3">
	註冊中公司報表
     </font>
 </td>
 <td><input type="button" name="Submit" onClick="javascript:postForm()" value="查詢"></td>
</tr>
</table>

<hr>
</form>
</body>

</html>








