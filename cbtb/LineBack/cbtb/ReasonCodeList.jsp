<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="reasonBean" scope="page" class="com.cbtb.javabean.ReasonCodeJB" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","REASON_CODE"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>原因代碼數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right">
	<a href="ReasonCodeAdd.jsp">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建 | </font>
	</a>
	<a href="MasterDataMaintenance.jsp">
	  <font color="#003366" size="2" face="Arial, Helvetica, sans-serif">關閉</font>
	</a>
</p>
<p><font face="Arial, Helvetica, sans-serif" size="3">原因代碼數據維護</font></p>

<form method="post" action="ReasonCodeList.jsp">
  <table border="0" width="75%">
    <tr> 
      <td>原因代碼: 
        <select name="RCSelect" >
          <%=dbList.getReasonCodeList("","")%> 
        </select>
      </td>
      <td> 
        <div align="right"><font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> 
          <input type="submit" name="Submit" value="查詢" >
          <input type="reset" name="Submit2" value="重設">
          </font> <font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> 
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

<table border="1" width="75%">
  <tr>
    <td>編號</td>
    <td>英文描述</td>
    <td>中文描述</td>
    <td>狀況</td>
  </tr>
<%
String type = request.getParameter("type");
String s_reasonId,s_reasonDesc,s_reasonChineseDesc,s_status,s_statusDesc="";
String sql_PK="";
Vector reasonCodes =new Vector();
try
{
	if (type == null  )
	{
		String s_RCSelect=request.getParameter("RCSelect");
		if (s_RCSelect.equals("Any"))
		  sql_PK="";
		else
		  sql_PK=" where reason_Id ='" +s_RCSelect + "'";

		reasonBean.InitContent();
		pagination.setPageNo(0);
		pagination.setRecords(reasonBean.queryReasonCodeByCondition(sql_PK));
		reasonCodes =(Vector)pagination.nextPage();

	}
	else
	{
		if (type.equals("N"))	{		reasonCodes=null; reasonCodes = (Vector)pagination.nextPage();	}
		if (type.equals("P"))	{		reasonCodes = new Vector(pagination.previousPage());		}
		if (type.equals("F"))	{		reasonCodes =new Vector(pagination.firstPage());		}
		if (type.equals("E"))	{		reasonCodes =new Vector(pagination.endPage());		}
		if (type.equals("T"))	{		reasonCodes =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));}
	}

	ReasonCodeValue theReasonCodeValue=new ReasonCodeValue();
	for (int i = 0;  (!reasonCodes.isEmpty()) && i < reasonCodes.size(); i++)
	{
		theReasonCodeValue=(ReasonCodeValue)reasonCodes.get(i);
		s_reasonId=theReasonCodeValue.reasonId;
		s_reasonDesc=theReasonCodeValue.reasonDesc;
		s_reasonChineseDesc=theReasonCodeValue.reasonChineseDesc;
		s_status=theReasonCodeValue.recordStatus;
		if (s_status.equals(constant.MASTER_CODE_ACTIVE))
		   s_statusDesc="正常";
		if (s_status.equals(constant.MASTER_CODE_DELETED))
		   s_statusDesc="刪除";
%>
<tr>
  <td width="78"   height="22" >
<% if (s_status.equals(constant.MASTER_CODE_ACTIVE)){
%>

    <a href="ReasonCodeView.jsp?reasonId=<%=s_reasonId%>"><%=s_reasonId%></a>
  </td>
<%}%>
<% if (s_status.equals(constant.MASTER_CODE_DELETED)){
%>
<%=s_reasonId%>
<%}%>

  <td width="108"   height="22" ><%=s_reasonDesc%>&nbsp;</td>
  <td width="126"   height="22" ><%=s_reasonChineseDesc%>&nbsp;</td>
  <td width="66"   height="22" ><%=s_statusDesc%>&nbsp;</td>
</tr>
<%
	}
}
catch(Exception e){}
%>
</table>

<table width="75%" border="0" cellspacing="0" cellpadding="0" height="22">
    <tr> 
      <td width="76%" class="unnamed1"> 
        <%
      if (pagination.getPageNo() > 1)
      {
      %>
        <a href="ReasonCodeList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> <a href="ReasonCodeList.jsp?type=P&init=Y">前一頁</a> 
        <%
      }
      if (pagination.getPageNo() < pagination.getPageSum())
      {
      %>
        <a href="ReasonCodeList.jsp?type=N&init=Y">後一頁</a> <a href="ReasonCodeList.jsp?type=E&init=Y">最後一頁</a> 
        <%
      }
      %>
      </td>
      <td class="unnamed1"> 
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