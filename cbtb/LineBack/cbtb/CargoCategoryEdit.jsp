<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>

<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="cargoCategoryBean" scope="page" class="com.cbtb.javabean.CargoCategoryJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","CARGO_CATEGORY"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨物種類數據維護</title>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (edit.cargoId.value =="Any")
   {
     alert("請選擇區域編碼！");
     return;
   }
   if (edit.cargoDesc.value =="")
   {
     alert("請輸入英文描述！");
     return;
   }
   if (edit.cargoChineseDesc.value =="")
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
<p align="right"><a href="javascript:history.back();"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">取消</a></font></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨物種類數據維護</font></p>
<hr>
<form method="post" name="edit" action="CargoCategoryConfirm.jsp">
<input type="hidden" name="URL" value="CargoCategoryUpdate.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%">
           <%=request.getParameter("cargoId")%>
           <input type="hidden" name="cargoId" value="<%=request.getParameter("cargoId")%>">
    </td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%">
      <input type="text" name="cargoDesc" value="<%=dbList.getCargoCategoryDesc(request.getParameter("cargoId"),"EN")%>" size="20" maxlength="20">
     
    </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%">
      <input type="text" name="cargoChineseDesc" value="<%=dbList.getCargoCategoryDesc(request.getParameter("cargoId"),"CN")%>" size="20" maxlength="10">
     
    </td>
  </tr>
</table>
<p>&nbsp;</p>
    <input type="button" name="post" onClick="javaScript:doPost()" value="提 交">&nbsp;&nbsp;<input type="reset" name="clear" value="清除">  </p>
</form>
</body>
</html>
