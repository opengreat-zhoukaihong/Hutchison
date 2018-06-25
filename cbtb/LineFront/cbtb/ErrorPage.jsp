<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ page import="com.cbtb.exception.*" %>
<jsp:useBean id="cbtbErrorContext" scope="application" class="com.cbtb.web.CbtbErrorContext" />
<%
  boolean debug = false;
  String errorCode=null, errorLevel=null, errorDesc=null;
  String language = "CN";
  if ((exception != null) && (exception instanceof CbtbException))
  {
    errorCode = exception.getMessage();
    errorDesc = cbtbErrorContext.getCodeDesc(errorCode, language);
  }
  else if ((exception != null) && (exception instanceof java.rmi.RemoteException))
  {
    if (((java.rmi.RemoteException) exception).detail != null)
    {
      errorCode = ((java.rmi.RemoteException) exception).detail.getMessage(); 
      errorDesc = cbtbErrorContext.getCodeDesc(errorCode, language);
    }
  }
  else if (exception != null)
  {
    if (debug) 
    {    
      errorCode = exception.getMessage();
      //errorDesc = exception.toString();
    }
    else
    {
      errorCode = "ER_0001";
      errorDesc = cbtbErrorContext.getCodeDesc(errorCode, language);
    }
  }
  else
  {
    errorCode = request.getParameter("errorMessage");
    if ((errorCode != null) && (errorCode.trim().length() > 0))
    {
      errorDesc = cbtbErrorContext.getCodeDesc(errorCode, language);
    }
    else
    {
      errorCode = "ER_0800";
      errorDesc = cbtbErrorContext.getCodeDesc(errorCode, language);
    }
  }
  if ((!debug) && ((errorDesc == null) || (errorDesc.trim().length() < 1)))
  {
      errorCode = "ER_0001";
      errorDesc = cbtbErrorContext.getCodeDesc(errorCode, language);
  }
%>
<html>
<head>
<title>Untitled Document</title>
<style>
.link
{
font-size: 9pt; color: #FFFFFF; text-decoration: none
}
</style>

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="28" width="30%" bgcolor="#ff6666">&nbsp;</td>
    <td height="28" width="54%" bgcolor="#ff6666"> 
      <div align="right"><img src="../images/cross%20border.jpg" width="172" height="28"></div>
    </td>
    <td height="28" width="16%" bgcolor="#ff6666">&nbsp;</td>
  </tr>
  <tr> 
    <td height="33" bgcolor="#003366" width="30%">  
      <div align="left"><font size="2"><font color="#FFFFFF">&nbsp;<a href="about.htm"><span class="link">關於我們</span></a> 
        | <a href="Faq.htm"><span class="link">常見問題</span></a> | </font><a href="mailto:webmaster@hutchtech.com.cn" class="link"><span class="link">聯絡我們</span></a></font></div>
    </td>
    <td height="33" bgcolor="#003366" width="54%">&nbsp;</td>
    <td height="33" bgcolor="#003366" width="16%"> 
      <div align="left"><img src="../images/Trucking.jpg" width="116" height="28"></div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="10" >
  <tr> 
    <td bgcolor="#FF6666"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="7" bgcolor="#FFFFFF">
  <tr>
    <td></td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30"> 
      <div align="center"></div>
    </td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="10%">&nbsp;</td>
    <td width="90%"><img src="../images/errorcode.jpg" width="111" height="18"></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="90%"> 
      <div align="left"></div>
      <table width="90%" border="2" cellspacing="1" cellpadding="5" height="40" bordercolor="#666666">
        <tr> 
          <td><%=errorCode%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="10%">&nbsp;</td>
    <td width="90%"><img src="../images/level.jpg" width="111" height="18"></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="90%"> 
      <table width="90%" border="2" cellspacing="1" cellpadding="5" height="40" bordercolor="#666666">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="10%">&nbsp;</td>
    <td width="90%"><img src="../images/description.jpg" width="111" height="18"></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="90%"> 
      <table width="90%" border="2" cellspacing="1" cellpadding="5" height="93" bordercolor="#666666">
        <tr> 
          <td>
<%
  if (debug) 
  {
    if ((errorDesc == null) || (errorDesc.trim().length() == 0)) out.print(exception);
    else out.println(errorDesc);
  }
  else out.print(errorDesc);
%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
</table>
<table width="89%" border="0" cellspacing="0" cellpadding="0" height="42">
  <tr> 
    <td> 
      <div align="right"><a href="javascript:history.back()"><img src="../images/back.jpg" width="44" height="19" border="0"></a></div>
    </td>
  </tr>
</table>
<table width="334" border="0" align="center">
  <tr> 
    <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
      <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright 
      2001 LINE. All Rights Reserved</font></font> </td>
  </tr>
</table>
</body>
</html>
