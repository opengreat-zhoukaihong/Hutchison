<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ page import="com.cbtb.exception.*" %>
<jsp:useBean id="cbtbErrorContext" scope="application" class="com.cbtb.web.CbtbErrorContext" />
<%
  boolean debug = true;
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
      errorDesc = exception.toString();
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
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="css/line.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000"><table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../images/logo_line.gif" width="160" height="30"></td>
  </tr>
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" width="760" height="53">
        <param name=movie value="../images/AS.swf">
        <param name=quality value=high>
        <embed src="../images/AS.swf" quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="760" height="53">
        </embed> 
      </object></td>
  </tr>
</table>
<title></title>
<style>
.link
{
font-size: 9pt; color: #FFFFFF; text-decoration: none
}
</style>
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
<p>&nbsp;</p>
</body>

</html>









