<%@ include file="Init.jsp"%>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="cityBean" scope="page" class="com.cbtb.javabean.CityJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>

<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CITY"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>城市數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="CityAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">城市數據維護</font></p>

<form method="post" action="CityList.jsp">

<table border="0" width="75%">
  <tr>
    <td>
      <div align="right">城市:</div>
    </td>
    <td>
      <select name="cityIdSelect" > 
        <%=dbList.getCityList("","")%>  
      </select> 
    </td>
    <td>
      <div align="right">區域:</div>
    </td>
    <td>
      <select name="zoneIdSelect" > 
        <%=dbList.getZoneList("","")%>  
      </select> 
    </td>
    <td><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif">
      <input   type="submit" name="Submit" value="查詢" >
      </font></a>
   </td>
    <td><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif">
      <input   type="reset" name="Submit2" value="重設">
      </font>
    </td>
  </tr>
</table>
<hr>
<% String init=request.getParameter("init");
if (!(init==null))
 {
%>
<table border="1" width="75%">
  <tr>
    <td><div align="center">編號</div></td>
    <td><div align="center">英文描述</div></td>
    <td><div align="center">中文描述</div></td>
    <td><div align="center">區域</div></td>
    <td><div align="center">狀況</div></td>
  </tr>
         <%
           String type = request.getParameter("type");
	   String s_cityId,s_zoneId,s_desc,s_chineseDesc,s_status,s_zoneDesc;
	   String sql_City="";
	   String sql_Zone="";
	   String s_statusDesc="";
           Vector citys =new Vector();
           try{
           if (type == null  )
           {
	   String s_cityIdSelect=request.getParameter("cityIdSelect");
	   String s_zoneIdSelect=request.getParameter("zoneIdSelect");
	   if (s_cityIdSelect.equals("Any"))
		sql_City="";
	   else
		sql_City=" and CITY_DATA.CITY_ID ='" +s_cityIdSelect + "'";
	   if (s_zoneIdSelect.equals("Any"))
		sql_Zone="";
	   else
		sql_Zone=" and CITY_DATA.ZONE_ID ='" +s_zoneIdSelect+ "'";
           cityBean.InitContent();
           pagination.setPageNo(0);
           pagination.setRecords(cityBean.queryCityByCondition(sql_City+sql_Zone));
           citys =(Vector)pagination.nextPage();
           }
           else
            {
               if (type.equals("N"))
                   {
                    citys=null;
                    citys = (Vector)pagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    citys = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    citys =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    citys =new Vector(pagination.endPage());
                   }
               }
            CityZoneModel cityBean1=new CityZoneModel();
            for (int i = 0;  (!citys.isEmpty()) && i < citys.size(); i++)
               {
                 cityBean1=(CityZoneModel)citys.get(i);
                 s_cityId=cityBean1.cityId;
                 s_zoneId=cityBean1.zoneId;
                 s_desc=cityBean1.cityDesc;
                 s_zoneDesc=cityBean1.zoneChineseDesc;
                 s_chineseDesc=cityBean1.cityChineseDesc;
                 s_status=cityBean1.recordStatus;
%>
        <tr>
<%
		 if (s_status.equals(constant.MASTER_CODE_ACTIVE)) {
		   s_statusDesc="正常";
%>
          <td width="78"   height="30" >
            <div align="center"><font size="2">
<a href="CityView.jsp?cityId=<%=s_cityId%>&zoneId=<%=s_zoneId%>"><%=s_cityId%>
              </a> </font></div>
          </td>
<%}
		 if (s_status.equals(constant.MASTER_CODE_DELETED)) {
		   s_statusDesc="刪除";
         %>

          <td width="78"   height="30" >
            <div align="center"><%=s_cityId%></div>
          </td>
<%}%>
          
          <td width="108"   height="30" >
            <div align="center"><font size="2"><%=s_desc%>&nbsp;</font></div>
          </td>
          <td width="126"   height="30" >
            <div align="center"><font size="2"><%=s_chineseDesc%>&nbsp;</font></div>
          </td>
          <td width="75"   height="30" >
            <div align="center"><font size="2"><%=s_zoneDesc%>&nbsp;</font></div>
          </td>
          <td width="66"   height="30" >
            <div align="center"><font size="2"><%=s_statusDesc%>&nbsp;</font></div>
	  </td>
        </tr>
         <%}}catch(Exception e){}
    	%>
      </table>

<table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1"> 
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="CityList.jsp?type=F&init=A" class="unnamed1">第一頁</a> <a href="CityList.jsp?type=P&init=A">前一頁</a> 
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="CityList.jsp?type=N&init=A">后一頁</a> <a href="CityList.jsp?type=E&init=A">最後一頁</a> 
          <%
          }
          %>
          </td>     
      
        <td width="9%" class="unnamed1">
          <div align="left">第<%=pagination.getPageNo()%>頁</div>
        </td>
        <td width="15%" class="unnamed1">
          <div align="right">總數：<%=pagination.getPageSum()%>頁</div>
        </td>
      </tr>
    </table>

<%}%>

<input type="hidden" name="init" value="notfirst">
</form>
</body>
</html>
