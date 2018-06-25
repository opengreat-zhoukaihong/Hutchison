<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","REASON_CODE"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>原因代碼數據維護</title>
</head>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{

    edit.submit();
}
</SCRIPT>

<body bgcolor="#FFFFFF">
<%
	String URL=request.getParameter("URL");
	String reasonId=request.getParameter("reasonId");
	String reasonDesc=request.getParameter("reasonDesc");
	String reasonChineseDesc=request.getParameter("reasonChineseDesc");
	String recordStatus=request.getParameter("recordStatus");
%>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right">
	<a href="javascript:doPost()">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a>
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> |</font>
	  <a href="javascript:history.back();">
	<font color="#003366" size="2"	face="Arial, Helvetica, sans-serif">取消</font></a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">原因代碼數據維護</font></p>
<hr>
<form name=edit mathod=post action=<%=URL%> >
<input type="hidden" name="reasonId" value="<%=request.getParameter("reasonId") %>">
<input type="hidden" name="reasonDesc" value="<%=request.getParameter("reasonDesc") %>">
<input type="hidden" name="reasonChineseDesc" value="<%=request.getParameter("reasonChineseDesc")%>">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%"><%=reasonId%></td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=reasonDesc%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=reasonChineseDesc%></td>
  </tr>
</table>
</form>
</body>
</html>
