<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.web.*"%>

<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />

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
String update="";
String companyId = request.getParameter("companyId");
CompanyManager companyManager = webOperator.getCompanyManager();
companyProfileModel=  companyManager.findCompanyProfile(companyId);
session.setAttribute("companyProfileModel",companyProfileModel);
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
 String capChannel="";
capChannel=(String)companyProfileModel.getRegistrationChannel();
if (capChannel!=null)
{
if (capChannel.equals(CbtbConstant.CAPTURE_CHANNEL_INTERNET))
capChannel="因特網";
if (capChannel.equals(CbtbConstant.CAPTURE_CHANNEL_EMAIL))
capChannel="電郵";
if (capChannel.equals(CbtbConstant.CAPTURE_CHANNEL_FAX))
capChannel="傳真";
if (capChannel.equals(CbtbConstant.CAPTURE_CHANNEL_PHONE))
capChannel="電話";
}
String comStauts=companyProfileModel.getCompanyStatus();
if (comStauts!=null)
{
if (comStauts.equals(CbtbConstant.COMPANY_BAD_LIST))
comStauts="黑名單";
if (comStauts.equals(CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS))
comStauts="註冊中";
if (comStauts.equals(CbtbConstant.COMPANY_DELETE))
comStauts="已刪除";
if (comStauts.equals(CbtbConstant.COMPANY_ACTIVE))
comStauts="正常";
if (comStauts.equals(CbtbConstant.COMPANY_SUSPEND))
comStauts="停用";
}
%>
<html>
<head>

<LINK href="../css/line.css" rel=stylesheet>
<title>Information</title>
</head>



<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="11"><font face="Arial, Helvetica, sans-serif">付貨人註冊信息</font></td>
    <td height="11"> 
      <div align="right"><font color="#003366"><a href="RegEdit.jsp?back=reg">更新</a></font> |  </font><a href="RegistrationSearch.jsp"><font
color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="IMAGES/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<form action="Registration_view.htm" method="post">
  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td>公司類型： </td>    <td>付貨人公司</td>
      <td>公司註冊編號/公司編號：</td>
      <td><%=companyProfileModel.getBusiRegistrationNum()%> /<%=companyId%></td>
    </tr>
    <tr> 
      <td>公司英文名稱：</td>
      <td><%=companyProfileModel.getCompanyName()%></td>
      <td>公司聯絡人英文姓名： </td>
      <td><%=companyProfileModel.getContactPerson()%></td>
    </tr>
    <tr> 
      <td>公司中文名稱：</td>
      <td><%=companyProfileModel.getCompanyChineseName()%></td>
      <td>公司聯絡人中文姓名：</td>
      <td><%=companyProfileModel.getContactChinesePerson()%></td>
    </tr>
    <tr> 
      <td>電話號碼：</td>
      <td><%=companyProfileModel.getTelephoneNo()%></td>
      <td>註冊日期：</td>
      <td><%=companyProfileModel.getRegistrationDate()%></td>
    </tr>
    <tr> 
      <td>選取聯絡途徑： </td>
      <td><%=comChannel%> </td>
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
      <td> <%=companyProfileModel.getBillingStatementContactfax()%></td>
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
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>(僅限付貨人)</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>公司網址：</td>
      <td><%=companyProfileModel.getWebSite()%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>付款條款：</td>
<%if (companyProfileModel.getPaymentTerms()!=null) {%>      <td><%=CbtbConstant.COMPANY_PAYMENT_TERMS_CASH.equals(companyProfileModel.getPaymentTerms())?"現金":"信用"%> </td>
<%}
else {%>
      <td>&nbsp;</td>
 <%}%> 
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
      <td>&nbsp;</td>
      <td>密碼：</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>留言：</td>
      <td><%=companyProfileModel.getMessage()%></td>
      <td>選取語言：</td>
      <td><%=CbtbConstant.NLS_EN.equals(companyProfileModel.getPrefLanguage())?"英文":"繁體中文"%></td>
    </tr>
    <tr> 
      <td>備注：</td>
      <td><%=companyProfileModel.getCompanyRemark()%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>狀況： </td>
      <td><%=comStauts%></td>
      <td>原因代碼： </td>
<% 
String rId=companyProfileModel.getReasonId();
if(rId==null)
   rId="";
else
rId=dbList.getReasonCodeDesc(rId,"CN");
%>
      <td><%=rId%></td>
    </tr>
    <tr> 
      <td>登記途徑： </td>
      <td><%=capChannel%></td>
      <td></td>
      <td>&nbsp;</td>
    </tr>
  </table>
    <p>&nbsp; </p>
</form>
</body>

</html>








