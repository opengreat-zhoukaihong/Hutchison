<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" errorPage="ErrorPage.jsp" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<script src=../js/calendarShow.js></script>
<script src=../js/JsLib.js></script>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "edit");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
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
function changeByValue()
{
	var i = add.deliveryTimeSlot.options.length;
	for(var j=0;j<i;j++)
	{
		v = add.deliveryTimeSlot.options[j].value;
		if(v =="<%=truckCapacityModel.getDeliveryTimeSlot()%>")
		{
			add.deliveryTimeSlot.options[j].selected=true;
		}
	}
}
function onload(father,son)
{
	son.options.length=1;
	chgDnCombobox(father, son,timeSlotClass,1);
	changeByValue();
}



function doPost()
{
	if (add.originCityId.value=="Any"&&add.destinationCityId.value=="Any")
	{
		alert("請輸入出發地城市,目的地城市能且只能有一個為空！");
		return;
	}
	if (add.originCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> && add.destinationCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'只能有一個為香港！");
		return;
	}
	if (add.originCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> && add.destinationCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'必須有一個為香港！");
		return;
	}
	if(!isDate(add.deliveryDate.value))
	{
		alert("發貨日期不合法或格式不為(YYYY-MM-DD)!");
		add.deliveryDate.focus();
		return;
	}
	if (add.deliveryTimeId.value=="Any")
	{
		alert("請輸入送貨時間！");
		return;
	}
	if (add.trailerId.value=="Any")
	{
		alert("請輸入空車的拖架種類！");
		return;
	}
	if (add.truckerId.value == "Any")
	{
		alert("請輸入空車的貨櫃車司機姓名！");
		return;
	}
 add.submit()
}
function nameToId(soureObject,aimObject1,aimObject2)
{
	var str=soureObject.options[soureObject.selectedIndex].value;
	var len = str.length;
	var x=str.indexOf('$');
	var y=str.lastIndexOf('$');
	aimObject1.value=str.substring(0,x);
	aimObject2.value=str.substring(y+1,len);
}
</SCRIPT>
<%
out.println(dbList.getTimeSlotClass(language));
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/headtrucker.jsp"%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" onload = "onload(document.add.deliveryTimeId,document.add.deliveryTimeSlot)" >
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852"><font face="Arial, Helvetica, sans-serif" size="2" color="#667852"><b><b></b></b></font><font face="Arial, Helvetica, sans-serif">修改空車貨運紀錄細節</font></font></b></font></b></font></td>
    <td>
      <div align="right"><a href="javascript:history.back()"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>
<form  name="add" action="CapacityEditConfirm.jsp" method ="post">
  <table border="0" width="98%"  height="50" align="center" cellpadding="0" cellspacing="0">
	  <tr><td colspan = "4">空車編號：<%=truckCapacityModel.getTruckCapacityNum()%></td></tr>
    <tr>
			<td width="19%">運輸公司編號：</td>
      <td width="32%"><%=companyProfileModel.getCompanyId()%></td>
      <td width="18%">運輸公司名稱：</td>
      <td width="31%"><%=companyProfileModel.getCompanyChineseName()%></td>
    </tr>
    <tr>
      <td width="19%">出發地城市：</td>
      <td width="32%">
				<select name="originCityId" size="1">
          <%=dbList.getCityList(truckCapacityModel.getMatchOriginCityId(),language)%>
        </select>
      </td>
      <td width="18%">目的地城市：</td>
      <td width="31%">
        <select name="destinationCityId" size="1">
          <%=dbList.getCityList(truckCapacityModel.getMatchDestCityId(),language)%>
        </select>
      </td>
    </tr>
    <tr>
      <td width="19%" >送貨日期：</td>
      <td width="32%" >
        <input type="text" maxlength="10" size="10" value="<%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%>" name="deliveryDate"  >
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" > </td>
      <td width="18%" >送貨時間：</td>
      <td width="31%" >
        <select name="deliveryTimeId" size="1" onClick="changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot)">
				  <%=dbList.getDeliveryTimeList(truckCapacityModel.getDeliveryTimeId(),language)%>
        </select>
      </td>
    </tr>
    <tr>
      <td width="19%" >拖架種類：</td>
      <td width="32%" >
        <select name="trailerId" size="1">
          <%=dbList.getTrailerTypeList(truckCapacityModel.getTrailerId(),language)%>
        </select>
      </td>
      <td width="18%" >送貨時段：</td>
      <td width="31%" >
        <select name="deliveryTimeSlot" size="1" onChange="changeTimeIdArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot)">
          <%=dbList.getDeliveryTimeSlotList(truckCapacityModel.getDeliveryTimeSlot(),language)%>
        </select>
      </td>
    </tr>
    <tr>
      <td width="19%" >貨櫃車司機姓名：</td>
      <td width="32%" >
				<select name = "truckerId" onChange="nameToId(document.add.truckerId,document.add.truckerName,document.add.hkPlateNo)">
					<%=dbList.getTruckerDetailList(companyProfileModel.getCompanyId(),truckCapacityModel.getTruckerId()+"$"+dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)+"$"+dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId()),language)%>
				</select></td>
				<%System.out.println(truckCapacityModel.getTruckerId()+"$"+dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)+"$"+dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId()));%>
      <td width="18%" >貨櫃車編號：</td>
      <td width="31%">
				<input type="text" name="truckerName" size="14" readonly value="<%=truckCapacityModel.getTruckerId()%>" style="background-color: #FFFFFF; color: #000000; border-style: solid; border-color: #FFFFFF">
			</td>
    </tr>
    <tr>
      <td width="19%" >狀況：</td>
      <td width="32%" >
        <%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%>
      </td>
      <td width="18%" >車牌號碼：</td>
      <td width="31%" >
        <input type="text" name="hkPlateNo" size="14" readonly value="<%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>" style="background-color: #FFFFFF; color: #000000; border-style: solid; border-color: #FFFFFF" >
      </td>
    </tr>
    <tr>
      <td width="19%" rowspan="2" valign="top">備註：</td>
      <td width="32%" rowspan="2"valign="top">
        <textarea cols="20" name="remark" ><%=truckCapacityModel.getRemark()%></textarea>
      </td>
      <td width="18%">&nbsp;</td>
      <td width="31%">&nbsp;</td>
    </tr>
  </table>

	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td>
				<a href="javascript:doPost()"><img src="../images/submit.jpg" width="44" height="19" border="0"></a>
				<img src="../images/good.jpg" width="10" height="10">
				<a href="javascript:add.reset()"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
			</td>
		</tr>
	</table>
</form>
<%@ include file="../include/food.jsp"%>
</body>
</html>