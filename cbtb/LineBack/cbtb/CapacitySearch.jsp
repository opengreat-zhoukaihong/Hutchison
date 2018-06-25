<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<script src=../js/JsLib.js></script>
<script src=../js/calendarShow.js></script>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "search");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String closePage="CapacitySearch.jsp";
session.setAttribute("closePage",closePage);
session.setAttribute("language","CH");
String language = (String)session.getAttribute("language");
%>
<SCRIPT LANGUAGE=javascript>
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
function changeTimeSlotArea(father,son)
{
	son.options.length=1;
	chgDnCombobox(father, son,timeSlotClass,1);
}
function changeTimeIdArea(father,son)
{
	correspondAction(father, son,timeSlotClass);
}
function changeCityArea(father,son)
{
	son.options.length=1;
	chgDnCombobox(father, son,cityClass,1);
}
function changeZoneArea(father,son)
{
	correspondAction(father, son,cityClass);
}
function doPost()
{
	if(!isDate(search.deliveryDate.value) && search.deliveryDate.value!=0)
	{
		alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
		search.deliveryDate.focus();
		return;
	}
	if (search.originCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> && search.destinationCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'只能有一個為香港！");
		return;
	}
	if (search.originCityId.value!="Any" && search.destinationCityId.value!="Any")
	{
		if (search.originCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> && search.destinationCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> )
		{
			alert("'出發地城市','目的地城市'不可以都不為香港！");
			return;
		}
	}
	search.submit();
}
</Script>
<%
out.println(dbList.getCityClass(language));
out.println(dbList.getTimeSlotClass(language));
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/head.jsp"%>
<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11">查詢紀錄</td>
    <td height="11"></td>
  </tr>
</table>
<BR>
<form action="CapacityList.jsp" name = "search" method="post">
<table border="0" width="90%">
    <tr>
        <td>公司編號： </td>
        <td><input type="text" size="10" name="companyId" maxlength="10"></td>
        <td>登記空車編號：</td>
        <td><input type="text" size="10" name="truckCapacityNum" maxlength="10"> </td>
    </tr>
    <tr>
        <td>送貨日期：</td>
    <td >
      <input type="text" maxlength="10" size="10" value="" name="deliveryDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
     </td>
        <td>配對編號：</td>
        <td><input type="text" size="20" name="matchNumber" maxlength="10"></td>
    </tr>
    <tr>
        <td>送貨時間：</td>
        <td>
				<select name="deliveryTimeId" size="1" onClick="changeTimeSlotArea(document.search.deliveryTimeId,document.search.deliveryTimeSlot)">
				  <%=dbList.getDeliveryTimeList("",language)%>
        </select>
				</td>
        <td>送貨時段：</td>
        <td><select name="deliveryTimeSlot" size="1" onChange="changeTimeIdArea(document.search.deliveryTimeId,document.search.deliveryTimeSlot)" >
            <%=dbList.getDeliveryTimeSlotList("",language)%>
        </select></td>
    </tr>
    <tr>
        <td>出發地區域：</td>
        <td><select name="originZoneId" size="1" onClick="changeCityArea(document.search.originZoneId,document.search.originCityId)">
            <%=dbList.getZoneList("",language)%>
        </select></td>
        <td>目的地區域：</td>
        <td><select name="destinationZoneId" size="1" onClick="changeCityArea(document.search.destinationZoneId,document.search.destinationCityId)">
            <%=dbList.getZoneList("",language)%>
        </select></td>
    </tr>
    <tr>
        <td>出發地城市：</td>
        <td><select name="originCityId" size="1" onChange="changeZoneArea(document.search.originZoneId,document.search.originCityId)">
            <%=dbList.getCityList("",language)%>
        </select> </td>
        <td>目的地城市：</td>
        <td><select name="destinationCityId" size="1" onChange="changeZoneArea(document.search.destinationZoneId,document.search.destinationCityId)">
            <%=dbList.getCityList("",language)%>
        </select> </td>
    </tr>
    <tr>
        <td>狀況：</td>
        <td><select name="truckCapacityStatus" size="1">
					<%=dbList.getTruckCapacityStatusList(CbtbConstant.TRUCK_CAPACITY_POST,language)%>
        </select> </td>
        <td>貨櫃種類： </td>
        <td><select name="containerTypeId" size="1">
					<%=dbList.getContainerTypeList("",language)%>
        </select></td>
    </tr>
    <tr>
		  <td>排序：</td>
      <td>
				<select name="orderByName" size="1">
				<%
				if(!language.equals("CH"))
				{
				%>
					<option selected value ="">NO Preference</option>
					<option value ="COMPANY_ID">Trcuking Organization ID</option>
					<option value ="TRUCK_CAPACITY_NUM">Truck Capacity Number</option>
					<option value ="TRUCKER_ID">Truck Plate Number</option>
					<option value ="ORIGIN_CITY_ID">Origin City</option>
					<option value ="DESTINATION_CITY_ID">Destination City</option>
					<option value ="TRAILER_ID">Trail Type</option>
					<option value ="DELIVERY_DATE">Delivery_Date</option>
					<option value ="DELIVERY_TIME_ID">Delivery Time(am/pm)</option>
				<%
				}
				else
				{
				%>
					<option selected value ="">缺省排序</option>
					<option value ="COMPANY_ID">公司編號</option>
					<option value ="TRUCK_CAPACITY_NUM">登記空車編號</option>
					<option value ="TRUCKER_ID">車牌號碼</option>
					<option value ="ORIGIN_CITY_ID">目的地城市</option>
					<option value ="DESTINATION_CITY_ID">出發地城市</option>
					<option value ="TRAILER_ID">拖架種類</option>
					<option value ="DELIVERY_DATE">送貨日期</option>
					<option value ="DELIVERY_TIME_ID">送貨時間</option>
				<%
				}
				%>
				</select>
			</td>
    </tr>
    <tr>
      <td>
				<input type="button" name="Submit" value="提交" onClick="javascript:doPost()">
        <input type="reset" name="reset" value="重設">
      </td>
    </tr>
</table>
</form>
</body>
</html>