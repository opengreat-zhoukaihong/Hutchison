<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<html>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>城市數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"> <a href="CityEdit.jsp?cityId=<%=request.getParameter("cityId")%>&zoneId=<%=request.getParameter("zoneId")%>&desc=<%=request.getParameter("desc")%>&zoneDesc=<%=request.getParameter("zoneDesc")%>&chineseDesc=<%=request.getParameter("chineseDesc")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">更新</font></a> 
  | <a href="CityDelView.jsp?cityId=<%=request.getParameter("cityId")%>&zoneId=<%=request.getParameter("zoneId")%>"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">刪除</font></a> 
  | </font><a
href="javascript:history.back()"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" szie="3">城市數據維護</font></p>

<hr>
<table width="56%" border="0">
<%
String cityId=request.getParameter("cityId");
%>
  <tr> 
    <td width="50%">編號：</td>
    <td width="50%"><%=request.getParameter("cityId")%> </td>
  </tr>
  <tr> 
    <td width="50%">英文描述：</td>
    <td width="50%"><%=dbList.getCityDesc(cityId, "EN")%></td>
  </tr>
  <tr>
    <td width="50%">中文描述：</td>
    <td width="50%"><%=dbList.getCityDesc(cityId, "CH")%></td>
  </tr>
  <tr> 
    <td width="50%">區域：</td>
    <td width="50%"><%=dbList.getZoneDesc(request.getParameter("zoneId"), "CH")%></td>
  </tr>
</table>
<p>&nbsp;</p>

</body>
</html>
