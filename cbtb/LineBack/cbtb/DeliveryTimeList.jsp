<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="deliveryTimeBean" scope="page" class="com.cbtb.javabean.DeliveryTimeJB" />
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>貨運時間數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="DeliveryTimeAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間數據維護</font></p>

<form method="post" action="DeliveryTimeList.jsp">
<table border="0" width="75%">
  <tr>
    <td><font face="Arial, Helvetica, sans-serif"></font> 貨運時間:</td>
    <td>&nbsp;</td>
    <td>
      <select name="deliveryTimeIdSelect">
        <%=dbList.getDeliveryTimeList("","")%>
      </select>
    </td>
    <td>&nbsp;</td>
    <td><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif">
      <input
        type="submit" name="Submit" value="查詢">
      </font></a></td>
    <td><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif">
      <input
        type="reset" name="Submit2" value="重設">
      </font></td>
  </tr>
</table>
<hr>
<%
  String init=request.getParameter("init");
  if (!(init==null))
  {
%>

<table border="1" width="75%">
  <tr>
   <td>編號</td>
    <td>英文描述</td>
    <td>中文描述</td>
    <td>狀況</td>
  </tr>

  <%
      String type = request.getParameter("type");
      String s_deliveryTimeId,s_deliveryTimedesc,s_chineseDesc,s_status;
      String sqlString="";
      int i = 0;
      DeliveryTimeValue deliveryTimeValue = new DeliveryTimeValue();

      Vector vectors =new Vector();
      try{
          if (type == null  )
          {
	      String s_deliveryTimeIdSelect = request.getParameter("deliveryTimeIdSelect");
	      if (s_deliveryTimeIdSelect.equals("Any"))
		  sqlString = "";
	     else
		  sqlString = " where DELIVERY_TIME_ID = '" + s_deliveryTimeIdSelect + "'";

   	     deliveryTimeBean.InitContent();

             pagination.setPageNo(0);
             pagination.setRecords(deliveryTimeBean.deliveryTimeQueryByCondition(sqlString));
             vectors =(Vector)pagination.nextPage();
          }
          else
          {
              if (type.equals("N"))
              { 
                    vectors = null;
                    vectors = (Vector)pagination.nextPage();
              }
              else if (type.equals("P"))
                   {
                    vectors = new Vector(pagination.previousPage());
                   }
                   else if (type.equals("F"))
                        {
                         vectors =new Vector(pagination.firstPage());
                        }
                       else if (type.equals("E"))
                            {
                              vectors = new Vector(pagination.endPage());
                            }
                           else if (type.equals("T"))
                                {
                                  vectors = new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                                }
           }

           for (i = 0;(!vectors.isEmpty()) && (i < vectors.size());i++)
               {
                 deliveryTimeValue = (DeliveryTimeValue)vectors.get(i);
                 s_deliveryTimeId = deliveryTimeValue.deliveryTimeId;
                 s_deliveryTimedesc = deliveryTimeValue.deliveryTimeDesc;
                 s_chineseDesc = deliveryTimeValue.deliveryTimeChineseDesc;
                 s_status = deliveryTimeValue.recordStatus;
%>
  <tr>
<%  
               if (s_status.equals(constant.MASTER_CODE_ACTIVE)) {
		   s_status="正常";
%>
    <td><a href="DeliveryTimeView.jsp?deliveryTimeId=<%= s_deliveryTimeId %>"><%= s_deliveryTimeId %></a>&nbsp;</td>
<% }

		 if (s_status.equals(constant.MASTER_CODE_DELETED)) {
		   s_status="刪除";
       %>


    <td><%= s_deliveryTimeId %>&nbsp;</td>
<%}%>
    <td><%= s_deliveryTimedesc %>&nbsp;</td>
    <td><%= s_chineseDesc %>&nbsp;</td>
    <td><%= s_status %>&nbsp;</td>
  </tr>
  <%
           }
      }
      catch(Exception e){
      }
  %>

</table>

 <table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1"> 
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="DeliveryTimeList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> <a href="DeliveryTimeList.jsp?type=P&init=Y">前一頁</a> 
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="DeliveryTimeList.jsp?type=N&init=Y">後一頁</a> <a href="DeliveryTimeList.jsp?type=E&init=Y">最後一頁</a> 
          <%
          }
          %>
          </td>     
      
        <td width="9%" class="unnamed1">
          <div align="left">第<%=pagination.getPageNo()%>頁</div>
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
