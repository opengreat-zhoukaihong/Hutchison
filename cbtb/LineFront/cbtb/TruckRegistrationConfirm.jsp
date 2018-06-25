<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.web.*"%>
<%@ include file="Init.jsp"%>
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%
CompanyProfileModel companyProfileModel=new CompanyProfileModel();
companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
companyProfileModel.setContactPerson(request.getParameter("contactPerson"));
companyProfileModel.setTelephoneNo(request.getParameter("telephoneNo"));
companyProfileModel.setContactChinesePerson(request.getParameter("contactChinesePerson"));
companyProfileModel.setPrefCommChannel(request.getParameter("prefCommChannel"));
companyProfileModel.setFaxNo(request.getParameter("faxNo"));
companyProfileModel.setMobileNo(request.getParameter("mobileNo"));
companyProfileModel.setEmailAddr(request.getParameter("emailAddr"));
companyProfileModel.setWebSite(request.getParameter("webSite"));
companyProfileModel.setCompanyAddr1(request.getParameter("companyAddr1"));
companyProfileModel.setCompanyAddr2(request.getParameter("companyAddr2"));
companyProfileModel.setCompanyAddr3(request.getParameter("companyAddr3"));
companyProfileModel.setCompanyAddr4(request.getParameter("companyAddr4"));
companyProfileModel.setSentPerson(request.getParameter("sentPerson"));
companyProfileModel.setBillingStatementContactphone(request.getParameter("billingStatementContactphone"));
companyProfileModel.setBillingStatementContactemail(request.getParameter("billingStatementContactemail"));
companyProfileModel.setBillingStatementContactfax(request.getParameter("billingStatementContactfax"));
companyProfileModel.setBillingOrStatementAddr1(request.getParameter("billingOrStatementAddr1"));
companyProfileModel.setBillingOrStatementAddr2(request.getParameter("billingOrStatementAddr2"));
companyProfileModel.setBillingOrStatementAddr3(request.getParameter("billingOrStatementAddr3"));
companyProfileModel.setBillingOrStatementAddr4(request.getParameter("billingOrStatementAddr4"));

companyProfileModel.setMessage(request.getParameter("message"));
String selectLanguage=request.getParameter(request.getParameter("prefLanguage"));
if(selectLanguage==null)
   selectLanguage="";
if(selectLanguage.equals("1"))
   selectLanguage="繁體中文";
else
   selectLanguage="英文";
String comStauts=companyProfileModel.getCompanyStatus();
String comChannel=companyProfileModel.getPrefCommChannel();
if (comChannel!=null)
{
if (comChannel.equals(CbtbConstant.CAPTURE_CHANNEL_INTERNET))
comChannel="因特網";
if (comChannel.equals(CbtbConstant.CAPTURE_CHANNEL_EMAIL))
comChannel="電郵";
if (comChannel.equals(CbtbConstant.CAPTURE_CHANNEL_FAX))
comChannel="傳真";
if (comChannel.equals(CbtbConstant.CAPTURE_CHANNEL_PHONE))
comChannel="電話";
}
if (comStauts!=null)
{
if (comStauts.equals(CbtbConstant.COMPANY_BAD_LIST))
comStauts="Bad List";
if (comStauts.equals(CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS))
comStauts="Registration_In_Progress";
if (comStauts.equals(CbtbConstant.COMPANY_DELETE))
comStauts="Delete";
if (comStauts.equals(CbtbConstant.COMPANY_ACTIVE))
comStauts="Active";
session.setAttribute("companyProfileModel",companyProfileModel);
}
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">

<%@ include file = "../include/headtrucker.jsp" %>
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


    <td width="43%" height="11"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>運輸公司註冊資料</b></font></font></td>

    <td width="57%" height="11">
      <div align="right"><a href="RegistrationUpdate.jsp"><font
color="#003366">確定</font></a><font color="#003366"> | </font><a href="javascript:history.back()"><font color="#003366">取消</font></a></div>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
      <div align="right"><font size="2"
    >註冊日期：<%=(companyProfileModel.getRegistrationDate().toString()).substring(0,10)%></font></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="right"><font size="2"
    >註冊參考編號：<%=companyProfileModel.getRegistrationRefNum()%></font></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="right"><font size="2"
    >公司編號：<%=companyProfileModel.getCompanyId()%></font></div>
    </td>
  </tr>
</table>


<form action="ShipperRegInsert.jsp" method="post">
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>公司英文名稱： </td>
      <td><%=dbList.getCompanyName(companyProfileModel.getCompanyId(),"EN")%></td>
      <td>公司註冊編號：</td>
      <td><%=companyProfileModel.getBusiRegistrationNum()%></td>
    </tr>
    <tr>
      <td>公司中文名稱：</td>
      <td><%=companyProfileModel.getCompanyChineseName()%></td>
      <td>聯絡人英文姓名： </td>
      <td><%=companyProfileModel.getContactPerson()%></td>
    </tr>
    <tr>
      <td>電話號碼：</td>
      <td><%=companyProfileModel.getTelephoneNo()%></td>
      <td>聯絡人中文姓名：</td>
      <td><%=companyProfileModel.getContactChinesePerson()%></td>
    </tr>
    <tr>
      <td>選取聯絡途徑：</td>
      <td><%=comChannel%></td>
      <td>公司地址：</td>
      <td><%=companyProfileModel.getCompanyAddr1()%></td>
    </tr>
    <tr>
      <td>傳真號碼：</td>
      <td><%=companyProfileModel.getFaxNo()%></td>
      <td>&nbsp;</td>
      <td><%=companyProfileModel.getCompanyAddr2()%></td>
    </tr>
    <tr>
      <td>手提電話號碼： </td>
      <td><%=companyProfileModel.getMobileNo()%></td>
      <td>&nbsp;</td>
      <td><%=companyProfileModel.getCompanyAddr3()%></td>
    </tr>
    <tr>
      <td>電郵地址：</td>
      <td><%=companyProfileModel.getEmailAddr()%></td>
      <td>&nbsp;</td>
      <td><%=companyProfileModel.getCompanyAddr3()%></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>(結算聯絡資料)</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>聯絡人：</td>
      <td><%=companyProfileModel.getSentPerson()%></td>
      <td>聯絡地址：</td>
      <td><%=companyProfileModel.getBillingOrStatementAddr1()%></td>
    </tr>
    <tr>
      <td>聯絡人電話號碼：</td>
      <td><%=companyProfileModel.getBillingStatementContactphone()%></td>
      <td>&nbsp;</td>
      <td><%=companyProfileModel.getBillingOrStatementAddr2()%></td>
    </tr>
    <tr>
      <td>聯絡人電郵地址：</td>
      <td><%=companyProfileModel.getBillingStatementContactemail()%></td>
      <td>&nbsp;</td>
      <td><%=companyProfileModel.getBillingOrStatementAddr3()%></td>
    </tr>
    <tr>
      <td>聯絡人傳真號碼：</td>
      <td><%=companyProfileModel.getBillingStatementContactfax()%></td>
      <td>&nbsp;</td>
      <td><%=companyProfileModel.getBillingOrStatementAddr4()%></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>(管理員)</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>帳號：</td>
      <td>&nbsp;</td>
      <td>密碼：</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>選取語言：</td>
      <td>繁體中文</td>
      <td>確認密碼：</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>留言：</td>
      <td><%=companyProfileModel.getMessage()%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <p>&nbsp; </p>
</form>
<hr>
<%@ include file="../include/end.jsp"%>
</BODY>
</HTML>


