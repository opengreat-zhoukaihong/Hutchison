<%@ include file="Init.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<html>


<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ZONE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>區域數據維護</title>
</head>

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (add.zoneId.value =="")
   {
     alert("區域编码不能为空!");
     add.zoneId.focus();
     return;
   }
   else
   {
     if(add.zoneId.value.length > 5)
     {
        alert("區域编码不能超過五位!");
        add.zoneId.focus();
        return;
     }
   }
   if (add.zoneDesc.value =="")
   {
     alert("英文描述不能為空!");
     add.zoneDesc.focus();
     return;
    }
    else
    {
     if(add.zoneDesc.value.length > 20)
     {
        alert("英文描述不能超過二十位!");
        add.zoneDesc.focus();
        return;
     }
   }
   if (add.chineseDesc.value =="")
   {
     alert("中文描述不能為空!");
     add.chineseDesc.focus();
     return;
     }
    else
    {
     if(add.chineseDesc.value.length > 20)
     {
        alert("中文描述不能超過二十位!");
        add.chineseDesc.focus();
        return;
     }
   }
    add.submit();
}
</SCRIPT>

</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a
href="ZoneList.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">區域數據維護</font></p>

<hr>
<form name="add" action="ZoneAddConfirm.jsp" method="POST">
<table width="56%" border="0">
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"> 
 <input type="text" maxlength="5" size = "5" name="zoneId">
    </td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"> 
      <input type="text" maxlength="20" size = "20" name="zoneDesc">
    </td>
  </tr>
  <tr> 
    <td width="50%">中文描述：</td>
    <td width="50%"> 
      <input type="text" name="chineseDesc" maxlength="10">
    </td>
  </tr>
</table>
<p>&nbsp;</p>

 <p><input type="button" name="denglu  3" value="提 交" LANGUAGE=javascript  onclick="return doPost()">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>
