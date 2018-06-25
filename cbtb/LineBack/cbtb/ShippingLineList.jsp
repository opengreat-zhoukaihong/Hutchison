<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="shippingLineBean" scope="page" class="com.cbtb.javabean.ShippingLineJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","SHIPPING_LINE"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>航運公司數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<body bgcolor="#FFFFFF">
<p align="right"><a href="ShippingLineAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">航運公司數據維護</font></p>

<form method="post" action="ShippingLineList.jsp">

 <table border="0" width="75%">
    <tr> 
      <td> 航運公司: 
        <select name="shippingLineIdSelect" >
          <%=dbList.getShippingLineList("","")%> 
        </select>
      </td>
      <td width="44%"> 
        <div align="right"><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif"> 
          <input
        type="submit" name="Submit" value="查詢" >
          <input
        type="reset" name="Submit2" value="重設">
          </font><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif"> </font></div>
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
    <td align="center">航運公司編號</td>
    <td align="center">英文描述</td>
    <td align="center">中文描述</td>
    <td align="center">狀況</td>
  </tr>
          <%String type = request.getParameter("type");

   	   String s_shippingLineId,s_desc,s_chineseDesc,s_status,s_statusDesc;
	   String sql_ShippingLine="";
           Vector shippingLines =new Vector();
          try{
               if (type == null  )
              {
	   String s_shippingLineIdSelect=request.getParameter("shippingLineIdSelect");
	   if (s_shippingLineIdSelect.equals("Any"))
		sql_ShippingLine="";
	   else
		sql_ShippingLine=" and SHIPPING_LINE_ID='" +s_shippingLineIdSelect + "'";

   	   shippingLineBean.InitContent();


               pagination.setPageNo(0);
               pagination.setRecords(shippingLineBean.sippingLineQueryByCondition(sql_ShippingLine));

               shippingLines =(Vector)pagination.nextPage();
              }
           else
              {
               if (type.equals("N"))
                   {
                    shippingLines=null;
                    shippingLines = (Vector)pagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    shippingLines = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    shippingLines =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    shippingLines =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     shippingLines =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }

           ShippingLineValue shippingLineValue=new ShippingLineValue();
           for (int i = 0;  (!shippingLines.isEmpty()) && i < shippingLines.size(); i++)
               {
                 shippingLineValue=(ShippingLineValue)shippingLines.get(i);
                 s_shippingLineId=shippingLineValue.shippingLineId;
                 s_desc=shippingLineValue.shippingLineDesc;
                 s_chineseDesc=shippingLineValue.shippingLineChineseDesc;
                 s_status=shippingLineValue.recordStatus;
		 if (s_status.equals(constant.MASTER_CODE_ACTIVE))
		   s_statusDesc="正常";
		 else
		   s_statusDesc="刪除";
         %>
        <tr>
          <td width="78"   height="22" >
            <div align="center"><font size="2">
<% if (s_status.equals(constant.MASTER_CODE_ACTIVE)){
%>
<a href="ShippingLineView.jsp?shippingLineId=<%=s_shippingLineId%>"><%=s_shippingLineId%>
              </a> </font></div>
          </td>
<%}%>
<% if (s_status.equals(constant.MASTER_CODE_DELETED)){
%>
<%=s_shippingLineId%>
<%}%>


          <td width="108"   height="22" >
            <div align="center"><font size="2"><%=s_desc%>&nbsp;</font></div>
          </td>
          <td width="126"   height="22" >
            <div align="center"><font size="2"><%=s_chineseDesc%>&nbsp;</font></div>
          </td>
          <td width="66"   height="22" >
            <div align="center"><font size="2"><%=s_statusDesc%> &nbsp;</font></div>
	  </td>
        </tr>

         <%}}catch(Exception e){}
    	%>

      </table>


  <table width="75%" border="0" cellspacing="0" cellpadding="0" height="22">
    <tr> 
      <td width="76%" class="unnamed1" height="20"> 
        <%
          if (pagination.getPageNo() > 1)
          {
            %>
        <a href="ShippingLineList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> 
        <a href="ShippingLineList.jsp?type=P&init=Y">前一頁</a> 
        <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
        <a href="ShippingLineList.jsp?type=N&init=Y">後一頁</a> <a href="ShippingLineList.jsp?type=E&init=Y">最後一頁</a> 
        <%
          }
          %>
      </td>
      <td height="20" class="unnamed1"> 
        <div align="right">第<%=pagination.getPageNo()%>页 总数：<%=pagination.getPageSum()%>页</div>
      </td>
    </tr>
  </table>

<%}%>

<input type="hidden" name="init" value="notfirst">
</form>


</body>

</html>