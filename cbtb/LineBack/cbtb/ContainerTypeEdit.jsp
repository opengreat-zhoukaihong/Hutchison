<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="cityBean" scope="page" class="com.cbtb.javabean.ContainerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<HTML>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨櫃種類數據維護</title>
</head>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>

<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
   if (edit.trailerTypeId.value =="")
   {
     alert("请选择拖架種類編號!");
     return;
   }
   if (edit.desc.value =="")
   {
     alert("貨櫃種類英文描述不能为空!");
       return;
   }
   if (edit.chineseDesc.value =="")
   {
     alert("貨櫃種類中文描述不能为空!");
       return;
   }
   if (edit.trailerTypeId.value =="Any")
   {
     alert("拖架種類不能为空!");
       return;
   }
    if(!isFloat(edit.multiple.value))
     {
       alert("請輸入正確的數據類型！");
       return false;
     }
   edit.baseTypeId.value=edit.baseTypeDesc.value;
   if ((edit.baseTypeId.value)=='Any')
   {
     edit.baseTypeId.value=edit.containerTypeId.value;
   }
   if (edit.baseTypeId.value==edit.containerTypeId.value)
   {
     edit.multiple.value="1.0";
   }
    edit.action="ContainerTypeConfirm.jsp" ;
    edit.submit();
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

<p><font face="Arial, Helvetica, sans-serif" size="3">貨櫃種類數據維護</font></p>

<hr>
<form method="post" name="edit" >
<input type="hidden" name="URL" value="ContainerTypeUpdate.jsp">
<%
String containerTypeId=request.getParameter("containerTypeId");
String trailerTypeId=request.getParameter("trailerTypeId");
%>
      <table  width="56%" border="0">
        <tr>
          <td width="50%">
            貨櫃種類編號：
          </td>
          <td width="50%">
           <%=request.getParameter("containerTypeId")%>
           <input type="hidden" name="containerTypeId" value="<%=request.getParameter("containerTypeId")%>" size="5" maxlength="5">
          </td>
        </tr>
        <tr>
          <td width="50%">
            貨櫃種類英文描述：
          </td>
          <td width="50%">
            <input type="text" name="desc" value="<%=request.getParameter("desc")%>" size="20" maxlength="20" >
          </td>
        </tr>
        <tr>
          <td width="50%">
            貨櫃種類中文描述：
          </td>
          <td width="50%">
            <input type="text" name="chineseDesc"          value="<%=dbList.getContainerTypeDesc(containerTypeId,"CH")%>" size="20" maxlength="10" >
          </td>
        </tr>
                <tr>
          <td width="50%">
            拖架種類：
          </td>
          <td width="50%"><select name="trailerTypeId">
             <%=dbList.getTrailerTypeList(request.getParameter("trailerTypeId"),"")%>
            </select>
          </td>
        </tr>
        <tr>
          <td width="50%">
            基本貨櫃種類編號：
          </td>
          <td width="50%">

               <select name="baseTypeDesc" >
                   <%=dbList.getContainerTypeList(request.getParameter("baseTypeId"),"")%>
                  </select>
          </td>
<input type="hidden" name="baseTypeId" >
        </tr>
        <tr>
          <td width="50%">
            倍數：
          </td>
          <td width="50%">
            <input type="text" name="multiple"     value="<%=request.getParameter("multiple")%>" size="1" maxlength="1" >
          </td>
        </tr>
      </table>
    <p><input type="button" onClick="JavaScript:doPost()" name="button" value="提交">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>