<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
  webOperator.clearPermissionContext();  //清除以前检查的内容
  webOperator.putPermissionContext("document_type","CONTAINER_INVENTORY"); //加入检查的内容
  webOperator.putPermissionContext("action", "edit"); //加入检查的内容
  if (!webOperator.checkPermission())
    response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
String language="CN";
String reservedQty="";
%>
<html>

<head>
<LINK href="../css/line.css" rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=UFT-8">
<title>航運公司貨櫃數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<script src=../js/calendarShow.js></script>
<p align="right"> <a href="InventoryUpdate.jsp?contCount=<%=request.getParameter("contCount")%>"><font
color="#003366" size = "2">確定</font></a>&nbsp;|&nbsp;<a href="JavaScript:history.back()"><font
color="#003366" size = "2">取消</font></a></p>




<div align="left">
  <table border="1" width="100%">
    <tr>
      <td>登記日期</td>
      <td>航運公司編號 </td>
      <td>貨櫃類型編號</td>
      <td>貨櫃數量</td>
      <td>已定貨櫃數量</td>
      <td>最後更新日期</td>
    </tr>
<%
ArrayList inventoryList =(ArrayList)session.getAttribute("inventoryDailyList");

     String[] containerNumber = request.getParameterValues("containerNumber");
     if(containerNumber!=null)
       {
         for (int i=0; i<containerNumber.length;i++)
   	   {
             InventoryDailyModel idm=new InventoryDailyModel();
             idm=(InventoryDailyModel)inventoryList.get(i);
             reservedQty=String.valueOf(idm.getReservedQty());
             if(reservedQty.equals("0"))
                reservedQty="";
             if(containerNumber[i]==null || containerNumber[i].trim().length()==0)
             {
              containerNumber[i]="0";
              idm.setAvailableQty(Integer.parseInt(containerNumber[i]));
             }
             else
             {
              idm.setAvailableQty(Integer.parseInt(containerNumber[i]));

%>
    <tr>
      <td><%=(idm.getCaptureDate().toString()).substring(0,10)%>&nbsp;</td>
      <td><%=dbList.getShippingLineDesc(idm.getShippingLineId(),language)%>&nbsp;</td>
      <td><%=dbList.getContainerTypeDesc(idm.getContainerTypeId(),language)%>&nbsp;</td>
      <td><%=idm.getAvailableQty()%>&nbsp;</td>
      <td><%=reservedQty%>&nbsp;</td>
      <td><%=idm.getLastUpdateDateTime()%>&nbsp;</td>
    </tr>
<%           }
           }
        }
    session.setAttribute("inventoryDailyList",inventoryList);
%>


  </table>
</div>

<p align="left">&nbsp; </p>
</body>
</html>