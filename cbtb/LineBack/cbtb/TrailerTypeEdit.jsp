<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="trailerTypeBean" scope="page" class="com.cbtb.javabean.TrailerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRAILER_TYPE"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
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
   if (edit.trailerId.value =="Any")
   {
     alert("請選擇區域編碼！");
     return;
   }
   if (edit.trailerDesc.value =="")
   {
     alert("請輸入英文描述！");
     return;
   }
   if (edit.trailerChineseDesc.value =="")
   {
     alert("請輸入中文描述！");
     return;
   }
    edit.submit();
}
</SCRIPT>

</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:history.back();"><font
color="#003366" size="2">取消</font></a></p>
<p align="left">拖架種類數據維護</p>
<form method="post" name="edit" action="TrailerTypeConfirm.jsp">
<input type="hidden" name="URL" value="TrailerTypeUpdate.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%">
           <%=request.getParameter("trailerId")%>
           <input type="hidden" name="trailerId" value="<%=request.getParameter("trailerId")%>">
    </td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%">
      <input type="text" name="trailerDesc" value="<%=dbList.getTrailerTypeDesc(request.getParameter("trailerId"),"EN")%>" size="20" maxlength="20">
     
    </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%">
      <input type="text" name="trailerChineseDesc" value="<%=dbList.getTrailerTypeDesc(request.getParameter("trailerId"),"CN")%>" size="20" maxlength="10">
     
  </tr>
</table>

<p align="left">&nbsp;</p>
    <input type="button" name="post" onClick="javaScript:doPost()" value="提 交">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>
