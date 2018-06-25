<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
  webOperator.putPermissionContext("action", "cancel"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
else
{
 String languageName ="CN";
 String type=request.getParameter("type");
 String matchNumber=request.getParameter("matchNum");
 String threeShow="N";
 int show=0;
 String whereFrom="";
 String bothShow="";
 MatchManager matchManager = webOperator.getMatchManager();
 MatchModel mm = null;
 MatchModel mmNew=null;

 if(matchNumber!=null)
 {
     mm=matchManager.findMatchCapacityRequest(matchNumber);
     session.setAttribute("oldMatch",mm);
     show=1;
    if (!matchManager.unmatch(matchNumber))
      {
        response.sendRedirect("ErrorPage.jsp?errorMessage=ER_0001");      
       }
  }
 else if(type.equals("match"))
    {
      whereFrom=request.getParameter("whereFrom");
      bothShow=request.getParameter("bothShow");
      String deliveryRequestNum=request.getParameter("deliveryRequestNum").trim();
      String truckCapacityNum=request.getParameter("truckCapacityNum").trim();
      mmNew=matchManager.match(deliveryRequestNum,truckCapacityNum);
       mm=(MatchModel)session.getAttribute("oldMatch");
      if(whereFrom.equals("D"))
       {
        threeShow="D";
        if(bothShow.equals("T"))
          {    
          show=4;
          }
         else
          {
           show=2;
          }
        }
      if(whereFrom.equals("T"))
       {
         threeShow="T";
         if(bothShow.equals("D"))
           {
           show=5;
           }
         else
           {
           show=3;
           }
       }
      session.setAttribute("oldMatch",mmNew);
    }
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
    <td>取消配對和重配對&nbsp;</td>
    <td>
      <div align="right"><a
href="UnMatchList.jsp"><font color="#003366">關閉</font></a></div>
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
    <td><div align="left"><font face="Arial, Helvetica, sans-serif"><font color="#FF0033">原來的配對已取消請重新配對</font></font></div></td>
  </tr>
</table>

<p>空車</p>

<table border="0">
    <tr>
        <td>登記空車編號</td>
        <td>公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>拖架種類</td>
        <td>&nbsp;</td>
    </tr>
    <%
    if(show==1 || show==3 || show==5)
     {
    %>
    <tr>
        <td><%=mm.getTruckCapacityNum()%></td>
        <td><%=dbList.getCompanyName(mm.getTruckCapacityModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getTruckCapacityModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getTruckCapacityModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=mm.getTruckCapacityModel().getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mm.getTruckCapacityModel().getDeliveryTimeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getTrailerTypeDesc(mm.getTruckCapacityModel().getTrailerId(),languageName)%>&nbsp;</td>
        <td>
          <%if(show!=5){%>         
	<input type="button" name="B2" value="重配對" onclick="javascript:location.href='ReMatchDelivery.jsp?t_change=1&truckCapacityNum=<%=mm.getTruckCapacityNum()%>&threeShow=<%=threeShow%>&oldDeliveryNo=<%=mm.getDeliveryRequestNum()%>&matchNum=<%=matchNumber%>'">
        <%}%>
         &nbsp;
        </td>
    </tr>
    <%
    }
    else
     {
    %>
    <tr>
        <td><%=mmNew.getTruckCapacityNum()%></td>
        <td><%=dbList.getCompanyName(mmNew.getTruckCapacityModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getTruckCapacityModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getTruckCapacityModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=mmNew.getTruckCapacityModel().getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mmNew.getTruckCapacityModel().getDeliveryTimeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getTrailerTypeDesc(mmNew.getTruckCapacityModel().getTrailerId(),languageName)%>&nbsp;</td>
        
        <td>

         &nbsp;
        </td>
    </tr>
    <%}%>
</table>
<%
if(show==2 || show==4)
{
%>
<p>重配對：<%=mmNew.getMatchNum()%></p>

<table border="0">
    <tr>
        <td>送貨要求編號</td>
        <td>公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td width="104">貨櫃種類</td>
        <td width="91">航運公司</td>
        <td width="59">&nbsp;</td>
    </tr>
    <tr>
        <td><%=mmNew.getDeliveryRequestNum()%>&nbsp;</td>
        <td><%=dbList.getCompanyName(mmNew.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getDeliveryRequestModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getDeliveryRequestModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=(mmNew.getDeliveryRequestModel().getDeliveryDate().toString()).substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mmNew.getDeliveryRequestModel().getTimeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getContainerTypeDesc(mmNew.getDeliveryRequestModel().getContainerTypeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getShippingLineDesc(mmNew.getDeliveryRequestModel().getShippingLineId(),languageName)%>&nbsp;</td>
        <td>&nbsp; </td>
    </tr>
</table>
<%
  }
else if(show==5 )
   {
%>
<p>重配對：<%=mm.getMatchNum()%></p>

<table border="0">
    <tr>
        <td>送貨要求編號</td>
        <td>公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td width="104">貨櫃種類</td>
        <td width="91">航運公司</td>
        <td width="59">&nbsp;</td>
    </tr>
    <tr>
        <td><%=mm.getDeliveryRequestNum()%>&nbsp;</td>
        <td><%=dbList.getCompanyName(mm.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getDeliveryRequestModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getDeliveryRequestModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=(mm.getDeliveryRequestModel().getDeliveryDate().toString()).substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mm.getDeliveryRequestModel().getTimeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getContainerTypeDesc(mm.getDeliveryRequestModel().getContainerTypeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getShippingLineDesc(mm.getDeliveryRequestModel().getShippingLineId(),languageName)%>&nbsp;</td>
        <td>&nbsp; </td>
    </tr>
</table>
<%}%>
<hr>

<p>送貨要求</p>

<table border="0">
    <tr>
        <td width="84">送貨要求編號</td>
        <td width="104">公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td width="104">貨櫃種類</td>
        <td width="91">航運公司</td>
        <td width="59">&nbsp;</td>
    </tr>
    <%
    if(show==1 || show==2 || show==4)
     {
    %>
    <tr>
        <td><%=mm.getDeliveryRequestNum()%></td>
        <td><%=dbList.getCompanyName(mm.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getDeliveryRequestModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getDeliveryRequestModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=mm.getDeliveryRequestModel().getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mm.getDeliveryRequestModel().getTimeId(),languageName)%>&nbsp;</td>
        <td width="104"><%=dbList.getContainerTypeDesc(mm.getDeliveryRequestModel().getContainerTypeId(),languageName) %>&nbsp;</td>
        <td width="91"><%=dbList.getShippingLineDesc(mm.getDeliveryRequestModel().getShippingLineId(),languageName)%>&nbsp;</td>
        <td width="59">
            <%if(show!=4){%>
            <p><input type="button" name="B1" value="重配對" onclick="javascript:location.href='ReMatchTruck.jsp?d_change=1&threeShow=<%=threeShow%>&oldTruckNo=<%=mm.getTruckCapacityNum()%>&deliveryRequestNum=<%=mm.getDeliveryRequestNum()%>&matchNum=<%=matchNumber%>'">
        </p>
         <%}%>
         &nbsp;
        </td>
    </tr>
    <%
    }
    else
     {
    %>
    <tr>
        <td><%=mmNew.getDeliveryRequestNum()%></td>
        <td><%=dbList.getCompanyName(mmNew.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getDeliveryRequestModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getDeliveryRequestModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=mmNew.getDeliveryRequestModel().getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mmNew.getDeliveryRequestModel().getTimeId(),languageName)%>&nbsp;</td>
        <td width="104"><%=dbList.getContainerTypeDesc(mmNew.getDeliveryRequestModel().getContainerTypeId(),languageName) %>&nbsp;</td>
        <td width="91"><%=dbList.getShippingLineDesc(mmNew.getDeliveryRequestModel().getShippingLineId(),languageName)%>&nbsp;</td>
        <td width="59">
         &nbsp;
        </td>
    </tr>
    <%}%>
</table>
<%
if(show==4 )
{
%>
<p>重配對：<%=mm.getMatchNum()%></p>

<table border="0">
    <tr>
        <td>登記空車編號</td>
        <td>公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>拖架種類</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><%=mm.getTruckCapacityNum()%>&nbsp;</td>
        <td><%=dbList.getCompanyName(mm.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getTruckCapacityModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mm.getTruckCapacityModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=(mm.getTruckCapacityModel().getDeliveryDate().toString()).substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mm.getTruckCapacityModel().getDeliveryTimeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getTrailerTypeDesc(mm.getTruckCapacityModel().getTrailerId(),languageName)%>&nbsp;</td>
        <td>&nbsp; </td>
    </tr>
</table>
<%}
else if(show==3 ||show==5)
{
%>
<p>重配對：<%=mmNew.getMatchNum()%></p>

<table border="0">
    <tr>
        <td>登記空車編號</td>
        <td>公司名稱</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>拖架種類</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><%=mmNew.getTruckCapacityNum()%>&nbsp;</td>
        <td><%=dbList.getCompanyName(mmNew.getDeliveryRequestModel().getCompanyId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getTruckCapacityModel().getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(mmNew.getTruckCapacityModel().getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=(mmNew.getTruckCapacityModel().getDeliveryDate().toString()).substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(mmNew.getTruckCapacityModel().getDeliveryTimeId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getTrailerTypeDesc(mmNew.getTruckCapacityModel().getTrailerId(),languageName)%>&nbsp;</td>
        <td>&nbsp; </td>
    </tr>
</table>
<%
}}
%>

</body>

</html>