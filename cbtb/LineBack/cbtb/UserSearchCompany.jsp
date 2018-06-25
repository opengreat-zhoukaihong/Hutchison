<%@ include file="Init.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*,com.cbtb.model.*" %>
<%@ page import="com.cbtb.util.*" %>

<jsp:useBean id="newPagination" scope="session" class="com.cbtb.util.NewPagination" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />


<%
webOperator.clearPermissionContext();
webOperator.putPermissionContext("document_type","COMPANY_USER");
webOperator.putPermissionContext("action", "view");
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
String languageName ="CN";
String companyId = request.getParameter("companyId");

CompanyManager companyManager = webOperator.getCompanyManager();
CompanyProfileModel companyProfileModel = new CompanyProfileModel();
companyProfileModel	=  companyManager.findCompanyProfile(companyId);
session.setAttribute("companyProfileModel",companyProfileModel);
  String type = request.getParameter("type");
  if(type == null) {
   companyProfileModel	=  companyManager.findCompanyProfile(companyId);
     session.setAttribute("companyProfileModel",companyProfileModel);   }
//  else
//      companyProfileModel = (CompanyProfileModel)session.getAttribute("companyProfileModel");

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11"><font face="Arial, Helvetica, sans-serif">登記空車列表</font> </td>
    <td height="11">
      <div align="right"><a href="CapacityAdd.jsp?companyId=<%=companyId%>"><font color="#003366">空車登記</font></a><font color="#003366"> | <a href="RegEdit.jsp?companyId=<%=companyId%>">更新註冊資料</a> | <a href="TruckerAdd.jsp?companyId=<%=companyId%>&companyName=<%=companyProfileModel.getCompanyName()%>">創建司機</a> | <a href="SearchOrg.jsp"><font color="#003366">關閉</font></a></div>
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
<p align="left"><font size="2"
face="Arial, Helvetica, sans-serif">公司編號： <%=companyId%> </font></p>

<table border="0" width="90%">
<input type="hidden" name="companyId" value="<%=companyId%>">
<input type="hidden" name="companyName" value="<%=companyProfileModel.getCompanyName()%>">
    <tr>
        <td><font size="2"><em>公司名稱： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getCompanyChineseName()%>&nbsp;</em></font></td>
        <td><font size="2"><em>公司聯絡人： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getContactChinesePerson()%>&nbsp;</em></font></td>
    </tr>
    <tr>
        <td><font size="2"><em>電話號碼：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getTelephoneNo()%>&nbsp; </em></font></td>
        <td><font size="2"><em>傳真號碼：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getFaxNo()%>&nbsp;</em></font></td>
    </tr>
    <tr>
        <td><font size="2"><em>手提電話號碼： </em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getMobileNo()%>&nbsp;</em></font></td>
        <td><font size="2"><em>電郵地址：</em></font></td>
        <td><font size="2"><em><%=companyProfileModel.getEmailAddr()%>&nbsp; </em></font></td>
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

ArrayList truckCapacitys = new ArrayList();
//truckCapacitys = (ArrayList)companyManager.searchTruckCapacity(companyId);

           if (type == null  )
              {
               newPagination.setPageNo(0);
               newPagination.setRecords((Collection)companyManager.searchTruckCapacity(companyId));
               truckCapacitys = new ArrayList(newPagination.nextPage());

              }
           else
              {
               if (type.equals("N"))
                   {
                    truckCapacitys = new ArrayList(newPagination.nextPage());
                   }
               else if (type.equals("P"))
                   {
                    truckCapacitys = new ArrayList(newPagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    truckCapacitys =new ArrayList(newPagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    truckCapacitys =new ArrayList(newPagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     truckCapacitys =new ArrayList(newPagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
	  //page
	  TruckCapacityModel  truckCapacityModel=new TruckCapacityModel();

%>
<table border="1" width="100%">
    <tr>

        <td>空車編號</td>
        <td>貨櫃車司機姓名</td>
        <td>貨櫃車牌照號碼</td>
        <td>出發地城市</td>
        <td>目的地城市</td>
        <td>拖架種類</td>
        <td>送貨日期</td>
        <td>送貨時間</td>
        <td>狀況</td>
    </tr>
<%  //out.print("size="+truckCapacitys.size());
       for (int i = 0;  (!truckCapacitys.isEmpty()) && i < truckCapacitys.size(); i++)
       {
	  truckCapacityModel =(TruckCapacityModel)truckCapacitys.get(i);

  %>    <tr>

        <td><a href="CapacityView.jsp?truckCapacityNum=<%=truckCapacityModel.getTruckCapacityNum()%>"><%=truckCapacityModel.getTruckCapacityNum()%></a></td>
        <td><%=dbList.getTruckerName(truckCapacityModel.getTruckerId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getTruckerHKPlate(truckCapacityModel.getTruckerId())%>&nbsp;</td>
        <td><%=dbList.getCityDesc(truckCapacityModel.getOriginCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getCityDesc(truckCapacityModel.getDestinationCityId(),languageName)%>&nbsp;</td>
        <td><%=dbList.getTrailerTypeDesc(truckCapacityModel.getTrailerId(),languageName)%>&nbsp;</td>
        <td><%=truckCapacityModel.getDeliveryDate().toString().substring(0,10)%>&nbsp;</td>
        <td><%=dbList.getDeliveryTimeDesc(truckCapacityModel.getDeliveryTimeId(),languageName)%>&nbsp;</td>
        <td><%if(truckCapacityModel.getTruckCapacityStatus().equals(CbtbConstant.TRUCK_CAPACITY_CANCEL))out.print("已取消");
if(truckCapacityModel.getTruckCapacityStatus().equals(CbtbConstant.TRUCK_CAPACITY_POST))out.print("已發佈");
if(truckCapacityModel.getTruckCapacityStatus().equals(CbtbConstant.TRUCK_CAPACITY_MATCH))out.print("已配對");
if(truckCapacityModel.getTruckCapacityStatus().equals(CbtbConstant.TRUCK_CAPACITY_CONFIRM))out.print("已確認");
if(truckCapacityModel.getTruckCapacityStatus().equals(CbtbConstant.TRUCK_CAPACITY_CONTAINER_PICKUP))out.print("已裝箱");
if(truckCapacityModel.getTruckCapacityStatus().equals(CbtbConstant.TRUCK_CAPACITY_CONTAINER_DELIVERED))out.print("已送貨");
%>&nbsp;</td>
    </tr>

  </tr>
  <%}	//for() end
    	%>
</table>
<table width="750" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="75%" class="unnamed1">
          <%
          if (newPagination.getPageNo() > 1)
          {
            %>
          <a href="UserSearchCompany.jsp?type=F&init=p&companyId=<%=companyId%>" class="unnamed1">第一頁</a> <a href="UserSearchCompany.jsp?type=P&init=p&companyId=<%=companyId%>">前一頁</a>
          <%
          }
          if (newPagination.getPageNo() < newPagination.getPageSum())
          {
            %>
          <a href="UserSearchCompany.jsp?type=N&init=p&companyId=<%=companyId%>">後一頁</a> <a href="UserSearchCompany.jsp?type=E&init=p&companyId=<%=companyId%>">最後一頁</a>
          <%
          }
          %>
          </td>

        <td width="25%" class="unnamed1">
          <div align="right">第<%=newPagination.getPageNo()%>頁&nbsp;&nbsp; 總數：<%=newPagination.getPageSum()%>頁</div>
        </td>
      </tr>
    </table>
<p>&nbsp;</p>
</body>
</html>
<%
System.out.println("------------UserSearchCompany.jsp--------------");
System.out.println("session.getId():"+session.getId());
System.out.println("companyProfileModel.getCompanyId():"+companyProfileModel.getCompanyId());
System.out.println("companyProfileModel.getCompanyName():"+companyProfileModel.getCompanyName());
System.out.println("companyProfileModel.getCompanyChineseName():"+companyProfileModel.getCompanyChineseName());
System.out.println("companyProfileModel.getCompanyStatus():"+companyProfileModel.getCompanyStatus());
%>