<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨櫃種類數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="ContainerTypeDelete.jsp?containerTypeId=<%=request.getParameter("containerTypeId")%>&trailerTypeId=<%=request.getParameter("trailerTypeId")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨櫃種類數據維護</font></p>
<hr>
<p><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">刪除這條記錄嗎?</font></font></p>
<table width="56%" border="0">
<%
String containerTypeId=request.getParameter("containerTypeId");
String trailerTypeId=request.getParameter("trailerTypeId");
%>
  <tr>
    <td width="50%">貨櫃種類編號：</td>
    <td width="50%"><%=request.getParameter("containerTypeId")%></td>
  </tr>
  <tr>
    <td width="50%">貨櫃種類英文描述：</td>
    <td width="50%"><%=request.getParameter("desc")%> </td>
  </tr>
  <tr>
    <td width="50%">貨櫃種類中文描述：</td>
    <td width="50%"><%=dbList.getContainerTypeDesc(containerTypeId,"CH")%></td>
  </tr>
  <tr>
    <td width="50%">拖架種類編號：</td>
    <td width="50%"><%=request.getParameter("trailerTypeId")%></td>
  </tr>
   <tr>
   <td width="50%">基本貨櫃種類編號：</td>
    <td width="50%"><%=dbList.getTrailerTypeDesc(trailerTypeId,"CH")%></td>
  </tr>
  <tr>
   <td width="50%">倍數：</td>
    <td width="50%"><%=request.getParameter("multiple")%></td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
