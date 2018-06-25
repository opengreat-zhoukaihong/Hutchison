<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.web.*"%>
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "view"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  String update="";

  String companyId = request.getParameter("companyId");

  CompanyManager companyManager = webOperator.getCompanyManager();
  companyProfileModel=  companyManager.findCompanyProfile(companyId);

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>
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
    <td height="11"><font face="Arial, Helvetica, sans-serif">註冊信息</font></td>
    <td height="11"> 
      <div align="right"><a href="javascript:history.back()"><font
color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
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
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
            <td>公司類型： </td>
            <td><%=CbtbConstant.COMPANY_TYPE_SHIPPER.equals(companyProfileModel.getCompanyType())?"付貨人公司":"運輸公司"%> </td>

      <td>公司註冊編號/公司編號：</td>
            <td><%=companyProfileModel.getBusiRegistrationNum()%>/<%=companyId%></td>
        </tr>
        <tr>
            <td>公司英文名稱： </td>
            <td><%=companyProfileModel.getCompanyName()%> </td>
            <td>公司聯絡人英文姓名： </td>
            <td><%=companyProfileModel.getContactPerson()%></td>
        </tr>
        <tr>
            <td>公司中文名稱： </td>
            <td><%=companyProfileModel.getCompanyChineseName()%></td>
            <td>聯絡人中文姓名： </td>
            <td><%=companyProfileModel.getContactChinesePerson()%></td>
        </tr>
        <tr>
            <td>電話號碼：</td>
            <td><%=companyProfileModel.getTelephoneNo()%> </td>

      <td>註冊日期：</td>

<td><%=companyProfileModel.getRegistrationDate()%>
</td>
        </tr>
<%
String cc=null;

if (CbtbConstant.CAPTURE_CHANNEL_PHONE.equalsIgnoreCase(companyProfileModel.getPrefCommChannel()))
cc="電話"; 
if (CbtbConstant.CAPTURE_CHANNEL_FAX.equalsIgnoreCase(companyProfileModel.getPrefCommChannel()))
cc="傳真"; 
if (CbtbConstant.CAPTURE_CHANNEL_EMAIL.equalsIgnoreCase(companyProfileModel.getPrefCommChannel()))
cc="電郵"; 
%>
        <tr>
            <td>選取聯絡途徑： </td>
            <td><%=cc%></td>

      <td>公司地址：</td>
            <td><%=companyProfileModel.getCompanyAddr1()%> </td>
        </tr>
        <tr>
            <td>傳真號碼：</td>
            <td><%=companyProfileModel.getFaxNo()%> </td>
            <td>&nbsp;</td>
            <td><%=companyProfileModel.getCompanyAddr2()%></td>
        </tr>
        <tr>
            <td>手提電話號碼： </td>
            <td><%=companyProfileModel.getMobileNo()%> </td>
            <td>&nbsp;</td>
            <td><%=companyProfileModel.getCompanyAddr3()%></td>
        </tr>
        <tr>
            <td>電郵地址：</td>
            <td><%=companyProfileModel.getEmailAddr()%> </td>
            <td>&nbsp;</td>
            <td><%=companyProfileModel.getCompanyAddr4()%></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>(結算聯絡) </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>

      <td>聯絡人中文名：</td>
            <td><%=companyProfileModel.getSentChinesePerson()%></td>

      <td>聯絡人英文名：</td>
            <td><%=companyProfileModel.getSentPerson()%></td>
        </tr>
        <tr>

      <td>聯絡人電話號碼：</td>
            <td><%=companyProfileModel.getBillingStatementContactphone()%></td>

      <td>聯絡地址：</td>
            <td><%=companyProfileModel.getBillingOrStatementAddr1()%></td>
        </tr>
        <tr>

      <td>聯絡人電郵地址：</td>
            <td><%=companyProfileModel.getBillingStatementContactemail()%></td>
            <td>&nbsp;</td>
            <td><%=companyProfileModel.getBillingOrStatementAddr2()%></td>
        </tr>
        <tr>

      <td>聯絡人傳真號碼：</td>
            <td><%=companyProfileModel.getBillingStatementContactfax()%></td>
            <td>&nbsp;</td>
            <td><%=companyProfileModel.getBillingOrStatementAddr3()%></td>
        </tr>
        <tr>

      <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><%=companyProfileModel.getBillingOrStatementAddr4()%></td>
        </tr>
        <tr>
            <td>(僅限付貨人)</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>公司網址：</td>
            <td><%=companyProfileModel.getWebSite()%> </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>付款條款：</td>

<td><%=CbtbConstant.COMPANY_PAYMENT_TERMS_CASH.equals(companyProfileModel.getPaymentTerms())?"現金":"信用"%></td>
            <td>信貸額：</td>
            <td><%=companyProfileModel.getCreditAmount()%></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
 
</table>
<p>&nbsp;</p>
</body>
</html>







