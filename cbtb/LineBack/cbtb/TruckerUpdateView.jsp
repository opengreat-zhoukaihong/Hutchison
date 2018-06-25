<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="web" scope="page" class="com.cbtb.web.WebOperator" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />

<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_REGISTRATION"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
String truckerId=request.getParameter("truckerId");
CompanyManager cm=web.getCompanyManager();
String companyName=request.getParameter("companyName");
String companyId=request.getParameter("companyId");
tdm=cm.findTruckerData(truckerId);
session.setAttribute("truckerDataModel",tdm);
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="11">貨櫃車司機信息</td>
    <td height="11"> 
      <div align="right"><a href="TruckerEdit.jsp?companyId=<%=companyId%>&truckerId=<%=truckerId%>&back=reg"><font
color="#003366" face="Arial, Helvetica, sans-serif">更新</font></a> | <a href="javascript:history.back()"><font
color="#003366" face="Arial, Helvetica, sans-serif">取消</font></a></div>
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
<table border="0" width="90%">
    <tr>
        <td>運輸公司名稱：</td>
        <td><%=dbList.getCompanyName(companyId,"CN")%>&nbsp;</td>
        <td>貨運公司編號：</td>
        <td><%=companyId%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車編號：</td>
        <td><%=tdm.getTruckerId()%>&nbsp;</td>
        <td>香港身份證號碼 / 護照號碼：</td>
        <td><%=tdm.getHkId()%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車司機姓名：</td>
        <td><%=tdm.getTruckerChineseName()%>&nbsp;</td>
        <td>貨櫃車型號：</td>
        <td><%=tdm.getTruckModelNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><%=tdm.getTruckerAddr1()%>&nbsp;</td>
        <td>顔色：</td>
        <td><%=tdm.getTruckColor()%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr2()%>&nbsp;</td>
        <td>重量 (公斤)：</td>
        <td><%=tdm.getCarryWeight()%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr3()%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr4()%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>内地車牌號碼：</td>
        <td><%=tdm.getInlandPlateNo()%>&nbsp;</td>
        <td>香港車牌號碼：</td>
        <td><%=tdm.getHkPlateNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地電話號碼：</td>
        <td><%=tdm.getInlandTelephoneNo()%>&nbsp;</td>
        <td>香港電話號碼：</td>
        <td><%=tdm.getHkTelephoneNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地手提電話號碼：</td>
        <td><%=tdm.getInlandMobileNo()%>&nbsp;</td>
        <td>香港手提電話號碼：</td>
        <td><%=tdm.getHkMobileNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地傳呼機號碼：</td>
        <td><%=tdm.getInlandPagerNo()%>&nbsp;</td>
        <td>香港傳呼機號碼：</td>
        <td><%=tdm.getHkPagerNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地駕駛執照號碼：</td>
        <td><%=tdm.getInlandLicenseNo()%>&nbsp;</td>
        <td>香港駕駛執照號碼：</td>
        <td><%=tdm.getHkLicenseNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
   <% String ts=null;
if(tdm.getTruckStatus()!=null)
{
if (tdm.getTruckStatus().equalsIgnoreCase(CbtbConstant.TRUCKER_ACTIVE)) ts="正常";
if (tdm.getTruckStatus().equalsIgnoreCase(CbtbConstant.TRUCKER_DELETE)) ts="已刪除";
if (tdm.getTruckStatus().equalsIgnoreCase(CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS)) ts="註冊中";
if (tdm.getTruckStatus().equalsIgnoreCase(CbtbConstant.TRUCKER_SUSPEND)) ts="暫停";
}
 %>  
     <tr>
        <td>狀況：</td>
        <td><%=ts%>&nbsp;</td>
        <td>備注：</td>
        <td><%=tdm.getRemark()%>&nbsp;</td>
    </tr>
    <tr>
        <td>原因代碼：</td>
<td>
      <% 
String rId=tdm.getReasonId();
if(rId==null)
   rId="";
else
rId=dbList.getReasonCodeDesc(rId,"EN");
%>
<%=rId%>
</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>

<p>&nbsp;</p>
</body>
</html>


