<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>附加費用數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<%
     String URL=request.getParameter("URL");
%>
<SCRIPT LANGUAGE="JavaScript">

function post()
{
document.add.submit();
}
</SCRIPT>
<p align="right"><a href="javascript:post()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">附加費用數據維護</font></p>

<form action="<%=URL%>" method="POST" name="add">
  <table width="50%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td>代碼：</td>
      <td > 
        <input type="hidden" name="addFeeId" value="<%=request.getParameter("addFeeId")%>"><%=request.getParameter("addFeeId")%>
      </td>
    </tr>
    <tr> 
      <td>英文描述：</td>
      <td > 
        <input type="hidden" name="description" value="<%=request.getParameter("description")%>">  <%=request.getParameter("description")%>
      </td>
    </tr>
    <tr> 
      <td >中文描述：</td>
      <td > 
        <input type="hidden" name="chineseDescription" value="<%=request.getParameter("chineseDescription")%>"><%=request.getParameter("chineseDescription")%>
      </td>
    </tr>


  </table>
</form>
</body>
</html>
