<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="cbtbConstant" scope="session" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="parameterBean" scope="page" class="com.cbtb.javabean.SystemParameterJB" />
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<SCRIPT LANGUAGE=javascript>
function doPost()
{
   if (this.document.add.truckUserId.value.length == 0)
   {
     alert("請輸入用戶編號!");
     return ;
   }
   if (this.document.add.truckUserPassword.value.length == 0)
   {
     alert("請輸入用戶密碼!");
     return ;
   }
   if ((this.document.add.truckUserPassword.value)!=(this.document.add.rTruckUserPassword.value))
   {
     alert("您兩次輸入的密碼不一致!");
     return ;
   }
   add.submit();
}
</SCRIPT>
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
    String companyType = companyProfileModel.getCompanyType();
    String includeFile = "";
       int maxUser = 0;
   SystemProcessParameterValue myValue=new SystemProcessParameterValue();
   ArrayList arrayList;
 	   parameterBean.InitContent();
   	   arrayList=parameterBean.selectSystemParameter();
           myValue = (SystemProcessParameterValue)arrayList.get(0);
           String maxUserForTruck=myValue.maxUserForTruck.toString();
           String maxUserForShippe=myValue.maxUserForShippe.toString();
   if (companyType.equals(cbtbConstant.COMPANY_TYPE_TRUCKER))
     {maxUser = Integer.parseInt(maxUserForTruck);%>
     <%@ include file="../include/headtrucker.jsp"%>
  <%
   }
   if (companyType.equals(cbtbConstant.COMPANY_TYPE_SHIPPER))
    {
      maxUser = Integer.parseInt(maxUserForShippe);%>
      <%@ include file="../include/ShiperHead.jsp"%>
      <%
   }
Vector vecUser = new Vector(webOperator.getSecurityManager().findUserByDomain(companyId));
    if (vecUser.size()>=maxUser)
    {
     response.sendRedirect("ErrorPage.jsp?errorMessage=SEC_1007");
    }
   %>



<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
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
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">創建用戶信息</font></b></font></td>
    <td>
      <div align="right"><a href="JavaScript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>

<form action="UserView.jsp" name="add" method="post">
<table border="0" width="70%" >
   <tr>
    <td height="22">運輸公司名稱：</td>
    <td height="22"><%=dbList.getCompanyName(companyId,language)%></td>
    <td height="22">運輸公司編號：</td>
    <td height="22"><%=companyId%></td>
    </tr>
    <tr>
        <td>用戶編號：</td>
        <td><input type="text" size="20" name="truckUserId" maxlength="20"></td>
    </tr>
    <tr>
        <td>用戶密碼：</td>
        <td><input type="password" size="20" name="truckUserPassword" maxlength="20"></td>
    </tr>
    <tr>
        <td>確認密碼：</td>
        <td><input type="password" size="20" name="rTruckUserPassword" maxlength="20"></td>
   </tr>
   <tr>
        <td>用戶描述：</td>
        <td><input type="text" size=50 name="truckUserDescription" maxlength="20"></td>
   </tr>
 </table>
</form>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
			<a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a>
			<img src="../images/good.jpg" width="10" height="10">
			<a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
    </td>
  </tr>
</table>


<p>&nbsp;</p>
<hr>
      <table width="400" border="0" align="center">
        <tr>
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
      <%}%>
</body>
</html>







