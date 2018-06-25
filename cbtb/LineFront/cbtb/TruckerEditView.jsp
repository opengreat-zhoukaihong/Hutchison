  
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
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
else
{
  
  String language = "CH";
  CompanyProfileModel companyProfileModel=new CompanyProfileModel();
  companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
  String companyId=companyProfileModel.getCompanyId();
  TruckerDataModel tdm = new TruckerDataModel();
  tdm=(TruckerDataModel)session.getAttribute("truckerDataModel");
  
        tdm.setHkTelephoneNo(request.getParameter("hkTelephoneNo"));
        tdm.setHkMobileNo(request.getParameter("hkMobileNo"));
        tdm.setHkPagerNo(request.getParameter("hkPagerNo"));
        tdm.setInlandTelephoneNo(request.getParameter("inlandTelephoneNo"));
        tdm.setInlandMobileNo(request.getParameter("inlandMobileNo"));
        tdm.setInlandPagerNo(request.getParameter("inlandPagerNo"));
        String theTruckerStatus=tdm.getTruckStatus();
  out.println(theTruckerStatus);
  session.removeAttribute("truckerDataModel");
  session.setAttribute("truckerDataModel",tdm);

%>


<html>

<head>

<LINK href="../css/line.css" rel=stylesheet>
<title>Trucker Information</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/headtrucker.jsp"%>

<p align="right"><a href="TruckerEditOperate.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a> | <a href="javascript:history.back()"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">
取消</font></a></p>

<p align="left">貨櫃車司機信息</p>



<table border="0" width="90%">
    <tr>
        <td>運輸公司名稱：</td>
        <td><%=dbList.getCompanyName(companyId,language)%>&nbsp;</td>
        <td>貨運公司編號</td>
        <td><%=companyId%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車編號：</td>
        <td><%=tdm.getTruckerId()%>&nbsp;</td>
        <td>香港身份證號碼 / 護照號碼：</td>
        <td><%=tdm.getHkId()%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車司機英文姓名：</td>
        <td><%=tdm.getTruckerName()%>&nbsp;</td>
        <td>貨櫃車型號：</td>
        <td><%=tdm.getTruckModelNo()%>&nbsp;</td>
    </tr>
    <tr>
        <td>貨櫃車司機中文姓名：</td>
        <td><%=tdm.getTruckerChineseName()%>&nbsp;</td>
        <td>顔色：</td>
        <td><%=tdm.getTruckColor()%>&nbsp;</td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><%=tdm.getTruckerAddr1()%>&nbsp;</td>
        <td>重量 (公斤)：</td>
        <td><%=tdm.getCarryWeight()%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><%=tdm.getTruckerAddr2()%>&nbsp;</td>
        <td>註冊日期：</td>
        <td><%=tdm.getCreationDate()%>&nbsp;</td>
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
        <td><%=tdm.getInlandPagerNo()%>&nbsp;</td>
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
if (CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(theTruckerStatus)) ts="註冊中";
if (CbtbConstant.TRUCKER_ACTIVE.equalsIgnoreCase(theTruckerStatus)) ts="正常";
if (CbtbConstant.TRUCKER_DELETE.equalsIgnoreCase(theTruckerStatus)) ts="已刪除";
if (CbtbConstant.TRUCKER_SUSPEND.equalsIgnoreCase(theTruckerStatus)) ts="停用";

 %>  
     <tr>
        <td>狀況：</td>
        <td><%=ts%>&nbsp;</td>
        <td>備注：</td>
        <td><%=tdm.getRemark()%>&nbsp;</td>
    </tr>
    <tr>
        <td>原因代碼：</td>
<%
String rea=request.getParameter("reasonId");
if (rea!=null) rea=dbList.getReasonCodeDesc(tdm.getReasonId(),language);
%>
        <td><%=rea%>&nbsp;</td>
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
