<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.util.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ page import="java.math.BigDecimal" %>
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<jsp:useBean id="mfdm" scope="page" class="com.cbtb.model.MatchFeeDetailModel" />
<jsp:useBean id="constant" scope="application"  class="com.cbtb.util.CbtbConstant"/>
<%@ include file="Init.jsp"%>
<%
    mcrm=(MatchModel)session.getAttribute("matchModel"); 
    ArrayList matchFeeList = (ArrayList)session.getAttribute("matchFeeList");  
    ArrayList editList=new ArrayList();
    String pageName="ErrorPage.jsp?errorMessage=ER_0001";
    String url=request.getParameter("url");  
    String matchNum="";
    String deliveryRequestNum="";
    String truckCapacityNum="";    
    
    MatchManager mm=webOperator.getMatchManager();
    if (url.equalsIgnoreCase("match")) {
        webOperator.clearPermissionContext();  //清除以前检查的内容
        webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
        webOperator.putPermissionContext("action", "edit"); //加入检查的内容
        boolean update=true;
        if (!webOperator.checkPermission())
        {
          pageName="ErrorPage.jsp?errorMessage=ER_9000";
          update=false; 
        }
        else
        {
          String status=request.getParameter("status");
          if(status.equals("-1"))
           {
             webOperator.clearPermissionContext();  //清除以前检查的内容
             webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
             webOperator.putPermissionContext("action", "change_status_down"); //加入检查的内容
             if (!webOperator.checkPermission())
             {          
                 pageName="ErrorPage.jsp?errorMessage=ER_9000";
                 update=false; 
             }
           }
          else if(status.equals("1"))
           {
             webOperator.clearPermissionContext();  //清除以前检查的内容
             webOperator.putPermissionContext("document_type","MATCH"); //加入检查的内容
             webOperator.putPermissionContext("action", "change_status_up"); //加入检查的内容
             if (!webOperator.checkPermission())
             {
                 pageName="ErrorPage.jsp?errorMessage=ER_9000";
                 update=false;  
              }
           }  
          if(update)
          {
           if (mm.updateMatchCapacityRequest(mcrm)) 
           {   pageName="MatchFunctionList.jsp";
               String closePage=(String)session.getAttribute("closePage");
               if(closePage!=null)
                pageName=closePage;         
           }
           else
               pageName="ErrorPage.jsp?errorMessage=ER_0001";
          }
        }
      }
      
      
      else if (url.equalsIgnoreCase("matchFee")) 
      {
        String act=request.getParameter("act");
        if(act.equals("Delete"))
        { 
            webOperator.clearPermissionContext();  //清除以前检查的内容
            webOperator.putPermissionContext("document_type","MATCH_ADDITIONAL_FEE"); //加入检查的内容
            webOperator.putPermissionContext("action", "edit"); //加入检查的内容
            if (!webOperator.checkPermission())
            {
             pageName="ErrorPage.jsp?errorMessage=ER_9000";
            }
            else
            {
            String[] box = request.getParameterValues("box");
            if(box!=null)
            {
               for (int i=0; i<box.length;i++)
               {
                   if (box[i]!=null) 
                   {         
                        editList.add(matchFeeList.get(Integer.parseInt(box[i])));     
                    }
                 }
              for (int j=0; j< editList.size(); j++)
              {
                 int k=matchFeeList.indexOf(editList.get(j));
                  matchFeeList.remove(k);
              }
             }
             if(editList!=null)  
             {
              if (mm.removeMatchFee(editList)) 
                 pageName="MatchFeeEdit.jsp";
              else
                 pageName="ErrorPage.jsp?errorMessage=ER_0001";
               }
            session.setAttribute("matchFeeList",matchFeeList);
            }
           }
          else if(act.equals("Insert"))
           {
              webOperator.clearPermissionContext();  //清除以前检查的内容
              webOperator.putPermissionContext("document_type","MATCH_ADDITIONAL_FEE"); //加入检查的内容
              webOperator.putPermissionContext("action", "create"); //加入检查的内容
              if (!webOperator.checkPermission())
                pageName="ErrorPage.jsp?errorMessage=ER_9000";
              else
              {      
                  pageName=request.getParameter("toPage");
                  MatchFeeDetailModel mfdmNew=new MatchFeeDetailModel();
                  mfdmNew.setAddFeeId(request.getParameter("addFee"));
                  mfdmNew.setAddFeeShipperAmount(new BigDecimal(request.getParameter("additionalFee")));
                  mfdmNew.setAddFeeTruckAmount(new BigDecimal(request.getParameter("additionalCharge")));
                  mfdmNew.setMatchNumber(mcrm.getMatchNum());
                  if(mm.addMatchFee(mfdmNew))
                  {
                    matchFeeList.add(mfdmNew);
                   }
                  else
                   pageName="ErrorPage.jsp?errorMessage=ER_0001";
                }
           } 
}
response.sendRedirect(pageName);
%>
