<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cargoCategoryBean" scope="page" class="com.cbtb.javabean.CargoCategoryJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","CARGO_CATEGORY"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨物種類數據維護</title>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.cargoId.value =="")
   {
     alert("貨物種類编码不能为空!");
     return;
   }
   if (add.cargoDesc.value =="")
   {
     alert("貨物種類英文描述不能为空!");
     return;
   }
   if (add.cargoChineseDesc.value =="")
   {
     alert("貨物種類中文描述不能为空!");
     return;
   }

    add.submit();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="CargoCategoryList.jsp"><font color="#003366"
size="2" face="Arial, Helvetica, sans-serif">  取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨物種類數據維護</font></p>

<hr>
<form method="post" name="add" action="CargoCategoryAddConfirm.jsp">
<input type="hidden" name="URL" value="CargoCategoryInsert.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%">
      <input type="text" name="cargoId" size="5" maxlength="5">
    </td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%">
      <input type="text" name="cargoDesc" size="20" maxlength="20">
    </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%">
      <input type="text" name="cargoChineseDesc" size="20" maxlength="10">
    </td>
  </tr>

</table>
<p>&nbsp;</p>
    <input type="button" name="post" onClick="javaScript:doPost()" value="提 交">&nbsp;&nbsp;<input type="reset" name="clear" value="清除">  </p>
</form>
</body>
</html>
