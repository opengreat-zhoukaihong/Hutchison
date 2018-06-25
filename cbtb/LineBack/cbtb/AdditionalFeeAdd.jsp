<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
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
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
   if (Trim(add.addFeeId.value).length ==0)
   {
     alert("附加費用代碼不能為空！");
     return false;
   }
   if (Trim(add.description.value).length ==0)
   {
     alert("請輸入英文描述！");
     return false;
   }
   if (Trim(add.chineseDescription.value).length ==0)
   {
     alert("請輸入中文描述！");
     return false;
    }


   add.submit();
}
</SCRIPT>


<p align="right"><a href="javascript:window.history.go(-1)"><font
size=2 color="#003366">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">附加費用數據維護</font></p>
<form action="AdditionalFeeConfirm.jsp" method="POST" name="add" >
<input type="hidden" name="URL" value="AdditionalFeeInsert.jsp">
  <table width="50%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td>編號：</td>
      <td > 
        <input type="text" name="addFeeId" size="5" maxlength="5">
      </td>
    </tr>
    <tr> 
      <td>英文描述：</td>
      <td > 
        <input type="text" name="description" size="20" maxlength="20">
      </td>
    </tr>
    <tr> 
      <td >中文描述：</td>
      <td > 
        <input type="text" name="chineseDescription" size="20" maxlength="10">
      </td>
    </tr>


  </table>
    <p><input type="button" name="post" onClick="javascript:doPost()" value="提交">
     &nbsp;&nbsp;<input type="reset" name="reset" value="清除">  </p>
</form>
</body>
</html>
