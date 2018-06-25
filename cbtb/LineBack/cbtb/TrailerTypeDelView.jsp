<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRAILER_TYPE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>Trailer Type</title>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="TrailerTypeDelete.jsp?trailerId=<%=request.getParameter("trailerId")%>"><font
color="#003366" size="2">確定 </font></a> | <a href="javascript:history.back();"><font
color="#003366" size="2">取消</font></a></p>

<p align="left">拖架種類數據維護</p>
<p align="left"><font color=red>刪除該條紀錄？</font></p>

<form name="form1" >
  <table width="50%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td>編號：</td>
      <td ><%=request.getParameter("trailerId")%> </td>
    </tr>
    <tr>
      <td >英文描述：</td>
      <td ><%=dbList.getTrailerTypeDesc(request.getParameter("trailerId"),"EN")%></td>
    </tr>
    <tr>
      <td>中文描述：</td>
      <td ><%=dbList.getTrailerTypeDesc(request.getParameter("trailerId"),"CN")%></td>
    </tr>
  </table>
</form>
<p align="left">&nbsp;</p>


</body>
</html>
