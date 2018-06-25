<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%><html>
<head>
<title>保存成功</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<% 
String listPageName=request.getParameter("backPage");
String opMode=request.getParameter("mode");
String outString="";

if (opMode.equals("Insert"))
   outString ="	 新增成功！";
if (opMode.equals("Update"))
   outString ="	 修改成功！";
if (opMode.equals("Delete"))
   outString ="	 刪除成功！";
%>

<p align="right"> <a href=<%=listPageName%>><font
color="#003366">關閉</font></a></p
<table width="100%">
  <tr> 
    <td> 
      <table width="98%" align="center" height="100">
        <tr> 
          <td height="200"> 
            <div align="center"><%=outString%></div>
          </td>
        </tr>
      </table>
      <hr>
      <table width="400" border="0" align="center">
       </table>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>

