<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.cbtb.model.*" %>
<%@ page import="com.cbtb.ejb.session.*" %>
<%@ page import="com.cbtb.web.*" %>
<%@ include file="Init.jsp"%>
<jsp:useBean id="web" scope="page" class="com.cbtb.web.WebOperator" />
<jsp:useBean id="mcrm" scope="session" class="com.cbtb.model.MatchModel" />
<%
      MatchManager matchManager = web.getMatchManager();
      String deliveryRequestNum=request.getParameter("deliveryRequestNum").trim();
      String truckCapacityNum=request.getParameter("truckCapacityNum").trim();
      mcrm=matchManager.match(deliveryRequestNum,truckCapacityNum);

      response.sendRedirect("ShipperCapacityMarket.jsp?init=Y&truckCapacityNum="+truckCapacityNum);

%>
