<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.javabean.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="com.cbtb.util.*" %>
<jsp:useBean id="tradingPartnerBean" scope="page" class="com.cbtb.javabean.TradingPartnerJB" />
<jsp:useBean id="dbList" scope="page" class="com.cbtb.web.DbList" />
<jsp:useBean id="pagination" scope="session" class="com.cbtb.util.Pagination" />
<jsp:useBean id="companyProfileModel" scope="session" class="com.cbtb.model.CompanyProfileModel" />
<%
    webOperator.clearPermissionContext(); 
    webOperator.putPermissionContext("document_type","TRADING_PARTNER"); //加入检查的内容
    webOperator.putPermissionContext("action", "search"); //加入检查的内容
    if (!webOperator.checkPermission())
    {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
    }

    String companyId = companyProfileModel.getCompanyId();
    String path = request.getParameter("path");
    String rootPath = request.getParameter("rootPath");
    if(path == null)
       path = "TradingPartnerList.jsp";
    String sMarkLanguage = "CH";
%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file="../include/ShiperHead.jsp" %>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>貿易夥伴數據維護</b></font></font></td>
      <td width="57%"> 
      <div align="right"><a href="TradingPartnerAdd.jsp?companyId=<%= companyId %>&path=<%= path %>&rootPath=<%= rootPath %>"><font
color="#003366" face="Arial, Helvetica, sans-serif">新建</font></a><font color="#003366"
face="Arial, Helvetica, sans-serif"></font><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> </font><font color="#003366" size="2"
face="Arial, Helvetica, sans-serif"> | </font><a href="indexShipping.jsp"><font color="#003366"
face="Arial, Helvetica, sans-serif">關閉</font></a></div>
      </td>
    </tr>
  </table>
  
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<form action="TradingPartnerList.jsp" name="frmList" method="post">

<input type="hidden" name="rootPath" value="<%= rootPath %>">
<input type="hidden" name="path" value="<%= path %>">

<table border="0" width="98%" align="center" cellpadding="1" cellspacing="1">
  <tr> 
    <td width="15%" height="14">貿易夥伴名稱：</td>
    <td width="16%" height="14"> 
      <select name="tradingPartnerId" size="1">
        <%=dbList.getTradingPartnerList(companyId,"",sMarkLanguage)%> 
      </select>
    </td>
    <td width="10%" height="14">貿易夥伴英文名稱： </td>
    <td width="8%" height="14"> 
      <input type="text" maxlength="100" size="10" name="tradingPartnerName">
    </td>
    <td width="10%" height="14">貿易夥伴中文名稱： </td>
    <td width="8%"> 
      <input type="text" maxlength="100" size="10" name="tradingPartnerChineseName">
    </td>
    <td width="13%" height="14"></td>
    <td width="19%" height="14"> </td>
  </tr>
  <tr> 
    <td width="15%">電話號碼：</td>
    <td width="16%"> 
      <input type="text" maxlength="30" size="8" name="telephoneNo">
    </td>
    <td width="12%" height="14">聯絡人英文姓名：</td>
    <td width="7%" height="14"> 
      <input type="text" maxlength="30" size="10" name="contactPerson">
    </td>
    <td width="12%" height="14"> 聯絡人中文姓名：</td>
    <td width="7%" height="14"> 
      <input type="text" maxlength="50" size="10" name="contactChinesePerson">
    </td>
    <td colspan="2" width="19%"> <a href="Registration_edit.htm"><font color="#003366"
        size="2" face="Arial, Helvetica, sans-serif"> </font></a><font color="#003366" size="2"
        face="Arial, Helvetica, sans-serif"><a href="javascript:frmList.submit()"><img src="../images/search.jpg" width="44" height="19" border="0"></a><img src="../images/good.jpg" width="10" height="10"><a href="javascript:frmList.reset();"><img src="../images/reset.jpg" width="44" height="19" border="0"></a>
      </font>
   </td>
  </tr>
</table>

<hr>

<%

  String init=request.getParameter("init");
  if (!(init==null))
  {


%>

<table cellpadding="4" cellspacing="" width="98%" align="center">
  <tr bgcolor="e0e0e0"> 
    <td width="15%">狀況&nbsp;&nbsp;</td>
    <td width="15%">貿易夥伴編號</td>
    <td width="15%">貿易夥伴英文名稱</td>
    <td width="15%">貿易夥伴中文名稱</td>
    <td width="10%">聯絡人英文姓名</td>
    <td width="15%">聯絡人中文姓名</td>
    <td width="10%">電話號碼</td>
  </tr>

    <%
      String type = request.getParameter("type");
      String s_companyId,s_tradingPartnerId,s_tradingPartnerName,s_status;
      String s_contactPerson,s_contactChinesePerson,s_telephoneNo,s_tradingPartnerAddr;
      String sqlTradingPartnerId="";
      String sqlTradingPartnerName="";
      String sqlContactPerson="";
      String sqlContactChinesePerson="";
      String sqlTelephoneNo="";
      String sqlTradingPartnerChineseName="";
      String sqlString = "";

      int i = 0;  //the i is mark the record per of one page 
      int k = 0;
      String strColor="";  
      TradingPartnerValue tradingPartnerValue = new TradingPartnerValue();
      CbtbConstant cbtbConstant = new CbtbConstant();

      Vector vectors =new Vector();
      if (type == null  )
          {
	      String s_deliveryTimeIdSelect = request.getParameter("tradingPartnerId");
              StringTokenizer dt=new StringTokenizer(s_deliveryTimeIdSelect,"$");
              s_deliveryTimeIdSelect=dt.nextToken();

              
	      if (s_deliveryTimeIdSelect.equals("Any")){
		  sqlTradingPartnerId = "";
                  sqlString = " WHERE COMPANY_ID = '" + companyId + "' and RECORD_STATUS = '" + cbtbConstant.TRADING_PARTNER_EFFECTIVE + "'";
	      }
              else
		  sqlString = " WHERE COMPANY_ID = '" + companyId + "' and RECORD_STATUS = '" + cbtbConstant.TRADING_PARTNER_EFFECTIVE + "' and TRADING_PARTNER_ID like '%" + s_deliveryTimeIdSelect + "%'";
              
              if (request.getParameter("tradingPartnerName").trim().length() > 0 )
	      {
                   if(sqlString != "")
		     sqlString = sqlString  + " and TRADING_PARTNER_NAME like '%" + request.getParameter("tradingPartnerName") + "%'";
                   else
                       sqlString =" WHERE TRADING_PARTNER_NAME like '%" + request.getParameter("tradingPartnerName") + "%'";
              }
              if (request.getParameter("contactPerson").trim().length() > 0)
	      {
                   if(sqlString != "")
		      sqlString = sqlString  + " and  CONTACT_PERSON like '%" + request.getParameter("contactPerson") + "%'";
                   else
                       sqlString =  " WHERE CONTACT_PERSON like '%" + request.getParameter("contactPerson") + "%'";
              }

              if (request.getParameter("contactChinesePerson").trim().length() > 0)
	      {
                   if(sqlString != "")
		      sqlString = sqlString  + " and  CONTACT_CHINESE_PERSON like '%" + request.getParameter("contactChinesePerson") + "%'";
                   else
                       sqlString =  " WHERE CONTACT_CHINESE_PERSON like '%" + request.getParameter("contactChinesePerson") + "%'";
              }

              if (request.getParameter("telephoneNo").trim().length() > 0)
	      {
                   if(sqlString != "")
		      sqlString = sqlString  + " and  TELEPHONE_NO like '%" + request.getParameter("telephoneNo") + "%'";
                   else
                       sqlString =  " WHERE  TELEPHONE_NO like '%" + request.getParameter("telephoneNo") + "%'";
              }
         
              if (request.getParameter("tradingPartnerChineseName").trim().length() > 0)
	      {
                   if(sqlString != "")
		      sqlString = sqlString  + " and  TRADING_PARTNER_CHINESE_NAME like '%" + request.getParameter("tradingPartnerChineseName") + "%'";
                   else
                       sqlString =  " WHERE TRADING_PARTNER_CHINESE_NAME like '%" + request.getParameter("tradingPartnerChineseName") + "%'";
              }

   	     tradingPartnerBean.initContent();  

             pagination.setPageNo(0);
             pagination.setRecords(tradingPartnerBean.queryTradingPartnerByCondition(sqlString));
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
                 tradingPartnerValue = (TradingPartnerValue)vectors.get(i);
                 s_status = tradingPartnerValue .recordStatus; 
                 strColor= "";
                 if((k+1) % 2 == 0)
                 {
                   out.println("<tr bgcolor='#ddffdd'>"); 
                 }
                 else
                    {
                     out.println("<tr>"); 
                    }    
                if(s_status.equals(cbtbConstant.TRADING_PARTNER_EFFECTIVE))
                {   
                  s_status="正常";
                  k++;          //if the k is even, then write <tr bgcolor=#ddffdd>
         %>
                 <td><%= s_status  %>&nbsp;</td>
                 <td><a href="TradingPartnerView.jsp?tradingPartnerId=<%= tradingPartnerValue.tradingPartnerId %>&companyId=<%=tradingPartnerValue.companyId%>&path=<%=path%>"><%= tradingPartnerValue.tradingPartnerId  %>&nbsp;</td>
                 <td><%= tradingPartnerValue.tradingPartnerName  %>&nbsp;</td>
                 <td><%= tradingPartnerValue.tradingPartnerChineseName  %>&nbsp;</td>
                 <td><%= tradingPartnerValue.contactPerson  %>&nbsp;</td>
                 <td><%= tradingPartnerValue.contactChinesePerson  %>&nbsp;</td>
                 <td><%= tradingPartnerValue.telephoneNo  %>&nbsp;</td>
         <%
                }
         %>
              </tr>     
  <%
    }
 %>
</table>

<hr>

<table width="750"  cellspacing="0" cellpadding="4" align="center">
  <tr> 
     <td width="84%" class="unnamed1">
        <%
          if (pagination.getPageNo() > 1)
          {
        %>
           <a href="TradingPartnerList.jsp?type=F&init=tmd"><img src="../images/firstpage.JPG" width="10" height="10" alt="第一頁" border="0"></a>
           <img src="../images/good.jpg" width="20" height="10"><a href="TradingPartnerList.jsp?type=P&init=tmd"><img src="../images/perviouspage.jpg" width="8" height="10" alt="上一頁" border="0"></a>
        <%
          }
          if (pagination.getPageNo() < pagination.getPageSum())
          {
       %> 
           <img src="../images/good.jpg" width="20" height="10"><a href="TradingPartnerList.jsp?type=N&init=tmd"><img src="../images/nextpage.jpg" width="8" height="10" alt="下一頁" border="0"></a><img src="../images/good.jpg" width="20" height="10"><a href="TradingPartnerList.jsp?type=E&init=tmd"><img src="../images/endpage.jpg" width="10" height="10" alt="最後一頁" border="0"></a> 
       <%
          }
       %>
    </td>     
    <td width="16%" class="unnamed1"> 
      <div align="right"><font color="#003366">第<%=pagination.getPageNo() %>頁&nbsp;總數：<%=pagination.getPageSum()%>頁</font></div>
    </td>
  </tr>
</table>

<%}%>

<input type="hidden" name="init" value="notfirst">
</form>
      
<%@ include file="../include/end.jsp" %>
</body>
</html>


