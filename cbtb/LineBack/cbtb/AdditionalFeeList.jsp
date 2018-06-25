<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="addFeeBean" scope="page" class="com.cbtb.javabean.AddFeeJB" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
webOperator.clearPermissionContext();  //清除以前检查的内容
webOperator.putPermissionContext("document_type","ADDITIONAL_FEE"); //加入检查的内容
webOperator.putPermissionContext("action", "search"); //加入检查的内容
if (webOperator.checkPermission())
  out.print(" ");
else
  response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
%>
<html>
<head>
  <link rel="stylesheet" href="../css/line.css" type="text/css">
  <title>附加費用數據維護</title>
</head>

<body bgcolor="#FFFFFF">
<%@ include file="../include/head.jsp"%>
<p align="right"><a href="AdditionalFeeAdd.jsp"><font
color="#003366" size="2">新建</font></a> | 
<a href="MasterDataMaintenance.jsp"><font
color="#003366" size="2">關閉</font></a></p>
<p><font face="Arial, Helvetica, sans-serif" size="3">附加費用數據維護</font></p>
<form method="post" action="AdditionalFeeList.jsp">
  <table border="0" width="80%">
    <tr> 
      <td>附加費用種類: 
        <select name="category" >
          <%=dbList.getAddFeeList("","")%> 
        </select>
      </td>
      <td> 
        <div align="right"><font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> 
          <input type="submit" name="Submit" value="查詢" >
          </font> <font color="#003366" size="2" face="Arial, Helvetica, sans-serif"> 
          <input type="reset" name="Submit2" value="重設">
          </font> </div>
      </td>
    </tr>
  </table>
<hr>
<input type="hidden" name="init" value="notfirst">
</form>
<% String init=request.getParameter("init");
 
if (!(init==null))
  {


%>


<div align="left">
<%
String category=request.getParameter("category");
String queryCondition="";

if (category!=null){
    category=category.trim();
    if(!category.equals("Any")){
    	queryCondition=" AND  add_fee_id ='"+category+"' Order by add_fee_id";
    } else{
        queryCondition=" Order by add_fee_id";
    }
  }
  try{
  addFeeBean.InitContent();
  Vector addFeeLists =new Vector();

  String type = request.getParameter("type");
        
           if (type == null  )
              {
               pagination.setPageNo(0);
               pagination.setRecords(addFeeBean.additionalFeeQueryByCondition(queryCondition));
               addFeeLists = new Vector(pagination.nextPage());
 
              }
           else
              {
               if (type.equals("N"))
                   {
                    addFeeLists = new Vector(pagination.nextPage());
                   }
               else if (type.equals("P"))
                   {
                    addFeeLists = new Vector(pagination.previousPage());
                   }
               else if (type.equals("F"))
                   {
                    addFeeLists =new Vector(pagination.firstPage());
                   }
               else if (type.equals("E"))
                   {
                    addFeeLists =new Vector(pagination.endPage());
                   }
               else if (type.equals("T"))
                   {
                     addFeeLists =new 

Vector(pagination.toPage(Integer.parseInt(request.getParameter("page"))));
                   }
               }
	AdditionalFeeValue   addFee1 =new   AdditionalFeeValue();
	String 

addFeeId,description,chineseDescription,recordStatus;
	
 %>
  <table border="1" width="80%">
    <tr> 
      <td> 
        <div align="center">編號</div>
      </td>
      <td> 
        <div align="center">英文描述</div>
      </td>
      <td> 
        <div align="center">中文描述</div>
      </td>

      <td>狀況</td>
    </tr>
    <%
        String s_recordStatusDesc="";
	for (int i = 0;  (!addFeeLists.isEmpty()) && i < addFeeLists.size(); i++)
         {
	    addFee1=(AdditionalFeeValue)addFeeLists.get(i);
	    addFeeId= addFee1.addFeeId.trim() ;
	    description	=  addFee1.addFeeDesc;
	    chineseDescription =addFee1.addFeeChineseDesc;
	    recordStatus =addFee1.recordStatus;
	    if (recordStatus.equals(constant.MASTER_CODE_ACTIVE))
		   s_recordStatusDesc="正常";
	    if (recordStatus.equals(constant.MASTER_CODE_DELETED))
	           s_recordStatusDesc="刪除";

  %> 
    <tr> 
      <td>
<% if (recordStatus.equals(constant.MASTER_CODE_ACTIVE)){
%>
<a href="AdditionalFeeView.jsp?addFeeId=<%=addFeeId%>"><%=addFeeId%></a></td>
<%}%>
<% if (recordStatus.equals(constant.MASTER_CODE_DELETED)){
%>
<%=addFeeId%>
<%}%>




      <td><%=description%></td>
      <td><%=chineseDescription%></td>

      <td><%=s_recordStatusDesc%>&nbsp</td>
    </tr>
    <%}
}catch(Exception e){}
    	%> 
  </table>
  <table width="80%" border="0" cellspacing="0" cellpadding="0" height="22">
    <tr> 
      <td width="76%" class="unnamed1" height="22"> 
        <%
          if (pagination.getPageNo() > 1)
          {
            %>
        <a href="AdditionalFeeList.jsp?type=F&init=p" class="unnamed1">第一頁</a> 
        <a 

href="AdditionalFeeList.jsp?type=P&init=p">前一頁</a> 
        <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
            %>
        <a href="AdditionalFeeList.jsp?type=N&init=p">後一頁</a> <a 

href="AdditionalFeeList.jsp?type=E&init=p">最後一頁</a> 
        <%
          }
          %>
      </td>
      <td height="22" class="unnamed1"> 
        <div align="right">第<%=pagination.getPageNo()%>頁 總數：<%=pagination.getPageSum()%>頁</div>
      </td>
    </tr>
  </table>
</div>

<%}
%>

<p align="left">&nbsp; </p>
</body>
</html>
