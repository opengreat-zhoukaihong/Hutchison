<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>

<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="depotBean" scope="page" class="com.cbtb.javabean.DepotJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","DEPOT"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
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
   if (edit.depotId.value =="")
   {
     alert("請輸入編號!");
     return;
   }
   if (edit.depotDesc.value =="")
   {
     alert("請輸入英文描述!");
     return;
   }
   if (edit.depotChineseDesc.value =="")
   {
     alert("請輸入中文描述!");
     return;
   }
   if (edit.priority.value =="")
   {
     alert("請輸入優先權!");
     return;
   }
    if(!isInt(edit.priority.value))
     {
       alert("請輸入正確的數據類型!");
       return;
     }
    if(edit.priority.value=="0" || edit.priority.value=="00")
     {
       alert("優先級不能為0！");
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
<p><font face="Arial, Helvetica, sans-serif" size="3">貨場數據維護</font></p>

<hr>
<form method="post" name="edit" action="DepotConfirm.jsp">
<input type="hidden" name="URL" value="DepotUpdate.jsp">
<table width="56%" border="0">
<%
String depotId=request.getParameter("depotId");
%>
  <tr>
    <td width="50%">編號：</td>
    <td width="50%">
           <%=request.getParameter("depotId")%>
           <input type="hidden" name="depotId" value="<%=request.getParameter("depotId")%>">
    </td>
  </tr>
  <tr>
    <td width="50%">英文描述：</td>
    <td width="50%">
      <input type="text" name="depotDesc" value="<%=dbList.getDepotDesc(depotId,"EN")%>" size="20" maxlength="20">
     
    </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%">
      <input type="text" name="depotChineseDesc" value="<%=dbList.getDepotDesc(depotId,"CN")%>" size="20" maxlength="10">
     
    </td>
  </tr>
  <tr>
    <td width="50%">優先權：</td>
    <td width="50%">
      <input type="text" name="priority" value="<%=request.getParameter("priority")%>" size="1" maxlength="2">
     
    </td>
  </tr>
</table>
    <input type="button" name="post" onClick="javaScript:doPost()" value="提交">&nbsp;&nbsp;<input type="reset" name="clear" value="清除">  </p>
</form>
</body>
</html>
