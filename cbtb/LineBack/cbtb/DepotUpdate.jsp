<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="depotBean" scope="page" class="com.cbtb.javabean.DepotJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","DEPOT"); //加入检查的内容
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String depotData[] = new String[5];
  depotData[0]=request.getParameter("depotId");
  depotData[1]=request.getParameter("depotDesc");
  depotData[2]=request.getParameter("depotChineseDesc");
  depotData[3]=constant.MASTER_CODE_ACTIVE;
  depotData[4]=request.getParameter("priority");
  String backPageName = "";
if (depotBean.depotUpdate(depotData))

    {
    dbList.loadDepotList();
    backPageName = "SuccessPage.jsp?backPage=DepotList.jsp&mode=Update";}
  else{
    backPageName = "ErrorPage.jsp?backPage=DepotList.jsp&mode=Update";}
%>
<jsp:forward page="<%=backPageName%>" />