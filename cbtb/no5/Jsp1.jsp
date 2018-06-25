<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,com.cbtb.ejb.entity.*, com.cbtb.ejb.session.*" %>
<jsp:useBean id="webOperator" scope="session" class="com.cbtb.web.WebOperator" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<%@ page import="com.cbtb.util.*" %>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="css/line.css" type="text/css">
</head>
 <%
String init=request.getParameter("init");
 String  companyId=request.getParameter("companyId");
 String  companyName=request.getParameter("companyName");
 String  contactPerson=request.getParameter("contactPerson");
 String  telephoneNo=request.getParameter("telephoneNo");
 String  faxNo=request.getParameter("faxNo");
 String  HKMobileNo=request.getParameter("HKMobileNo");
 String  truckerName=request.getParameter("truckerName");
 String  HKPlateNo=request.getParameter("HKPlateNo");

  %>
<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="IMAGES/logo_line.gif" width="160" height="30"></td>
  </tr>
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" width="760" height="53">
        <param name=movie value="IMAGES/AS.swf">
        <param name=quality value=high>
        <embed src="IMAGES/AS.swf" quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="760" height="53">
        </embed>
      </object></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
      <div align="right"><font color="003366" size="2"><a href="billing.htm" target="_parent">賬項</a>&nbsp|&nbsp<a href="Registration_search.htm" target="_parent">註冊</a>&nbsp|&nbsp<a href="search%20org.htm" target="_parent">用戶查詢</a>&nbsp|&nbsp<a href="search.htm" target="_parent">空車維護</a>&nbsp|&nbsp<a href="searchshipper.htm" target="_parent">送貨要求維護</a>&nbsp|&nbsp<a href="Master_Data_Maintenance.htm" target="_parent">系統數據維護</a>&nbsp|&nbsp<a href="function%20list_matching.htm" target="_parent">配對</a>&nbsp|&nbsp<a href="reports.htm" target="_parent">報表</a>&nbsp|&nbsp<a href="administration.htm" target="_parent">管理</a>&nbsp|&nbsp<a href="index.htm">退出</a></font></div>
    </td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="IMAGES/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="IMAGES/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="11"><font face="Arial, Helvetica, sans-serif">用戶確定</font></td>
    <td height="11">
      <div align="right"><a href="Registration_edit.htm"><font
color="#003366" face="Arial, Helvetica, sans-serif">創建公司</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif"> | </font><a
href="function%20list.htm"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
    </td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="IMAGES/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="IMAGES/good.jpg" width="10" height="10"></td>
  </tr>
</table>
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
    try{

  CompanyManager companyManager = webOperator.getCompanyManager();
  Vector userInfos =new Vector();
  String type = request.getParameter("type");

           if (type == null  )
              {
               pagination.setPageNo(0);
               pagination.setRecords(companyManager.getUserInfoByCondition( companyId,companyName,contactPerson,telephoneNo,faxNo,HKMobileNo,truckerName,HKPlateNo, null,null,null,null));
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
      <div align="center">聯絡人</div>
    </td>
    <td>
      <div align="center">聯絡電話號碼</div>
    </td>
    <td>
      <div align="center">聯絡傳真號碼</div>
    </td>
    <td>
      <div align="center">狀況</div>
    </td>
  </tr>
  <%  //out.print("size="+userInfos.size());
       for (int i = 0;  (!userInfos.isEmpty()) && i < userInfos.size(); i++)
       {
	  userInfo =new   Hashtable();
	  userInfo =(Hashtable)userInfos.get(i);

  %>
  <tr>
    <td>
      <div align="center"><%=userInfo.get("companyId")%>&nbsp;</div>
    </td>
    <td>
      <div align="center"> <%if (userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER)){%> <a href="UserSearchCompany.jsp?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyName")%></a>
        <%}else{%> <a href="UserSearchCompanyShipper.jsp?companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("companyName")%></a>
        <%}%> &nbsp;</div>
    </td>
    <td>
      <div align="center"><%=userInfo.get("truckerId")%>&nbsp; </div>
    </td>
    <td>
      <div align="center"> <%if (userInfo.get("companyType").equals(CbtbConstant.COMPANY_TYPE_TRUCKER)){%> <a href="UserSearchCompanyTrucker.jsp?truckerId=<%=userInfo.get("truckerId")%>&companyId=<%=userInfo.get("companyId")%>"><%=userInfo.get("truckerName")%></a>
        <%}%>&nbsp;</div>
    </td>
    <td>
      <div align="center"><%=userInfo.get("contactPerson")%>&nbsp; </div>
    </td>
    <td>
      <div align="center"><%=userInfo.get("telephoneNo")%>&nbsp;</div>
    </td>
    <td>
      <div align="center"><%=userInfo.get("faxNo")%>&nbsp; </div>
    </td>
    <td>
      <div align="center"><%
//      out.print(userInfo.get("andTrucker"));
String andTrucker = (String)userInfo.get("andTrucker");
if(andTrucker=="Y"){
if (userInfo.get("stauts").equals(CbtbConstant.TRUCKER_DELETE))out.print("DELETED");
else
out.print("ACTIVED");
}else{
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_BAD_LIST))out.print("BAD");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_REGISTRATION_IN_PROGRESS))out.print("REGISTRATING");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_ACTIVE))out.print("ACTIVED");
if (userInfo.get("stauts").equals(CbtbConstant.COMPANY_DELETE))out.print("DELETED");
}
%>&nbsp; </div>
    </td>
  </tr>
  <%}	//for() end
}//try() end
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
