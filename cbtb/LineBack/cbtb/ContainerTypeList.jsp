<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="containerTypeBean" scope="page" class="com.cbtb.javabean.ContainerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>



<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨櫃種類數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="ContainerTypeAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨櫃種類數據維護</font></p>

<form method="post" action="ContainerTypeList.jsp">

<table border="0" width="75%">
  <tr>
    <td>
      <div align="right">貨櫃種類:</div>
    </td>
    <td>
      <select name="containerTypeId" >
        <%=dbList.getContainerTypeList("","")%>
      </select>
    </td>
    <td>
      <div align="right">拖架種類:</div>
    </td>
    <td>
      <select name="trailerTypeId" >

        <%=dbList.getTrailerTypeList("","")%>

      </select>
    </td>
    <td><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif">
      <input
        type="submit" name="Submit" value="查詢" >
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
    <td width="29%" align="center"><font face="Arial, Helvetica, sans-serif">
      貨櫃種類編號</font> </td>
    <td width="29%" align="center">貨櫃種類英文描述</td>
    <td width="29%" align="center">貨櫃種類中文描述</td>
    <td width="15%" align="center">拖架種類</td>
    <td width="29%" align="center">基本貨櫃種類編號</td>
    <td width="15%" align="center">倍數</td>
    <td width="10%" align="center">狀況</td>
  </tr>
          <%String type = request.getParameter("type");

   	   String s_containerTypeId,s_trailerTypeId,s_desc,s_chineseDesc,s_status,s_trailerTypeDesc;
           String s_baseTypeId,s_multiple,s_statusDesc;
	   String sql_ContainerType="";
	   String sql_TrailerType="";
           Vector containerTypes =new Vector();
          try{
               if (type == null  )
              {

	   s_containerTypeId=request.getParameter("containerTypeId");
	   s_trailerTypeId=request.getParameter("trailerTypeId");
	   if (s_containerTypeId.equals("Any"))
		sql_ContainerType="";
	   else
		sql_ContainerType=" and CONTAINER_TYPE.CONTAINER_TYPE_ID ='" +s_containerTypeId + "'";

	   if (s_trailerTypeId.equals("Any"))
		sql_TrailerType="";
	   else
		sql_TrailerType=" and CONTAINER_TYPE.TRAILER_ID ='" +s_trailerTypeId+ "'";

   	       containerTypeBean.InitContent();
               pagination.setPageNo(0);
               pagination.setRecords(containerTypeBean.containerTypeQueryByCondition(sql_ContainerType+sql_TrailerType));
               containerTypes =(Vector)pagination.nextPage();
              }
           else
              {
               if (type.equals("N"))
                   {
                    containerTypes=null;
                    containerTypes = (Vector)pagination.nextPage();
                   }
               else if (type.equals("P"))
                   {
                    containerTypes = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    containerTypes =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    containerTypes =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     containerTypes =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }

           ContainerTypeTrailerModel ctModel=new ContainerTypeTrailerModel();

           for (int i = 0;  (!containerTypes.isEmpty()) && i < containerTypes.size(); i++)
               {
                 ctModel=(ContainerTypeTrailerModel)containerTypes.get(i);
                 s_containerTypeId=ctModel.containerTypeId;
                 s_trailerTypeId=ctModel.trailerId;
                 s_desc=ctModel.containerTypeDesc;
                 s_trailerTypeDesc=ctModel.trailerChineseDesc;
                 s_chineseDesc=ctModel.containerTypeChineseDesc;
 		 s_baseTypeId=ctModel.baseContainerTypeId;
                 s_multiple=ctModel.multiple.toString();
                 s_status=ctModel.recordStatus;
%>
        <tr>
<%

		 if (s_status.equals(constant.MASTER_CODE_ACTIVE))  {
		   s_statusDesc="正常";
%>
          <td width="78"   height="30" >
            <div align="center"><font size="2"><a href="ContainerTypeView.jsp?containerTypeId=<%=s_containerTypeId%>&trailerTypeId=<%=s_trailerTypeId%>&baseTypeId=<%=s_baseTypeId%>&desc=<%=s_desc%>&status=<%=s_status%>&multiple=<%=s_multiple%>"    ><%=s_containerTypeId%>
              </a> </font></div>
          </td>
<%}
		 else  {
		   s_statusDesc="刪除";
         %>

          <td width="78"   height="30" >
            <div align="center"> <%=s_containerTypeId%> </div>
          </td>
<%}%>

          <td width="108"   height="30" >
            <div align="center"><font size="2"><%=s_desc%>&nbsp;</font></div>
          </td>
          <td width="126"   height="30" >
            <div align="center"><font size="2"><%=s_chineseDesc%>&nbsp;</font></div>
          </td>
          <td width="75"   height="30" >
            <div align="center"><font size="2"><%=s_trailerTypeDesc%>&nbsp;</font></div>
          </td>
          <td width="75"   height="30" >
            <div align="center"><font size="2"><%=s_baseTypeId%>&nbsp;</font></div>
          </td>
          <td width="75"   height="30" >
            <div align="center"><font size="2"><%=s_multiple%>&nbsp;</font></div>
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
          <a href="ContainerTypeList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> <a href="ContainerTypeList.jsp?type=P&init=Y">前一頁</a>
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="ContainerTypeList.jsp?type=N&init=Y">後一頁</a> <a href="ContainerTypeList.jsp?type=E&init=Y">最後一頁</a>
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

<%}%>

<input type="hidden" name="init" value="notfirst">
</form>
</body>

</html>
