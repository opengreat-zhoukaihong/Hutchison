<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
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

String language = (String)session.getAttribute("language");
truckCapacityModel = (TruckCapacityModel)session.getAttribute("truckCapacityModel");
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

function nameToId(soureObject,aimObject1,aimObject2)
{
	var str=soureObject.options[soureObject.selectedIndex].value;
	var len = str.length;
	var x=str.indexOf('$');
	var y=str.lastIndexOf('$');
	aimObject1.value=str.substring(0,x);
	aimObject2.value=str.substring(y+1,len);
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
		add.originCityId.focus();
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
	if (add.captureChannel.value=="Any")
	{
		alert("請輸入登記途徑！");
		return;
	}
	if (add.trailerId.value=="Any")
	{
		alert("請輸入空車的拖架種類！");
		return;
	}
	if (add.truckerId.value == "Any")
	{
		alert("請輸入空車的貨櫃車編號！");
		return;
	}
 add.submit();
}
</SCRIPT>
<%
out.println(dbList.getTimeSlotClass(language));
%>
<html>
<head>
<LINK href="../css/line.css" rel=stylesheet>
<title></title>
</head>
<%@ include file="../include/head.jsp"%>
<body bgcolor="#FFFFFF" text="#000000" onload = "onload(document.add.deliveryTimeId,document.add.deliveryTimeSlot)">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11">登記空車細節</td>
    <td height="11">
      <div align="right"><a href="javascript:history.back()"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>
<p align="left"><font size="2" face="Arial, Helvetica, sans-serif">公司編號：<%=companyProfileModel.getCompanyId()%></font></p>
<table border="0" width="90%">
  <tr>
    <td><font size="2"><em>公司名稱： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%></em></font></td>
    <td><font size="2"><em>公司聯絡人： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%></em></font></td>
  </tr>
  <tr>
    <td><font size="2"><em>電話號碼：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%> </em></font></td>
    <td><font size="2"><em>傳真號碼：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getFaxNo()%></em></font></td>
  </tr>
  <tr>
    <td><font size="2"><em>手提電話號碼： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getMobileNo()%></em></font></td>
    <td><font size="2"><em>電郵地址：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getEmailAddr()%></em></font></td>
  </tr>
</table>
<BR>
<form name="add" method="post" action="CapacityUpdateConfirm.jsp">
  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="44%" height="30">空車編號：</td>
      <td width="28%"><%=truckCapacityModel.getTruckCapacityNum()%></td>
      <td width="28%">提交日期：</td>
      <td width="56%">
				<%
					String subMissionDatetime = new String();
					if(truckCapacityModel.getSubMissionDatetime()!=null)
						subMissionDatetime = truckCapacityModel.getSubMissionDatetime().toString().trim();
					else
						subMissionDatetime = "&nbsp;";
						out.write(subMissionDatetime);
				%>
      </td>
      <td width="56%">狀態：</td>
      <td width="56%"><%=dbList.getTruckCapacityStatusDesc(truckCapacityModel.getTruckCapacityStatus(),language)%> </td>
    </tr>
    <tr>
      <td width="44%" height="30">出發地城市：</td>
      <td width="0%">
        <select name="originCityId" size="1">
          <%=dbList.getCityList(truckCapacityModel.getOriginCityId(),language)%>
        </select>
      </td>
      <td width="0%">目的地城市：</td>
      <td width="0%">
        <select name="destinationCityId" size="1">
          <%=dbList.getCityList(truckCapacityModel.getDestinationCityId(),language)%>
        </select>
      </td>
      <td width="0%">送貨日期：</td>
      <td width="56%">
        <input type="text" maxlength="10" size="10" value="<%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%>" name="deliveryDate"  >
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
      </td>
    </tr>
    <tr>
      <td width="44%" height="30">送貨時間：</td>
      <td width="0%" height="11">
        <select name="deliveryTimeId" size="1" onClick="changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot)">
				<%=dbList.getDeliveryTimeList(truckCapacityModel.getDeliveryTimeId(),language)%>
        </select>
      </td>
      <td width="0%" height="11">送貨時段：</td>
      <td width="0%" height="11">
        <select name="deliveryTimeSlot" size="1" onChange="changeTimeIdArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot)" >
            <%=dbList.getDeliveryTimeSlotList(truckCapacityModel.getDeliveryTimeSlot(),language)%>
        </select>
      </td>
      <td width="0%" height="11">拖架種類：</td>
      <td width="56%" height="11">
        <select name="trailerId" size="1">
          <%=dbList.getTrailerTypeList(truckCapacityModel.getTrailerId(),language)%>
        </select>
      </td>
    </tr>
    <tr>
      <td width="44%" height="30">貨櫃車司機姓名：</td>
      <td width="0%">
        <select name = "truckerId" onChange="nameToId(document.add.truckerId,document.add.truckerName,document.add.hkPlateNo)">
					<%=dbList.getTruckerDetailList(companyProfileModel.getCompanyId(),truckCapacityModel.getTruckerId()+"$"+dbList.getTruckerName(truckCapacityModel.getTruckerId(),language)+"$"+dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId()),language)%>
				</select>
      </td>
      <td>貨櫃車編號：</td>
      <td><input type="text" name="truckerName" size="14" readonly value="<%=truckCapacityModel.getTruckerId()%>" style="background-color: #FFFFFF; color: #000000; border-style: solid; border-color: #FFFFFF"></td>
      <td>車牌號碼：</td>
      <td width="56%"><input type="text" name="hkPlateNo" size="14" readonly value="<%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>" style="background-color: #FFFFFF; color: #000000; border-style: solid; border-color: #FFFFFF"></td>
    </tr>
    <tr>
      <td width="44%" height="30">登記途徑：</td>
      <td width="0%">
				<input type = "radio" name = "captureChannel" <%if(truckCapacityModel.getCaptureChannel().equalsIgnoreCase(CbtbConstant.CAPTURE_CHANNEL_EMAIL)) out.print("checked");%> value="<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%>">電子郵件
				<input type = "radio" name = "captureChannel" <%if(truckCapacityModel.getCaptureChannel().equalsIgnoreCase(CbtbConstant.CAPTURE_CHANNEL_FAX)) out.print("checked");%> value="<%=CbtbConstant.CAPTURE_CHANNEL_FAX%>">傳真
				<input type = "radio" name = "captureChannel" <%if(truckCapacityModel.getCaptureChannel().equalsIgnoreCase(CbtbConstant.CAPTURE_CHANNEL_INTERNET)) out.print("checked");%> value="<%=CbtbConstant.CAPTURE_CHANNEL_INTERNET%>">因特網
				<input type = "radio" name = "captureChannel" <%if(truckCapacityModel.getCaptureChannel().equalsIgnoreCase(CbtbConstant.CAPTURE_CHANNEL_PHONE)) out.print("checked");%> value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>">電話
      </td>
      <td width="0%">運費：</td>
      <td width="0%"><%
												BigDecimal deliveryFee = new BigDecimal("0");
												if(truckCapacityModel.getMatchRequestFee().equals(deliveryFee))
												{
												  out.write("&nbsp");
												}
												else
												{
												  out.write(truckCapacityModel.getMatchRequestFee().toString());
												}
											%>
			</td>
      <td width="0%">配對編號：</td>
      <td width="56%"><%=truckCapacityModel.getMatchNumber()%></td>
    </tr>
    <tr>
      <td width="44%" height="30">備註：</td>
      <td width="56%" colspan="5">
        <textarea cols="20" name="remark" ><%=truckCapacityModel.getRemark()%></textarea>
      </td>
    </tr>
  </table>
  <input type="button" name="post" onClick="javascript:doPost()" value="提交">
  <input type="reset" name="Submit2" value="重設">
</form>
</html>