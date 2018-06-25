<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ZONE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>區域數據維護</title>
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
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">區域數據維護</font></p>

<hr>
<form action="ZoneInsert.jsp" name="add" method="post" >
<table width="56%" border="0">
<input type="hidden" name="zoneId" value="<%=request.getParameter("zoneId") %>">
<input type="hidden" name="zoneDesc" value="<%=request.getParameter("zoneDesc") %>">
<input type="hidden" name="chineseDesc" value="<%=request.getParameter("chineseDesc")%>">
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"><%=request.getParameter("zoneId") %></td>
    <input type="hidden" name="" value="">
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"><%=request.getParameter("zoneDesc") %></td>
  </tr>
  <tr> 
    <td width="50%">中文描述：</td>
    <td width="50%"><%=request.getParameter("chineseDesc")%></td>
  </tr>
</table>
</form>
<p>&nbsp;</p>

</body>
</html>
