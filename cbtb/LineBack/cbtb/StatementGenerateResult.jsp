<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="ErrorPage.jsp"%>
<%

webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (!(webOperator.checkPermission()))
response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
else
{
%>

<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.ejb.session.*"%>
<%@ page import="com.cbtb.model.StatementDataModel"%>
<jsp:useBean id="statementDataModel" scope="session" class="com.cbtb.model.StatementDataModel" />
<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope = "session" class = "com.cbtb.util.Pagination" />

<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<%@ include file="../include/head.jsp"%>
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
    <td height="11"><font face="Arial, Helvetica, sans-serif">生成服務報表列表</font></td>
    <td height="11">
      <div align="right"><a href="Billing.jsp"><font color="#003366">關閉</font></a></div>
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

<%
 try {
 Vector statementList=null;
 String type = request.getParameter("type");
  if (type == null)
  {
  String  beginDate  = request.getParameter("beginDate");
   if ((beginDate == null) || beginDate == "")
       beginDate = "";

  String  endDate    = request.getParameter("endDate");
   if ((endDate == null) || (endDate ==""))
      endDate = "";

  String  companyId     = request.getParameter("companyIdTmp");
    if ((companyId == null) || (companyId == ""))
        companyId = "";
  String matchNum = request.getParameter("matchNum");
    if ((matchNum == null) || (matchNum == ""))
         matchNum = "";
//out.println("beginDate = "+beginDate+"endDate = "+endDate+"status = "+status);
    BillingManager billingManager = webOperator.getBillingManager();
    pagination.setPageNo(0);
    pagination.setRecords(billingManager.createStatementData(companyId,matchNum,beginDate,endDate));
    statementList = new Vector(pagination.nextPage());
  }
  else
  {
    if (type.equals("N"))
    {
      statementList = new Vector(pagination.nextPage());
    }
    else if (type.equals("P"))
    {
      statementList = new Vector(pagination.previousPage());
    }
  }
%>
<table border="1" width="95%" align=center>
<tr>
    <td width="15%">服務報表編號</td>
        <td width="7%">創建日期</td>
        <td width="20%">運輸公司編號</td>
        <td width="25%">運輸公司名稱</td>
        <td width="30%">總金額 (港幣)</td>
    </tr>
<%


for(int i=0;(!statementList.isEmpty()) && i<statementList.size();i++)
{
 statementDataModel = (StatementDataModel)statementList.get(i);
 String companyId = statementDataModel.getTruckCompanyNo();
 String companyName = dbList.getCompanyName(companyId,"");

 %>
   <tr>
      <td><%=statementDataModel.getStatementNo()%></td>
      <td><%=statementDataModel.creationDate%></td>
      <td><%=statementDataModel.getTruckCompanyNo()%></td>
      <td><%=companyName%></td>
      <td><%=statementDataModel.getTotalPrice()%></td>
    </tr>
<%}
%>

</table>

    <table width="95%" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="74%" class="unnamed1">
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="GenerateResult.jsp?type=P">前一页</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="GenerateResult.jsp?type=N">后一页</a>
          <%
          }
          %>
        </td>
        <td width="12%" class="unnamed1">
          <div align="left">第<%=pagination.getPageNo()%>页 </div>
        </td>
        <td width="14%" class="unnamed1">
          <div align="right">总数：<%=pagination.getPageSum()%>页</div>
        </td>
      </tr>

    </table>
    <%}
catch (Exception e)
{response.sendRedirect("ErrorPage.jsp?errorMessage=ST_0008");}%>
<p>&nbsp;</p>
</body>

</html>
<%}%>







