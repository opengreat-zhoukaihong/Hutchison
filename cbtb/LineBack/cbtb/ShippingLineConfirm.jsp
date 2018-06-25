<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","SHIPPING_LINE"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>航運公司數據維護</title>
</head>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{

    edit.submit();
}
</SCRIPT>

<%
     String URL=request.getParameter("URL");
%>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:doPost()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">航運公司數據維護</font></p>

<hr>
<form name=edit mathod=post action=<%=URL%> >
<input type="hidden" name="shippingLineId" value="<%=request.getParameter("shippingLineId") %>">
<input type="hidden" name="desc" value="<%=request.getParameter("desc") %>">
<input type="hidden" name="chineseDesc" value="<%=request.getParameter("chineseDesc")%>">
<table width="56%" border="0">
  <tr>
    <td width="50%">航運公司編號：</td>
    <td width="50%"><%=request.getParameter("shippingLineId")%></td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><%=request.getParameter("desc")%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=request.getParameter("chineseDesc")%></td>
  </tr>
</table>
<p>&nbsp;</p>
</form>

</body>
</html>
