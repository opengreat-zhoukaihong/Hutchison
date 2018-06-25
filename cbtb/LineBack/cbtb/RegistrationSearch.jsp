<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*" %>

<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<%@ page import="com.cbtb.util.*" %>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","COMPANY_REGISTRATION"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

  <html>
<head>

<LINK href="../css/line.css" rel=stylesheet>
<title>Information</title>
</head>



<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../include/head.jsp"%>


<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="11"><font face="Arial, Helvetica, sans-serif">註冊</font> </td>
    <td height="11"> 
      <div align="right"><a href="RegAdd.jsp?back=reg"><font
color="#003366" face="Arial, Helvetica, sans-serif">創建公司</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font><a
href="index.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>

<FORM method="post" action="RegistrationSearch.jsp">
<input type="hidden" name="init" value="notfirst">
<table border="0" width="75%">
    <tr>
        <td><input type="radio" name="selectType"
        value="Tcom" checked> 運輸公司 </td>
        <td>
      <input type="radio" name="selectType"
        value="Trucker">
       司機 </td>
        <td>
      <input type="radio" name="selectType"
        value="Shipper">
       付貨人 </td>
        <td>
      <input type="radio" name="selectType"
        value="Reg">
       註冊中</td>
    </tr>
</table>

<table border="0" width="98%" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td width="16%">公司編號：</td>
    <td width="16%">註冊參考編號：</td>
    <td width="16%">司機姓名：</td>
    <td width="16%">香港駕駛執照號碼：</td>
    <td width="15%">香港車牌號碼：</td>
    <td width="14%">公司名稱</td>
    <td width="7%">排序：</td>
  </tr>
  <tr> 
    <td width="16%"> 
      <input type="text" size="15" name="companyId">
    </td>
    <td width="16%"> 
      <input type="text" size="15" name="refNum">
    </td>
    <td width="16%"> 
      <input type="text" size="15" name="truckerName">
    </td>
    <td width="16%"> 
      <input type="text" size="15" name="HKLicenseNo">
    </td>
    <td width="15%"> 
      <input type="text" size="15" name="HKPlateNo">
    </td>
    <td width="14%">
      <input type="text" size="15" name="companyName">
    </td>
    <td width="7%">
      <select name="orderBy" size="1">
          <option value="company_id">按公司編號排</option>
          <option value="trucker_id">按司機編號排</option>
        </select>
    </td>
  </tr>
  <tr> 
    <td width="16%"><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif"> 
      <input
        type="submit" name="Submit" value="查詢">
      </font><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif"> 
      <input
        type="reset" name="Submit2" value="重設">
      </font></td>
    <td width="16%">&nbsp;</td>
    <td width="16%">&nbsp;</td>
    <td width="16%">&nbsp;</td>
    <td width="15%">&nbsp; </td>
    <td width="14%">&nbsp;</td>
    <td width="7%">&nbsp;</td>
  </tr>
</table>
</FORM>
<% 
 String init=request.getParameter("init");
 String  companyId=request.getParameter("companyId");
 String  refNum=request.getParameter("refNum");
 String  selectType=request.getParameter("selectType");
 String  companyName=request.getParameter("companyName");
 String  HKLicenseNo=request.getParameter("HKLicenseNo");
 String  orderBy=request.getParameter("orderBy");
 String  truckerName=request.getParameter("truckerName");
 String  HKPlateNo=request.getParameter("HKPlateNo");
 
if (!(init==null))
  {
   
  CompanyManager companyManager = webOperator.getCompanyManager();
  Vector userInfos =new Vector();
  String type = request.getParameter("type");
        
           if (type == null  )
              {
               pagination.setPageNo(0);
               pagination.setRecords(companyManager.getUserInfoByCondition( companyId,companyName,null,null,null,null,truckerName,HKPlateNo, selectType,refNum,HKLicenseNo,null,orderBy));
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
%>
<hr>

<table border="1" width="100%">
  <tr> 
    <td>公司編號 / 註冊參考編號</td>
    <td>公司名稱</td>
    <td>貨櫃車編號</td>
    <td>司機姓名</td>
    <td>聯絡人</td>
    <td>電話號碼</td>
    <td>公司類型</td>
    <td>車牌號碼</td>
    <td>狀況</td>
  </tr>
 
  <%  //out.print("size="+userInfos.size());
       for (int i = 0;  (!userInfos.isEmpty()) && i < userInfos.size(); i++)
       {
	  userInfo =new   Hashtable();
	  userInfo =(Hashtable)userInfos.get(i);

  %>
  <tr> 
    <td> 
      <div align="center"><a href="<%=userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER)?"RegistrationTruckerView.jsp":"RegistrationShipperView.jsp"%>?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyId")%>&nbsp;/&nbsp;<%=userInfo.get("refNum")%></a>&nbsp;</div>
    </td>
    <td><%=userInfo.get("companyChineseName")%>&nbsp;</td>
    <td> 
      <div align="center"><%=userInfo.get("truckerId")%>&nbsp;</div>
    </td>

    <td><a href="TruckerUpdateView.jsp?companyId=<%=userInfo.get("companyId")%>&companyName=<%=userInfo.get("companyChineseName")%>&operate=update&truckerId=<%=userInfo.get("truckerId")%>"><%=userInfo.get("truckerChineseName")%></a>&nbsp;</td>
    <td><%=userInfo.get("contactChinesePerson")%>&nbsp;</td>
    <td><%=userInfo.get("telephoneNo")%>&nbsp;</td>
    <td> 
      <div align="center">
      <%if (userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER)){%>運輸公司
      <%}else{%>付貨人公司      <%}%> &nbsp;</div>
    </td>
    <td><%=userInfo.get("HKPlateNo")%>&nbsp;</td>
    <td> 
      <div align="center"><%
//      out.print(userInfo.get("andTrucker"));
String andTrucker = (String)userInfo.get("andTrucker");
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

<table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1"> 
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="RegistrationSearch.jsp?type=F&init=p" class="unnamed1">第一頁</a> <a href="RegistrationSearch.jsp?type=P&init=p">前一頁</a> 
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="RegistrationSearch.jsp?type=N&init=p">後一頁</a> <a href="RegistrationSearch.jsp?type=E&init=p">最後一頁</a> 
          <%
          }
          %>
          </td>     
      
        <td width="9%" class="unnamed1">
          <div align="left">第<%=pagination.getPageNo()%>頁 </div>
        </td>
        <td width="15%" class="unnamed1">
          <div align="right">總數：<%=pagination.getPageSum()%>頁</div>
        </td>
      </tr>
    </table>
<%
}//if(!init==null)
%>
<p>&nbsp;</p>
</body>

</html>








