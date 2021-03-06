﻿<%--
/**
 * AmendDate:2001/06/22
 * Author:T_Liang
 * Reason01:should not display Zone column
 * AmendId:01
 * Reason02:delivery fee must not display zero(for all pages)
 * AmendId:02
 * Reason03:the errorpage must import and no catch the error on the page
 * AmendId:03
 */
--%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%
/**
*AmendId:03
*/
%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.MasterManager" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","TRUCK_CAPACITY"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
  if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
  %>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script src=../js/changlist.js></script>
<style type="text/css">
</style>
<%
String language="CN";
String lan ="CH";
out.println(dbList.getCityClass(lan));%>
<SCRIPT LANGUAGE=javascript>
<!--
function change_area(searchFrm) {
searchFrm.cityId.options.length=1;
chgDnCombobox(searchFrm.zoneId, searchFrm.cityId,cityClass,1);
}
</Script>
<script language="javascript">
function doPost()
{
  searchFrm.action = "TruckPriceSearch.jsp";
  searchFrm.submit();
}
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/headtrucker.jsp"%>

<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852"><font face="Arial, Helvetica, sans-serif">運費查詢</font></font></b></font></b></font></td>
    <td>
      <div align="right"><a href="indexTrucking.jsp"><font
color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>

</table>


<form action="TruckPriceSearch.jsp" name="searchFrm">
<input type="hidden" name="init" value="notfirst">
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="15%" height="20">貨櫃種類編號：</td>
      <td width="16%" height="20">
        <select name="containerId" size="1">
        <%=dbList.getContainerTypeList(request.getParameter("containerId"),language)%>
        </select>
      </td>
      <td width="12%" height="20">區域編號：</td>
      <td width="17%" height="20">
        <select name="zoneId" size="1" onChange="change_area(document.searchFrm)">
        <%=dbList.getZoneList(request.getParameter("cityId"),language)%>
        </select>
      </td>
      <td width="8%" height="20">城市編號：</td>
      <td width="16%" height="20">
        <select name="cityId" size="1">
        <%=dbList.getCityList(request.getParameter("zoneId"),language)%>
        </select>
      </td>
      <td width="16%" height="20">
					<a href="javascript:doPost()"><img src="../images/search.jpg" width="44" height="19" border="0"></a>
					<img src="../images/good.jpg" width="10" height="10">
					<a href="javascript:searchFrm.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
      </td>
    </tr>
  </table>
  <font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif"> </font>

<hr>

<table border="0" cellspacing="0" cellpadding="0" align="center" width="98%">
  <tr>
    <td  width="20%" bgcolor="e0e0e0" height="28" align="center">貨櫃種類</td>
    <td  width="15%" bgcolor="e0e0e0" align="center">城市</td>
<%
/**
*AmendId:01
*/
%>
    <td  width="25%" bgcolor="e0e0e0" align="center">運費（入境）</td>
    <td  width="25%" bgcolor="e0e0e0" align="center">運費（出境）</td>
  </tr>
<% String init=request.getParameter("init");
if (!(init==null))
 {
%>
  <%
    String s_containerId = null;
    String s_cityId = null;
    String s_zoneId = null;
     ArrayList deliveryFees =new ArrayList();
      String type = request.getParameter("type");
       if (type == null  )
       {
         if (request.getParameter("containerId").trim().equals("Any"))
         {
           s_containerId = null;
         }
         else
        {
          s_containerId = request.getParameter("containerId");
        }
        if (request.getParameter("cityId").trim().equals("Any"))
        {
          s_cityId = null;
        }
        else
        {
          s_cityId = request.getParameter("cityId").trim();
        }
        if (request.getParameter("zoneId").trim().equals("Any"))
        {
            s_zoneId = null;
        }
       else
       {
         s_zoneId = request.getParameter("zoneId").trim();
       }

               ArrayList deliveryFeeList = new ArrayList();
               MasterManager masterManager = webOperator.getMasterManager();
               deliveryFeeList = (ArrayList)masterManager.searchDeliveryPriceFee(s_containerId,s_cityId,s_zoneId);
               newPagination.setPageNo(0);
               newPagination.setRecords(deliveryFeeList);
               deliveryFees =(ArrayList)newPagination.nextPage();
              }
           else
              {
               if (type.equals("N"))
                   {
                      deliveryFees = (ArrayList)newPagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    deliveryFees = new ArrayList(newPagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    deliveryFees =new ArrayList(newPagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    deliveryFees =new ArrayList(newPagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     deliveryFees =new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
      DeliveryPriceFeeModel dpfm = new DeliveryPriceFeeModel();
      boolean color = true;
      for(int i=0;(!deliveryFees.isEmpty())&&(i<deliveryFees.size());i++)
      {
        dpfm = (DeliveryPriceFeeModel)deliveryFees.get(i);
     if(color)
	{
	out.write("<tr>");
	color = false;
	}
	else
	{
	out.write("<tr bgcolor=\"#ddffdd\">");
	color = true;
	}
   %>
   <td align="center"><%=dbList.getContainerTypeDesc(dpfm.containerTypeId,language)%></td>
   <td align="center"><%=dbList.getCityDesc(dpfm.cityId,language)%></td>
<%
/**
*AmendId:01
*/
%>
   <td align="center"><%=(dpfm.ibFeeToTruck==null || dpfm.ibFeeToTruck.toString().equals("0"))?"":dpfm.ibFeeToTruck.toString()%></td>
   <td align="center"><%=(dpfm.obFeeToTruck==null || dpfm.obFeeToTruck.toString().equals("0"))?"":dpfm.obFeeToTruck.toString()%></td>
<%
/**
*AmendId:02
*/
%>
   </tr>
 <%}
 %>
<%
/**
*AmendId:03
*/
%>
</table>
</form>
<table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1">
          <%
          if (newPagination.getPageNo() > 1)
          {
            %>
          &nbsp;&nbsp<a href="TruckPriceSearch.jsp?type=F&init=p" class="unnamed1"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp<a href="TruckPriceSearch.jsp?type=P&init=p"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
            %>
          &nbsp;&nbsp;<a href="TruckPriceSearch.jsp?type=N&init=p"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <a href="TruckPriceSearch.jsp?type=E&init=p"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>
          <%
          }
          %>
          </td>


        <td width="15%" class="unnamed1">
          <div align="right">第<%=newPagination.getPageNo()%>頁 &nbsp;&nbsp;總數：<%=newPagination.getPageSum()%>頁</div>
        </td>
      </tr>
<%}}%>
    </table>

<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>
<table width="342" border="0" align="center">
  <tr>
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>

<p>&nbsp;</p>
</body>
</html>






