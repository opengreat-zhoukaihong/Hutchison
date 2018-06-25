<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
   sDate=report06.startDate.value;
   eDate=report06.endDate.value;
   comId=report06.companyId.value;
   maNu=report06.matchNumber.value;
   no=report06.truckCapacityNo.value;
   trID=report06.truckerId.value;
   stNo=report06.statementNo.value;
   user="<%=userId%>"; 
   window.open("/servlets/com.cbtb.report.Report06?sd="+sDate+"&ed="+eDate+"&ci="+comId+"&mn="+maNu+"&no="+no+"&ti="+trID+"&sn="+stNo+"&user="+user,null, "height=550,width=800,left=0,top=0,scrollbars=yes");
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
    <td><font face="Arial, Helvetica, sans-serif" size="3">
        服務報表
	</font>
    </td>
    <td>
      <div align="right"><a href="Reports.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>

<form name="report06" >
<table border="0" width="100%">
    <tr>
        <td>送貨日期起：</td>
        <td>送貨日期止：</td>
        <td>公司編號：</td>
        <td>配對編號：</td>
        <td>送貨要求編號：</td>
    </tr>
    <tr>
     <td>
      <input type="text" maxlength="10" size="10"  name="startDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(startDate);return false" >
     </td>
     <td>
      <input type="text" maxlength="10" size="10"  name="endDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(endDate);return false" >
     </td>
     <td width="12%">
       <input type="text" size="10" name="companyId" maxlength="12">
     </td>
     <td width="12%">
       <input type="text" size="10" name="matchNumber" maxlength="12">
     </td>
     <td width="12%">
          <input type="text" size="10" name="truckCapacityNo" maxlength="12">
     </td>
     </tr>
     <tr>
        <td>司機編號：</td>
        <td>服務報表編號：</td>
     </tr>
     <tr>
      <td width="12%">
       <input type="text" size="10" name="truckerId" maxlength="12">
      </td>
      <td width="12%">
          <input type="text" size="10" name="statementNo" maxlength="12">
      </td>
      <td><input type="button" name="Submit" onClick="javascript:postForm()" value="查詢"></td>
      <td><input type="reset" name="reset" value="重設"></td>
    </tr>
</table>
</body>

</html>
