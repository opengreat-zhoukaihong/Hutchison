<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="deliveryPriceFeeBean" scope="page" class="com.cbtb.javabean.DeliveryPriceFeeJB" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>運價數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="DeliveryPriceFeeAdd.jsp">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建 | </font>
	</a>
	<a href="MasterDataMaintenance.jsp">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">關閉</font>
	</a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">運價數據維護</font></p>

<form method="post" action="DeliveryPriceFeeList.jsp">
  <table border="0" width="75%">
    <tr> 
      <td>貨櫃類型: 
        <select name="containerSelect" >
          <%=dbList.getContainerTypeList("","")%> 
        </select>
      </td>
      <td>城市: 
        <select name="citySelect" >
          <%=dbList.getCityList("","")%> 
        </select>
      </td>
      <td> 
        <div align="right"><font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> 
          <input type="submit" name="Submit" value="查詢" >
          </font> <font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> 
          <input type="reset" name="Submit2" value="重設">
          </font> </div>
      </td>
    </tr>
  </table>
<hr>
<%
String init=request.getParameter("init");
if (!(init==null))
{
%>

  <table border="1" width="100%">
    <tr>
    <td>貨櫃種類</td>
    <td>城市</td>
    <td>運費(入境)</td>
    <td>運費(出境)</td>
    <td>運價(入境)</td>
    <td>運價(出境)</td>
    <td>最後更新時間</td>
    <td>狀況</td>
    <td>&nbsp;</td>
  </tr>
<%
String type = request.getParameter("type");
String s_containerTypeId,s_cityId,s_ibFeeToTruck,s_obFeeToTruck,s_ibPriceToShipper,
			 s_obPriceToShipper,s_lastUpdateDate,s_recordStatus,s_containerDesc,
			 s_containerChineseDesc,s_cityDesc,s_cityChineseDesc,s_statusDesc="";
String sql_PK="";
Vector deliveryPriceFees =new Vector();
try
{
	if (type == null  )
	{
		String s_containerSelect=request.getParameter("containerSelect");

		String s_citySelect=request.getParameter("citySelect");
		if (s_containerSelect.equals("Any"))
		{
			if(s_citySelect.equals("Any"))
		           sql_PK="";
			else
			  sql_PK=" AND DELIVERY_PRICE_FEE.CITY_ID = '" + s_citySelect + "'";
		}
		else
		{
			if(s_citySelect.equals("Any"))
				sql_PK=" AND DELIVERY_PRICE_FEE.CONTAINER_TYPE_ID ='" 

+s_containerSelect + "'";
			else
				sql_PK=" AND DELIVERY_PRICE_FEE.CONTAINER_TYPE_ID ='" 

+s_containerSelect + "' and DELIVERY_PRICE_FEE.CITY_ID = '" + s_citySelect + "'";
		}
		deliveryPriceFeeBean.InitContent();

		pagination.setPageNo(0);
		

pagination.setRecords(deliveryPriceFeeBean.queryDeliveryPriceFeeByCondition(sql_PK));
		deliveryPriceFees =(Vector)pagination.nextPage();

	}
	else
	{
		if (type.equals("N"))	{		deliveryPriceFees=null; deliveryPriceFees 

= (Vector)pagination.nextPage();	}
		if (type.equals("P"))	{		deliveryPriceFees = new 

Vector(pagination.previousPage());		}
		if (type.equals("F"))	{		deliveryPriceFees =new 

Vector(pagination.firstPage());		}
		if (type.equals("E"))	{		deliveryPriceFees =new 

Vector(pagination.endPage());		}
		if (type.equals("T"))	{		deliveryPriceFees =new 

Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));}
	}

	DeliveryPriceFeeModel theDeliveryPriceFeeModel=new DeliveryPriceFeeModel();
	for (int i = 0;  (!deliveryPriceFees.isEmpty()) && i < deliveryPriceFees.size(); i++)
	{
		theDeliveryPriceFeeModel=(DeliveryPriceFeeModel)deliveryPriceFees.get(i);
		s_containerTypeId=theDeliveryPriceFeeModel.containerTypeId;
		s_cityId=theDeliveryPriceFeeModel.cityId;
		s_ibFeeToTruck=(theDeliveryPriceFeeModel.ibFeeToTruck.toString()).trim();
		s_obFeeToTruck=(theDeliveryPriceFeeModel.obFeeToTruck.toString()).trim();
		s_ibPriceToShipper=(theDeliveryPriceFeeModel.ibPriceToShipper.toString()).trim();
		s_obPriceToShipper=(theDeliveryPriceFeeModel.obPriceToShipper.toString()).trim();
		s_lastUpdateDate=(theDeliveryPriceFeeModel.lastUpdateDate.toString()).trim();
		s_recordStatus=(theDeliveryPriceFeeModel.recordStatus).trim();

		s_containerDesc=(theDeliveryPriceFeeModel.containerDesc).trim();
		s_containerChineseDesc=(theDeliveryPriceFeeModel.containerChineseDesc).trim();
		s_cityDesc=(theDeliveryPriceFeeModel.cityDesc).trim();
		s_cityChineseDesc=(theDeliveryPriceFeeModel.cityChineseDesc).trim();
		if (s_recordStatus.equals(constant.MASTER_CODE_ACTIVE))
		   s_statusDesc="正常";
		if (s_recordStatus.equals(constant.MASTER_CODE_DELETED))
		   s_statusDesc="刪除";
%>
<tr>
  <td width="78"   height="22" >
     <%=s_containerChineseDesc%>
  </td>
  <td><%=s_cityChineseDesc%>&nbsp;</td>
  <td><%=s_ibFeeToTruck%>&nbsp;</td>
  <td><%=s_obFeeToTruck%>&nbsp;</td>
  <td><%=s_ibPriceToShipper%>&nbsp;</td>
  <td><%=s_obPriceToShipper%>&nbsp;</td>
  <td><%=s_lastUpdateDate%>&nbsp;</td>
  <td><%=s_statusDesc%>&nbsp;</td>
  <td>
<% if (s_recordStatus.equals(constant.MASTER_CODE_ACTIVE)){
%>
<a href="DeliveryPriceFeeView.jsp?cityId=<%=s_cityId%>
&containerTypeId=<%=s_containerTypeId%>
&status=<%=s_recordStatus%>
&ibFeeToTruck=<%=s_ibFeeToTruck%>
&obFeeToTruck=<%=s_obFeeToTruck%>
&ibPriceToShipper=<%=s_ibPriceToShipper%>
&obPriceToShipper=<%=s_obPriceToShipper%>">
修改</a></td>
<%}%>
<% if (s_recordStatus.equals(constant.MASTER_CODE_DELETED)){
%>
&nbsp;
<%}%>
</tr>
<%
 }
}
catch(Exception e){}
%>
</table>

  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="22">
    <tr> 
      <td width="76%" class="unnamed1" height="22"> 
        <%
      if (pagination.getPageNo() > 1)
      {
      %>
        <a href="DeliveryPriceFeeList.jsp?type=F&init=tmd" class="unnamed1">第一頁</a> 
        <a 

href="DeliveryPriceFeeList.jsp?type=P&init=tmd">前一頁</a> 
        <%
      }
      if (pagination.getPageNo() < pagination.getPageSum())
      {
      %>
        <a href="DeliveryPriceFeeList.jsp?type=N&init=tmd">後一頁</a> <a 

href="DeliveryPriceFeeList.jsp?type=E&init=tmd">最後一頁</a> 
        <%
      }
      %>
      </td>
      <td height="22" class="unnamed1"> 
        <div align="right">第<%=pagination.getPageNo()%>頁 總數：<%=pagination.getPageSum()%>頁</div>
      </td>
    </tr>
    <%
}
%>
  </table>
<input type="hidden" name="init" value="notfirst">
</form>
</body>
</html>