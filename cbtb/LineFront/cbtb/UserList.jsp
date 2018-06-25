<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="net.line.fortress.apps.system.security.User"%>
<jsp:useBean id="cbtbConstant" scope="session" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<%@ include file="Init.jsp"%>
<%
String language = "CH";
String ts="";

webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","COMPANY_USER"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容

if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {

CompanyProfileModel companyProfileModel=new CompanyProfileModel();
companyProfileModel = webOperator.getCompanyManager().findCompanyProfile("TRC001");
companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
String companyId=companyProfileModel.getCompanyId();
String companyType=companyProfileModel.getCompanyType();
//String companyId = "TRC001";
Vector vecUser = new Vector(webOperator.getSecurityManager().findUserByDomain(companyId));

%>
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

    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">用戶列表</font></b></font></td>
      <td width="57%">

      <div align="right"><a
href="UserAdd.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">創建用戶</font></a><font
color="#003366" face="Arial, Helvetica, sans-serif"> | </font><a
href="indexTrucking.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
      </td>
    </tr>
  </table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td> <font size="2"
face="Arial, Helvetica, sans-serif">公司編號：</font><font size="2"
face="Arial, Helvetica, sans-serif"><%=companyId%></font> </td>
  </tr>
</table>
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><font size="2">公司名稱： </font></td>
    <td><font size="2"><%=dbList.getCompanyName(companyId,language)%></font></td>
    <input type="hidden" name="companyId" value="<%=companyId%>">
    <td><font size="2">聯絡人： </font></td>
    <td><font size="2"><%=companyProfileModel.getContactChinesePerson()%></font></td>
    <td><font size="2">手提電話號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getMobileNo()%> </font></td>
  </tr>
  <tr>
    <td><font size="2">電話號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getTelephoneNo()%> </font></td>
    <td><font size="2">傳真號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getFaxNo()%> </font></td>
    <td><font size="2">電郵地址：</font></td>
    <td><font size="2"><%=companyProfileModel.getEmailAddr()%></font></td>
  </tr>
</table>

<hr>
<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>用戶編號</td>
    <td>用戶密碼</td>
    <td>是否吊銷</td>
    <td>用戶描述</td>
  </tr>
<%
for (int i=0;(!vecUser.isEmpty() && i<vecUser.size());i++)
{
net.line.fortress.apps.system.security.User user = (User)vecUser.get(i);
String statusName = "";
%>
<form name="edit<%=i%>" action="UserEdit.jsp" method="post">
<tr>
<td>
<input type=hidden name=truckUserId value="<%=user.getUserID()%>">
<input type=hidden name=truckUserPassword value="<%=user.getPassword()%>">
<input type=hidden name=truckUserStatus value="<%=user.isSuspended()%>">
<input type=hidden name=truckUserDescription value="<%=user.getDescription()%>"><a href = "javascript:edit<%=i%>.submit()"><%=user.getUserID()%></a></td>
<td>********</td>
<td><%
if (user.isSuspended()==false)
   statusName = "正常";
else 
   statusName = "吊銷";%><%=statusName%></td>
<td><%=user.getDescription()%></td>
</tr>
</form>

<%}%>
</table>
<p>&nbsp;</p>
<hr>
<table width="342" border="0" align="center">
  <tr>
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
<%}%>
</body>
</html>