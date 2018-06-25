<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","CONTAINER_INVENTORY"); //加入检查的内容
  webOperator.putPermissionContext("action", "create"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
    ArrayList inventoryDailyList = (ArrayList)session.getAttribute("inventoryDailyList");
     String pageName="ErrorPage.jsp";
         MasterManager mm=webOperator.getMasterManager();
         if(mm.updateInventoryDaily(inventoryDailyList))
           pageName="InventorySearch.jsp";
    response.sendRedirect(pageName);

%>