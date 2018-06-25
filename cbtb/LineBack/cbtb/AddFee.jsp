<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="java.math.BigDecimal" %>
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="mfdm" scope="page" class="com.cbtb.model.MatchFeeDetailModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="cbtbConstant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","MATCH_ADDITIONAL_FEE"); //加入检查的内容
  webOperator.putPermissionContext("action", "create"); //加入检查的内容
  if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
    ArrayList editList=new ArrayList();
    String language="CN";
    mcrm=(MatchModel)session.getAttribute("matchModel");
    ArrayList matchFeeList =(ArrayList)session.getAttribute("matchFeeList");
    session.setAttribute("matchModel",mcrm);
    session.setAttribute("matchFeeList",matchFeeList);
     java.math.BigDecimal fee;
     String matchRequestFee="";
     String deliveryFee="";
       fee=mcrm.getTruckCapacityModel().getMatchRequestFee();
     if(fee!=null)
       matchRequestFee=fee.toString();
       fee=mcrm.getDeliveryRequestModel().getDeliveryFee();
     if(fee!=null)
      deliveryFee=fee.toString();
%>

<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script src=../js/DateValid.js></script>
<script src=../js/funStrTrim.js></script>
<SCRIPT LANGUAGE="JavaScript">
function doPost(i)
{
     
     var isHave=false;
     for(j=0;j<matchFeeAdd.disc.length;j++)
      {
       if(matchFeeAdd.disc[j].value==matchFeeAdd.addFee.value)
        {
          isHave=true;
          break;
         }
      }
     if(isHave)
     {
      alert("此項附加費已經存在，請選擇其它款項或先刪除再增加！");
      matchFeeAdd.addFee.focus();
      return;      
     }
     if(matchFeeAdd.status.value!=matchFeeAdd.delivery.value)
      {
         if(matchFeeAdd.status.value!=matchFeeAdd.pickUp.value)
         {
         alert("對不起！在此狀況下不能增加附加費用");
         return;
         }
       }
      if (matchFeeAdd.addFee.value =="Any")
       {
         alert("附加費描述不能為空!");
         matchFeeAdd.addFee.focus();
         return;
       }

      if (matchFeeAdd.additionalCharge.value=="")
       {
         
         alert("運輸公司附加費不能為空！");
         matchFeeAdd.additionalCharge.focus();
         return;
       }
      if (matchFeeAdd.additionalFee.value=="")
       {
         alert("付貨人附加費不能為空！");
         matchFeeAdd.additionalFee.focus();
         return;
       }
      if (!isFloat(matchFeeAdd.additionalFee.value))
       {
         alert("請輸入正確的數據類型！");
         matchFeeAdd.additionalFee.focus();
         return;
       }
      if (!isFloat(matchFeeAdd.additionalCharge.value))
       {
         alert("請輸入正確的數據類型！");
         matchFeeAdd.additionalCharge.focus();
         return;
       }
      if (parseFloat(matchFeeAdd.additionalCharge.value)>parseFloat(matchFeeAdd.additionalFee.value))
       {
         alert("付貨人附加費不能大於運輸公司附加費！");
         return;
       }
      if (parseInt(matchFeeAdd.additionalFee.value,10)>999999)
       {
         alert("輸入的金額太大！");
         matchFeeAdd.additionalFee.focus();
         return;
       }
      if (parseInt(matchFeeAdd.additionalCharge.value,10)>999999)
       {
         alert("輸入的金額太大！");
         matchFeeAdd.additionalCharge.focus();
         return;
       }
  if(i==1)
   {

    matchFeeAdd.toPage.value="MatchFeeEdit.jsp";
    matchFeeAdd.action="MatchUpdate.jsp"
    matchFeeAdd.submit();
    }
  if(i==2)
   {

    matchFeeAdd.toPage.value="AddFee.jsp";
    matchFeeAdd.action="MatchUpdate.jsp"
    matchFeeAdd.submit();
   }
}
</SCRIPT>
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
    <td>增加附加費</td>
    <td>
      <div align="right"><a href="MatchFeeEdit.jsp"><font color="#003366" face="Arial, Helvetica, sans-serif">關閉</font></a></div>
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
<form method="POST"  name="matchFeeAdd" >
<table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
   <input type="hidden" name="url" value="matchFee">
   <input type="hidden" name="act" value="Insert">
   <input type="hidden" name="toPage" value="">

   <tr>
        <td>配對編號：</td>
        <td><%=mcrm.getMatchNum()%></td>
        <td>提交日期：</td>
        <td><%=(mcrm.getTruckCapacityModel().getSubMissionDatetime().toString()).substring(0,10)%></td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td><%=dbList.getCityDesc(mcrm.getDeliveryRequestModel().getOriginCityId(),language)%></td>
        <td>目的地城市：</td>
        <td><%=dbList.getCityDesc(mcrm.getDeliveryRequestModel().getDestinationCityId(),language)%></td>
    </tr>
    <tr>
        <td>送貨日期：</td>
        <td><%=(mcrm.getTruckCapacityModel().getDeliveryDate().toString()).substring(0,10)%></td>
        <td>送貨時間：</td>
        <td><%=dbList.getDeliveryTimeDesc(mcrm.getTruckCapacityModel().getDeliveryTimeId(),language)%></td>
    </tr>
    <tr>
        <td>送貨要求編號：</td>
        <td><%=mcrm.getDeliveryRequestNum()%></td>
        <td>登記空車編號：</td>
        <td><%=mcrm.getTruckCapacityNum()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人：</td>
        <td><%=mcrm.getShipperContactPerson()%></td>
        <td>收貨聯絡人：</td>
        <td><%=mcrm.getTruckContactPerson()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人電話號碼：</td>
        <td><%=mcrm.getShipperContactTelphone()%></td>
        <td>收貨聯絡人電話號碼：</td>
        <td><%=mcrm.getShipperContactTelphone()%></td>
    </tr>
    <tr>
        <td>發貨聯絡人傳真號碼：</td>
        <td><%=mcrm.getShipperContactFaxNo()%></td>
        <td>收貨聯絡人傳真號碼：</td>
        <td><%=mcrm.getShipperContactFaxNo()%></td>
    </tr>
    <tr>
        <td>航運公司：</td>
        <td><%=dbList.getShippingLineDesc(mcrm.getDeliveryRequestModel().getShippingLineId(),language)%></td>
        <td>貨櫃車司機姓名：</td>
        <td><%=dbList.getTruckerName(mcrm.getTruckCapacityModel().getTruckerId(),language)%></td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td><%=dbList.getMatchStatusDesc(mcrm.getMatchStatus(),language)%></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>

    <tr>

    <td>運輸公司運費：</td>
        <td><%=matchRequestFee%></td>

    <td>付貨人運價：</td>
        <td><%=deliveryFee%></td>
    </tr>
</table>
<input type="hidden" name="status" value="<%=mcrm.getMatchStatus()%>">
<input type="hidden" name="pickUp" value="<%=cbtbConstant.MATCH_STATUS_CONTAINER_PICKUP%>">
<input type="hidden" name="delivery" value="<%=cbtbConstant.MATCH_STATUS_CONTAINER_DELIVERED%>">
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
    <td width="28%">附加費描述：
      <select name="addFee" size="1">
       <%=dbList.getAddFeeList("",language)%>
      </select>
    </td>
    <td width="39%">運輸公司附加費：
<input type="text" size="11"
name="additionalCharge" maxlength="8">
    </td>
    <td width="33%">付貨人附加費：
<input type="text" size="11"
name="additionalFee" maxlength="8">
    </td>
  </tr>
</table>

  <input type="button" name="saveAndExit" onClick="JavaScript:doPost(1)" value="保存&退出">
  &nbsp;&nbsp;
  <input type="button" name="saveAndAdd"  onClick="JavaScript:doPost(2)" value="保存&增加">
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
<table border="1" width="75%">
  <tr>
    <td>費用描述</td>
    <td width="23%">運輸公司附加費</td>
    <td width="18%">付貨人附加費</td>
  </tr>
<%


     for (int i = 0;  (!matchFeeList.isEmpty()) && i < matchFeeList.size(); i++) {
        mfdm = (MatchFeeDetailModel)matchFeeList.get(i);

%>
  <tr>
    <td width="59%"><%=dbList.getAddFeeDesc(mfdm.getAddFeeId(),language)%></td>
    <td width="23%"><%=mfdm.getAddFeeTruckAmount()%></td>
    <td width="18%"><%=mfdm.getAddFeeShipperAmount()%></td>
    <input type="hidden" name="disc" value="<%=mfdm.getAddFeeId()%>">
  </tr>
<%}}
%>
</table>
<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>

<p align="left">&nbsp;</p>
</form>
</body>

</html>
