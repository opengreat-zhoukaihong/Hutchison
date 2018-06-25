<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
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
webOperator.putPermissionContext("action", "create");
if (!webOperator.checkPermission())
	response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

String language = "CH";
if(companyProfileModel!=null)
{
	System.out.println("session.getId():"+session.getId());
	System.out.println("companyProfileModel.getCompanyId():"+companyProfileModel.getCompanyId());
	System.out.println("companyProfileModel.getCompanyName():"+companyProfileModel.getCompanyName());
	System.out.println("companyProfileModel.getCompanyChineseName():"+companyProfileModel.getCompanyChineseName());
	System.out.println("companyProfileModel.getCompanyStatus():"+companyProfileModel.getCompanyStatus());
}
String companyId = request.getParameter("companyId");
CompanyManager companyManager = webOperator.getCompanyManager();
companyProfileModel = companyManager.findCompanyProfile(companyId);

if(!companyProfileModel.getCompanyStatus().equals(com.cbtb.util.CbtbConstant.COMPANY_ACTIVE))
	response.sendRedirect("ErrorPage.jsp?errorMessage=TC_0003");
String backPage = "UserSearchCompany.jsp?companyId="+companyProfileModel.getCompanyId();
session.setAttribute("backPage",backPage);
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
		return;
	}
	if (add.originCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> && add.destinationCityId.value!=<%=CbtbConstant.HONGKONG_CITY_ID%> )
	{
		alert("'出發地城市','目的地城市'必須有一個為香港！");
		return;
	}
	if (add.originCityId.value=="Any" && add.destinationCityId.value=="Any")
	{
		alert("'出發地城市','目的地城市'只能有一個Any！");
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
	if (add.truckerId0.value == "Any")
	{
		alert("請輸入空車的貨櫃車編號！");
		return;
	}
	if (add.trailerId0.value == "Any")
	{
		alert("請輸入空車的拖架種類！");
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
<%@ include file="../include/head.jsp"%>
<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11">登記空車細節</td>
    <td height="11">
      <div align="right"><a href="javascript:history.back()"><font color="#003366">關閉</font></a></div>
    </td>
  </tr>
</table>
<BR>
<p align="left"><font size="2" face="Arial, Helvetica, sans-serif">
	公司編號：<%=companyProfileModel.getCompanyId()%>
	<input type = "hidden" name = "companyId" value ="<%=companyProfileModel.getCompanyId()%>">
</font></p>
<table border="0" width="90%">
  <tr>
    <td><font size="2"><em>公司名稱： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%></em></font></td>
    <td><font size="2"><em>公司聯絡人： </em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%></em></font></td>
  </tr>
  <tr>
    <td><font size="2"><em>電話號碼：</em></font></td>
    <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%></em></font></td>
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

<form action="CapacityAddConfirm.jsp" method="post" name="add">
<div align="left">
  <table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="35%">出發地城市：</td>
      <td width="44%">
        <select name="originCityId" size="1">
          <%=dbList.getCityList("","CH")%>
        </select>
      </td>
      <td width="19%">目的地城市：</td>
      <td width="2%">
        <select name="destinationCityId" size="1">
          <%=dbList.getCityList("","CH")%>
        </select>
      </td>
    </tr>
    <tr>
      <td width="35%">&nbsp;</td>
      <td colspan="3">&nbsp; </td>
    </tr>
    <tr>
      <td width="35%">送貨日期：</td>
      <td >
        <input type="text" maxlength="10" size="10" value="" name="deliveryDate">
        <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(deliveryDate);return false" >
			</td>
      <td >送貨時間：</td>
      <td >
        <select name="deliveryTimeId" size="1"  onClick="change5()">
          <%=dbList.getDeliveryTimeList("","CH")%>
        </select>
      </td>
    </tr>
    <tr>
      <td width="35%">登記途徑：</td>
      <td>
				<input type = "radio" name = "captureChannel"  value="<%=CbtbConstant.CAPTURE_CHANNEL_EMAIL%>">電子郵件
				<input type = "radio" name = "captureChannel"  value="<%=CbtbConstant.CAPTURE_CHANNEL_FAX%>">傳真
				<input type = "radio" name = "captureChannel"  value="<%=CbtbConstant.CAPTURE_CHANNEL_INTERNET%>">因特網
				<input type = "radio" checked="true" name = "captureChannel"  value="<%=CbtbConstant.CAPTURE_CHANNEL_PHONE%>">電話
      </td>
      <td>備註：</td>
      <td>
        <textarea cols="20" name="remark"></textarea>
      </td>
    </tr>
  </table>
</div>

<p align="left">貨櫃車司機列表 (最多輸入5個司機)</p>
<div align="left">

<table border="1" width="75%">
    <tr>
        <td>貨櫃車司機姓名</td>
        <td>貨櫃車編號</td>
        <td>車牌號碼</td>
        <td>拖架種類</td>
        <td>送貨時段</td>
    </tr>
		<%
			for(int i=0;i<5;i++)
			{
		%>
			<tr>
					<td><select onChange="nameToId(document.add.truckerId<%=i%>,document.add.truckerName<%=i%>,document.add.hkPlateNo<%=i%>)" name = "truckerId<%=i%>" >
						<%=dbList.getTruckerDetailList(companyProfileModel.getCompanyId(),"","CH")%>
					</select></td>
					<td><input type="text" readonly name="truckerName<%=i%>" value="" style="background-color: #FFFFFF; color: #000000; border-style: solid; border-color: #FFFFFF"></td>
					<td><input type="text" readonly name="hkPlateNo<%=i%>" value="" style="background-color: #FFFFFF; color: #000000; border-style: solid; border-color: #FFFFFF"></td>
					<td><select name="trailerId<%=i%>" size="1">
							<%=dbList.getTrailerTypeList("","CH")%>
					</select></td>
					<td><select name="deliveryTimeSlot<%=i%>" size="1">
							<%=dbList.getDeliveryTimeSlotList("","CH")%>
					</select></td>
			</tr>
		<%
			}
		%>
</table>
</div>
<p><input type="button" name="post" onClick="javascript:doPost()" value="提交">&nbsp;&nbsp;
<input  type="reset" name="B1" value="清除">  </p>
</form>
</body>
</html>