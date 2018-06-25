<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>            
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="trailerTypeBean" scope="page" class="com.cbtb.javabean.TrailerTypeJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRAILER_TYPE"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>Trailer Type</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="TrailerTypeAdd.jsp"><font
color="#003366" size="2">新建 </font></a>|<a href="Trailer%20Type%20Update.html"><font
color="#003366" size="2"> </font></a> <a href="MasterDataMaintenance.jsp"><font
color="#003366" size="2">關閉</font></a></p>

<p align="left">拖架種類數據維護</p>
<form method="post" action="TrailerTypeList.jsp">
<table border="0" width="46%">
  <tr>
    <td>拖架種類：</td>

    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <select name="trailerIdSelect" size="1">
        <%=dbList.getTrailerTypeList("","")%>
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
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<hr>
<% String init=request.getParameter("init");
if (!(init==null))
 {
%>
<p>&nbsp;</p>
<div align="left">
<table border="1" width="75%">
  <tr>
    <td>編號</td>
    <td>英文描述</td>
    <td>中文描述</td>
    <td>狀況</td>
  </tr>
          <%String type = request.getParameter("type");
   	   String s_trailerId,s_trailerDesc,s_trailerChineseDesc,s_recordStatus;
           String s_recordStatusDesc="";
	   String sql_TrailerType="";
           Vector trailerTypes =new Vector();
          try{
               if (type == null  )
              {
	   String s_trailerIdSelect=request.getParameter("trailerIdSelect");
	   if (s_trailerIdSelect.equals("Any"))
		sql_TrailerType="";
	   else
		sql_TrailerType=" and TRAILER_ID ='" +s_trailerIdSelect + "'";

   	       trailerTypeBean.InitContent();
               System.out.println("test");
               pagination.setPageNo(0);
               pagination.setRecords(trailerTypeBean.trailerTypeQueryByCondition(sql_TrailerType));
               trailerTypes =(Vector)pagination.nextPage();
              }
           else
              {
               if (type.equals("N"))
                   {
                    trailerTypes=null;
                    trailerTypes = (Vector)pagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    trailerTypes = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    trailerTypes =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    trailerTypes =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     trailerTypes =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }

          TrailerTypeValue trailerTypeValue = new TrailerTypeValue();  
          for (int i = 0;  (!trailerTypes.isEmpty()) && i < trailerTypes.size(); i++)
               {
                 trailerTypeValue=(TrailerTypeValue)trailerTypes.get(i);
                 s_trailerId=trailerTypeValue.trailerId;
                 s_trailerDesc=trailerTypeValue.trailerDesc;
                 s_trailerChineseDesc=trailerTypeValue.trailerChineseDesc;
                 s_recordStatus=trailerTypeValue.recordStatus;
%>
<tr>
<%
		 if (s_recordStatus.equals(constant.MASTER_CODE_ACTIVE))
		   {s_recordStatusDesc="正常";
%>
    <td><a href="TrailerTypeView.jsp?trailerId=<%=s_trailerId%>"><%=s_trailerId%></a></td>
<%}
		 if (s_recordStatus.equals(constant.MASTER_CODE_DELETED))
		  { s_recordStatusDesc="刪除";
         %>
    <td><%=s_trailerId%></td><%}%>
    <td><%=s_trailerDesc%></td>
    <td><%=s_trailerChineseDesc%></td>
    <td><%=s_recordStatusDesc%></td>
  </tr>
<%}}catch(Exception e){}%>
</table>

<table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1">
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="TrailerTypeList.jsp?type=F&init=tmd" class="unnamed1">第一頁</a> <a href="TrailerTypeList.jsp?type=P&init=tmd">前一頁</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="TrailerTypeList.jsp?type=N&init=tmd">後一頁</a> <a href="TrailerTypeList.jsp?type=E&init=tmd">最後一頁</a>
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


</div>

<p align="left">&nbsp; </p>
</form>
</body>
</html>
