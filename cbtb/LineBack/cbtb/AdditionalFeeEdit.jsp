<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
String addFeeId=request.getParameter("addFeeId");
%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>附加費用數據維護</title>
</head>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>

<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
 with(edit){
   action = "AdditionalFeeConfirm.jsp"
 }
   if (edit.description.value =="")
   {
     alert("請輸入英文描述！");
     return;
   }
   if (edit.chineseDescription.value =="")
   {
     alert("請輸入中文描述！");
     return;
    }
 

    document.edit.submit();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="javascript:history.back();"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">取消</a></font></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">附加費用數據維護</font></p>

<hr>
<form method="post" name="edit" >

<input type="hidden" name="URL" value="AdditionalFeeUpdate.jsp">
      <table  width="56%" border="0">

        <tr> 
          <td width="50%"> 
            種類編號：
          </td>
          <td width="50%"> <input type="hidden" name="addFeeId" value="<%=request.getParameter("addFeeId")%>"><%=request.getParameter("addFeeId")%>
          </td>
        </tr>

        <tr> 
          <td width="50%"> 
            英文描述：
          </td>
          <td width="50%">
            <input type="text" name="description" value="<%=dbList.getAddFeeDesc(addFeeId, "EN")%>" size="20" maxlength="20">
          </td>
        </tr>
        <tr> 
          <td width="50%"> 
            中文描述：
          </td>
          <td width="50%"> 
            <input type="text" name="chineseDescription"     value="<%=dbList.getAddFeeDesc(addFeeId, "CN")%>" size="20" maxlength="10" >
          </td>
        </tr>

      </table>
      <input type="button" name="post" onClick="javascript:doPost()" value="提交">&nbsp;&nbsp;
<input type="reset" name="clear" value="清除"> 

</form>
</body>

</html>
