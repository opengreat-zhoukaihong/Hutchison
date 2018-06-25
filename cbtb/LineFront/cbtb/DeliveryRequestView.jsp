<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp" %>
<%@ include file="Init.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.entity.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.ejb.session.CompanyManager " %>
<%@ page import="com.cbtb.web.*" %>
<jsp:useBean id="dbList" scope="application" class="com.cbtb.web.DbList" />
<jsp:useBean id="utilTool" scope="page" class="com.cbtb.util.UtilTool" />
<jsp:useBean id="cbtbConstant" scope="page" class="com.cbtb.util.CbtbConstant" />
<jsp:useBean id="deliveryRequestMode" scope="session" class="com.cbtb.model.DeliveryRequestModel" />
<%
   webOperator.clearPermissionContext(); 
   webOperator.putPermissionContext("document_type","DELIVERY_REQUEST"); //加入检查的内容
   webOperator.putPermissionContext("action", "view"); //加入检查的内容
   if (!webOperator.checkPermission())
   {
      response.sendRedirect("ErrorPage.jsp?errorMessage=ER_9000");
   }


   String deliveryRequestNum="";  
   String sMarkLanguage = "CH";
   String strIssuer = "";
   String strIssuerID = "";
   String strReceive = "" ;
   String strReceiveID = "" ;
   deliveryRequestNum = request.getParameter("deliveryRequestNum");
   CompanyProfileModel companyProfileModel=new CompanyProfileModel();
   companyProfileModel=(CompanyProfileModel)session.getAttribute("companyProfileModel");
   String companyId=companyProfileModel.getCompanyId(); 
   String companyName = companyProfileModel.getCompanyChineseName();
   CompanyManager companyManager = webOperator.getCompanyManager();
   deliveryRequestMode = companyManager.findDeliveryRequest(deliveryRequestNum);
   session.setAttribute("deliveryRequestMode",deliveryRequestMode);
   if(dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoIssuer(),sMarkLanguage).length() >0)
   { 
      strIssuer =  dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoIssuer(),sMarkLanguage);
      strIssuerID = deliveryRequestMode.getCargoIssuer();
   } 
   else
       {
        strIssuer = deliveryRequestMode.getCargoIssuer();
        strIssuerID = deliveryRequestMode.getCargoIssuer();
        }
 if(dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoReceiver(),sMarkLanguage).length() >0)
 { 
    strReceive = dbList.getTradingPartnerDesc(deliveryRequestMode.getCargoReceiver(),sMarkLanguage);
    strReceiveID = deliveryRequestMode.getCargoReceiver();
 }
 else
     {
       strReceive = deliveryRequestMode.getCargoReceiver();
       strReceiveID = deliveryRequestMode.getCargoReceiver();
     }
 %>

<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0">
<%@ include file = "../include/ShiperHead.jsp" %>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/good.jpg" width="10" height="10"></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      
      
    <td width="43%"><font face="Arial, Helvetica, sans-serif" size="2"><font color="#667852"><b>送貨要求細節</b></font></font></td>
      <td width="57%">   
       <div align="right">
    <%
     if(deliveryRequestMode.getRequestStatus().equals(cbtbConstant.DELIVERY_REQUEST_POST))
     {
        if(request.getParameter("path").equals("DeliveryRequestSearch.jsp"))
        {
   %>
          <a href="DeliveryRequestEdit.jsp?path=<%= request.getParameter("path") %>"><font
          color="#003366">更新</font></a> | <a href="DeliveryRequestDeleteView.jsp?path=<%= request.getParameter("path") %>"><font
          color="#003366">刪除</font></a> | <font face="Arial, Helvetica, sans-serif"><a href="DeliveryRequestReAdd.jsp?path=<%= request.getParameter("path") %>">拷貝</a></font> | 
   <%
        }
        else
            {
   %>
                 <font face="Arial, Helvetica, sans-serif"><a href="DeliveryRequestReAdd.jsp?path=<%=request.getParameter("path")%>">拷貝</a></font> | 
   <%
             } 
     }
     else  // the stasus is match
     {
         if(deliveryRequestMode.getRequestStatus().equals(cbtbConstant.DELIVERY_REQUEST_MATCH) && request.getParameter("path").equals("DeliveryRequestSearch.jsp"))
         {
   %>
            <a href="DeliveryRequestPostEdit.jsp?path=<%=request.getParameter("path") %>"><font color="#003366">更新</font></a> | 
   <%
         }
         else
             {
                if(deliveryRequestMode.getRequestStatus().equals(cbtbConstant.DELIVERY_REQUEST_MATCH))
                {
   %>
                   <font face="Arial, Helvetica, sans-serif"><a href="DeliveryRequestReAdd.jsp?path=<%= request.getParameter("path")%>">拷貝</a></font> | 
   <%
                }    
             } 
      }
   %>
               <a href="javascript:history.back()"><font color="#003366">關閉</font></a>
         </div>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td>
      <div align="right">提交日期： <%= deliveryRequestMode.getSubMissionDatetime().toString().substring(0,10)  %></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="right">送貨要求號碼： <%= deliveryRequestMode.getDeliveryRequestNum()  %></div>
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
<div align="left">

  <table border="0" width="98%" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="38%">付貨人編號：</td>
      <td width="12%"><%= companyId %></td>
      <td width="32%">付貨人姓名：</td>
      <td width="18%"><%= companyName %></td>
    </tr>

    <tr> 
      <td width="38%">出發地城市：</td>
      <td width="12%"><%=  dbList.getCityDesc(deliveryRequestMode.getOriginCityId(),sMarkLanguage) %></td>
      <td width="32%">目的地城市：</td>
      <td width="18%"><%= dbList.getCityDesc(deliveryRequestMode.getDestinationCityId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td width="38%">發貨日期：</td>
      <td width="12%"><%= deliveryRequestMode.getDeliveryDate().toString().substring(0,10) %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="32%">發貨時閒：</td>
      <td width="18%"><%= dbList.getDeliveryTimeDesc(deliveryRequestMode.getTimeId(),sMarkLanguage) %></td>
      <td width="38%">發貨時閒段：</td>
      <td width="12%"><%= dbList.getDeliveryTimeSlotDesc(deliveryRequestMode.getTimeSlotId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td width="38%">貨物種類：</td>
      <td width="12%"><%= dbList.getCargoCategoryDesc(deliveryRequestMode.getCargoId(),sMarkLanguage) %> </td>
      <td width="32%">要求貨櫃檯種類：</td>
      <td width="18%"><%= dbList.getContainerTypeDesc(deliveryRequestMode.getContainerTypeId(),sMarkLanguage) %></td>
    </tr>
    <tr> 
      <td height="20" width="38%">數量：</td>
      <td height="20" width="12%"><%= deliveryRequestMode.getCargoQty() %></td>
      <td height="20" width="32%">度量單位：</td>
      <td height="20" width="18%"><%= dbList.getPackageUomDesc(deliveryRequestMode.getCargoUom(),sMarkLanguage) %> </td>
    </tr>
    <tr> 
      <td width="38%">重量：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoWeight() %> </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="38%">航運公司：</td>
      <td width="12%"><%= dbList.getShippingLineDesc(deliveryRequestMode.getShippingLineId(),sMarkLanguage) %> </td>
      <td width="32%">落貨紙號碼/提貨單號碼：</td>
      <td width="18%"><%= deliveryRequestMode.getShippingOrderNo() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%">&nbsp; </td>
      <td width="32%">&nbsp;</td>
      <td width="18%">&nbsp; </td>
    </tr>
    <tr> 
      <td height="20" width="38%">發貨公司名稱：</td>
      <td height="20" width="12%"><%= strIssuer %></td>
      <td height="20" width="32%">收貨公司名稱：</td>
      <td height="20" width="18%"><%= strReceive %></td>
    </tr>
    <tr> 
      <td width="38%">發貨公司聯絡人電話號碼：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerPhoneNo() %></td>
      <td width="32%">收貨公司聯絡人電話號碼：</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverPhoneNo() %></td>
    </tr>
    <tr> 
      <td width="38%">發貨地詳細地址：</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr1() %></td>
      <td width="32%">目的地詳細地址：</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr1() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr2() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr2() %></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr3() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr3()%></td>
    </tr>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="12%"><%= deliveryRequestMode.getCargoIssuerAddr4() %></td>
      <td width="32%">&nbsp;</td>
      <td width="18%"><%= deliveryRequestMode.getCargoReceiverAddr4() %></td>
    </tr>
    <tr> 
      <td width="38%">狀態：</td>
      <td width="12%"><%= dbList.getDeliveryStatusDesc(deliveryRequestMode.getRequestStatus(),sMarkLanguage) %>&nbsp; </td>
      <td width="32%">運價：</td>
      <td width="18%"><%= deliveryRequestMode.getDeliveryFee() %></td>
    </tr>
    <tr> 
      <td width="38%">登記途經：</td>
      <td width="12%"><%= dbList.getCaptureChannelDesc(deliveryRequestMode.getCaptureChannel(),sMarkLanguage)  %></td>
      <td width="32%">備注：</td>
      <td width="18%">&nbsp;
               <%
                   if(deliveryRequestMode.getRemark() != null)
                   {
               %>
              <textarea rows = 5 cols=5 readonly style="font-family: 宋体; font-size: 9pt; border: 1 solid #000000"><%= deliveryRequestMode.getRemark() %></textarea>
              <%
                   }
              %>
      </td>
    </tr>
  </table>

</div>


<p align="left">&nbsp;</p>
<hr>
      
<%@ include file = "../include/end.jsp" %>
</body>
</html>


