<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>
<head>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ZONE"); //加入检查的内容
webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>區域數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="ZoneDelete.jsp?zoneId=<%=request.getParameter("zoneId")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">區域數據維護</font></p>

<p align="left"><FONT color=#ff0033>刪除這條紀錄?</font></p>

<hr>

<table width="56%" border="0">
<%
String zoneId=request.getParameter("zoneId");
%>
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"> 
      <%=request.getParameter("zoneId")%>
    </td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"> 
<%=dbList.getZoneDesc(zoneId, "EN")%>
      </td>
  </tr>
  <tr> 
    <td width="50%">中文描述：</td>
    <td width="50%"> 
<%=dbList.getZoneDesc(zoneId, "CN")%>
    </td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
