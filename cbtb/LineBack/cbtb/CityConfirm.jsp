<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>城市數據維護</title>
</head>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<SCRIPT LANGUAGE="JavaScript">
function doPost()
{

    op.submit();
}
</SCRIPT>
<%
     String URL=request.getParameter("URL");
     String zoneId=request.getParameter("zoneId");
     String zoneDesc=dbList.getZoneDesc(zoneId,"CH");
%>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:doPost()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">城市數據維護</font></p>
<hr>
<form action="<%=URL%>" name="op" method="post" >
<table width="56%" border="0">
<input type="hidden" name="cityId" value="<%=request.getParameter("cityId")%>">
<input type="hidden" name="zoneId" value="<%=request.getParameter("zoneId")%>">
<input type="hidden" name="desc" value="<%=request.getParameter("desc")%>">
<input type="hidden" name="chineseDesc" value="<%=request.getParameter("chineseDesc")%>">

  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"><%=request.getParameter("cityId")%></td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"><%=request.getParameter("desc")%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=request.getParameter("chineseDesc")%></td>
  </tr>
  <tr> 
    <td width="50%">區域：</td>
    <td width="50%"><%=zoneDesc%></td>
  </tr>
</table>
</form>
<p>&nbsp;</p>

</body>
</html>
