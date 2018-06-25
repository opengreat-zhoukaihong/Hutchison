<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="depotBean" scope="page" class="com.cbtb.javabean.DepotJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","DEPOT"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨場數據維護</title>

</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="DepotAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨場數據維護</font></p>

<form method="post" action="DepotList.jsp">
<table border="0" width="46%">
  <tr>
    <td>貨場:<td>
    <td>
      <select name="depotIdSelect">
      <%=dbList.getDepotList("","")%>
      </select>
    </td>
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
<% String init=request.getParameter("init");
if (!(init==null))
 {
%>
<table border="1" width="75%">
  <tr>
    <td>編號</td>
    <td>英文描述</td>
    <td>中文描述</td>
    <td>狀況</td>
    <td>優先權</td>
  </tr>
          <%String type = request.getParameter("type");
   	   String s_depotId,s_depotDesc,s_depotChineseDesc,s_recordStatus,s_priority;
           String s_recordStatusDesc="";
	   String sql_depot="";
           Vector depots =new Vector();
          try{
               if (type == null  )
              {
	   String s_depotIdSelect=request.getParameter("depotIdSelect");
	   if (s_depotIdSelect.equals("Any"))
		sql_depot="";
	   else
		sql_depot=" AND DEPOT_ID ='" +s_depotIdSelect + "'";
               depotBean.InitContent();
               pagination.setPageNo(0);
               pagination.setRecords(depotBean.depotQueryByCondition(sql_depot));
               depots =(Vector)pagination.nextPage();
              }
           else
              {
               if (type.equals("N"))
                   {
                    depots=null;
                    depots = (Vector)pagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    depots = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    depots =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    depots =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     depots =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
	   DepotValue depotValue =new DepotValue();
           for (int i = 0;  (!depots.isEmpty()) && i < depots.size(); i++)
               {
                 depotValue=(DepotValue)depots.get(i);
                 s_depotId=depotValue.depotId;
                 s_depotDesc=depotValue.depotDesc;
                 s_depotChineseDesc=depotValue.depotChineseDesc;
                 s_recordStatus=depotValue.recordStatus;
                 s_priority=depotValue.priority.toString();
%>
  <tr>
<%
		 if (s_recordStatus.equals(constant.MASTER_CODE_ACTIVE)) {
		   s_recordStatusDesc="正常";
%>
<td><a href="DepotView.jsp?depotId=<%=s_depotId%>&priority=<%=s_priority%>"><%=s_depotId%></a></td>
    <td><%=s_depotDesc%>&nbsp</td>
<%}
		 if (s_recordStatus.equals(constant.MASTER_CODE_DELETED)) {
		   s_recordStatusDesc="刪除";
         %>

<td><%=s_depotId%></td>
    <td><%=s_depotDesc%>&nbsp</td>
<%}%>
    <td><%=s_depotChineseDesc%>&nbsp</td>
    <td><%=s_recordStatusDesc%>&nbsp</td>
    <td><%=s_priority%>&nbsp</td>
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
          <a href="DepotList.jsp?type=F&init=tmd" class="unnamed1">第一頁</a> <a href="DepotList.jsp?type=P&init=tmd">前一頁</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="DepotList.jsp?type=N&init=tmd">後一頁</a> <a href="DepotList.jsp?type=E&init=tmd">最後一頁</a>
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


<p>&nbsp;</p>
</form>
</body>
</html>
