<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="cbtbConstant" scope="session" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
String language = "CH";
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
    CompanyProfileModel companyProfileModel=new CompanyProfileModel();
    companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
    String companyId=companyProfileModel.getCompanyId();
    String truckUserId = request.getParameter("truckUserId");
    String truckUserPassword = request.getParameter("truckUserPassword");
    String truckUserStatus = request.getParameter("truckUserStatus"); 
    String truckUserDescription = request.getParameter("truckUserDescription");
String companyType=companyProfileModel.getCompanyType();
    String statusName = ""; 
%>


<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%if (companyType.equals(cbtbConstant.COMPANY_TYPE_SHIPPER))
  {%><%@ include file="../include/ShiperHead.jsp"%>
<%}%>
<%if (companyType.equals(cbtbConstant.COMPANY_TYPE_TRUCKER))
{%>
<%@ include file="../include/headtrucker.jsp"%>
<%}%>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="../images/good.jpg" width="10" height="10"></td>
    </tr>
  </table>
  <table width="75%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="../images/good.jpg" width="10" height="10"></td>
    </tr>
  </table>
  
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">用戶詳細信息</font></b></font></td>
    <td>
      <div align="right"><a href="javascript:add.submit()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>

<form action="UserInsert.jsp" name="add" method="post">
<table border="0" width="90%">
<input type="hidden" name="companyId" value="<%=companyId%>">   
   <tr>
    <td height="22">運輸公司名稱：</td>
    <td height="22"><%=dbList.getCompanyName(companyId,language)%></td>
    <td height="22">運輸公司編號：</td>
        
    <td height="22"><%=companyId%></td>
    </tr>
<br>
    <tr>
    <td>用戶編號：</td>
    <td>
      <input type="hidden" name="truckUserId" value=<%=truckUserId%>><%=truckUserId%>
    </td>
        <td>用戶描述：</td>
        <td><input type="hidden" name="truckUserDescription" value=<%=truckUserDescription%>><%=truckUserDescription%> 
<input type=hidden name="truckUserPassword" value=<%=truckUserPassword%>></td>
    </tr>
</table>
</form>
<p>&nbsp;</p>
<hr>
      <table width=450 border="0" align="center">
        <tr> 
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright 
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
      <%}%>
</body>
</html>







