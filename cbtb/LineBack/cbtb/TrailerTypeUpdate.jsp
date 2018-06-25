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
webOperator.putPermissionContext("action", "edit"); //加入检查的内容
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String trailerTypeData[] = new String[4];
  trailerTypeData[0]=request.getParameter("trailerId").trim();
  trailerTypeData[1]=request.getParameter("trailerDesc").trim();
  trailerTypeData[2]=request.getParameter("trailerChineseDesc").trim();
  trailerTypeData[3]=constant.MASTER_CODE_ACTIVE;
 String backPageName = "";
if (trailerTypeBean.trailerTypeUpdate(trailerTypeData))

    {
    dbList.loadTrailerTypeList();
    backPageName = "SuccessPage.jsp?backPage=TrailerTypeList.jsp&mode=Update";}
  else{
    backPageName = "ErrorPage.jsp?backPage=TrailerTypeList.jsp&mode=Update";}
%>
<jsp:forward page="<%=backPageName%>" />