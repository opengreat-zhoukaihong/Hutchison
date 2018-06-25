<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<jsp:useBean id="shippingLineBean" scope="page" class="com.cbtb.javabean.ShippingLineJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","SHIPPING_LINE"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
String shippingLineId=request.getParameter("shippingLineId");
%>
<HTML>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>航運公司數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (edit.desc.value =="")
   {
     alert("英文描述不能为空!");
       return;
   }
   if (edit.chineseDesc.value =="")
   {
     alert("中文描述不能为空!");
       return;
   }
    edit.action="ShippingLineConfirm.jsp"
    edit.submit();
}
</SCRIPT>
<p align="right">
	<a href="javascript:history.back();">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font>
	</a>
</p>

<p><font face="Arial, Helvetica, sans-serif" size="3">航運公司數據維護</font></p>

<hr>
<form method="post" name="edit" >

<input type="hidden" name="URL" value="ShippingLineUpdate.jsp">
      <table  width="56%" border="0">

        <tr>
          <td width="50%">
            航運公司編號：
          </td>
          <td width="50%">
           <%=request.getParameter("shippingLineId")%>
           <input type="hidden" name="shippingLineId" value="<%=request.getParameter("shippingLineId")%>">
          </td>
        </tr>

        <tr>
          <td width="50%">
            英文描述：
          </td>
          <td width="50%">
            <input type="text" name="desc" value="<%=dbList.getShippingLineDesc(shippingLineId, "EN")%>" size="20" maxlength="20" >
          </td>
        </tr>
        <tr>
          <td width="50%">
            中文描述：
          </td>
          <td width="50%">
            <input type="text" name="chineseDesc"          value="<%=dbList.getShippingLineDesc(shippingLineId, "CN")%>" size="20" maxlength="10" >
          </td>
        </tr>
      </table>


    <p><input type="button" name="button" onClick="JavaScript:doPost()" value="提 交">&nbsp;&nbsp;<input type="reset" name="B1" value="清除">  </p>
</form>
</body>

</html>
