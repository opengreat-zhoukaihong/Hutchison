<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="reasonCodeBean" scope="page" class="com.cbtb.javabean.ReasonCodeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","REASON_CODE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<%
  String Data[] = new String[4];
  Data[0]=request.getParameter("reasonId");
  Data[1]=request.getParameter("reasonDesc");
  Data[2]=request.getParameter("reasonChineseDesc");
  Data[3]=constant.MASTER_CODE_ACTIVE;
  String backPageName = "";
  if (reasonCodeBean.ReasonCodeInsert(Data))
	{
		dbList.loadReasonCodeList();
    backPageName = "SuccessPage.jsp?backPage=ReasonCodeList.jsp&mode=Insert";
	}
  else
    backPageName = "ErrorPage.jsp?backPage=ReasonCodeList.jsp&mode=Insert";
%>
<jsp:forward page="<%=backPageName%>" />