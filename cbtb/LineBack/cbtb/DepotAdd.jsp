<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="depotBean" scope="page" class="com.cbtb.javabean.DepotJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","DEPOT"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨場數據維護</title>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.depotId.value =="")
   {
     alert("貨場編號不能为空!");
     return;
   }
   if (add.depotDesc.value =="")
   {
     alert("貨場英文描述不能为空!");
     return;
   }
   if (add.depotChineseDesc.value =="")
   {
     alert("貨場中文描述不能为空!");
     return;
   }
   if (add.priority.value =="")
   {
     alert("貨場優先權不能为空!");
     return;
   }
    if(!isInt(add.priority.value))
     {
       alert("請輸入正確的數據類型！");
       return;
     }
    if(add.priority.value=="0" || add.priority.value=="00")
     {
       alert("優先級不能為0！");
       return;
     }

    add.submit();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="DepotList.jsp"><font color="#003366"
size="2" face="Arial, Helvetica, sans-serif">  取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨場數據維護</font></p>
</p>
<hr>
<form method="post" name="add" action="DepotConfirm.jsp">
<input type="hidden" name="URL" value="DepotInsert.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">編號：</td>
    <td width="50%">
      <input type="text" name="depotId" size="5" maxlength="5">
    </td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%">
      <input type="text" name="depotDesc" size="20" maxlength="20">
    </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%">
      <input type="text" name="depotChineseDesc" size="20" maxlength="10">
    </td>
  </tr>
  <tr>
    <td width="50%">優先權：</td>
    <td width="50%">
      <input type="text" name="priority" size="2" maxlength="2">
    </td>
  </tr>

</table>
<p>&nbsp;</p>
    <input type="button" name="post" onClick="javaScript:doPost()" value="提交">&nbsp;&nbsp;<input type="reset" name="clear" value="清除">  </p>
</form>
</body>
</html>
