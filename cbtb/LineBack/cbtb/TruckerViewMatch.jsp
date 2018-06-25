<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />

<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />

<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (!webOperator.checkPermission())
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
 String language="CN";
 String operate=request.getParameter("operate"); 
String truckerId=request.getParameter("truckerId");
CompanyManager cm=webOperator.getCompanyManager();
String companyName=dbList.getCompanyName(request.getParameter("companyId"),"CH");
String companyId=request.getParameter("companyId");
tdm=cm.findTruckerData(truckerId);
session.setAttribute("truckerDataModel",tdm);
%>
<html>
<head>
<title>Untitled Document</title>
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
    <td height="11">貨櫃車司機信息</td>
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
<table border="0" width="90%">
    <tr>
        <td>運輸公司名稱：</td>
        <td><%=companyName%>&nbsp;</td>
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
if (tdm.getTruckStatus().equalsIgnoreCase(CbtbConstant.TRUCKER_ACTIVE)) ts="正常";
if (tdm.getTruckStatus().equalsIgnoreCase(CbtbConstant.TRUCKER_DELETE)) ts="已刪除";
 %>  
     <tr>
        <td>狀況：</td>
        <td><%=ts%>&nbsp;</td>
        <td>備注：</td>
        <td><%=tdm.getRemark()%>&nbsp;</td>
    </tr>
    <tr>
        <td>原因代碼：</td>
        <td><%=dbList.getReasonCodeDesc(tdm.getReasonId(),language)%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>

<p>&nbsp;</p>
</body>
</html>


