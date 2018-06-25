<%@ include file="Init.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="zoneBean" scope="page" class="com.cbtb.javabean.ZoneJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>

<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ZONE"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>區域數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="ZoneAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>
</head>

<form method="post" action="ZoneList.jsp">
<p><font face="Arial, Helvetica, sans-serif" size="3">區域數據維護</font></p>

<table border="0" width="86%">
  <tr>
    <td>
      區域:
    </td>
    <td>
      <select name="zoneIdSelect">
        <%=dbList.getZoneList("","")%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif">
      <input
        type="submit" name="Submit" value="查詢">
      </font></a></td>
    <td><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif">
      <input
        type="reset" name="Submit2" value="重設">
      </font></td>
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
      String s_zoneId,s_desc,s_chineseDesc,s_status,s_zoneDesc;
      String sql_Zone="";
      int i = 0;
      ZoneValue cityBean1=new ZoneValue();

      Vector zones =new Vector();
      try{
          if (type == null  )
          {
	      String s_zoneIdSelect=request.getParameter("zoneIdSelect");
	      if (s_zoneIdSelect.equals("Any"))
		  sql_Zone="";
	     else
		  sql_Zone=" where ZONE_DATA.ZONE_ID ='" +s_zoneIdSelect+ "'";

   	     zoneBean.InitContent();

             pagination.setPageNo(0);
             pagination.setRecords(zoneBean.queryZoneByCondition(sql_Zone));
             zones =(Vector)pagination.nextPage();
          }
          else
          {
              if (type.equals("N"))
              {
                    zones=null;
                    zones = (Vector)pagination.nextPage();
              }
              else if (type.equals("P"))
                   {
                    zones = new Vector(pagination.previousPage());
                   }
                   else if (type.equals("F"))
                        {
                         zones =new Vector(pagination.firstPage());
                        }
                       else if (type.equals("E"))
                            {
                              zones =new Vector(pagination.endPage());
                            }
                           else if (type.equals("T"))
                                {
                                  zones =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                                }
           }

           for (i = 0;(!zones.isEmpty()) && (i < zones.size());i++)
               {
                 cityBean1 = (ZoneValue)zones.get(i);
                 s_zoneId = cityBean1.zoneId;
                 s_zoneDesc = cityBean1.zoneDesc;
                 s_chineseDesc = cityBean1.zoneChineseDesc;
                 s_status = cityBean1.recordStatus;
%>
  <tr>
<%
                 if (s_status.equals(constant.MASTER_CODE_ACTIVE))  {
		   s_status="正常";

%>
    <td><a href="ZoneView.jsp?zoneId=<%=s_zoneId%>"><%=s_zoneId%></a></td>
<%}
		 if (s_status.equals(constant.MASTER_CODE_DELETED))  {
		   s_status="刪除";
       %>
    <td><%=s_zoneId%></td>
<%}%>
    <td><%= s_zoneDesc %>&nbsp;</td>
    <td><%= s_chineseDesc %>&nbsp;</td>
    <td><%= s_status %>&nbsp;</td>
  </tr>
  <%
           }
      }
      catch(Exception e){
      }
  %>

</table>

 <table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1"> 
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="ZoneList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> <a href="ZoneList.jsp?type=P&init=Y">前一頁</a> 
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="ZoneList.jsp?type=N&init=Y">後一頁</a> <a href="ZoneList.jsp?type=E&init=Y">最後一頁</a> 
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
<p>&nbsp;</p>
</body>
</html>
