<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="java.sql.Timestamp" %>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="tdm" scope="session" class="com.cbtb.model.TruckerDataModel" />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<%@ include file="Init.jsp"%>
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
  tdm = (TruckerDataModel)session.getAttribute("truckerDataModel");
  String companyId = tdm.getCompanyId();
  String truckerId = tdm.getTruckerId();
  String truckerName = tdm.getTruckerName();
  String truckerChineseName = tdm.getTruckerChineseName();
  String hkId = tdm.getHkId();
  String truckerAddr1 = tdm.getTruckerAddr1();
  String truckerAddr2 = tdm.getTruckerAddr2();
  String truckerAddr3 = tdm.getTruckerAddr3();
  String truckerAddr4 = tdm.getTruckerAddr4();
  String hkTelephoneNo = request.getParameter("hkTelephoneNo");
  String hkMobileNo = request.getParameter("hkMobileNo");
  String hkPagerNo = request.getParameter("hkPagerNo");
  String inlandTelephoneNo = request.getParameter("inlandTelephoneNo");
  String inlandMobileNo = request.getParameter("inlandMobileNo");
  String inlandPagerNo = request.getParameter("inlandPagerNo");
  String hkLicenseNo = tdm.getHkLicenseNo();
  String inlandLicenseNo = tdm.getInlandLicenseNo();
  String hkPlateNo = tdm.getHkPagerNo();
  String inlandPlateNo = tdm.getInlandPlateNo();
  String truckModelNo = tdm.getTruckModelNo();
  String truckColor = tdm.getTruckColor();
  String carryWeight = tdm.getCarryWeight();
  String remark = tdm.remark;
  String truckStatus = tdm.getTruckStatus();
  String reasonId = tdm.getReasonId();
  tdm.setCarryWeight(carryWeight);
  tdm.setCompanyId(companyId);
  tdm.setCreationDate(Timestamp.valueOf(UtilTool.getCurrentDateTime()));
  tdm.setHkId(hkId);
  tdm.setHkLicenseNo(hkLicenseNo);
  tdm.setHkMobileNo(hkMobileNo);
  tdm.setHkPagerNo(hkPagerNo);
  tdm.setHkPlateNo(hkPlateNo);
  tdm.setHkTelephoneNo(hkTelephoneNo);
  tdm.setInlandLicenseNo(inlandLicenseNo);
  tdm.setInlandMobileNo(inlandMobileNo);
  tdm.setInlandPagerNo(inlandPagerNo);
  tdm.setInlandPlateNo(inlandPlateNo);
  tdm.setInlandTelephoneNo(inlandTelephoneNo);
  tdm.setReasonId(reasonId);
  tdm.setRemark(remark);
  tdm.setTruckColor(truckColor);
  tdm.setTruckerAddr1(truckerAddr1);
  tdm.setTruckerAddr1(truckerAddr2);
  tdm.setTruckerAddr1(truckerAddr3);
  tdm.setTruckerAddr1(truckerAddr4);
  tdm.setTruckerChineseName(truckerChineseName);
  tdm.setTruckerId(truckerId);
  tdm.setTruckerName(truckerName);
  tdm.setTruckModelNo(truckModelNo);
  tdm.setTruckStatus(truckStatus);
  session.setAttribute("truckerDataModel",tdm);
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
</table>
</table><table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">貨櫃車信息<font face="Arial, Helvetica, sans-serif" size="2" color="#667852"><b><b></b></b></font></font></b></font></b></font></td>
    <td>
      <div align="right"><a href="TruckerInfoUpdate.jsp"><font
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
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>運輸公司名稱：</td>
    <td><%=dbList.getCompanyName(tdm.getCompanyId(),"EN")%></td>
    <td>香港身份證號碼 / 護照號碼：</td>
    <td><%=tdm.getHkId()%></td>
  </tr>
  <tr>
    <td>貨櫃車編號：</td>
    <td><%=tdm.getTruckerId()%></td>
    <td>貨櫃車型號：</td>
    <td><%=tdm.getTruckModelNo()%></td>
  </tr>
  <tr>
    <td>貨櫃車司機英文姓名：</td>
    <td><%=tdm.getTruckerName()%></td>
    <td>顔色：</td>
    <td><%=tdm.getTruckColor()%></td>
  </tr>
  <tr>
    <td>貨櫃車司機中文姓名：</td>
    <td><%=tdm.getTruckerChineseName()%></td>
    <td>重量 (公斤)：</td>
    <td><%=tdm.getCarryWeight()%></td>
  </tr>
  <tr>
    <td>地址：</td>
    <td><%=tdm.getTruckerAddr1()%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td><%=tdm.getTruckerAddr2()%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td><%=tdm.getTruckerAddr3()%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td><%=tdm.getTruckerAddr4()%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>内地車牌號碼：</td>
    <td><%=tdm.getInlandPlateNo()%></td>
    <td>香港車牌號碼<font
size="3" >：</font></td>
    <td><%=tdm.getHkPlateNo()%></td>
  </tr>
  <tr>
    <td>内地電話號碼：</td>
    <td><%=tdm.getInlandTelephoneNo()%></td>
    <td>香港電話號碼：</td>
    <td><%=tdm.getHkTelephoneNo()%></td>
  </tr>
  <tr>
    <td>内地手提電話號碼：</td>
    <td><%=tdm.getInlandMobileNo()%></td>
    <td>香港手提電話號碼：</td>
    <td><%=tdm.getHkMobileNo()%></td>
  </tr>
  <tr>
    <td>内地傳呼機號碼：</td>
    <td><%=tdm.getInlandPagerNo()%></td>
    <td>香港傳呼機號碼：</td>
    <td><%=tdm.getHkPagerNo()%></td>
  </tr>
  <tr>
    <td>内地駕駛執照號碼：</td>
    <td><%=tdm.inlandLicenseNo%></td>
    <td>香港駕駛執照號碼：</td>
    <td><%=tdm.getHkLicenseNo()%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>狀況：</td>
    <td><%=tdm.getTruckStatus()%></td>
    <td>備注：</td>
    <td><%=tdm.getRemark()%></td>
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
</body>
</html>






