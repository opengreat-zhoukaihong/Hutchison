<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="packageUomBean" scope="page" class="com.cbtb.javabean.PackageUomJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
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
	if (edit.uomDesc.value =="")
   {
     alert("英文描述不能为空!");
     return;
   }
   if (edit.uomChineseDesc.value =="")
   {
     alert("中文描述不能为空!");
     return;
   }
	edit.submit();
}
</SCRIPT>
</head>

<body bgcolor="FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right">
	<a href="javascript:history.back();">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font>
	</a>
</p>

<p><font face="Arial, Helvetica, sans-serif" size="3">量度單位數據維護</font></p>

<hr>
<form method="post" name="edit" action = "PackageUomConfirm.jsp">
<input type="hidden" name="URL" value="PackageUomUpdate.jsp">
<%
String uomId=request.getParameter("uomId");
%>
<table  width="56%" border="0">
	<tr>
		<td width="50%">編號:</td>
		<td width="50%">
			<%=request.getParameter("uomId")%>
		  <input type="hidden" name="uomId" value="<%=request.getParameter("uomId")%>">
		</td>
	</tr>
	<tr>
		<td width="50%">英文描述：</td>
		<td width="50%"><input type="text" name="uomDesc" value="<%=dbList.getPackageUomDesc(uomId, "EN")%>" size="20" maxlength="20" ></td>
	</tr>
	<tr>
	<td width="50%">中文描述：</td>
	<td width="50%">
		<input type="text" name="uomChineseDesc" value="<%=dbList.getPackageUomDesc(uomId, "CN")%>" size="20" maxlength="10" >
		<input type="hidden" name="recordStatus" value = "0">
	</td>
</table>
<p>
	<input type="button" name="post" onClick="javascript:doPost()" value="提交">&nbsp;&nbsp;
	<input type="reset" name="clear" value="清除">
</p>
</form>
</body>
</html>