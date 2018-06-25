<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="parameterBean" scope="page" class="com.cbtb.javabean.SystemParameterJB" />
<html>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","SYSTEM_PARAMETER"); 
webOperator.putPermissionContext("action", "view"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>系統處理參數列表
</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="SystemParameterEdit.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">更新</font></a>
<font color="#003366" size="2"face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">系統處理參數列表維護</font></p>

<hr>
<table width="58%" border="0">
  <%
   String recordId;
   String processLeadTime;
   String maxUserForTruck;
   String maxUserForShippe;
   String invoiceSpecificDay1;
   String invoiceSpecificDay2;
   String invoiceSpecificDay3;
   String invoiceSpecificDay4;
   String invoiceDuedays;
   String lastUpdateDate;
   SystemProcessParameterValue myValue=new SystemProcessParameterValue();
   Vector parameters =new Vector();
   ArrayList arrayList;
      try{
 	   parameterBean.InitContent();
   	   arrayList=parameterBean.selectSystemParameter();
           myValue = (SystemProcessParameterValue)arrayList.get(0);
           recordId=myValue.recordId.toString();
           processLeadTime=myValue.processLeadTime.toString();
           maxUserForTruck=myValue.maxUserForTruck.toString();
           maxUserForShippe=myValue.maxUserForShippe.toString();
           invoiceSpecificDay1=myValue.invoiceSpecificDay1.toString();
           invoiceSpecificDay2=myValue.invoiceSpecificDay2.toString();
           invoiceSpecificDay3=myValue.invoiceSpecificDay3.toString();
           invoiceSpecificDay4=myValue.invoiceSpecificDay4.toString();
           invoiceDuedays=myValue.invoiceDuedays.toString();
           lastUpdateDate=myValue.lastUpdateDate.toString().substring(0,10);
  %>
  <tr> 
    <td width="42%"> 
      <div align="left">預配對天數：</div>
    </td>
    <td width="49%"><%=processLeadTime%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">貨運公司用戶數：</div>
    </td>
    <td width="49%"><%=maxUserForTruck%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">付貨公司用戶數：</div>
    </td>
    <td width="49%"><%=maxUserForShippe%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">發票產生日1：</div>
    </td>
    <td width="49%"><%=invoiceSpecificDay1%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">發票產生日2：</div>
    </td>
    <td width="49%"><%=invoiceSpecificDay2%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">發票產生日3：</div>
    </td>
    <td width="49%"><%=invoiceSpecificDay3%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">發票產生日4：</div>
    </td>
    <td width="49%"><%=invoiceSpecificDay4%></td>
  </tr>

  <tr> 
    <td width="42%"> 
      <div align="left">發票預期未付天數：</div>
    </td>
    <td width="49%"><%=invoiceDuedays%></td>
  </tr>
  <tr> 
    <td width="42%"> 
      <div align="left">最後更新日：</div>
    </td>
    <td width="49%"><%=lastUpdateDate%></td>
  </tr>
  <%
     }
   catch(Exception e){
    }
  %>
</table>
<p>&nbsp;</p>

</body>
</html>
