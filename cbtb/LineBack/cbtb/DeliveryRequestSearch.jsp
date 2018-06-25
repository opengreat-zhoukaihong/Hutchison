<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script Language="JavaScript" src="../js/JsLib.js"></script>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%> 
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%
  webOperator.clearPermissionContext();  
  webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
  webOperator.putPermissionContext("action", "search"); //加入检查的内容
  if (webOperator.checkPermission())
    out.print("");
  else
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  String sMarkLanguage = "CH";
  String closePage="DeliveryRequestSearch.jsp";
  session.setAttribute("closePage",closePage);
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">

<SCRIPT LANGUAGE="JavaScript">
  function deliveryDate_onchange() { 
       var inputstr =RemoveSpace(add.deliveryDate.value);
       if(inputstr.length > 0){
          if(!isDate(inputstr))
          {
             alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
             add.deliveryDate.focus();
             return false;
          }
       }
  }

  function RemoveSpace(inputstr){
     var Str;
     Str = "";
     for (i = 0;i < inputstr.length;i++){
         var onechar = inputstr.charAt(i);
           if(onechar != " "){
             Str = Str  + inputstr.charAt(i);
        }
    }
    return  Str;
  }
//the relation of the combo
 function aClass(aData, aValue, aText) {
    if (aClass.arguments.length < 3)
      alert("传入的参数错误！")
    else {
      this.Data  = aData;
      this.Value = aValue;
      this.Text  = aText;
    }
  }

  function chgDnCombobox(aSrc, aDes, aClass, aRemain){
    if (chgDnCombobox.arguments.length < 3)
alert("传入的参数错误！")
    else if (aSrc.type != "select-one")
      alert("传入的参数错误！")
    else if (aClass == null)
      alert("aClass未定义错误！")
    else {
      if (aRemain==null)
        aRemain = 1;
      chgDnComboboxItem(aSrc.options[aSrc.selectedIndex].value, aDes, aClass, aRemain);
    }
  }

  function chgDnComboboxItem(aValue, aDes, aClass, aRemain){
    if (chgDnComboboxItem.arguments.length<3)
      alert("参数传入错误！")
    else if (aClass==null)
      alert("错误！aClass没有定义！")
    else{
      if (aRemain==null)
        aRemain = 1;
      deleteAllComboboxItem(aDes, aRemain);
      if(aValue=="Any")
        {
      for (var i=0; i<aClass.length; i++)
          if (aClass[i].Data!="Any")
          {
            if (aClass[i].Data!="End")
            addComboboxItem(aDes, aClass[i].Text, aClass[i].Value);
          }
        }
      else
       {
      for (var i=0; i<aClass.length; i++)
        if (aClass[i].Data==aValue)  /* check aClass[i].Data */
          if (aClass[i].Data!="")
            addComboboxItem(aDes, aClass[i].Text, aClass[i].Value);
       }
    }
  }

  function deleteAllComboboxItem(aList, aRemain) {
    for (var i=aList.options.length; i > aRemain-1; i--)
      aList.options[i] = null;
  }    

  function addComboboxItem(aList, aText, aValue) {
    var aOption = new Option(aText, aValue);
    eval("aList.options[aList.options.length]=aOption");
  }
  function correspondAction(aSrc, aDes, aClass)
  {
    if (correspondAction.arguments.length<3)
      alert("参数传入错误！")
    else if (aClass==null)
      alert("错误！aClass没有定义！")
    else
    {
       for (var i=0; i<aClass.length; i++)
        {
          if (aDes.options[aDes.selectedIndex].value == "Any")
          {
            aSrc.options[0].selected = true;
          }
          else if (aClass[i].Value==aDes.options[aDes.selectedIndex].value)
          {
            for (var j=0;j<aSrc.length;j++)
            {
              if (aSrc.options[j].value ==aClass[i].Data)
              {
                aSrc.options[j].selected=true;
                break;              
              }
            }
          }
        }
    }
  }


//the form event

 function deliveryTime_onChange(){
     chgDnCombobox(add.deliveryTime,add.timeSlotId,timeSlotClass,1);
}

function timeSlotId_onChange(){
     correspondAction(add.deliveryTime,add.timeSlotId,timeSlotClass);
}

 function originZoneId_onChange(){
     chgDnCombobox(add.originZoneId,add.originCityId,cityClass,1);
}

function originCityId_onChange(){
     correspondAction(add.originZoneId,add.originCityId,cityClass);
}

 function destinationZoneId_onChange(){
     chgDnCombobox(add.destinationZoneId,add.destinationCityId,cityClass,1);
}

function destinationCityId_onChange(){
     correspondAction(add.destinationZoneId,add.destinationCityId,cityClass);
}

</SCRIPT>
<%
   out.println(dbList.getCityClass(sMarkLanguage));
   out.println(dbList.getTimeSlotClass(sMarkLanguage));
%>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp" %>
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
    <td height="11">查詢紀錄</td>
    <td height="11"> 
      <div align="right"><font color="#003366"><a href="index.jsp">關閉</a></font></div>
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

<form action="DeliveryRequestList.jsp" name="add" method="post">
<table border="0" width="90%">
    <tr>
        <td>公司編號： </td>
        <td><input type="text" maxlength="10" size="20" name="companyId"> </td>
        <td>
<p>送貨要求編號：</p>
        </td>
        <td><input type="text" maxlength="10" size="20" name="deliveryRequestNum"> </td>
    </tr>
    <tr>
        <td>送貨日期：</td>
    <td > 
      <input type="text" maxlength="10" size="10" value="" name="deliveryDate"  javascript onchange="return deliveryDate_onchange()" >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" > 
     </td>
        <td>配對編號：</td>
        <td><input type="text" maxlength="10" size="20" name="matchNumber"></td>
    </tr>
    <tr>
        <td>送貨時間：</td>
        <td><select name="deliveryTime" size="1" Language="javascript" onChange="deliveryTime_onChange()">
              <%= dbList.getDeliveryTimeList("",sMarkLanguage) %>
        </select></td>
        <td>送貨時段：</td>
        <td><select name="timeSlotId" size="1" Language="javascript" onChange="timeSlotId_onChange()">
            <%= dbList.getDeliveryTimeSlotList("",sMarkLanguage) %>
        </select></td>
    </tr>
    <tr>
        <td>出發地區域：</td>
        <td><select name="originZoneId" size="1" Language="javascript" onChange="originZoneId_onChange()">
            <%= dbList.getZoneList("",sMarkLanguage) %>
        </select></td>
        <td>目的地區域：</td>
        <td><select name="destinationZoneId" size="1" Language="javascript" onChange="destinationZoneId_onChange()">
            <%= dbList.getZoneList("",sMarkLanguage) %>
        </select></td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td><select name="originCityId" size="1" Language="javascript" onChange="originCityId_onChange()">
            <%= dbList.getCityList("",sMarkLanguage) %>
        </select> </td>
        <td>目的地城市：</td>
        <td><select name="destinationCityId" size="1" Language="javascript" onChange="destinationCityId_onChange()">
             <%= dbList.getCityList("",sMarkLanguage) %>
        </select> </td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td><select name="requestStatus" size="1">
            <%= dbList.getDeliveryStatusList("",sMarkLanguage) %>
        </select> </td>
        <td>落貨紙號碼/提貨單號碼：</td>
        <td><input type="text" maxlength="20" size="20" name="shippingOrderNo"></td>
    </tr>
    <tr>
        
      <td>貨櫃種類： </td>
        <td><select name="containerTypeId" size="1">
              <%= dbList.getContainerTypeList("",sMarkLanguage) %>
        </select></td>
        <td>排序：</td>
     <%
        if( sMarkLanguage == "" )
        {
     %>
        <td><select name="orderByName" size="1">
              <option value="COMPANY_ID">Shipper ID</option>
              <option value="CARGO_ID">Cargo Category</option>
              <option value="ORIGIN_CITY_ID">Origin City</option>
              <option value="DESTINATION_CITY_ID">Destination City</option>
              <option value="REQUEST_CONTAINER_ID">Container Type</option>
              <option value="DELIVERY_DATE">Delivery Date</option>
              <option value="DELIVERY_TIME_ID">Delivery Time</option>
              <option value="Any" selected>No Preference</option>
            </select>
         </td>
     <%
         }
         else
             {
     %>
              <td><select name="orderByName" size="1">
                    <option value="COMPANY_ID">公司編號</option>
                    <option value="CARGO_ID">貨物種類</option>
                    <option value="ORIGIN_CITY_ID">出發地城市</option>
                    <option value="DESTINATION_CITY_ID">目的地城市</option>
                    <option value="REQUEST_CONTAINER_ID">貨櫃種類</option>
                    <option value="DELIVERY_DATE">發貨日期</option>
                    <option value="DELIVERY_TIME_ID">發貨時閒</option>
                    <option value="Any" selected>按默認順序</option>
                  </select>
             </td>
       <%
          }
       %>
    </tr>
    <tr>
        <td><input type="submit" name="Submit" value="提交" >
        <input type="reset" name="Submit2" value="重設">
      </td>
      <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>

</html>








