<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="trailerTypeBean" scope="page" class="com.cbtb.javabean.TrailerTypeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","TRAILER_TYPE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String trailerTypeData[] = new String[4];
  trailerTypeData[0]=request.getParameter("trailerId");
  trailerTypeData[1]=request.getParameter("trailerDesc");
  trailerTypeData[2]=request.getParameter("trailerChineseDesc");
  trailerTypeData[3]=constant.MASTER_CODE_ACTIVE;
   String backPageName = "";
  if (trailerTypeBean.trailerTypeInsert(trailerTypeData))
    {
    dbList.loadTrailerTypeList();
    backPageName = "SuccessPage.jsp?backPage=TrailerTypeList.jsp&mode=Insert";}
  else{
    backPageName = "ErrorPage.jsp?backPage=TrailerTypeListList.jsp&mode=Insert";}
%>
<jsp:forward page="<%=backPageName%>" />