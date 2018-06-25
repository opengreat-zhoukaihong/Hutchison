  
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
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />

<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
else
{
  

String truckerId=null;

String language="CN";
CompanyManager cm=webOperator.getCompanyManager();
truckerId=cm.getNewTruckerDataNum();
tdm.setCreationDate(Timestamp.valueOf(UtilTool.getCurrentDateTime()));
String companyName=null;
String companyId=request.getParameter("companyId");
companyName=dbList.getCompanyName(companyId,language);
String theTruckerStatus=CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS;
tdm.setHkId(request.getParameter("hkId"));
tdm.setTruckerId(truckerId);
tdm.setTruckerName(request.getParameter("truckerName"));
tdm.setTruckerChineseName(request.getParameter("truckerChineseName"));
tdm.setCompanyId(companyId);
tdm.setTruckStatus(theTruckerStatus);
      tdm.setTruckerAddr1(request.getParameter("truckerAddr1"));
      tdm.setTruckerAddr2(request.getParameter("truckerAddr2"));
      tdm.setTruckerAddr3(request.getParameter("truckerAddr3"));
      tdm.setTruckerAddr4(request.getParameter("truckerAddr4"));
      tdm.setHkTelephoneNo(request.getParameter("hkTelephoneNo"));
      tdm.setHkMobileNo(request.getParameter("hkMobileNo"));
      tdm.setHkPagerNo(request.getParameter("hkPagerNo"));
      tdm.setInlandTelephoneNo(request.getParameter("inlandTelephoneNo"));
      tdm.setInlandMobileNo(request.getParameter("inlandMobileNo"));
      tdm.setInlandPagerNo(request.getParameter("inlandPagerNo"));
      tdm.setHkLicenseNo(request.getParameter("hkLicenseNo"));
      tdm.setInlandLicenseNo(request.getParameter("inlandLicenseNo"));
      tdm.setHkPlateNo(request.getParameter("hkPlateNo"));
      tdm.setInlandPlateNo(request.getParameter("inlandPlateNo"));
      tdm.setTruckModelNo(request.getParameter("truckModelNo"));
      tdm.setTruckColor(request.getParameter("truckColor"));
      tdm.setCarryWeight(request.getParameter("carryWeight"));
      tdm.setRemark(request.getParameter("remark"));
      tdm.setReasonId(null);

session.setAttribute("truckerDataModel",tdm);

%>


<html>

<head>

<LINK href="../css/line.css" rel=stylesheet>
<title>Trucker Information</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/headtrucker.jsp"%>

<p align="right"><a href="TruckerOperate.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="javascript:history.back()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">
取消</font></a></p>

<p align="left">貨櫃車司機信息</p>



<table border="0" width="90%">
    <tr>
        <td>運輸公司名稱：</td>
        <td><%=companyName%>&nbsp;</td>
        <td>貨運公司編號</td>
        <td><%=companyId%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車編號：</td>
        <td><%=tdm.getTruckerId()%>&nbsp;</td>
        <td>香港身份證號碼 / 護照號碼：</td>
        <td><%=request.getParameter("hkId")%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車司機英文姓名：</td>
        <td><%=request.getParameter("truckerName")%>&nbsp;</td>
        <td>貨櫃車型號：</td>
        <td><%=request.getParameter("truckModelNo")%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車司機中文姓名：</td>
        <td><%=request.getParameter("truckerChineseName")%>&nbsp;</td>
        <td>顔色：</td>
        <td><%=request.getParameter("truckColor")%>&nbsp;</td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><%=request.getParameter("truckerAddr1")%>&nbsp;</td>
        <td>重量 (公斤)：</td>
        <td><%=request.getParameter("carryWeight")%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=request.getParameter("truckerAddr2")%>&nbsp;</td>
        <td>註冊日期：</td>
        <td><%=tdm.getCreationDate()%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=request.getParameter("truckerAddr3")%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=request.getParameter("truckerAddr4")%>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>内地車牌號碼：</td>
        <td><%=request.getParameter("inlandPlateNo")%>&nbsp;</td>
        <td>香港車牌號碼：</td>
        <td><%=request.getParameter("hkPlateNo")%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地電話號碼：</td>
        <td><%=request.getParameter("inlandTelephoneNo")%>&nbsp;</td>
        <td>香港電話號碼：</td>
        <td><%=request.getParameter("hkTelephoneNo")%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地手提電話號碼：</td>
        <td><%=request.getParameter("inlandMobileNo")%>&nbsp;</td>
        <td>香港手提電話號碼：</td>
        <td><%=request.getParameter("hkMobileNo")%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地傳呼機號碼：</td>
        <td><%=request.getParameter("inlandPagerNo")%>&nbsp;</td>
        <td>香港傳呼機號碼：</td>
        <td><%=request.getParameter("hkPagerNo")%>&nbsp;</td>
    </tr>
    <tr>
        <td>内地駕駛執照號碼：</td>
        <td><%=request.getParameter("inlandLicenseNo")%>&nbsp;</td>
        <td>香港駕駛執照號碼：</td>
        <td><%=request.getParameter("hkLicenseNo")%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
   <% String ts=null;
if (CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(theTruckerStatus)) ts="註冊中";
if (CbtbConstant.TRUCKER_ACTIVE.equalsIgnoreCase(theTruckerStatus)) ts="正常";
if (CbtbConstant.TRUCKER_DELETE.equalsIgnoreCase(theTruckerStatus)) ts="已刪除";
if (CbtbConstant.TRUCKER_SUSPEND.equalsIgnoreCase(theTruckerStatus)) ts="停用";

 %>  
     <tr>
        <td>狀況：</td>
        <td><%=ts%>&nbsp;</td>
        <td>備注：</td>
        <td><%=request.getParameter("remark")%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
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
