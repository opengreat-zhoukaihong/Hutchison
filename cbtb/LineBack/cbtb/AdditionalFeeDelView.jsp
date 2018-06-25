<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
String addFeeId=request.getParameter("addFeeId");
%>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>附加費用數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="AdditionalFeeDelete.jsp?addFeeId=<%=request.getParameter("addFeeId")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">附加費用數據維護</font></p>
<hr>
<p><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">刪除這條記錄嗎?</font></font></p>
<table width="56%" border="0">
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"><%=request.getParameter("addFeeId")%></td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"><%=dbList.getAddFeeDesc(addFeeId, "EN")%> </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=dbList.getAddFeeDesc(addFeeId, "CN")%></td>
  </tr>

</table>
<p>&nbsp;</p>

</body>
</html>
