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
webOperator.putPermissionContext("action", "create");
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
String back=request.getParameter("back");

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
with (document.regAdd)                   //if (Trim(departmentId.value).length == 0)
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
if (!Trim(creditAmount.value).length==0)  {
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
  {if (Trim(emailAddr.value).length==0)
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


 }
regAdd.submit();
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


<form method="post" name="regAdd" action="RegView.jsp">
<table border="0" width="90%">


<input type="hidden" name="operate" value="insert">
<input type="hidden" name="back" value="<%=back%>">
    <tr>
      <td width="25%">公司類型： </td>
      <td width="25%">
        <select name="companyType" size="1" tabindex=1>
        <option value="<%=CbtbConstant.COMPANY_TYPE_TRUCKER%>" >運輸公司</option>
        <option value="<%=CbtbConstant.COMPANY_TYPE_SHIPPER%>" >付貨人公司</option>                      </select>
      </td>
      <td width="25%">公司註冊編號：</td>
      <td width="25%">
        <input type="text" size="20" name="busiRegistrationNum" maxlength="30" tabindex=2>
         <font color="red">*</font>
      </td>
    </tr>
    <tr>
      <td width="33%">公司英文名稱： </td>
      <td width="42%">
        <input type="text" size="20" name="companyName" maxlength="200" tabindex=3>
         <font color="red">*</font>
      </td>
      <td width="22%">公司聯絡人英文姓名： </td>
      <td width="3%">
        <input type="text" size="20" name="contactPerson" maxlength="50" tabindex=4>
         <font color="red">*</font>
      </td>
    </tr>
    <tr>
      <td width="33%">公司中文名稱：</td>
      <td width="42%">
        <input type="text" size="20" maxlength="60" name="companyChineseName" tabindex=5>
         <font color="red">*</font>
      </td>
      <td width="22%">公司聯絡人中文姓名：</td>
      <td width="3%">
        <input type="text" size="20" maxlength="16"name="contactChinesePerson" tabindex=6>
         <font color="red">*</font>
      </td>
    </tr>
    <tr>
      <td width="33%">電話號碼：</td>
      <td width="42%">
        <input type="text" size="20" maxlength="30" name="telephoneNo" tabindex=7>
         <font color="red">*</font>
      </td>
      <td width="22%">&nbsp;</td>
      <td width="3%">&nbsp;</td>
    </tr>
    <tr>
      <td>選取聯絡途徑： </td>
      <td>

        <input type="radio" checked name="prefCommChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>" tabindex=8>
        電話 </td>
      <td>
        <input type="radio" name="prefCommChannel"
            value=<%=CbtbConstant.CAPTURE_CHANNEL_FAX%> >
        傳真 </td>
      <td>
        <input type="radio" name="prefCommChannel"
            value=<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%> >
        電郵</td>
    </tr>

    <tr>
      <td>傳真號碼：</td>
      <td>
        <input type="text" size="20" name="faxNo" maxlength="30" tabindex=9>

      </td>
      <td>公司地址：</td>
      <td>
        <input type="text" size="20" name="companyAddr1" maxlength="16" tabindex=10>
         <font color="red">*</font>
      </td>
    </tr>
    <tr>
      <td>手提電話號碼： </td>
      <td>
        <input type="text" size="20" name="mobileNo" maxlength="20" tabindex=14>
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="companyAddr2" maxlength="16" tabindex=11>
      </td>
    </tr>
    <tr>
      <td>電郵地址：</td>
      <td>
        <input type="text" size="20" name="emailAddr" maxlength="50" tabindex=15>
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="companyAddr3" maxlength="16" tabindex=12>
      </td>
    </tr>
    <tr>
      <td width="33%">&nbsp;</td>
      <td width="42%">&nbsp;</td>
      <td width="22%">&nbsp;</td>
      <td width="3%">
        <input type="text" size="20" name="companyAddr4" maxlength="16" tabindex=13>
      </td>
    </tr>
    <tr>
      <td width="33%">(結算聯絡) </td>
      <td width="42%">&nbsp;</td>
      <td width="22%">&nbsp;</td>
      <td width="3%">&nbsp;</td>
    </tr>
    <tr>
      <td>聯絡人中文姓名：</td>
      <td>
        <input type="text" size="20" name="sentChinesePerson" maxlength="16" tabindex=16>
      </td>
      <td>聯絡人英文姓名：</td>
      <td>
        <input type="text" size="20" name="sentPerson" maxlength="50" tabindex=17>
      </td>
    </tr>
    <tr>
      <td width="33%">聯絡人電話號碼：</td>
      <td width="42%">
        <input type="text" size="20" name="billingStatementContactphone"  maxlength="30" tabindex=18>
      </td>
      <td width="22%">聯絡地址：</td>
      <td width="3%">
        <input type="text" size="20" name="billingOrStatementAddr1" maxlength="16" tabindex=19>
      </td>
    </tr>
    <tr>
      <td>聯絡人電郵地址：</td>
      <td>
        <input type="text" size="20" name="billingStatementContactemail" maxlength="50" tabindex=23>
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr2" maxlength="16" tabindex=20>
      </td>
    </tr>
    <tr>
      <td>聯絡人傳真號碼：</td>
      <td>
        <input type="text" size="20" name="billingStatementContactfax"  maxlength="50" tabindex=24>
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr3" maxlength="16" tabindex=21>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr4" maxlength="16" tabindex=22>
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
        <input type="text" size="20" name="webSite"  maxlength="30" tabindex=25>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>付款條款：</td>
      <td>
        <select name="paymentTerms" size="1" tabindex=26>
          <option selected value="<%=CbtbConstant.COMPANY_PAYMENT_TERMS_CASH%>" >現金</option>
          <option value="<%=CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT%>">信用 </option>
        </select>
      </td>
      <td>信貸額：</td>
      <td>
        <input type="text" size="20" name="creditAmount" maxlength="10" tabindex=27>
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
        <input type="text" size="20" name="admin" tabindex=28>
      </td>
      <td>密碼：</td>
      <td>
        <input type="password" size="20" name="password" tabindex=29>
      </td>
    </tr>
    <tr>
      <td>留言：</td>
      <td>
        <input type="text" size="20" name="message" tabindex=30 maxlength="100">
      </td>
      <td>&nbsp;</td>
      <td>
     &nbsp;
      </td>
    </tr>
<tr>
      <td>選取語言：</td>
      <td>
        <input type="radio" name="prefLanguage"
            value="<%=CbtbConstant.NLS_CN%>" tabindex=31>
        繁體中文</td>
      <td>
        <input type="radio" name="prefLanguage"
            value="<%=CbtbConstant.NLS_EN%>" >
        英文</td>
</tr>
    <tr>
      <td>備注：</td>
      <td>
        <textarea name="companyRemark" rows="3" cols="18" tabindex=32 maxlength="66"></textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>




    <tr>
      <td>登記途徑： </td>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>"  tabindex=33>
        電話</td>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_FAX%>"  >
        傳真</td>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%>"  >
        電郵</td>
      <td>
        <input type="radio" name="registrationChannel"
            value="<%=CbtbConstant.CAPTURE_CHANNEL_INTERNET%>"  >
        因特網</td>

    </tr>
  </table>
 <p>
    <input type="button" name="denglu" value="提 交" onclick="javascript:postform()">&nbsp;
    <input type="reset" name="B1" value="清除">  </p>
  <p>&nbsp;</p>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>

</html>








