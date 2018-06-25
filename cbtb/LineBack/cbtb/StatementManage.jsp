<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%

webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","BILLING"); //加入检查的内容
webOperator.putPermissionContext("action", "search");
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");

%>

<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.cbtb.util.*"%>
<%@ page import="com.cbtb.ejb.session.*"%>
<%@ page import="com.cbtb.model.*"%>
<jsp:useBean id="statementDataModel" scope="session" class="com.cbtb.model.StatementDataModel" />
<jsp:useBean id="cbtbConstant" scope="session" class="com.cbtb.util.CbtbConstant" />

<jsp:useBean id="dbList" scope="session" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope = "session" class = "com.cbtb.util.Pagination" />
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<script Language="JavaScript" src="../js/calendarShow.js"></script>
<script Language="JavaScript" src="../js/funStrTrim.js"></script>
<script language ="javascript">
<!--

function selchange(statementNo)
{

 //paid
 var oldStatus = document.all(statementNo+"OldStatus").value;
 var canChange = true;
 newStatus = document.all(statementNo+"Status").value
 step = parseInt(newStatus,10) - parseInt(oldStatus,10) 
 absStep = Math.abs(parseInt(newStatus,10) - parseInt(oldStatus,10))
 if(oldStatus == "5")
   {
    alert("報表已付款，不能更新狀態")
    canChange = false;
   }
 //cancelld
 if(canChange && oldStatus == "0")
  {
   alert("報表已被取消，不能更新狀態");
   canChange = false;
  } 
 if(canChange && absStep>1)
  {
    alert("您只能一步一步得更形報表狀態")
    canChange = false
  }
 if(!canChange)
  {
   document.all(statementNo+"Status").value=oldStatus;
  }
 return canChange
 }

function query()
{
 statement.action = "StatementManage.jsp?type=search";
 statement.submit();
}



function docLoad()
{
 
  document.all("updateStatementNo").value="";
  document.all("newStatus").value = "";
  
}

function openpage(url)
{
  var 
newwin=window.open(url,"NewWin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes");
  return false; 
}

-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
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
    <td height="11"><font face="Arial, Helvetica, sans-serif">審核 / 更新服務報表</font></td>
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
<form method=post name=statement >
<table border="0" width="100%">
    <tr>
        <td>運輸公司編號：</td>

    <td><font face="Arial, Helvetica, sans-serif">服務報表</font>編號：</td>

    <td><font face="Arial, Helvetica, sans-serif">服務報表</font>開始日期：</td>

    <td><font face="Arial, Helvetica, sans-serif">服務報表</font>最后日期：</td>
        <td>狀況：</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><input type="text" size="12" name="companyId"></td>
        <td><input type="text" size="12" name="statementNo"></td>
    <td >
       <input type="text" maxlength="10" size="10" value="" name="beginDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(beginDate);return false" >
     </td>
    <td >
         <input type="text" maxlength="10" size="10" value="" name="toDate"  >
      <img src="../images/datetime.gif" style="cursor：hand;"  alt="弹出日历下拉菜单"
        onClick="fPopUpCalendarDlg(toDate);return false" >
     </td>
        <td><select name="status" size="1">
 <%out.println(dbList.getStatementStatusList("","",true));%>
        </select>
  </td>

        <td><input type="submit" name="Submit1" value="查詢"  onclick="javascript:return query();"></td>
        <td><input type="reset" name="Submit2" value="重设"></td>
    </tr>
</table>
</form>
<hr>


<%
try {

 Vector statementList=null;
 String type = request.getParameter("type");
  if (type != null && type.equals("search") )
  {
  String companyIdTmp = request.getParameter("companyId");
  String statementNoTmp = request.getParameter("statementNo");
  String beginDate = request.getParameter("beginDate");
  String toDate = request.getParameter("toDate");
  String statusTmp = request.getParameter("status");
  BillingManager billingManager = webOperator.getBillingManager();

  pagination.setPageNo(0);
pagination.setRecords(billingManager.searchStatementData(companyIdTmp,statementNoTmp,beginDate,toDate,statusTmp));
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
    else if (type.equals("B"))
    {
      statementList = statementList;
    }
  }
%>
<table border="1" width="100%">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif">服務報表</font>編號</td>
    <td>運輸公司名稱</td>
    <td><font face="Arial, Helvetica, sans-serif">服務報表</font>日期</td>
    <td>總金額</td>
    <td>狀況</td>
    <td>操作</td>
  </tr>
<%

for(int i=0;(!statementList.isEmpty()) && i<statementList.size();i++)
{
  statementDataModel  = (StatementDataModel)statementList.get(i);
  String companyId = statementDataModel.getTruckCompanyNo();
  String companyName =  dbList.getCompanyName(companyId,"");
  String statementNo = statementDataModel.getStatementNo();
  String statusNow = statementDataModel.getStatementStatus();
  String generated = cbtbConstant.STATEMENT_STATUS_GENERATED;
  int iGenerated = Integer.parseInt(generated);
  int iStatus = Integer.parseInt(statusNow);
 
%>
<form name=updateStatus<%=i%> method = post action =StatementApprove.jsp >

  <tr>
<td><%if (iStatus>=iGenerated) {%><a href = "StatementPrintPrepare.jsp?statementNo=<%=statementNo%>" onClick='return openpage(this.href);' target=_blank><%}%><%=statementNo%></a></td>
    <td><%=companyName%></td>
    <td><%=statementDataModel.getCreationDate()%></td>
    <td><%=statementDataModel.getTotalPrice()%></td>
    <td>
          <select name="<%=statementNo%>Status" size="1" style="width:100px"  onchange = "return selchange('<%=statementNo%>')">
      <%out.print(dbList.getStatementStatusList(statusNow,"",false));%>
      </select>
    <input type= hidden name ="<%=statementNo%>OldStatus" value = "<%=statusNow%>">
<input type = hidden name = i value = <%=i%>>    
</td>
    <td><a href="javascript:updateStatus<%=i%>.submit()">更新</a></td>
  </tr>
</form>
<%}%>
</table>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td >
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="StatementManage.jsp?type=P">前一页</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="StatementManage.jsp?type=N">后一页</a>
          <%
          }
          %>
        </td>
        <td >
          <div align="left">第<%=pagination.getPageNo()%>页 </div>
        </td>
        <td >
          <div align="right">总数：<%=pagination.getPageSum()%>页</div>
        </td>
      </tr>

    </table><p>&nbsp;</p>
<%
}
catch (Exception e)
{}%>
</body>
</html>








