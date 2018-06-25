<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="parameterBean" scope="page" class="com.cbtb.javabean.SystemParameterJB" />
<html>
<head>
<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","SYSTEM_PARAMETER"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>系統處理參數列表
</title>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>

<SCRIPT LANGUAGE="JavaScript">

function doPost()
{
   if (edit.processLeadTime.value =="")
   {
     alert("預配對天數不能为空!");
     return;
   }
   if(!isInt(edit.processLeadTime.value))
   {
       alert("請輸入正確的預配對天數!");
       return;
   }
   if(!isInt(edit.maxUserForTruck.value))
   {
       alert("請輸入正確的貨運公司用戶數!");
       return;
   }
   if(!isInt(edit.maxUserForShippe.value))
   {
       alert("請輸入正確的付貨公司用戶數!");
       return;
   }
   if ((edit.invoiceSpecificDay3.value >"1") && (edit.invoiceSpecificDay2.value <"1"))
   {
       alert("請先輸入發票產生日2!");
       return;
   }

   if ((edit.invoiceSpecificDay4.value >"1") && (edit.invoiceSpecificDay3.value <"1"))
   {
       alert("請先輸入發票產生日3!");
       return;
   }

   if(!isInt(edit.invoiceSpecificDay1.value) || (parseInt(edit.invoiceSpecificDay1.value)>31))
   {
       alert("請輸入正確的發票產生日1!");
       return;
   }

   if (edit.invoiceSpecificDay2.value >"")
   {
     if(!isInt(edit.invoiceSpecificDay2.value) || (parseInt(edit.invoiceSpecificDay2.value)>31) || (parseInt(edit.invoiceSpecificDay2.value)<0))
      {
       alert("請輸入正確的發票產生日2!");
       return;
      }
   }

   if (edit.invoiceSpecificDay3.value >"")
   {
    if(!isInt(edit.invoiceSpecificDay3.value) || (parseInt(edit.invoiceSpecificDay3.value)>31) || (parseInt(edit.invoiceSpecificDay3.value)<0))
     {
       alert("請輸入正確的發票產生日3!");
       return;
     }
   }

   if (edit.invoiceSpecificDay4.value >"")
   {
    if(!isInt(edit.invoiceSpecificDay4.value) || (parseInt(edit.invoiceSpecificDay4.value)>31)|| (parseInt(edit.invoiceSpecificDay4.value)<0))
     {
       alert("請輸入正確的發票產生日4!");
       return;
     }
   }

    if((parseInt(edit.invoiceSpecificDay2.value) >0) && (parseInt(edit.invoiceSpecificDay1.value))>=(parseInt(edit.invoiceSpecificDay2.value)))
     {
       alert("發票產生日2必須大於發票產生日1!");
       return;
     }

    if((parseInt(edit.invoiceSpecificDay3.value) >0) && (parseInt(edit.invoiceSpecificDay2.value))>=(parseInt(edit.invoiceSpecificDay3.value)))
     {
       alert("發票產生日3必須大於發票產生日2!");
       return;
     }

    if((parseInt(edit.invoiceSpecificDay4.value) >0) && (parseInt(edit.invoiceSpecificDay3.value))>=(parseInt(edit.invoiceSpecificDay4.value)))
     {
       alert("發票產生日4必須大於發票產生日3!");
       return;
     }


   if(!isInt(edit.invoiceDuedays.value))
   {
       alert("請輸入正確的發票預期未付天數!");
       return;
   }
    edit.action="SystemParameterConfirm.jsp";
    edit.submit();
}
</script>
</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right">
	<a href="javascript:history.back();">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">取消</font>
	</a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">系統處理參數列表維護</font></p>

<hr>
<form method="post" name="edit" >
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
    <td width="32%"> 
      <div align="left">預配對天數：</div>
    </td>
    <td width="38%">
      <input type="text" name="processLeadTime" value="<%=processLeadTime%>" size="2" maxlength="2" >
    </td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">貨運公司用戶數：</div>
    </td>
    <td width="38%">
      <input type="text" name="maxUserForTruck" value="<%=maxUserForTruck%>" size="2" maxlength="2" >
    </td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">付貨公司用戶數：</div>
    </td>
    <td width="38%">
      <input type="text" name="maxUserForShippe" value="<%=maxUserForShippe%>" size="2" maxlength="2" >
    </td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日1：</div>
    </td>
    <td width="38%">
      <input type="text" name="invoiceSpecificDay1" value="<%=invoiceSpecificDay1%>" size="2" maxlength="2" >
    </td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日2：</div>
    </td>
    <td width="38%">
      <input type="text" name="invoiceSpecificDay2" value="<%=invoiceSpecificDay2%>" size="2" maxlength="2" >
    </td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日3：</div>
    </td>
    <td width="38%">
      <input type="text" name="invoiceSpecificDay3" value="<%=invoiceSpecificDay3%>" size="2" maxlength="2" >
    </td>
  </tr>
  <tr> 
    <td width="32%"> 
      <div align="left">發票產生日4：</div>
    </td>
    <td width="38%">
      <input type="text" name="invoiceSpecificDay4" value="<%=invoiceSpecificDay4%>" size="2" maxlength="2" >
    </td>
  </tr>

  <tr> 
    <td width="32%"> 
      <div align="left">發票預期未付天數：</div>
    </td>
    <td width="38%">
      <input type="text" name="invoiceDuedays" value="<%=invoiceDuedays%>" size="2" maxlength="2" >
    </td>
  </tr>
   <input type="hidden" name="recordId" value="<%=recordId%>">
  <%
     }
   catch(Exception e){
    }
  %>
</table>
   <p><input type="button" name="button" onClick="JavaScript:doPost()"  value="提 交">
    &nbsp;&nbsp;<input type="reset" name="B1" value="清除"> 
   </p>
</form>
</body>
</html>
