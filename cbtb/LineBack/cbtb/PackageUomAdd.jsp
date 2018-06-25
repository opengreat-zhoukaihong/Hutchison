<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="packageUomBean" scope="page" class="com.cbtb.javabean.PackageUomJB" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<HTML>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>量度單位數據維護</title>

<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
   if (add.uomId.value =="")
   {
     alert("编码不能为空!");
     return;
   }
   if (add.uomDesc.value =="")
   {
     alert("英文描述不能为空!");
     return;
   }
   if (add.uomChineseDesc.value =="")
   {
     alert("中文描述不能为空!");
     return;
   }
   add.submit();
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="javascript:history.back();">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font>
	</a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">量度單位數據維護</font></p>

<hr>
<form method="post" name="add" action="PackageUomConfirm.jsp">
<input type="hidden" name="URL" value="PackageUomInsert.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
		<td width="50%"><input type="text" name="uomId" value="" size="5" maxlength="5"></td>
 </tr>
 <tr>
    <td width="50%">英文描述：</td>
    <td width="50%"><input type="text" name="uomDesc" value=""size="20" maxlength="20" ></td>
	</tr>
	<tr>
		<td width="50%">中文描述：</td>
		<td width="50%">
			<input type="text" name="uomChineseDesc" value=""size="20" maxlength="10" >
		</td>

	</tr>
</table>
<p>
	<input type="button" name="post" onClick="javascript:doPost()" value="提交">&nbsp;&nbsp;
	<input type="reset" name="clear" value="清除">
</p>
</form>
</body>
</html>
