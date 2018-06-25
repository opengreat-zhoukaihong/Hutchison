<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cityBean" scope="page" class="com.cbtb.javabean.ContainerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<HTML>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨櫃種類數據維護</title>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
   if (add.containerTypeId.value =="")
   {
     alert("貨櫃種類編號不能为空!");
       return;
   }
   if (add.trailerTypeId.value =="")
   {
     alert("请选择拖架種類!");
     return;
   }
   if (add.desc.value =="")
   {
     alert("貨櫃種類英文描述不能为空!");
       return;
   }
   if (add.chineseDesc.value =="")
   {
     alert("貨櫃種類中文描述不能为空!");
       return;
   }
   if (add.trailerTypeId.value =="Any")
   {
     alert("拖架種類不能为空!");
       return;
   }
   add.baseTypeId.value=add.baseTypeDesc.value;
   if (add.baseTypeId.value =="")
   {
     add.baseTypeId.value=add.containerTypeId.value;
   }
   if (add.multiple.value =="")
   {
     add.multiple.value="1";
   }
    if(!isInt(add.multiple.value))
     {
       alert("請輸入正確的數據類型！");
       return false;
     }
   if (add.baseTypeId.value=='Any')
   {
     add.baseTypeId.value = add.containerTypeId.value;
   }
   if (add.baseTypeId.value==add.containerTypeId.value)
   {
       add.multiple.value="1";
   }
    add.action="ContainerTypeConfirm.jsp";
    add.submit();
}
</SCRIPT>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="javascript:history.back()"><font color="#003366" size="2" 
face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨櫃種類數據維護</font></p>

<hr>
<form method="post" name="add">
<input type="hidden" name="URL" value="ContainerTypeInsert.jsp">
<table width="56%" border="0">
  <tr>
    <td width="50%">貨櫃種類編號：</td>
          <td width="50%">
            <input type="text" name="containerTypeId" value="" size="5" maxlength="5" >
          </td>
        </tr>
        <tr>
          <td width="50%">
            貨櫃種類英文描述：
          </td>
          <td width="50%">
            <input type="text" name="desc" value="" size="20" maxlength="20">
          </td>
        </tr>
        <tr>
          <td width="50%">
            貨櫃種類中文描述：</div>
          </td>
          <td width="50%">
            <input type="text" name="chineseDesc" value="" size="20" maxlength="10">
          </td>
        </tr>
        <tr>
          <td width="50%">
            拖架種類編號：</div>
          </td>
          <td width="50%">
               <select name="trailerTypeId" >
                   <%=dbList.getTrailerTypeList("","")%>
                  </select>
          </td>
        </tr>
        <tr>
          <td width="50%">
            基本貨櫃種類編號：</div>
          </td>
          <td width="50%">

               <select name="baseTypeDesc" >
                   <%=dbList.getContainerTypeList("","")%>
                  </select>
<input type="hidden" name="baseTypeId" >
          </td>
        </tr>
        <tr>
          <td width="50%">
            倍數：</div>
          </td>
          <td width="50%">
            <input type="text" name="multiple" value="" size="3" maxlength="1">
          </td>
        </tr>
      </table>
   <p><input type="button" name="denglu" onClick="JavaScript:doPost()" value="提交">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>