﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<HTML>
<HEAD>
<%@ page import="net.line.fortress.apps.system.nls.*" %>
<jsp:useBean id="Jsp1BeanId" scope="session" class="test.Jsp1Bean" />
<jsp:setProperty name="Jsp1BeanId" property="*" />
<TITLE>
Jsp1
</TITLE>
</HEAD>
<BODY>
<H1>
JBuilder Generated JSP
</H1>
<%

   out.print("口若悬河");
      MultilingualSystem.getInstance().setBaseName("Translation");
      //Initialize FilePool
      FilePool.getInstance();

      //Define the default language and encoding ACCORDING TO THE USER PROFILE
      //LogManager.instance.logInfo("LogManager Setting line.current.language and line.current.encoding");
      //HttpSession session = event.getSession();
      session.setAttribute("line.current.language", "zh_TW");
      session.setAttribute("line.current.encoding", "UTF-8");
      //LogManager.instance.logInfo("MultilingualSystemListener.valueBound: end");
      MultilingualSystem system = MultilingualSystem.getInstance();
      system.setCharacterset(request,response);
      LanguageBundleSystem localLabels = system.getLabels(session,"HIT");
      out.println(localLabels.getProperty("Shipper ID"));
      out.print(localLabels.getProperty("Billing"));
      out.print(localLabels.getProperty("Billingdsfdsfdsfdsf"));

      /*session.setAttribute("line.current.language", "zh_TW");
      session.setAttribute("line.current.encoding", "big5");
      system = MultilingualSystem.getInstance();
      system.setCharacterset(request,response);
      out.println(localLabels.getProperty("Shipper ID"));
      out.print(localLabels.getProperty("Billing"));
      out.print(localLabels.getProperty("Billingdsfdsfdsfdsf"));*/
%>

<FORM method="post">
<BR>Enter new value   :  <INPUT NAME="sample"><BR>
<BR><BR>
<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Submit">
<INPUT TYPE="RESET" VALUE="Reset">
<BR>
Value of Bean property is :<jsp:getProperty name="Jsp1BeanId" property="sample" />
</FORM>
</BODY>
</HTML>
