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
<%@ page import="java.sql.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<jsp:useBean id="truckCapacityModel" scope="session" class="com.cbtb.model.TruckCapacityModel" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<script src=../js/calendarShow.js></script>
<script src=../js/JsLib.js></script>
<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","TRUCK_CAPACITY");
webOperator.putPermissionContext("action", "create");
if (!webOperator.checkPermission())
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

dbList.refresh();
String language = "CH";
companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");
if(!companyProfileModel.getCompanyStatus().equals(com.cbtb.util.CbtbConstant.COMPANY_ACTIVE))
{
	response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
}
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
function change5()
{
	changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot0)
	changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot1)
	changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot2)
	changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot3)
	changeTimeSlotArea(document.add.deliveryTimeId,document.add.deliveryTimeSlot4)
}
function nameToId(soureObject,aimObject1,aimObject2)
{
 	same=0
 	var str=soureObject.options[soureObject.selectedIndex].value;
	if(str == "Any")
	{
		aimObject1.value="";
		aimObject2.value="";
		return;
	}
  if(str == document.add.truckerId0.value)	same++;
  if(str == document.add.truckerId1.value)	same++;
  if(str == document.add.truckerId2.value)	same++;
  if(str == document.add.truckerId3.value)	same++;
  if(str == document.add.truckerId4.value)	same++;
  if(same==2)
  {
  	alert("同一天同一個司機不能發佈兩條運力信息！");
  	soureObject.value="Any";
		aimObject1.value="";
		aimObject2.value="";
  	return;
  }
  else
  {
	  var len = str.length;
	  var x=str.indexOf('$');
	  var y=str.lastIndexOf('$');
	  aimObject1.value=str.substring(0,x);
	  aimObject2.value=str.substring(y+1,len);
	}
}
function doPost()
{
	if (add.originCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> && add.destinationCityId.value==<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'只能有一個為香港！");
		add.originCityId.focus();
		return;
	}
	if (add.originCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> && add.destinationCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'必須有一個為香港！");
		add.originCityId.focus();
		return;
	}
	if (add.originCityId.value=="Any" && add.destinationCityId.value=="Any")
	{
		alert("'出發地城市','目的地城市'只能有一個Any！");
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
		add.deliveryTimeId.focus();
		return;
	}
	if (add.truckerId0.value == "Any")
	{
		alert("請輸入空車的貨櫃車編號！");
		add.truckerId0.focus();
		return;
	}
	if (add.trailerId0.value == "Any")
	{
		alert("請輸入空車的拖架種類！");
		add.trailerId0.focus();
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
<title>Truck Capacity Details</title>
</head>
<%@ include file="../include/headtrucker.jsp"%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="12%"><font face="Arial, Helvetica, sans-serif" size="2"><b></b></font></td>
    <td width="88%">
			<div align="right"><a href="indexTrucking.jsp"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<form action="CapacityAddConfirm.jsp" method="post" name="add">
<table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
  <tr>
		<td width="24%">運輸公司編號：</td>
		<td width="27%"><%=companyProfileModel.getCompanyId()%></td>
		<td width="21%">運輸公司名稱：</td>
		<td width="28%"><%=companyProfileModel.getCompanyChineseName()%></td>
	</tr>
  <tr>
    <td width="24%">出發地城市：</td>
    <td width="27%">
      <select name="originCityId" size="1">
        <%=dbList.getCityList("",language)%>
      </select>
    </td>
    <td width="21%">目的地城市：</td>
    <td width="28%">
      <select name="destinationCityId" size="1">
        <%=dbList.getCityList("",language)%>
      </select>
    </td>
  </tr>
  <tr>
    <td width="24%">送貨日期：</td>
    <td ><input type="text" maxlength="10" size="10" value="" name="deliveryDate">
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
		</td>
    <td width="21%">送貨時間：</td>
    <td width="28%">
      <select name="deliveryTimeId" size="1" onClick="change5()">
        <%=dbList.getDeliveryTimeList("",language)%>
      </select>
    </td>
  </tr>
</table>
<table cellpadding="4" cellspacing="" width="98%" align="center">
	<tr bgcolor="e0e0e0">
		<td>貨櫃車司機姓名</td>
		<td>貨櫃車編號</td>
		<td>車牌號碼 </td>
		<td>拖架種類</td>
		<td>送貨時段</td>
		<td>備註</td>
	</tr>
		<%
			boolean color = true;
			String backcolor = "#ddffdd";
			for(int i=0;i<5;i++)
			{
				if(color)
				{
					backcolor = "#FFFFFF";
				  color = false;
				}
				else
				{
					backcolor = "#ddffdd";
					color = true;
				}
				out.write("<tr bgcolor="+backcolor+">");
		%>
				<td><select onChange="nameToId(document.add.truckerId<%=i%>,document.add.truckerName<%=i%>,document.add.hkPlateNo<%=i%>)" name = "truckerId<%=i%>" >
					<%=dbList.getTruckerDetailList(companyProfileModel.getCompanyId(),"",language)%>
				</select></td>
				<td><input type="text" readonly name="truckerName<%=i%>" value="" style="background-color: <%=backcolor%>; color: #000000; border-style: solid; border-color: <%=backcolor%>"></td>
				<td><input type="text" readonly name="hkPlateNo<%=i%>" value="" style="background-color: <%=backcolor%>; color: #000000; border-style: solid; border-color: <%=backcolor%>"></td>
				<td><select name="trailerId<%=i%>" size="1">
					<%=dbList.getTrailerTypeList("",language)%>
				</select></td>
				<td><select name="deliveryTimeSlot<%=i%>" size="1" >
						<%=dbList.getDeliveryTimeSlotList("",language)%>
				</select></td>
				<td><input type="text" size="10" name="remark<%=i%>" style="background-color:<%=backcolor%>"></td>
		</tr>
		<%
			}
		%>
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