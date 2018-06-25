<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TARIFF"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
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

<%
	String URL=request.getParameter("URL");
	String containerTypeId=request.getParameter("containerTypeId");
	String cityId=request.getParameter("cityId");
	String containerChineseDesc=dbList.getContainerTypeDesc(containerTypeId,"");
	String cityChineseDesc=dbList.getCityDesc(cityId,"");
	String ibFeeToTruck=request.getParameter("ibFeeToTruck");
	String obFeeToTruck=request.getParameter("obFeeToTruck");
	String ibPriceToShipper=request.getParameter("ibPriceToShipper");
	String obPriceToShipper=request.getParameter("obPriceToShipper");
%>
<SCRIPT LANGUAGE="JavaScript">

function doPost()
{

    edit.submit();
}
</SCRIPT>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right">
<a href="javascript:doPost()">
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">確定</font></a>
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> |</font>
	  <a href="javascript:history.back();">
	<font color="#003366" size="2"	face="Arial, Helvetica, sans-serif">取消</font></a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">運價數據維護</font></p>
<hr>
<form name=edit mathod=post action=<%=URL%> >
<table width="56%" border="0">
<input type="hidden" name="containerTypeId" value="<%=request.getParameter("containerTypeId")%>">
<input type="hidden" name="cityId" value="<%=request.getParameter("cityId") %>">
<input type="hidden" name="ibFeeToTruck" value="<%=request.getParameter("ibFeeToTruck")%>">
<input type="hidden" name="obFeeToTruck" value="<%=request.getParameter("obFeeToTruck") %>">
<input type="hidden" name="ibPriceToShipper" value="<%=request.getParameter("ibPriceToShipper") %>">
<input type="hidden" name="obPriceToShipper" value="<%=request.getParameter("obPriceToShipper")%>">

  <tr>
    <td width="50%">貨櫃種類：</td>
    <td width="50%"><%=containerChineseDesc%> </td>
  </tr>
  <tr>
    <td width="50%">城市：</td>
    <td width="50%"><%=cityChineseDesc%></td>
  </tr>
  <tr>
    <td width="50%">運費(入境)：</td>
    <td width="50%"><%=ibFeeToTruck%></td>
  </tr>
  <tr>
    <td width="50%">運費(出境)：</td>
    <td width="50%"><%=obFeeToTruck%></td>
  </tr>
  <tr>
    <td width="50%">運價(入境)：</td>
    <td width="50%"><%=ibPriceToShipper%></td>
  </tr>
  <tr>
    <td width="50%">運價(出境)：</td>
    <td width="50%"><%=obPriceToShipper%></td>
  </tr>
</table>
</form>
</body>
</html>
