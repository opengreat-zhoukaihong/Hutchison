<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<jsp:useBean id="addFeeBean" scope="page" class="com.cbtb.javabean.AddFeeJB" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "create"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<%
  String addFeeData[] = new String[6];
  addFeeData[0]=request.getParameter("addFeeId");
  addFeeData[1]=request.getParameter("description");
  addFeeData[2]=request.getParameter("chineseDescription");
  addFeeData[3]="0";
  addFeeData[4]="0";
  addFeeData[5]=constant.MASTER_CODE_ACTIVE;

  String backPageName = "";
if (addFeeBean.additionalFeeInsert(addFeeData))
    {
    dbList.loadAddFeeList();
    backPageName = "SuccessPage.jsp?backPage=AdditionalFeeList.jsp&mode=Insert";
    }
  else
    backPageName = "ErrorPage.jsp?backPage=AdditionalFeeList.jsp&mode=Insert";
response.sendRedirect(backPageName);
%>
