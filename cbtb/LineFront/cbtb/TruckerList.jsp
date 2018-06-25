<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.model.TruckerDataModel"%>
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="newPagination" scope ="session" class="com.cbtb.util.NewPagination"/>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>
<%@ include file="Init.jsp"%>
<%
String language = "CH";
String ts="";

webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRUCKER"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (!webOperator.checkPermission())
   response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
  else
  {
CompanyProfileModel companyProfileModel=new CompanyProfileModel();
companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
String companyId=companyProfileModel.getCompanyId();
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/headtrucker.jsp"%>
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

    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#667852">建立司機</font></b></font></td>
      <td width="57%">

      <div align="right"><a
href="TruckerAdd.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">創建司機</font></a><font
color="#003366" face="Arial, Helvetica, sans-serif"> | </font><a
href="indexTrucking.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
      </td>
    </tr>
  </table>
<form action="TruckerList.jsp" name="frm" >
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
    <td> <font size="2"
face="Arial, Helvetica, sans-serif">公司編號：</font><font size="2"
face="Arial, Helvetica, sans-serif"><%=companyId%></font> </td>
  </tr>
</table>
<table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><font size="2">公司名稱： </font></td>
    <td><font size="2"><%=dbList.getCompanyName(companyId,language)%></font></td>
    <input type="hidden" name="companyId" value="<%=companyId%>">
    <td><font size="2">聯絡人： </font></td>
    <td><font size="2"><%=companyProfileModel.getContactChinesePerson()%></font></td>
    <td><font size="2">手提電話號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getMobileNo()%> </font></td>
  </tr>
  <tr>
    <td><font size="2">電話號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getTelephoneNo()%> </font></td>
    <td><font size="2">傳真號碼：</font></td>
    <td><font size="2"><%=companyProfileModel.getFaxNo()%> </font></td>
    <td><font size="2">電郵地址：</font></td>
    <td><font size="2"><%=companyProfileModel.getEmailAddr()%></font></td>
  </tr>
</table>

<hr>
<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0">
    <td>貨櫃車編號</td>
    <td>司機姓名</td>
    <td>香港車牌號碼</td>
    <td>内地車牌號碼</td>
    <td>狀況</td>
    <td>最後更改日期</td>
  </tr>
<%
    ArrayList tdms = new ArrayList();
    String type = request.getParameter("type");
    if (type == null)
    {

      MasterManager masterManager = webOperator.getMasterManager();
      ArrayList tdmList = new ArrayList();
      tdmList=(ArrayList)dbList.searchTruckerByCompanyId(companyId);
      newPagination.setPageNo(0);
      newPagination.setRecords(tdmList);
      tdms = (ArrayList)newPagination.nextPage();
    }
    else
    {
      if (type.equals("N"))
      {
        tdms = (ArrayList)newPagination.nextPage();
      }
      else if(type.equals("P"))
      {
        tdms = (ArrayList)newPagination.previousPage();
      }
      else if(type.equals("F"))
      {
        tdms = (ArrayList)newPagination.firstPage();
      }
      else if (type.equals("E"))
      {
        tdms = (ArrayList)newPagination.endPage();
      }
      else if (type.equals("T"))
      {
        tdms = new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
      }
    }
    boolean color = true;
    for (int i=0;(!tdms.isEmpty())&&(i<tdms.size());i++)
    {
      TruckerDataModel tdm = new TruckerDataModel();
      tdm = (TruckerDataModel)tdms.get(i);
      if (CbtbConstant.TRUCKER_ACTIVE.equalsIgnoreCase(tdm.getTruckStatus())) ts="正常";
      if (CbtbConstant.TRUCKER_DELETE.equalsIgnoreCase(tdm.getTruckStatus())) ts="已刪除";
      if (CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS.equalsIgnoreCase(tdm.getTruckStatus())) ts="註冊中";
      if (CbtbConstant.TRUCKER_SUSPEND.equalsIgnoreCase(tdm.getTruckStatus())) ts="暫停";
     if(color)
	{
	out.write("<tr>");
	color = false;
	}
	else
	{
	out.write("<tr bgcolor=\"#ddffdd\">");
	color = true;
	}
%>
<td><a href="TruckerUpdateView.jsp?truckerId=<%=tdm.getTruckerId()%>"><%=tdm.getTruckerId()%></a></td>
<td><%=tdm.getTruckerChineseName()%></td>
<td><%=tdm.getHkPlateNo()%></td>
<td><%=tdm.getInlandPlateNo()%></td>
<td><%=ts%></td>
<td><%=tdm.getCreationDate().toString().substring(0,10)%></td>
</tr>
<%}%>
</table>
<hr>
 <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1">
          <%
          if (newPagination.getPageNo() > 1)
          {
            %>
          &nbsp;&nbsp;<a href="TruckerList.jsp?type=F" class="unnamed1"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;<a href="TruckerList.jsp?type=P"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
            %>
          &nbsp;&nbsp;<a href="TruckerList.jsp?type=N"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;<a href="TruckerList.jsp?type=E"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a>
          <%
          }
          %>
          <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp;總數：<%=newPagination.getPageSum()%>頁</div>
        </td>
      </tr>
    </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>
<table width="342" border="0" align="center">
  <tr>
          <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
            <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
            2001 LINE. All Rights Reserved</font></font> </td>
        </tr>
      </table>
<%}%>
</body>
</html>