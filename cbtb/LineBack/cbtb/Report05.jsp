﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page errorPage="ErrorPage.jsp"%>
<jsp:useBean id="web" scope="page" class="com.cbtb.web.WebOperator" />
<jsp:useBean id="mcrm" scope="page" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","MANAGEMENT_REPORT"); 
webOperator.putPermissionContext("action", "create"); 
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String userId=webOperator.getUserID();

%>
<html>
<head>
<title>Untitled Document</title>

<link rel="stylesheet" href="../css/line.css" type="text/css">
<script src=../js/calendarShow.js></script>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script language="JavaScript">
function postForm()
{
   sDate=report05.startDate.value;
   eDate=report05.endDate.value;
   invoiceNo=report05.invoiceNo.value;
   shipperId=report05.shipperId.value;
   user="<%=userId%>"; 
   window.open("/servlets/com.cbtb.report.Report05?sd="+sDate+"&ed="+eDate+"&no="+invoiceNo+"&id="+shipperId+"&user="+user,null, "height=550,width=800,top=0,left=0,scrollbars=yes");
}
</script>

</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
   &nbsp
  </tr>
  <tr>
    <td>
	<font face="Arial, Helvetica, sans-serif" size="3" >
        未付款發票報表
	</font>
    </td>
    <td>
      <div align="right"><a href="Reports.jsp"><font
	color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>

<form name="report05" >
<table border="0" width="100%">
    <tr>
        <td>發票日期起：</td>
        <td>發票日期止：</td>
        <td>發票編號：</td>
        <td>發貨公司編號：</td>
    </tr>
    <tr>
     <td >
      <input type="text" maxlength="10" size="10"  name="startDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(startDate);return false" >
     </td>
     <td>
      <input type="text" maxlength="10" size="10"  name="endDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(endDate);return false" >
     </td>
     <td><input type="text" size="10" name="invoiceNo" maxlength="10"></td>
     <td><input type="text" size="10" name="shipperId" maxlength="10"></td>
        <td><input type="button" name="Submit" onClick="javascript:postForm()" value="查詢"></td>
        <td><input type="reset" name="reset" value="重設"></td>
    </tr>
</table>
</body>

</html>
