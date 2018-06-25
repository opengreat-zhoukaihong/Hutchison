<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>

<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagSjf" scope="session" class="com.cbtb.util.NewPagination" />


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","GUANLAN"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%

String companyId = request.getParameter("companyId");
String companyName = request.getParameter("companyName");
String truckerName = request.getParameter("truckerName");
String matchNumber = request.getParameter("matchNumber");
String hkPlateNo = request.getParameter("hkPlateNo");
String deliveryDate = request.getParameter("deliveryDate");
String deliveryTimeId = request.getParameter("deliveryTimeId");
String orderByField = request.getParameter("orderByField");

String num=request.getParameter("num");
ArrayList matchList = (ArrayList) session.getAttribute("matchList");
ArrayList guanLan = new ArrayList(); 
ArrayList tempList = new ArrayList();
  System.out.println("***********************************");
System.out.println(matchList.size());
int count=0;
for (int i = 0;  (!matchList.isEmpty()) && i < matchList.size(); i++) {
        mcrm = (MatchModel)matchList.get(i);
  System.out.println("***********************************");
  String containerNum= "containerNum"+String.valueOf(count);

  String shippingOrderNo= "shippingOrderNo"+String.valueOf(count);

  String matchStatus= "matchStatus"+String.valueOf(count);
  count++;
boolean con=false;
boolean ship=false;
boolean status=false;
if (mcrm.getContainerNum()==null && request.getParameter(containerNum).trim().length()==0)
   con=true;

else if (request.getParameter(containerNum).equalsIgnoreCase(mcrm.getContainerNum()))
         con=true;
if (mcrm.getDeliveryRequestModel().getShippingOrderNo()==null && request.getParameter(shippingOrderNo).trim().length()==0)
ship=true;

else if (request.getParameter(shippingOrderNo).equalsIgnoreCase(mcrm.getDeliveryRequestModel().getShippingOrderNo()))
         ship=true;

if ((request.getParameter(matchStatus)==null ||  request.getParameter(matchStatus).trim().length()==0 ))
   status=true;

else if (request.getParameter(matchStatus).equalsIgnoreCase(mcrm.getMatchStatus()))
         status=true;
if ((!con)  || (!status))
{ String[] str=new String[4]; 


  str[0]=mcrm.getMatchNum();


str[1]=request.getParameter(containerNum);
System.out.println(request.getParameter(matchStatus));
System.out.println(CbtbConstant.MATCH_STATUS_CONTAINER_PICKUP);
str[2]=request.getParameter(shippingOrderNo);
if ((request.getParameter(matchStatus)!=null) && (request.getParameter(matchStatus).trim().length()!=0))
  str[3]=request.getParameter(matchStatus); 
else {str[3]=mcrm.getMatchStatus();}
  guanLan.add(str);  
tempList.add(matchList.get(i));
}
//else { matchList.remove(i); i=i-1; }
 } 
  System.out.println("***********************************");
session.setAttribute("guanLan",guanLan);
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<SCRIPT LANGUAGE=javascript>
function doPost()
{


   document.confirm.submit();
}
</SCRIPT>

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
    <td height="11" width="18%"><font size="2">觀蘭狀況確認</font></td>
    <td height="11" width="82%"> 
      <div align="right"><font
color="#003366" face="Arial, Helvetica, sans-serif"><a href="javascript:doPost()">確定</a></font><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font><a href="javascript:history.back()"><font color="#003366" face="Arial, Helvetica, sans-serif">取消</font></a></div>
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

<form name="confirm" action="GuanLanOperate.jsp">


 <table border="1" width="100%">
  <tr> 
    <td><font size="2">配對編號</font></td>
    <td><font size="2">送貨要求編號</font></td>
    <td><font size="2">登記空車編號</font></td>
    <td><font size="2">貨櫃車司機姓名</font></td>
    <td><font size="2">送貨日期</font> <font
        size="2">送貨時間</font> </td>
    <td><font size="2">車牌號碼</font></td>
    <td><font size="2">貨櫃編號</font></td>
    <td><font size="2">落貨紙/提貨單</font></td>
    <td><font size="2">狀況更新</font></td>
  </tr>
 <input type="hidden" name="companyId" value="<%=companyId%>">
 <input type="hidden" name="companyName" value="<%=companyName%>">
 <input type="hidden" name="truckerName" value="<%=truckerName%>">
 <input type="hidden" name="matchNumber" value="<%=matchNumber%>">
 <input type="hidden" name="hkPlateNo" value="<%=hkPlateNo%>">
 <input type="hidden" name="deliveryDate" value="<%=deliveryDate%>">
 <input type="hidden" name="deliveryTimeId" value="<%=deliveryTimeId%>">
 <input type="hidden" name="orderByField" value="<%=orderByField%>">
<%
for (int i = 0;  (!tempList.isEmpty()) && i < tempList.size(); i++) {
    System.out.println(guanLan.size());   
     mcrm = (MatchModel)tempList.get(i);
        String[] str=(String[])guanLan.get(i);
        

%>
  <tr> 
    <td><%=mcrm.getMatchNum()%>&nbsp;</td>
    <td><%=mcrm.getDeliveryRequestNum()%>&nbsp;</td>
    <td><%=mcrm.getTruckCapacityNum()%>&nbsp;</td>
    <td><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),"CN")%>&nbsp;</td>
    <td><%=mcrm.getTruckCapacityModel().getDeliveryDate()%>&nbsp;<%=dbList.getDeliveryTimeDesc(mcrm.getTruckCapacityModel().getDeliveryTimeId(),"EN")%>&nbsp;</td>
    <td><%=dbList.getTruckerHKPlate(mcrm.getTruckCapacityModel().getTruckerId())%>&nbsp;</td>
    <td><%=str[1]%>&nbsp;</td>
    <td><font size="2"><%=str[2]%>&nbsp;</font></td>
<%
String statusDesc=" ";


if (CbtbConstant.MATCH_STATUS_MATCHED.equalsIgnoreCase(str[3].trim())) statusDesc= "已配對";
if (CbtbConstant.MATCH_STATUS_CONFIRM.equalsIgnoreCase(str[3].trim())) statusDesc= "已確認";
if (CbtbConstant.MATCH_STATUS_CONTAINER_PICKUP.equalsIgnoreCase(str[3].trim())) statusDesc="已裝箱";
if (CbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED.equalsIgnoreCase(str[3].trim())) statusDesc="已送貨";

%>    
    <td><%=statusDesc%>&nbsp;</td>
  </tr>
<%}%>
</table>
<input type="hidden" name="pageNum" value="<%=request.getParameter("pageNum")%>">
</form>
<p align="left">&nbsp;</p>

</body>

</html>








