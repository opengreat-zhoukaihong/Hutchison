<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","MANAGEMENT_REPORT"); 
webOperator.putPermissionContext("action", "view"); 
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>
<head>
<title>CBTB</title>
</head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="30">
      <p><a href="Report01a.jsp"><font face="Arial, Helvetica, sans-serif" size="2" color="#003366">
	  註冊中公司報表
	</font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
     <a href="Report01b.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	註冊中司機報表
     </font></a></td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report02a.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	未配對入境送貨要求報表
      </font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report02b.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	未配對出境送貨要求報表
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report03.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	已確認空車和送貨要求配對報表
      </font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report04a.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	已確認未送貨（入境）報表
      </font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report04b.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	已裝箱未發貨（出境）報表
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report05.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	未付款發票報表
      </font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report06.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	服務報表
      </font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report07.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	已配對未確認報表
      </font></a></p>
    </td>
  </tr>
  <tr>
    <td height="30">
      <p><a href="Report08.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">
	未配對報表
      </font></a></p>
    </td>
  </tr>
</table>
</body>
</html>







