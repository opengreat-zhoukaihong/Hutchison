<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="idm" scope="page" class="com.cbtb.model.InventoryDailyModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","CONTAINER_INVENTORY"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String language="CN";
%>
<html>

<head>
<LINK href="../css/line.css" rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=UFT-8">
<title>航運公司貨櫃數據維護</title>
<script src=../js/calendarShow.js></script>
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<script src=../js/JsLib.js></script>

<SCRIPT LANGUAGE="JavaScript">
function doPost(i)
{
  if(i==2)
   {
    search.action="InventoryConfirm.jsp";
    search.submit();
   }
   if(i==1)
    {
     if(search.shippingLineId.value=="Any")
      {
          alert("請選擇航運公司！");
          return;
       }
     if(search.captureDate.value=="")
      {
           alert("請選擇登記時間！");
          return;
       }
if(!isDate(search.captureDate.value) && search.captureDate.value!=0)
{
	alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
	search.captureDate.focus();
	return;
}
          search.action="InventorySearch.jsp";
          search.submit();
    }
}
 function check(thisElem,resQtyElem)
 {
 with(document.search)

  {
   thisElem.value=Trim(thisElem.value);
   if(thisElem.value!="" && !isInt(thisElem.value))
     {
       alert("請輸入正確的數據類型！");
       thisElem.select();
       return;
      }
  if(parseInt(thisElem.value)<parseInt(resQtyElem.value))
     {
       alert("貨櫃數量不能小於已定貨櫃數量！");
       thisElem.select();
       return;
     }
  if(thisElem.value=="" && resQtyElem.value!="0")
     {
       alert("定貨櫃數量已存在貨櫃數量不能刪除！");
       thisElem.select();
       return;
     }   
  }
 }
</Script>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="index.jsp"><font
color="#003366" size = "2">關閉</font></a></p>

<p align="left">航運公司貨櫃數據維護</p>
<form name="search" method="POST">
<table border="0" width="86%">
  <tr>
    <td>登記日期  </td>
    <td>航運公司</td>
    <td>貨櫃種類</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td >
      <input type="text" maxlength="10" size="10" value="<%=request.getParameter("captureDate")%>" name="captureDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="彈出日曆下拉菜單"
        onClick="fPopUpCalendarDlg(captureDate);return false" >
     </td>

    <td>
      <select name="shippingLineId" >

        <%=dbList.getShippingLineList(request.getParameter("shippingLineId"),language)%>
      </select>
    </td>
    <td>
      <select name="containerTypeId" >
        <%=dbList.getBaseContainerDescList(request.getParameter("containerTypeId"),language)%>
      </select>
    </td>
    <td><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif">
      <input
        type="button" name="button" onClick="JavaScript:doPost(1)" value="查詢">
      </font></a><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif">
      <input
        type="reset" name="reset" value="重設">
      </font></td>
  </tr>
</table>
<hr>
<% String init=request.getParameter("init");

if (!(init==null))
 {
%>
<p>&nbsp;</p>
<div align="left">
  <table border="1" width="100%">
    <tr>
      <td>登記日期</td>
      <td>航運公司 </td>
      <td>貨櫃類型</td>
      <td>貨櫃數量</td>
      <td>已定貨櫃數量</td>
      <td>最後更新日期</td>
    </tr>
<%
String captureDate = request.getParameter("captureDate").trim();
String shippingLineId = request.getParameter("shippingLineId");
String containerTypeId = request.getParameter("containerTypeId");
String depotId="DI001";
String s_hidresQtyName="";
String reservedQty="";
String availableQty="";
if(containerTypeId.equals("Any"))
  containerTypeId=null;

MasterManager mm=webOperator.getMasterManager();
ArrayList invertoryList = (ArrayList)mm.searchInventoryDaily(depotId, shippingLineId, containerTypeId,captureDate);



session.setAttribute("inventoryDailyList",invertoryList);
     for (int i = 0;  (!invertoryList.isEmpty()) && i < invertoryList.size(); i++) {
        idm = (InventoryDailyModel)invertoryList.get(i);
        s_hidresQtyName="hidRQValue";
        s_hidresQtyName=s_hidresQtyName+String.valueOf(i);
        reservedQty=String.valueOf(idm.getReservedQty());
        if(reservedQty.equals("0"))
          reservedQty="";
        availableQty=String.valueOf(idm.getAvailableQty());
        if(availableQty.equals("0"))
          availableQty="";
%>

    <tr>
      <td><%=(idm.getCaptureDate().toString()).substring(0,10)%>&nbsp;</td>
      <td><%=dbList.getShippingLineDesc(idm.getShippingLineId(),language)%>&nbsp;</td>
      <td><%=dbList.getContainerTypeDesc(idm.getContainerTypeId(),language)%>&nbsp;</td>
      <td><input type="text" size="4" name="containerNumber" onBlur="JavaScript:check(this,<%=s_hidresQtyName%>)"  value="<%=availableQty%>"></td>
      <td><%=reservedQty%>&nbsp;</td>
      <td><%=idm.getLastUpdateDateTime()%>&nbsp;</td>
      <input type="hidden" name="<%=s_hidresQtyName%>" value="<%=idm.getReservedQty()%>">
    </tr>
<%}%>
  </table>
</div>
<input type="button" name="button1" onClick="JavaScript:doPost(2)" value="提交">
<input type="reset" value="取消">
<%}%>
<input type="hidden" name="init" value="notfirst">
</form>
<p align="left">&nbsp; </p>
</body>
</html>