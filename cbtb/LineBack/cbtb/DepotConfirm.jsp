<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","DEPOT"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨場數據維護</title>
</head>

<SCRIPT LANGUAGE="JavaScript">
function doPost()
{

    op.submit();
}
</SCRIPT>

<%
     String URL=request.getParameter("URL");
     String s_depotId=request.getParameter("depotId");
     String s_depotDesc=request.getParameter("depotDesc");
     String s_depotChineseDesc=request.getParameter("depotChineseDesc");
     String s_priority=request.getParameter("priority");
%>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="javascript:doPost()"><font
size="2"color="#003366"  face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="javascript:history.back();">
<font size="2" color="#003366"  face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨場數據維護</font></p>

<hr>
<form action="<%=URL%>" name="op" method="post" >
<table width="56%" border="0">
<input type="hidden" name="depotId" value="<%=request.getParameter("depotId")%>">
<input type="hidden" name="depotDesc" value="<%=request.getParameter("depotDesc")%>">
<input type="hidden" name="depotChineseDesc" value="<%=request.getParameter("depotChineseDesc")%>">
<input type="hidden" name="priority" value="<%=request.getParameter("priority")%>">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%"><%=s_depotId%></td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=s_depotDesc%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=s_depotChineseDesc%></td>
  </tr>
  <tr>
    <td width="50%">優先權：</td>
    <td width="50%"><%=s_priority%></td>
  </tr>
</table>
</form>
<p>&nbsp;</p>

</body>
</html>
