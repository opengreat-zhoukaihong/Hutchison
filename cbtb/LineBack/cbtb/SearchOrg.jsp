<%@ include file="Init.jsp"%>  


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*" %>

<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<%@ page import="com.cbtb.util.*" %>
<html>
<head>
<title>用戶查詢</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_USER"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>



 <% 
 String  init=request.getParameter("init");
 String  companyId=request.getParameter("companyId");
 String  companyName=request.getParameter("companyName");
 String  contactPerson=request.getParameter("contactPerson");
 String  telephoneNo=request.getParameter("telephoneNo");
 String  faxNo=request.getParameter("faxNo");
 String  HKMobileNo=request.getParameter("HKMobileNo");
 String  truckerName=request.getParameter("truckerName");
 String  HKPlateNo=request.getParameter("HKPlateNo");
 String  HKLicenseNo=request.getParameter("HKLicenseNo");
 String  truckerId =request.getParameter("truckerId");
 String  refNum=request.getParameter("refNum");

  %>
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
    <td height="30"><font face="Arial, Helvetica, sans-serif">用戶查詢</font></td>
    <td height="11"> 
      <div align="right"><a href="RegAdd.jsp"><font
color="#003366" face="Arial, Helvetica, sans-serif">創建公司</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font>
<%if(init==null){%><a href="index.jsp"><%}else{%><a href="SearchOrg.jsp"><%}%>
<font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>

<FORM method="post" action="SearchOrg.jsp">
<input type="hidden" name="init" value="notfirst">
<table border="0" width="90%">
  <tr> 
    <td>公司編號： </td>
    <td>
      <input type="text" size="20" name="companyId">
    </td>
    <td>公司名稱：</td>
    <td>
      <input type="text" size="20" name="companyName">
    </td>
  </tr>
  <tr> 
    <td>聯絡人：</td>
    <td>
      <input type="text" size="20" name="contactPerson">
    </td>
    <td>聯絡電話號碼：</td>
    <td>
      <input type="text" size="20" name="telephoneNo">
    </td>
  </tr>
  <tr> 
    <td>聯絡傳真：</td>
    <td>
      <input type="text" size="20" name="faxNo">
    </td>
    <td>手提電話號碼：</td>
    <td>
      <input type="text" size="20" name="HKMobileNo">
    </td>
  </tr>
  <tr> 
    <td>司機姓名：</td>
    <td>
      <input type="text" size="20" name="truckerName">
    </td>
    <td>香港車牌號碼：</td>
    <td>
      <input type="text" size="20" name="HKPlateNo">
    </td>
  </tr>
  <tr> 
    <td>貨櫃車編號：</td>
    <td>
      <input type="text" size="20" name="truckerId">
    </td>
    <td>香港駕駛執照號碼：</td>
    <td>
      <input type="text" size="20" name="HKLicenseNo">
    </td>
  </tr>
  <tr> 
    <td>註冊參考編號：</td>
    <td>
      <input type="text" size="20" name="refNum">
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <input type="submit" name="B1"
            value="查詢">
      <input type="reset"
            name="Submit2" value="重設">
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</FORM>
<% 
if (!(init==null))
  {
   
  CompanyManager companyManager = webOperator.getCompanyManager();
  Vector userInfos =new Vector();
  String type = request.getParameter("type");
  String andTrucker="N";
        
           if (type == null  )
              {
               pagination.setPageNo(0);
               pagination.setRecords(companyManager.getUserInfoByCondition( companyId,companyName,contactPerson,telephoneNo,faxNo,HKMobileNo,truckerName,HKPlateNo, null,refNum,HKLicenseNo,truckerId,null));
               userInfos = new Vector(pagination.nextPage());
 
              }
           else
              {
               if (type.equals("N"))
                   {
                    userInfos = new Vector(pagination.nextPage());
                   }
               else if (type.equals("P"))
                   {
                    userInfos = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    userInfos =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    userInfos =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     userInfos =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
	Hashtable   userInfo ;
if(!userInfos.isEmpty()){
userInfo =(Hashtable)userInfos.get(0);
andTrucker = (String)userInfo.get("andTrucker");
}

%>
<table border="1" width="98%" align="center">
  <tr> 
    <td> 
      <div align="center">公司編號</div>
    </td>
    <td> 
      <div align="center">公司名稱</div>
    </td>
    <td> 
      <div align="center">貨櫃車編號</div>
    </td>
    <td> 
      <div align="center">貨櫃車司機姓名</div>
    </td>
    <td> 
      <div align="center">香港車牌號碼</div>
    </td>
    <td> 
      <div align="center">聯絡人</div>
    </td>
    <td> 
      <div align="center">聯絡電話號碼</div>
    </td>
<%if(andTrucker=="Y"){%>
    <td> 
      <div align="center">聯絡手機號碼</div>
    </td>
<%}else{%>
    <td> 
      <div align="center">傳真號碼</div>
    </td>
<%}%>
    <td> 
      <div align="center">狀況</div>
    </td>
  </tr>
  <%  //out.print("size="+userInfos.size());
       for (int i = 0;  (!userInfos.isEmpty()) && i < userInfos.size(); i++)
       {
	  userInfo =new   Hashtable();
	  userInfo =(Hashtable)userInfos.get(i);
	  andTrucker = (String)userInfo.get("andTrucker");
         if (userInfos.size()==1){//if only one record
         //trucker 
	   if ((andTrucker=="Y")&&(userInfo.get("stauts").equals(CbtbConstant.TRUCKER_ACTIVE)))
	   {response.sendRedirect("CapacityListbyTrucker.jsp?truckerId="+userInfo.get("truckerId")+"&companyId="+userInfo.get("companyId"));}
         //trucker company
	   if ((andTrucker=="N")&&(userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER))&&(userInfo.get("stauts").equals(CbtbConstant.COMPANY_ACTIVE)))
	   {response.sendRedirect("UserSearchCompany.jsp?companyId="+userInfo.get("companyId"));}

	 //shipper company
	   if ((andTrucker=="N")&&(userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_SHIPPER))&&(userInfo.get("stauts").equals(CbtbConstant.COMPANY_ACTIVE)))
	   {response.sendRedirect("UserSearchCompanyShipper.jsp?companyId="+userInfo.get("companyId"));}

         }
  %>
  <tr 
  <%if(userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_SHIPPER))
  out.print("bgcolor=#CCCCCC");
%>>  
    <td> 
      <div align="center"><%=userInfo.get("companyId")%>&nbsp;</div>
    </td>
    <td> 
      <div align="center"> 
<%if (andTrucker=="Y"){
if ((userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER))&&(userInfo.get("stauts").equals(CbtbConstant.TRUCKER_ACTIVE))){%> <a href="UserSearchCompany.jsp?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyChineseName")%></a> 
        <%}
	else if ((userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_SHIPPER))&&(userInfo.get("stauts").equals(CbtbConstant.TRUCKER_ACTIVE))){%> <a href="UserSearchCompanyShipper.jsp?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyChineseName")%></a> 
        <%}else{
%><%=userInfo.get("companyChineseName")%>
<%}
}else{//if andTrucker else part
if ((userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER))&&(userInfo.get("stauts").equals(CbtbConstant.COMPANY_ACTIVE))){%> <a href="UserSearchCompany.jsp?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyChineseName")%></a> 
        <%}
	else if ((userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_SHIPPER))&&(userInfo.get("stauts").equals(CbtbConstant.COMPANY_ACTIVE))){%> <a href="UserSearchCompanyShipper.jsp?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyChineseName")%></a> 
        <%}else{
%><%=userInfo.get("companyChineseName")%>
<%}
}//if andTrucker end
%> &nbsp;</div>
    </td>
    <td> 
      <div align="center"><%=userInfo.get("truckerId")%>&nbsp; </div>
    </td>
    <td> 
      <div align="center"> <%if ((userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER))&&(userInfo.get("stauts").equals(CbtbConstant.TRUCKER_ACTIVE))){%><a href="CapacityListbyTrucker.jsp?truckerId=<%=userInfo.get("truckerId")%>&companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("truckerChineseName")%></a> 
        <%}else{%><%=userInfo.get("truckerChineseName")%>
<%}%>&nbsp;</div>
    </td>
    <td> 
      <div align="center"><%=userInfo.get("HKPlateNo")%>&nbsp; </div>
    </td>
    <td> 
      <div align="center"><%=userInfo.get("contactChinesePerson")%>&nbsp; </div>
    </td>
    <td> 
      <div align="center"><%=userInfo.get("telephoneNo")%>&nbsp;</div>
    </td>
<%if(andTrucker=="Y"){%>
    <td> 
      <div align="center"><%=userInfo.get("mobileNo")%>&nbsp; </div>
    </td>
<%}else{%>
    <td> 
      <div align="center"><%=userInfo.get("faxNo")%>&nbsp; </div>
    </td>
<%}%>
    <td> 
      <div align="center"><%
//      out.print(userInfo.get("andTrucker"));
if(andTrucker=="Y"){
if (userInfo.get("stauts").equals(CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS))out.print("註冊中");
if (userInfo.get("stauts").equals(CbtbConstant.TRUCKER_ACTIVE))out.print("正常");
if (userInfo.get("stauts").equals(CbtbConstant.TRUCKER_DELETE))out.print("已刪除");
if (userInfo.get("stauts").equals(CbtbConstant.TRUCKER_SUSPEND))out.print("停用");
}else{
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_BAD_LIST))out.print("黑名單");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS))out.print("註冊中");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_ACTIVE))out.print("正常");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_DELETE))out.print("已刪除");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_SUSPEND))out.print("停用");
}
%>&nbsp; </div>
    </td>
  </tr>
  <%}	//for() end
    	%> 
</table>


<table width="750" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="75%" class="unnamed1"> 
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="SearchOrg.jsp?type=F&init=p" class="unnamed1">第一頁</a> <a href="SearchOrg.jsp?type=P&init=p">前一頁</a> 
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="SearchOrg.jsp?type=N&init=p">後一頁</a> <a href="SearchOrg.jsp?type=E&init=p">最後一頁</a> 
          <%
          }
          %>
          </td>     
      
        <td width="25%" class="unnamed1">
          <div align="right">第<%=pagination.getPageNo()%>頁&nbsp;&nbsp; 總數：<%=pagination.getPageSum()%>頁</div>
        </td>
      </tr>
    </table>
<%
}//if(!init==null)
%>
<p>&nbsp;</p>
</body>

</html>