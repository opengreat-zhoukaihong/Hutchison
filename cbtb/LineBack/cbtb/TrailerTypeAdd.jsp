<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="trailerTypeBean" scope="page" class="com.cbtb.javabean.TrailerTypeJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
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
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>Trailer Type</title>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.trailerId.value =="")
   {
     alert("拖架種類编码不能为空!");
     return;
   }
   if (add.trailerDesc.value =="")
   {
     alert("拖架種類英文描述不能为空!");
     return;
   }
   if (add.trailerChineseDesc.value =="")
   {
     alert("拖架種類中文描述不能为空!");
     return;
   }
    add.submit();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="TrailerTypeList.jsp"><font
color="#003366" size="2">取消</font></a></p>
<p align="left">拖架種類數據維護</p>
<form method="post" name="add" action="TrailerTypeAddConfirm.jsp">
<input type="hidden" name="URL" value="TrailerTypeInsert.jsp">
  <table width="50%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td>編號：</td>
      <td >
        <input type="text" name="trailerId" size="5" maxlength="5">
      </td>
    </tr>
    <tr>
      <td >英文描述：</td>
      <td >
        <input type="text" name="trailerDesc" size="20" maxlength="20">
      </td>
    </tr>
    <tr>
      <td>中文描述：</td>
      <td >
        <input type="text" name="trailerChineseDesc" size="20" maxlength="10">
      </td>
    </tr>
  </table>
<input type="button" name="post" onClick="javaScript:doPost()" value="提 交">
&nbsp;&nbsp;<input type="reset" name="clear" value="清除">  </p>
</form>
</form>
</body>
</html>
