<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.web.*"%>
<%//@ include file="Init.jsp"%>
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />

<%

companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
String companyId = companyProfileModel.getCompanyId();
%>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
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
if ( isNaN(creditAmount.value)==true)
     { alert("貸款額只能為數字，請重新輸入！" );
       return;
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


    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>運輸公司註冊資料</b></font></font></td>
      <td width="57%">

      <div align="right"><a
href="Trading_Partner_search.htm"></a><a href="indexTrucking.jsp"><font color="#003366">關閉</font></a></div>
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
    >註冊日期：<%=companyProfileModel.getRegistrationDate()%></font></div>
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


<form action="TruckRegistrationConfirm.jsp" method="post" name="regEdit">
  <table width="98%" border="0" height="126" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="21%">公司英文名稱：</td>
      <td width="30%"><%=dbList.getCompanyName(companyProfileModel.getCompanyId(),"EN")%></td>
      <td width="26%">公司註冊編號：</td>
      <td width="20%"><%=companyProfileModel.getBusiRegistrationNum()%></td>
    </tr>
    <tr>
      <td height="32">公司中文名稱：</td>
      <td height="32"><%=companyProfileModel.getCompanyChineseName()%></td>
      <td height="32">聯絡人英文姓名：</td>
      <td height="32">
        <input type="text" size="20" name="contactPerson" maxlength="20" value="<%=companyProfileModel.getContactPerson()%>">
      </td>
    </tr>
    <tr>
      <td>電話號碼：</td>
      <td>
        <input type="text" size="20" name="telephoneNo" maxlength="20" value="<%=companyProfileModel.getTelephoneNo()%>">
      </td>
      <td>聯絡人中文姓名：</td>
      <td>
        <input type="text" size="20" name="contactChinesePerson" maxlength="20" value="<%=companyProfileModel.getContactChinesePerson()%>">
      </td>
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
                    value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>" <%=check%> >
                電話 </td>
        <%
        check=null;
        if (CbtbConstant.CAPTURE_CHANNEL_FAX.equalsIgnoreCase(channel)) check="checked";
        %>
              <td> 
                <input type="radio" name="prefCommChannel"
                    value=<%=CbtbConstant.CAPTURE_CHANNEL_FAX%> <%=check%> >
                傳真 </td>
        <%
        check=null;
        if (CbtbConstant.CAPTURE_CHANNEL_EMAIL.equalsIgnoreCase(channel)) check="checked";
        %>
      <td> 
        <input type="radio" name="prefCommChannel"
            value=<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%> <%=check%> >
        電郵</td>
    </tr>
    <tr>
      <td>傳真號碼：</td>
      <td>
        <input type="text" size="20" name="faxNo" maxlength="20" value="<%=companyProfileModel.getFaxNo()%>">
      </td>
      <td>手提電話號碼： </td>
      <td>
        <input type="text" size="20" name="mobileNo" maxlength="20" value="<%=companyProfileModel.getMobileNo()%>">
      </td>
    </tr>
    <tr>
      <td>電郵地址：</td>
      <td>
        <input type="text" size="20" name="emailAddr" value="<%=companyProfileModel.getEmailAddr()%>">
      </td>
      <td>公司地址：</td>
      <td>
        <input type="text" size="20" name="companyAddr1" value="<%=companyProfileModel.getCompanyAddr1()%>">
      </td>
    </tr>
    <tr>
      <td>公司網址：</td>
      <td>
        <input type="text" size="20" name="webSite" value="<%=companyProfileModel.getWebSite()%>">
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="companyAddr2" value="<%=companyProfileModel.getCompanyAddr2()%>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="companyAddr3" value="<%=companyProfileModel.getCompanyAddr3()%>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="companyAddr4" value="<%=companyProfileModel.getCompanyAddr4()%>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>(付款聯絡資料) </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>聯絡人：</td>
      <td>
        <input type="text" size="20" name="sentPerson" maxlength="20" value="<%=companyProfileModel.getSentPerson()%>">
      </td>
      <td>聯絡地址：</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr1" maxlength="50" value="<%=companyProfileModel.getBillingOrStatementAddr1()%>">
      </td>
    </tr>
    <tr>
      <td>聯絡人電話號碼：</td>
      <td>
        <input type="text" size="20" name="billingStatementContactphone" maxlength="20" value="<%=companyProfileModel.getBillingStatementContactphone()%>">
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr2" maxlength="50" value="<%=companyProfileModel.getBillingOrStatementAddr2()%>">
      </td>
    </tr>
    <tr>
      <td>聯絡人電郵地址：</td>
      <td>
        <input type="text" size="20" name="billingStatementContactemail" maxlength="20" value="<%=companyProfileModel.getBillingStatementContactemail()%>">
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr3" maxlength="50" value="<%=companyProfileModel.getBillingOrStatementAddr3()%>">
      </td>
    </tr>
    <tr>
      <td>聯絡人傳真號碼：</td>
      <td>
        <input type="text" size="20" name="billingStatementContactfax" maxlength="20" value="<%=companyProfileModel.getBillingStatementContactfax()%>">
      </td>
      <td>&nbsp;</td>
      <td>
        <input type="text" size="20" name="billingOrStatementAddr4" value="<%=companyProfileModel.getBillingOrStatementAddr4()%>">
      </td>
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
        <input type="text" size="20" name="textfield142222">
      </td>
      <td>密碼：</td>
      <td>
        <input type="text" size="20" name="textfield1452">
      </td>
    </tr>
    <tr>
      <td>選取語言：</td>
      <td> 

        <select name="prefLanguage" size="1">
<%
String select=null;
if 
(CbtbConstant.NLS_CN.equalsIgnoreCase(companyProfileModel.getPrefLanguage()))
 select="selected";
%>
                <option value="<%=CbtbConstant.NLS_CN%>" <%=select%> >繁體中文</option>
<%
select=null;
if 
(CbtbConstant.NLS_EN.equalsIgnoreCase(companyProfileModel.getPrefLanguage()))
 select="selected";
%>
                <option value="<%=CbtbConstant.NLS_EN%>" <%=select%> >英文</option>
         </select>
      </td>
      <td>確認密碼：</td>
      <td>
        <input type="text" size="20" name="textfield14522">
      </td>
    </tr>
    <tr>
      <td>留言：</td>
      <td height="120">
        <textarea name="message" rows="3" cols="18" style="width:200px" value="<%=companyProfileModel.getMessage()%>"><%=companyProfileModel.getMessage()%>  </textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4">&nbsp;</td>
    </tr>
  </table>
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td height="30"> <a href="javascript:regEdit.submit()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a><img src="../images/good.jpg" width="10" height="10"><a href="javascript:regEdit.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
      </td>
    </tr>
  </table>

</form>
<hr>
<%@ include file="../include/end.jsp"%>
</BODY>
</HTML>





