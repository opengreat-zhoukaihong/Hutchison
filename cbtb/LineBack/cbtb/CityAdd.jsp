<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cityBean" scope="page" class="com.cbtb.javabean.CityJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "create"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<HTML>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>城市數據維護</title>
<SCRIPT LANGUAGE="JavaScript">
function doPost()
{
   if (add.cityId.value =="")
   {
     alert("請輸入城市編號！");
     return ;
   }
   if (add.zoneId.value =="Any")
   {
     alert("請選擇區域編碼！");
     return ;
   }
   if (add.desc.value =="")
   {
     alert("請輸入英文描述！");
     return ;
   }
   if (add.chineseDesc.value =="")
   {
     alert("請輸入中文描述！");
     return ;
   }
   add.submit();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a
href="javascript:history.back()"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">取消</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">城市數據維護</font></p>
<hr>
<form method="post" name="add" action="CityConfirm.jsp">
<input type="hidden" name="URL" value="CityInsert.jsp">
<table width="56%" border="0">
  <tr> 
    <td width="50%">編號：</td>
          <td width="50%"> 
            <input type="text" name="cityId" value="" size="5" maxlength="5" >
          </td>
        </tr>
        <tr> 
          <td width="50%"> 
            英文描述：
          </td>
          <td width="50%">
            <input type="text" name="desc" value="" size="20" maxlength="20">
          </td>
        </tr>
        <tr> 
          <td width="50%"> 
            中文描述：</div>
          </td>
          <td width="50%"> 
            <input type="text" name="chineseDesc" value="" size="20" maxlength="10">
          </td>
        </tr>        
        <tr> 
          <td width="50%"> 
            區域：</div>
          </td>
          <td width="50%"> 
               <select name="zoneId" > 
                   <%=dbList.getZoneList("","")%>
               </select> 
          </td> 
        </tr>
      </table>
<p>
<input type="button" name="post" onClick="javascript:doPost()" value="提交">&nbsp;&nbsp;
<input type="reset" name="clear" value="清除"> 
</p>
</form>
</body>
</html>
