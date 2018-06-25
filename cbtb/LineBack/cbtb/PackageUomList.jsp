<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="packageUomBean" scope="page" class="com.cbtb.javabean.PackageUomJB" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","PACKAGE_UOM"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>量度單位數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="PackageUomAdd.jsp">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font>
	</a> |
	<a href="MasterDataMaintenance.jsp">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">關閉</font>
	</a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">量度單位數據維護</font></p>

<form method="post" action="PackageUomList.jsp">
<table border="0" width="75%">
  <tr>
    <td>編號:</td>
    <td>
      <select name="PKSelect" >
	 <%=dbList.getPackageList("","")%>
      </select>
    </td>
    <td>
      <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">
      <input type="submit" name="Submit" value="查詢" ></font>
    </td>
    <td>
	<font color="#003366" size="2" face="Arial, Helvetica, sans-serif">
      <input type="reset" name="Submit2" value="重設"></font>
    </td>
  </tr>
</table>
<hr>
<%
String init=request.getParameter("init");
if (!(init==null))
{
%>

<table border="1" width="75%">
  <tr>
    <td>編號</td>
    <td>英文描述</td>
    <td>中文描述</td>
    <td>狀況</td>
  </tr>
<%
String type = request.getParameter("type");
String s_uomId,s_uomDesc,s_uomChineseDesc,s_status,s_statusDesc="";
String sql_PK="";
Vector packageUoms =new Vector();
try
{
	if (type == null  )
	{
		String s_PKSelect=request.getParameter("PKSelect");

		if (s_PKSelect.equals("Any"))
		  sql_PK="";
		else
		  sql_PK=" where uom_Id ='" +s_PKSelect + "'";

		packageUomBean.InitContent();
		pagination.setPageNo(0);
		pagination.setRecords(packageUomBean.queryPackageUomByCondition(sql_PK));
		packageUoms =(Vector)pagination.nextPage();

	}
	else
	{
		if (type.equals("N"))	{		packageUoms=null; packageUoms = (Vector)pagination.nextPage();	}
		if (type.equals("P"))	{		packageUoms = new Vector(pagination.previousPage());		}
		if (type.equals("F"))	{		packageUoms =new Vector(pagination.firstPage());		}
		if (type.equals("E"))	{		packageUoms =new Vector(pagination.endPage());		}
		if (type.equals("T"))	{		packageUoms =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));}
	}

	PackageUomValue thePackageUomValue=new PackageUomValue();
	for (int i = 0;  (!packageUoms.isEmpty()) && i < packageUoms.size(); i++)
	{
		thePackageUomValue=(PackageUomValue)packageUoms.get(i);
		s_uomId=thePackageUomValue.uomId;
		s_uomDesc=thePackageUomValue.uomDesc;
		s_uomChineseDesc=thePackageUomValue.uomChineseDesc;
		s_status=thePackageUomValue.recordStatus;
%>
<tr>
<%
		if (s_status.equals(constant.MASTER_CODE_ACTIVE))  {
		   s_statusDesc="正常";
%>
  <td width="78"   height="30" >
    <a href="PackageUomView.jsp?uomId=<%=s_uomId%>"><%=s_uomId%></a>
  </td>
<%}
		if (s_status.equals(constant.MASTER_CODE_DELETED))  {
		   s_statusDesc="刪除";
%>

  <td width="78"   height="30" >
    <%=s_uomId%>
  </td>
<%}%>
  <td width="108"   height="30" ><%=s_uomDesc%>&nbsp;</td>
  <td width="126"   height="30" ><%=s_uomChineseDesc%>&nbsp;</td>
  <td width="66"   height="30" ><%=s_statusDesc%>&nbsp;</td>
</tr>
<%
	}
}
catch(Exception e){}
%>
</table>

<table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
  <tr>
    <td width="76%" class="unnamed1">
      <%
      if (pagination.getPageNo() > 1)
      {
      %>
        <a href="PackageUomList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> <a href="PackageUomList.jsp?type=P&init=Y">前一頁</a>
      <%
      }
      if (pagination.getPageNo() < pagination.getPageSum())
      {
      %>
        <a href="PackageUomList.jsp?type=N&init=Y">後一頁</a> <a href="PackageUomList.jsp?type=E&init=Y">最後一頁</a>
      <%
      }
      %>
      </td>
    <td width="9%" class="unnamed1">
			第<%=pagination.getPageNo()%>頁
    </td>
    <td width="15%" class="unnamed1">
      總數：<%=pagination.getPageSum()%>頁
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