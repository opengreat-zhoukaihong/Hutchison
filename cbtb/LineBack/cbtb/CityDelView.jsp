<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "cancel"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>城市數據維護</title>
</head>
<%
     String zoneId=request.getParameter("zoneId");
     String zoneDesc=dbList.getZoneDesc(zoneId,"CH");
%>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="CityDelete.jsp?cityId=<%=request.getParameter("cityId")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | <a href="javascript:history.back();"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">城市數據維護</font></p>

<hr>
<p><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">刪除這條記錄嗎?</font></font></p>
<table width="56%" border="0">
<%
String cityId=request.getParameter("cityId");
%>
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"><%=request.getParameter("cityId")%></td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"><%=dbList.getCityDesc(cityId, "EN")%> </td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=dbList.getCityDesc(cityId, "CH")%></td>
  </tr>
  <tr> 
    <td width="50%">區域：</td>
    <td width="50%"><%=zoneDesc%></td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
