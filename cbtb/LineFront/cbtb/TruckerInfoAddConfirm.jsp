<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />
<%
//webOperator.clearPermissionContext();  //清除以前检查的内容
//webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
//webOperator.putPermissionContext("action", "view"); //加入检查的内容
//if (webOperator.checkPermission())
//  out.print("You have view trucker Context");
//else
//  out.print("You can't view trucker Context");
%>

<%
 String operate=request.getParameter("operate");
 String truckerId=null;
 if (operate.equalsIgnoreCase("update"))
 {
   truckerId=request.getParameter("truckerId");
 }
 if (operate.equalsIgnoreCase("insert"))
 {
  CompanyManager cm=webOperator.getCompanyManager();
  truckerId=cm.getNewTruckerDataNum();
 }

  String companyId=request.getParameter("companyId");
  String companyName=dbList.getCompanyName(companyId,"EN");


  tdm.setHkId(request.getParameter("hkId"));
  tdm.setTruckerId(truckerId);
  tdm.setTruckerName(request.getParameter("truckerName"));
  tdm.setTruckerChineseName(request.getParameter("truckerChineseName"));
  tdm.setCompanyId(companyId);
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
  tdm.setTruckStatus(request.getParameter("truckStatus"));
  tdm.setReasonId(request.getParameter("reasonId"));
  tdm.setCreationDate(Timestamp.valueOf(UtilTool.getCurrentDateTime()));
  session.setAttribute("truckerDataModel",tdm);

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨櫃車信息<font face="Arial, Helvetica, sans-serif" size="2" color="#667852"><b><b></b></b></font></font></b></font></b></font></td>
    <td>
      <div align="right"><a href="TruckerInfoInsert.jsp"><font
color="#003366" face="Arial, Helvetica, sans-serif">確定</font></a> |<a href="javascript:history.back()"><font
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="13">
      <div align="right">創建日期： 2001/01/01</div>
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
<form action="" name="frm">
<input type="hidden" name="operate" value="<%=operate%>">
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>運輸公司名稱：</td>
    <td><%=companyName%>&nbsp;</td>
    <td>香港身份證號碼 / 護照號碼：</td>
    <td><%=request.getParameter("hkId")%>&nbsp;</td>
  </tr>
  <tr>
    <td>貨櫃車編號：</td>
    <td><%=tdm.getTruckerId()%>&nbsp;</td>
    <td>貨櫃車型號：</td>
    <td><%=request.getParameter("truckModelNo")%>&nbsp;</td>
  </tr>
  <tr>
    <td>貨櫃車司機英文姓名：</td>
    <td><%=request.getParameter("truckerName")%>&nbsp;</td>
    <td>顔色：</td>
    <td><%=request.getParameter("truckColor")%>&nbsp;</td>
  </tr>
  <tr>
    <td>貨櫃車司機中文姓名：</td>
    <td><%=request.getParameter("truckerChineseName")%>&nbsp;</td>
    <td>重量 (公斤)：</td>
    <td><%=request.getParameter("carryWeight")%>&nbsp;</td>
  </tr>
  <tr>
    <td>地址：</td>
    <td><%=request.getParameter("truckerAddr1")%>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td><%=request.getParameter("truckerAddr2")%>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td><%=request.getParameter("truckerAddr3")%>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td><%=request.getParameter("truckerAddr4")%>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>内地車牌號碼：</td>
    <td><%=request.getParameter("inlandPlateNo")%>&nbsp;</td>
    <td>香港車牌號碼<font
size="3" >：</font></td>
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
  <tr>
    <td>備注：</td>
    <td><%=request.getParameter("remark")%>&nbsp;</td>
  </tr>
</table>
</form>

<p>&nbsp;</p>
<hr>
      <table width="400" border="0" align="center">
        <tr>
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
</body>
</html>






