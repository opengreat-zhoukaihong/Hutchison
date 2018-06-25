<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨櫃種類數據維護</title>
</head>

<SCRIPT LANGUAGE="JavaScript">
function doPost()
{

    op.submit();
}
</SCRIPT>

<body bgcolor="#FFFFFF">

<%    String URL=request.getParameter("URL");
   String containerTypeId=request.getParameter("containerTypeId");
   String trailerTypeId=request.getParameter("trailerTypeId");
  String trailerTypeDesc=dbList.getTrailerTypeDesc(trailerTypeId,"CN");%>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:doPost()">
<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a>
<font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();">
<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨櫃種類數據維護</font></p>

<hr>
<form action="<%=URL%>" name="op" method="post" >
<table width="56%" border="0">
<input type="hidden" name="containerTypeId" value="<%=request.getParameter("containerTypeId")%>">
<input type="hidden" name="trailerTypeId" value="<%=request.getParameter("trailerTypeId")%>">
<input type="hidden" name="desc" value="<%=request.getParameter("desc")%>">
<input type="hidden" name="chineseDesc" value="<%=request.getParameter("chineseDesc")%>">
<input type="hidden" name="baseTypeId" value="<%=request.getParameter("baseTypeId")%>">
<input type="hidden" name="multiple" value="<%=request.getParameter("multiple")%>">
  <tr>
    <td width="50%">貨櫃種類編號：</td>
    <td width="50%"><%=request.getParameter("containerTypeId")%></td>
  </tr>
 <tr>
    <td width="50%">貨櫃種類英文描述：</td>
   <td width="50%"><%=request.getParameter("desc")%></td>
  </tr>
 <tr>
    <td width="50%">貨櫃種類中文描述：</td>
    <td width="50%"><%=request.getParameter("chineseDesc")%></td>
  </tr>
  <tr>
   <td width="50%">拖架種類：</td>
    <td width="50%"><%=trailerTypeDesc%></td>
  </tr>
   <tr>
   <td width="50%">基本貨櫃種類編號：</td>
    <td width="50%"><%=request.getParameter("baseTypeId")%></td>
  </tr>
  <tr>
   <td width="50%">倍數：</td>
    <td width="50%"><%=request.getParameter("multiple")%></td>
  </tr>
</table>
</form>
<p>&nbsp;</p>
</body>
</html>
