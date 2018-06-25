<%@ include file="Init.jsp"%>   


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />

<jsp:useBean id="companyProfileModel" scope="page" class="com.cbtb.model.CompanyProfileModel" />

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_REGISTRATION"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
String back=request.getParameter("back");
CompanyManager cm = webOperator.getCompanyManager();
if (request.getParameter("companyId")!=null) {
companyProfileModel = cm.findCompanyProfile(request.getParameter("companyId"));
}
else
 companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");

%>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/DateValidLt.js></script>
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<script language="javascript">
function postform()
 {
with (document.regEdit)
  {
if (Trim(busiRegistrationNum.value).length==0)
   {
     alert("請輸入公司註冊編號");
     return;
   }
if (Trim(companyName.value).length==0)
   {
     alert("請輸入公司英文名稱");
     return;
   }
if (Trim(companyChineseName.value).length==0)
   {
     alert("請輸入公司中文名稱");
     return;
   }
if (Trim(companyAddr1.value).length==0)
   {
     alert("請輸入公司地址");
     return;
   }
if (Trim(contactPerson.value).length==0)
   {
     alert("請輸入公司聯絡人英文姓名");
     return;
   }
if (Trim(contactChinesePerson.value).length==0)
   {
     alert("請輸入公司聯絡人中文姓名");
     return;
   }
if (Trim(telephoneNo.value).length==0)
   {
     alert("請輸入公司電話號碼");
     return;
   }
if (Trim(faxNo.value).length==0  && Trim(emailAddr.value).length==0)
   {
     alert("請輸入傳真號碼或電郵");
     return;
   }
if (isNaN(telephoneNo.value)==true)
     {alert("電話號碼只能為數字，請重新輸入！");
       return;
         }
if (isNaN(faxNo.value)==true)
     {alert("傳真號碼只能為數字，請重新輸入！");
       return;
         }
if (isNaN(mobileNo.value)==true)
     {alert("手提電話號碼只能為數字，請重新輸入！");
       return;
         }
if (isNaN(billingStatementContactphone.value)==true)
     {alert("聯絡人電話號碼只能為數字，請重新輸入！");
       return;
         }
if (isNaN(billingStatementContactfax.value)==true)
     {alert("聯絡人傳真號碼只能為數字，請重新輸入！");
       return;
         }
if (!Trim(creditAmount.value).length==0) {  
   if ( !isInt(creditAmount.value)==true)
     { alert("信貸額只能為整數，請重新輸入！" );
       return;
      }
}
if (prefCommChannel(1).checked)
  { 
   if (Trim(faxNo.value).length==0)
     {
     alert("請輸入傳真號碼");
     return;
     }
  }
if (prefCommChannel(2).checked)
  {  if (Trim(emailAddr.value).length==0)
     {
     alert("請輸入電郵地址");
     return;
     }
  }
if(companyType.value==<%=CbtbConstant.COMPANY_TYPE_SHIPPER%>)
{
  if (Trim(sentPerson.value).length==0)
   {
     alert("請輸入結算聯絡人英文姓名");
     return;
   }
  if (Trim(billingOrStatementAddr1.value).length==0)
   {
     alert("請輸入結算聯絡地址");
     return;
   }


}
if ((companyStatus.value=="<%=CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS%>") || (companyStatus.value=="<%=CbtbConstant.COMPANY_ACTIVE%>"))
  {     
      if(reasonId.value!="Any")
       { alert("公司狀況在註冊中和正常時，不能輸入原因!");
            return; 
       }
       

  }
if ((companyStatus.value!="<%=CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS%>") && (companyStatus.value!="<%=CbtbConstant.COMPANY_ACTIVE%>"))
  {      if(reasonId.value=="Any")
       { alert("公司狀況在黑名單、暫停或已刪除時，請輸入明確的原因");
            return; 
        }
  }

  



}
regEdit.submit();
}
</script>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>




<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 

    <td height="11"> 
      <div align="right"><a href="javascript:history.back()"><font color="#003366">關閉</font></a></div>
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

<form method="post" name="regEdit" action="RegView.jsp">
<table border="0" width="90%">
 

<input type="hidden" name="operate" value="update">
<input type="hidden" name="back" value="<%=back%>">
<input type="hidden" name="registrationRefNum" value="<%=companyProfileModel.getRegistrationRefNum()%>">

    <tr> 
      <td width="25%">公司類型： </td>
<% String type = companyProfileModel.getCompanyType();
   String select=null;
   if (CbtbConstant.COMPANY_TYPE_TRUCKER.equalsIgnoreCase(type))  select="selected";
%>
      <td width="25%"> 
        <select name="companyType" size="1" tabindex=1>
        <option value="<%=CbtbConstant.COMPANY_TYPE_TRUCKER%>" <%=select%> >運輸公司</option>
<% select=null;
   if (CbtbConstant.COMPANY_TYPE_SHIPPER.equalsIgnoreCase(type))  select="selected";
%>
        <option value="<%=CbtbConstant.COMPANY_TYPE_SHIPPER%>" <%=select%> >付貨人公司</option>                      </select>
      </td>
      <td width="25%">公司註冊編號：</td>
      <td width="25%"> 
        <input type="text" size="20" name="busiRegistrationNum" maxlength="30" value="<%=companyProfileModel.getBusiRegistrationNum()%>" tabindex=2>    <font color="red">*</font>
     <input type="hidden"  name="companyId" value="<%=companyProfileModel.getCompanyId()%>"> 
      </td>
    </tr>
    <tr> 
      <td width="33%">公司英文名稱： </td>
      <td width="42%"> 
        <input type="text" size="20" name="companyName" maxlength="200" value="<%=companyProfileModel.getCompanyName()%>" tabindex=3>
         <font color="red">*</font>
      </td>
      <td width="22%">公司聯絡人英文姓名： </td>
      <td width="3%"> 
        <input type="text" size="20" name="contactPerson" maxlength="50" value="<%=companyProfileModel.getContactPerson()%>" tabindex=4> 
         <font color="red">*</font>
      </td>
    </tr>
    <tr> 
      <td width="33%">公司中文名稱：</td>
      <td width="42%"> 
        <input type="text" size="20" maxlength="60" name="companyChineseName" value="<%=companyProfileModel.getCompanyChineseName()%>" tabindex=5>
         <font color="red">*</font>
      </td>
      <td width="22%">公司聯絡人中文姓名：</td>
      <td width="3%"> 
        <input type="text" size="20" maxlength="16" name="contactChinesePerson" value="<%=companyProfileModel.getContactChinesePerson()%>" tabindex=6>
         <font color="red">*</font>
      </td>
    </tr>
    <tr> 
      <td width="33%">電話號碼：</td>
      <td width="42%"> 
        <input type="text" size="20" maxlength="30" name="telephoneNo"  value="<%=companyProfileModel.getTelephoneNo()%>" tabindex=7>
         <font color="red">*</font>
      </td>
      <td width="22%"> 註冊日期：</td>
      <td width="3%"><%=companyProfileModel.getRegistrationDate()%></td>
 <input type="hidden" name="registrationDate" value="<%=companyProfileModel.getRegistrationDate()%>" >
    </tr>
    <tr> 
      <td>選取聯絡途徑： </td>
<%
String channel= companyProfileModel.getPrefCommChannel();
String check=null;
if (CbtbConstant.CAPTURE_CHANNEL_PHONE.equalsIgnoreCase(channel)) check="checked";
%>      
      <td> 
        <input type="radio" checked name="prefCommChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>" <%=check%> tabindex=8>
        電話 </td>
<%
check=null;
if (CbtbConstant.CAPTURE_CHANNEL_FAX.equalsIgnoreCase(channel)) check="checked";
%>
      <td> 
        <input type="radio" name="prefCommChannel"
            value=<%=CbtbConstant.CAPTURE_CHANNEL_FAX%> <%=check%> tabindex=9>
        傳真 </td>
<%
check=null;
if (CbtbConstant.CAPTURE_CHANNEL_EMAIL.equalsIgnoreCase(channel)) check="checked";
%>
      <td> 
        <input type="radio" name="prefCommChannel"
            value=<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%> <%=check%> tabindex=10>
        電郵</td>
    </tr>
    <tr> 
      <td>傳真號碼：</td>
      <td> 
        <input type="text" size="20" name="faxNo" maxlength="30" value="<%=companyProfileModel.getFaxNo()%>" tabindex=11>
      </td>
      <td>公司地址：</td>
      <td> 
        <input type="text" size="20" name="companyAddr1" maxlength="16" value="<%=companyProfileModel.getCompanyAddr1()%>" tabindex=12>
         <font color="red">*</font>
      </td>
    </tr>
    <tr> 
      <td>手提電話號碼： </td>
      <td> 
        <input type="text" size="20" name="mobileNo" maxlength="20" value="<%=companyProfileModel.getMobileNo()%>" tabindex=16>
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" size="20" name="companyAddr2" maxlength="16" value="<%=companyProfileModel.getCompanyAddr2()%>" tabindex=13>
      </td>
    </tr>
    <tr> 
      <td>電郵地址：</td>
      <td> 
        <input type="text" size="20" name="emailAddr" maxlength="50" value="<%=companyProfileModel.getEmailAddr()%>" tabindex=17>
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" size="20" name="companyAddr3" maxlength="16" value="<%=companyProfileModel.getCompanyAddr3()%>" tabindex=14>
      </td>
    </tr>
    <tr> 
      <td width="33%">&nbsp;</td>
      <td width="42%">&nbsp;</td>
      <td width="22%">&nbsp;</td>
      <td width="3%"> 
        <input type="text" size="20" name="companyAddr4" maxlength="16" value="<%=companyProfileModel.getCompanyAddr4()%>" tabindex=15>
      </td>
    </tr>
    <tr> 
      <td width="33%">(結算聯絡) </td>
      <td width="42%">&nbsp;</td>
      <td width="22%">&nbsp;</td>
      <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td>聯絡人中文名：</td>
      <td> 
        <input type="text" size="20" name="sentChinesePerson" maxlength="16" value="<%=companyProfileModel.getSentChinesePerson()%>" tabindex=18>
      </td>
      <td>聯絡人英文名：</td>
      <td> 
        <input type="text" size="20" name="sentPerson" maxlength="50" value="<%=companyProfileModel.getSentPerson()%>" tabindex=19>
      </td>
    </tr>
    <tr> 
      <td width="33%">聯絡人電話號碼：</td>
      <td width="42%"> 
        <input type="text" size="20" name="billingStatementContactphone"  maxlength="30" value="<%=companyProfileModel.getBillingStatementContactphone()%>" tabindex=20>
      </td>
      <td width="22%">聯絡地址：</td>
      <td width="3%"> 
        <input type="text" size="20" name="billingOrStatementAddr1" maxlength="16" value="<%=companyProfileModel.getBillingOrStatementAddr1()%>" tabindex=21>
      </td>
    </tr>
    <tr> 
      <td>聯絡人電郵地址：</td>
      <td> 
        <input type="text" size="20" name="billingStatementContactemail" maxlength="50" value="<%=companyProfileModel.getBillingStatementContactemail()%>" tabindex=25>
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" size="20" name="billingOrStatementAddr2" maxlength="16" value="<%=companyProfileModel.getBillingOrStatementAddr2()%>" tabindex=22>
      </td>
    </tr>
    <tr> 
      <td>聯絡人傳真號碼：</td>
      <td> 
        <input type="text" size="20" name="billingStatementContactfax"  maxlength="50" value="<%=companyProfileModel.getBillingStatementContactfax()%>" tabindex=26>
      </td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" size="20" name="billingOrStatementAddr3" maxlength="16" value="<%=companyProfileModel.getBillingOrStatementAddr3()%>" tabindex=23>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td> 
        <input type="text" size="20" name="billingOrStatementAddr4" maxlength="16" value="<%=companyProfileModel.getBillingOrStatementAddr4()%>" tabindex=24>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td>(僅限付貨人)</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>公司網址：</td>
      <td> 
        <input type="text" size="20" name="webSite"  maxlength="30" value="<%=companyProfileModel.getWebSite()%>" tabindex=27>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>付款條款：</td>

      <td> 
        <select name="paymentTerms" size="1" tabindex=28>
<%
select=null;
if 
(CbtbConstant.COMPANY_PAYMENT_TERMS_CASH.equalsIgnoreCase(companyProfileModel.getPaymentTerms()))
 select="selected";
%>
          <option selected value="<%=CbtbConstant.COMPANY_PAYMENT_TERMS_CASH%>" <%=select%>  >現金</option>
<%
select=null;
if 
(CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT.equalsIgnoreCase(companyProfileModel.getPaymentTerms()))
 select="selected";
%>
          <option value="<%=CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT%>" <%=select%> >信用 </option>
        </select> 
      </td>
      <td>信貸額：</td>
      <td> 
        <input type="text" size="20" name="creditAmount" maxlength="10" value="<%=companyProfileModel.getCreditAmount()%>" tabindex=29>
      </td>
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
      <td> 
        <input type="text" size="20" name="textfield8" value="" tabindex=30>
      </td>
      <td>密碼：</td>
      <td> 
        <input type="password" size="20" name="textfield3" value="" tabindex=31>
      </td>
    </tr>
    <tr> 
      <td>留言：</td>
      <td> 
        <input type="text" size="20" name="message"  maxlength="100" value="<%=companyProfileModel.getMessage()%>" tabindex=32>
      </td>
      <td>&nbsp;</td>
      <td> 
       &nbsp;
      </td>
    </tr>
<tr>
      <td>選取語言：</td>
<%
select=null;
if 
(CbtbConstant.NLS_CN.equalsIgnoreCase(companyProfileModel.getPrefLanguage()))
 select="checked";
%>
      <td>
        <input type="radio" name="prefLanguage"
            value="<%=CbtbConstant.NLS_CN%>" <%=select%> tabindex=33>
        繁體中文</td>
<%
select=null;
if 
(CbtbConstant.NLS_EN.equalsIgnoreCase(companyProfileModel.getPrefLanguage()))
 select="checked";
%>
      <td>
        <input type="radio" name="prefLanguage"
            value="<%=CbtbConstant.NLS_EN%>" <%=select%> >
        英文</td>
</tr>
    <tr> 
      <td>備注：</td>
      <td> 
        <textarea name="companyRemark" rows="3" cols="18"  maxlength="66"tabindex=34><%=companyProfileModel.getCompanyRemark()%></textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 

      <td>狀況： </td>
      <td> 

<select name="companyStatus" size="1" tabindex=35>
<%
select=null;
if 
(CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(companyProfileModel.getCompanyStatus()))
 select="selected";
%>
          <option value="<%=CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS%>" <%=select%>  >註冊中</option>
<%
select=null;
if 
(CbtbConstant.COMPANY_DELETE.equalsIgnoreCase(companyProfileModel.getCompanyStatus()))
 select="selected";
%>
          <option value="<%=CbtbConstant.COMPANY_DELETE%>"  <%=select%> >已刪除</option>
<%
select=null;
if 
(CbtbConstant.COMPANY_BAD_LIST.equalsIgnoreCase(companyProfileModel.getCompanyStatus()))
 select="selected";
%>
                <option value="<%=CbtbConstant.COMPANY_BAD_LIST%>" <%=select%>  >黑名單</option>
<%
select=null;
if 
(CbtbConstant.COMPANY_ACTIVE.equalsIgnoreCase(companyProfileModel.getCompanyStatus()))
 select="selected";
%>
                <option value="<%=CbtbConstant.COMPANY_ACTIVE%>" <%=select%>  >正常</option>
<%
select=null;
if 
(CbtbConstant.COMPANY_SUSPEND.equalsIgnoreCase(companyProfileModel.getCompanyStatus()))
 select="selected";
%>
                <option value="<%=CbtbConstant.COMPANY_SUSPEND%>" <%=select%>  >暫停</option>
            </select>
      </td>
<td>原因代碼： </td>
      <td> 

        <select name="reasonId" size="1" tabindex=36>
<% 
String reaId=companyProfileModel.getReasonId();
if (reaId==null)  reaId=" ";
%>
        <%=dbList.getReasonCodeList(reaId, "CN")%>
        </select> 
      </td>
   
    </tr>
    <tr> 
      <td>登記途徑： </td>


<%
select=null;
if 
(CbtbConstant.CAPTURE_CHANNEL_PHONE.equalsIgnoreCase(companyProfileModel.getRegistrationChannel()))
 select="checked";
%>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>" <%=select%> tabindex=37>
        電話</td>
<%
select=null;
if 
(CbtbConstant.CAPTURE_CHANNEL_FAX.equalsIgnoreCase(companyProfileModel.getRegistrationChannel()))
 select="checked";
%>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_FAX%>"  <%=select%> >
        傳真</td>
<%
select=null;
if 
(CbtbConstant.CAPTURE_CHANNEL_EMAIL.equalsIgnoreCase(companyProfileModel.getRegistrationChannel()))
 select="checked";
%>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%>" <%=select%> >
        電郵</td>
<%
select=null;
if 
(CbtbConstant.CAPTURE_CHANNEL_INTERNET.equalsIgnoreCase(companyProfileModel.getRegistrationChannel()))
 select="checked";
%>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_INTERNET%>"  <%=select%> >
        因特網</td>

      </td>
      <td></td>
      <td>&nbsp;</td>
    </tr>
  </table>
 <p>
    <input type="button" name="denglu" value="提 交" onclick="javascript:postform()" tabindex=38>&nbsp;
    <input type="reset" name="B1" value="清除" tabindex=39>  </p>
  <p>&nbsp;</p>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>

</html>








