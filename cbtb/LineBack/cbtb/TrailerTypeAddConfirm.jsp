<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRAILER_TYPE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
     String s_trailerId=request.getParameter("trailerId");
     String s_trailerDesc=request.getParameter("trailerDesc");
     String s_trailerChineseDesc=request.getParameter("trailerChineseDesc");
%>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>拖架種類數據維護</title>
</head>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
    add.submit();
}
</SCRIPT>


<body bgcolor="#FFFFFF">

<%@ include file="../include/head.jsp"%>

<p align="right"><a href="javascript:doPost()"><font
size="2"color="#003366"  face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="javascript:history.back();"><font
size="2" color="#003366"  face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">拖架種類數據維護</font></p>

<hr>
<form method="post" name="add" action="TrailerTypeInsert.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%"><%=s_trailerId%></td>
    <input type="hidden" name ="trailerId" value="<%=s_trailerId%>">
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=s_trailerDesc%></td>
    <input type="hidden" name ="trailerDesc" value="<%=s_trailerDesc%>">
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=s_trailerChineseDesc%></td>
    <input type="hidden" name ="trailerChineseDesc" value="<%=s_trailerChineseDesc%>">
  </tr>
</table>
<p>&nbsp;</p>
</form>
</body>
</html>
