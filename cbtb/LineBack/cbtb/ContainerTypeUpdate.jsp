<%@ include file="Init.jsp"%>  
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="containerTypeBean" scope="page" class="com.cbtb.javabean.ContainerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","CONTAINER_TYPE"); 
webOperator.putPermissionContext("action", "edit"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<%
  String containerTypeData[] = new String[7];
  String backPageName="";
  containerTypeData[0]=request.getParameter("containerTypeId");
  containerTypeData[1]=request.getParameter("trailerTypeId");
  containerTypeData[2]=request.getParameter("desc");
  containerTypeData[3]=request.getParameter("chineseDesc");
  containerTypeData[4]=request.getParameter("baseTypeId");
  containerTypeData[5]=request.getParameter("multiple");
  containerTypeData[6]=constant.MASTER_CODE_ACTIVE;
  if (containerTypeBean.containerTypeUpdate(containerTypeData))
    {
    backPageName = "SuccessPage.jsp?backPage=ContainerTypeList.jsp&mode=Update";
    dbList.loadContainerTypeList();
    }
  else
    backPageName = "ErrorPage.jsp?backPage=ContainerTypeList.jsp&mode=Update";
%>
<jsp:forward page="<%=backPageName%>" />