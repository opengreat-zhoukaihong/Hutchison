<%@ include file="Init.jsp"%>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="deliveryTimeSlotBean" scope="page" class="com.cbtb.javabean.DeliveryTimeSlotJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>


<%
webOperator.clearPermissionContext();  
webOperator.putPermissionContext("document_type","DELIVERY_TIME_SLOT"); 
webOperator.putPermissionContext("action", "search"); 
if (webOperator.checkPermission())
  out.print("");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>


<html>

<head>
<link rel="stylesheet" href="../css/line.css" type="text/css">
<title>貨運時間段數據維護</title>

</head>
<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>

<p align="right"><a href="DeliveryTimeSlotAdd.jsp"><font
color="#003366" size="2" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a
href="MasterDataMaintenance.jsp"><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif">關閉</font></a></p>

<p><font face="Arial, Helvetica, sans-serif" size="3">貨運時間段數據維護</font></p>

<form method="post" action="DeliveryTimeSlotList.jsp">

<table border="0" width="75%">
  <tr>
    <td>
      <div align="right">貨運時間段:</div>
    </td>
    <td>
      <select name="timeSlotIdSelect" > 
        <%=dbList.getDeliveryTimeSlotList("","")%>  
      </select> 
    </td>
    <td>
      <div align="right">貨運時間:</div>
    </td>
    <td>
      <select name="timeIdSelect" > 
        <%=dbList.getDeliveryTimeList("","")%>  
      </select> 
    </td>
    <td><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif">
      <input
        type="submit" name="Submit" value="查詢" >
      </font></a></td>
    <td><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif">
      <input
        type="reset" name="Submit2" value="重設">
      </font></td>
  </tr>
</table>
<hr>
<% String init=request.getParameter("init");
 
if (!(init==null))
 {
%>
<table border="1" width="75%">
  <tr>
    <td>時間段編號</td>
    <td>起始時間</td>
    <td>終止時間</td>
    <td>時間段描述</td>
    <td>時間段中文描述</td>
    <td>貨運時間</td>
    <td>狀況</td>
  </tr>
          <%String type = request.getParameter("type");
         
   	   String s_timeSlotId,s_timeId,s_fromTime,s_toTime;
	   String s_timeSlotDesc,s_timeSlotChineseDesc,s_status;
	   String sql_timeSlot="";
	   String sql_time="";
           Vector vectors =new Vector();
          try{
               if (type == null  )
              {
	       String s_timeSlotIdSelect=request.getParameter("timeSlotIdSelect");

	       String s_timeIdSelect=request.getParameter("timeIdSelect");

	      if (s_timeSlotIdSelect.equals("Any"))
		 sql_timeSlot = "";
	      else
		  sql_timeSlot = " and DELIVERY_TIME_SLOT.TIME_SLOT_ID ='" +s_timeSlotIdSelect + "'";

	      if (s_timeIdSelect.equals("Any"))
		  sql_time="";
	      else
		  sql_time=" and DELIVERY_TIME_SLOT.DELIVERY_TIME_ID ='" +s_timeIdSelect+ "'";
    
   	      deliveryTimeSlotBean.InitContent();       
        

               pagination.setPageNo(0);
               pagination.setRecords(deliveryTimeSlotBean.deliveryTimeSlotQueryByCondition(sql_timeSlot+sql_time));
               vectors =(Vector)pagination.nextPage();
             }
             else
             {
                if (type.equals("N"))
                {
                    vectors=null;
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
                             vectors =new Vector(pagination.endPage());
                         }
                              else if (type.equals("T"))
                              {
                                  vectors =new Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                              }
            }

           DeliveryTimeModel deliveryTimeModel = new DeliveryTimeModel();
          
           for (int i = 0;  (!vectors.isEmpty()) && i < vectors.size(); i++)
               {
                 deliveryTimeModel =(DeliveryTimeModel)vectors.get(i);
                 s_timeSlotId = deliveryTimeModel.timeSlotId;
                 s_timeId =  deliveryTimeModel.deliveryTimeId;
                 s_fromTime = deliveryTimeModel.fromTime;
                 s_toTime = deliveryTimeModel.toTime;
                 s_timeSlotDesc = deliveryTimeModel.slotDesc;
                 s_timeSlotChineseDesc = deliveryTimeModel.slotChineseDesc;
                 s_status = deliveryTimeModel.recordStatus;
%>
<%
                 if (s_status.equals(constant.MASTER_CODE_ACTIVE)) {
		   s_status="正常";
%>
          <td width="68"   height="30" >
            <div align="center"><font size="2"><a href="DeliveryTimeSlotView.jsp?timeSlotId=<%=s_timeSlotId%>&deliveryTimeId=<%=s_timeId%>&fromTime=<%=s_fromTime%>&toTime=<%=s_toTime%>&status=<%=s_status%>&slotDesc=<%=s_timeSlotDesc%>"><%=s_timeSlotId%>
              </a> </font></div>
          </td>
<%}
		 if (s_status.equals(constant.MASTER_CODE_DELETED)) {
		   s_status="刪除";
         %>
        <tr>
          <td width="68"   height="30" >
            <div align="center"><%=s_timeSlotId%></div>
          </td>
<%  }  %>
          <td width="88"   height="30" >
            <div align="center"><font size="2"><%=s_fromTime%>&nbsp;</font></div>
          </td>
          <td width="88"   height="30" >
            <div align="center"><font size="2"><%=s_toTime %>&nbsp;</font></div>
          </td>
          <td width="96"   height="30" >
            <div align="center"><font size="2"><%=s_timeSlotDesc%>&nbsp;</font></div>
          </td>
          <td width="96"   height="30" >
            <div align="center"><font size="2"><%=s_timeSlotChineseDesc%>&nbsp;</font></div>
          </td>
          <td width="70"   height="30" >
            <div align="center"><font size="2"><%= dbList.getDeliveryTimeDesc(s_timeId, "") %>&nbsp;</font></div>
          </td>
          <td width="60"   height="30" >
            <div align="center"><font size="2"><%=s_status%>&nbsp;</font></div>
	  </td>
        </tr>

       <%
           }
         }catch(Exception e){}
    	%>

      </table>


<table width="477" border="0" cellspacing="0" cellpadding="0" height="22">
      <tr>
        <td width="76%" class="unnamed1"> 
          <%
          if (pagination.getPageNo() > 1)
          {
            %>
          <a href="DeliveryTimeSlotList.jsp?type=F&init=Y" class="unnamed1">第一頁</a> <a href="DeliveryTimeSlotList.jsp?type=P&init=Y">前一頁</a> 
          <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
          <a href="DeliveryTimeSlotList.jsp?type=N&init=Y">後一頁</a> <a href="DeliveryTimeSlotList.jsp?type=E&init=Y">最後一頁</a> 
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
