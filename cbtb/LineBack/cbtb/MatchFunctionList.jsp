<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "view"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
<p align="left">&nbsp;</p>


<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
      <td height="30"> 
        <p><a href="MatchSearch.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">配對記錄維護</font></a></p>
    
  </td>
    </tr>
    <tr>
      <td height="30"><a href="MatchTruck.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">根據空車直接配對 
        </font></a></td>
    </tr>
    <tr>
      <td height="30"> 
        
      <p><a href="MatchDelivery.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">根據送貨要求直接配對</font></a></p>
    
</td>
    </tr>
    <tr>
      <td height="30"> 
        
      <p><a href="DirectMatch.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">根據空車和送貨要求直接配對</font></a></p>
    
</td>
    </tr>
    <tr>
      <td height="30"><a href="UnMatchList.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif" size="2">取消配對</font></a></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</body>
</html>







