<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<%@ include file="Init.jsp"%>
<%
String addFeeId=request.getParameter("addFeeId");
%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "view"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>

<html>

<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>附加費用數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="AdditionalFeeEdit.jsp?addFeeId=<%=request.getParameter("addFeeId")%>&addFeeTruckAmount=<%=request.getParameter("addFeeTruckAmount")%>&addFeeShipperAmount=<%=request.getParameter("addFeeShipperAmount")%>"><font
size=2 color="#003366">更新</font></a> | <a href="AdditionalFeeDelView.jsp?addFeeId=<%=request.getParameter("addFeeId")%>&addFeeTruckAmount=<%=request.getParameter("addFeeTruckAmount")%>&addFeeShipperAmount=<%=request.getParameter("addFeeShipperAmount")%>"><font
size=2 color="#003366">刪除</font></a> | <a href="javascript:history.back()"><font
size=2 color="#003366">取消</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">附加費用數據維護</font></p>

<form name="form1" >
  <table width="50%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td>種類：</td>
      <td ><%=request.getParameter("addFeeId")%>  </td>
    </tr>
    <tr> 
      <td>英文描述：</td>
      <td ><%=dbList.getAddFeeDesc(addFeeId, "EN")%> </td>
    </tr>
    <tr> 
      <td >中文描述：</td>
      <td ><%=dbList.getAddFeeDesc(addFeeId, "CN")%>  </td>
    </tr>


  </table>
</form>

<p align="left">&nbsp;</p>


</body>
</html>
