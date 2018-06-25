<%@ include file="Init.jsp"%>   

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>   
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />



<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_REGISTRATION"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%

String operate=request.getParameter("operate"); 
String back= request.getParameter("back") ;
String companyId=null;
String registrationRefNum=null;
CompanyManager cm=webOperator.getCompanyManager();
CompanyProfileModel companyProfileModel = new CompanyProfileModel() ;  
if (operate.equalsIgnoreCase("update"))    
 {
  
companyId=request.getParameter("companyId");
registrationRefNum=request.getParameter("registrationRefNum");  companyProfileModel.setRegistrationDate(Timestamp.valueOf(request.getParameter("registrationDate")));
}
if (operate.equalsIgnoreCase("insert"))
{

companyId=cm.getNewCompanyProfileNum();
registrationRefNum=cm.getNewRegistrationRefNum();
companyProfileModel.setRegistrationDate(Timestamp.valueOf(UtilTool.getCurrentDateTime()));

}
String companyStatus=request.getParameter("companyStatus");

if (companyStatus==null) 
companyStatus=CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS;

 companyProfileModel.setCompanyId(companyId);
 companyProfileModel.setCompanyType(request.getParameter("companyType"));
 companyProfileModel.setCompanyName(request.getParameter("companyName"));
 companyProfileModel.setCompanyChineseName(request.getParameter("companyChineseName"));  
 companyProfileModel.setBillingStatementContactemail(request.getParameter("billingStatementContactemail"));
 companyProfileModel.setBillingOrStatementAddr1(request.getParameter("billingOrStatementAddr1"));
 companyProfileModel.setBillingOrStatementAddr2(request.getParameter("billingOrStatementAddr2"));
 companyProfileModel.setBillingOrStatementAddr3(request.getParameter("billingOrStatementAddr3"));
 companyProfileModel.setBillingOrStatementAddr4(request.getParameter("billingOrStatementAddr4"));
 companyProfileModel.setRegistrationChannel(request.getParameter("registrationChannel"));
 companyProfileModel.setCompanyAddr1(request.getParameter("companyAddr1"));
 companyProfileModel.setCompanyAddr2(request.getParameter("companyAddr2"));
 companyProfileModel.setCompanyAddr3(request.getParameter("companyAddr3"));
 companyProfileModel.setCompanyAddr4(request.getParameter("companyAddr4"));
 companyProfileModel.setBusiRegistrationNum(request.getParameter("busiRegistrationNum"));
 companyProfileModel.setContactPerson(request.getParameter("contactPerson"));
 companyProfileModel.setContactChinesePerson(request.getParameter("contactChinesePerson"));
 companyProfileModel.setRegistrationRefNum(registrationRefNum);
 companyProfileModel.setSentPerson(request.getParameter("sentPerson"));
 companyProfileModel.setSentChinesePerson(request.getParameter("sentChinesePerson"));
 companyProfileModel.setTelephoneNo(request.getParameter("telephoneNo"));
 companyProfileModel.setBillingStatementContactfax(request.getParameter("billingStatementContactfax"));
 companyProfileModel.setMobileNo(request.getParameter("mobileNo"));
 companyProfileModel.setFaxNo(request.getParameter("faxNo"));
 companyProfileModel.setBillingStatementContactphone(request.getParameter("billingStatementContactphone"));
 companyProfileModel.setWebSite(request.getParameter("webSite"));
 companyProfileModel.setEmailAddr(request.getParameter("emailAddr"));
 companyProfileModel.setCompanyRemark(request.getParameter("companyRemark"));
 companyProfileModel.setMessage(request.getParameter("message"));
 companyProfileModel.setCompanyStatus(companyStatus);
 companyProfileModel.setPrefCommChannel(request.getParameter("prefCommChannel"));
 companyProfileModel.setPrefLanguage(request.getParameter("prefLanguage"));
companyProfileModel.setSuperUser(request.getParameter("admin"));
companyProfileModel.setPassword(request.getParameter("password"));


if (request.getParameter("creditAmount")==null) 
    companyProfileModel.setCreditAmount("0");
else if (request.getParameter("creditAmount").trim().length()==0)
    companyProfileModel.setCreditAmount("0");
else
 companyProfileModel.setCreditAmount(request.getParameter("creditAmount"));
 companyProfileModel.setPaymentTerms(request.getParameter("paymentTerms"));




String rcId=request.getParameter("reasonId");
if (rcId==null) rcId="";
rcId= rcId.trim();
if ("Any".equalsIgnoreCase(rcId))  rcId=null;


 companyProfileModel.setReasonId(rcId);

 session.removeAttribute("companyProfileModel");
 session.setAttribute("companyProfileModel",companyProfileModel);
%>


<html>

<head>

<LINK href="../css/line.css" rel=stylesheet>
<title>Trucker Information</title>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11"><font face="Arial, Helvetica, sans-serif">註冊信息確認</font></td>
    <td height="11">
      <div align="right"><a href="RegOperate.jsp?operate=<%=operate%>&back=<%=back%>" ><font
color="#003366" face="Arial, Helvetica, sans-serif">確定</font></a><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font><a
href="javascript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">取消
</font></a></div>
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
        <tr>
            <td>(管理員)</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>帳號：</td>
            <td>&nbsp; </td>
            <td>密碼：</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>留言：</td>
            <td><%=companyProfileModel.getMessage()%> </td>
            <td>選取語言：</td>
            <td><%=CbtbConstant.NLS_EN.equals(companyProfileModel.getPrefLanguage())?("英文"):("繁體中文")%></td>
        </tr>
        <tr>
            <td height="33">備注：</td>
            <td height="33"><%=companyProfileModel.getCompanyRemark()%> </td>
            <td height="33">&nbsp;</td>
            <td height="33">&nbsp;</td>
        </tr>
   <% String ts=null;
if (CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(companyStatus)) ts="註冊中";
if (CbtbConstant.COMPANY_ACTIVE.equalsIgnoreCase(companyStatus)) ts="正常";
if (CbtbConstant.COMPANY_DELETE.equalsIgnoreCase(companyStatus)) ts="已刪除";
if (CbtbConstant.COMPANY_SUSPEND.equalsIgnoreCase(companyStatus)) ts="停用";
if (CbtbConstant.COMPANY_BAD_LIST.equalsIgnoreCase(companyStatus)) ts="黑名單";
 %>  
     <tr>
        <td>狀況：</td>
        <td><%=ts%>&nbsp;</td>
        <td>原因代碼：</td>
<%
String rea=request.getParameter("reasonId");
if (rea!=null) rea=dbList.getReasonCodeDesc(request.getParameter("reasonId"),"CN");
%>
        <td><%=rea%>&nbsp;</td>
    </tr>
    <tr>
<%
String regc=null;
if (CbtbConstant.CAPTURE_CHANNEL_PHONE.equalsIgnoreCase(companyProfileModel.getRegistrationChannel())) regc="電話";
if (CbtbConstant.CAPTURE_CHANNEL_FAX.equalsIgnoreCase(companyProfileModel.getRegistrationChannel())) regc="傳真";
if (CbtbConstant.CAPTURE_CHANNEL_EMAIL.equalsIgnoreCase(companyProfileModel.getRegistrationChannel())) regc="電郵";
if (CbtbConstant.CAPTURE_CHANNEL_INTERNET.equalsIgnoreCase(companyProfileModel.getRegistrationChannel())) regc="因特網";                      

%>

        <td>登記途徑：</td>
        <td><%=regc%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>

<p>&nbsp;</p>
</body>
</html>
