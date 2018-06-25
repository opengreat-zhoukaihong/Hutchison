<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="cargoCategoryBean" scope="page" class="com.cbtb.javabean.CargoCategoryJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","CARGO_CATEGORY"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨物種類數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="CargoCategoryAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">貨物種類數據維護</font></p>
<form method="post" action="CargoCategoryList.jsp">
<table border="0" width="75%">
  <tr>
    <td>貨物種類:<td>
    <td>
      <select name="cargoIdSelect">
      <%=dbList.getCargoCategoryList("","")%>
      </select>
    </td>
    <td><font color="#003366" size="2" face="Arial, Helvetica, sans-serif">
          <input type="submit" name="Submit" value="查詢">
        </font></a>
    </td>
    <td><font color="#003366" size="2" face="Arial, Helvetica, sans-serif">
           <input type="reset" name="Submit2" value="重設">
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
    <td>編號</td>
    <td>英文描述</td>
    <td>中文描述</td>
    <td>狀況</td>
  </tr>
          <%String type = request.getParameter("type");
   	   String s_cargoId,s_cargoDesc,s_cargoChineseDesc,s_recordStatus;
           String s_recordStatusDesc="";
	   String sql_CargoCategory="";
           Vector cargoCategorys =new Vector();
          try{
               if (type == null  )
              {
	   String s_cargoIdSelect=request.getParameter("cargoIdSelect");
	   if (s_cargoIdSelect.equals("Any"))
		sql_CargoCategory="";
	   else
		sql_CargoCategory=" AND CARGO_ID ='" +s_cargoIdSelect + "'";
               cargoCategoryBean.InitContent();
               pagination.setPageNo(0);
               pagination.setRecords(cargoCategoryBean.cargoCategoryQueryByCondition(sql_CargoCategory));
               cargoCategorys =(Vector)pagination.nextPage();
              }
           else
              {
               if (type.equals("N"))
                   {
                    cargoCategorys=null;
                    cargoCategorys = (Vector)pagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    cargoCategorys = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    cargoCategorys =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    cargoCategorys =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     cargoCategorys =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
	   CargoCategoryValue cargoCategoryValue =new CargoCategoryValue();
           for (int i = 0;  (!cargoCategorys.isEmpty()) && i < cargoCategorys.size(); i++)
               {
                 cargoCategoryValue=(CargoCategoryValue)cargoCategorys.get(i);
                 s_cargoId=cargoCategoryValue.cargoId;
                 s_cargoDesc=cargoCategoryValue.cargoDesc;
                 s_cargoChineseDesc=cargoCategoryValue.cargoChineseDesc;
                 s_recordStatus=cargoCategoryValue.recordStatus;
%>
<tr>
<%
		 if (s_recordStatus.equals(constant.MASTER_CODE_ACTIVE))
		 {  s_recordStatusDesc="正常";%>
<td><a href="CargoCategoryView.jsp?cargoId=<%=s_cargoId%>"><%=s_cargoId%></a></td>
<%}
		 if (s_recordStatus.equals(constant.MASTER_CODE_DELETED))
		  { s_recordStatusDesc="刪除";%>
<td><%=s_cargoId%></td>
    <%} %>
    <td><%=s_cargoDesc%>&nbsp</td>
    <td><%=s_cargoChineseDesc%>&nbsp</td>
    <td><%=s_recordStatusDesc%>&nbsp</td>
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
          <a href="CargoCategoryList.jsp?type=F&init=tmd" class="unnamed1">第一頁</a> <a href="CargoCategoryList.jsp?type=P&init=tmd">前一頁</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="CargoCategoryList.jsp?type=N&init=tmd">後一頁</a> <a href="CargoCategoryList.jsp?type=E&init=tmd">最後一頁</a>
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
