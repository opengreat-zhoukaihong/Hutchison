<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title> CBTB Login</title>

<style>
.link
{
font-size: 9pt; color: #FFFFFF; text-decoration: none
}
</style>
<script language=javascript>
function checkNull(){
login.submit();
return;
 if (document.login.userId.value=="")
    {
     alert ("Input your userId！");
     return ;
    }

 if (document.login.password.value=="")
    {
     alert ("Input your password！");
     return ;
    }

 if (document.login.organizationId.value=="")
    {
     alert ("Input your companyId！");
     return ;
    }
login.submit();
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<%@ page errorPage="ErrorPage.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="28" width="30%" bgcolor="#ff6666">&nbsp;</td>
    <td height="28" width="54%" bgcolor="#ff6666"> 
      <div align="right"><img src="../images/crossborder.jpg" width="172" height="28"></div>
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

<table border=0 cellpadding=0 cellspacing=0 width="100%">
  <tbody>
  <tr>
    <td height=5></td>
  </tr>
  <tr bgcolor=#003366>
    <td><img height=120 src="../images/photo.gif"
width=740></td>
  </tr>
  </tbody>
</table>
<form method=post name=login action="LoginTemp.jsp">
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
  <table width="59%" border="0" cellspacing="0" cellpadding="0" height="73" align="left">
    <tr>
      <td width="23%">
        <div align="right"></div>
      </td>
      <td width="23%">
        <div align="left">TL Login</div>
      </td>
      <td colspan="3"></td>
    </tr>
    <tr>
      <td width="23%">
        <div align="right"></div>
      </td>
      <td width="23%">
        <div align="left"><img src="../images/userId.jpg" width="111" height="18"></div>
      </td>
      <td colspan="3"><font size=3><span style="FONT-SIZE: 15px">
        <input type=text name=userId size=18>
        </span></font></td>
    </tr>
    <tr>
      <td width="23%">
        <div align="right"></div>
      </td>
      <td width="23%">
        <div align="left"><img src="../images/password.jpg" width="111" height="18"></div>
      </td>
      <td colspan="3"><font size=3><span style="FONT-SIZE: 15px">
        <input type=password  name=password size=18>
        </span></font></td>
    </tr>
    <tr>
      <td width="23%">
        <div align="right"></div>
      </td>
      <td width="23%"><img src="../images/organizationid.jpg" width="120" height="18"></td>
      <td colspan="3"><font size=3><span style="FONT-SIZE: 15px">
        <input  type=text name=organizationId size=18>
        </span></font></td>
    </tr>
    <tr>
      <td width="46%" colspan="2" rowspan="2">&nbsp;</td>
      <td width="11%">&nbsp;</td>
      <td width="23%">
        <div align="center"></div>
      </td>
      <td width="20%">&nbsp;</td>
    </tr>
    <tr>
      <td width="11%"><a href = "javascript:checkNull()"><img src="../images/login.jpg" width="57" height="18" border=0></a></td>
      <td width="23%">
        <div align="center"><a href = "javascript:login.reset()"><img src="../images/indexreset.jpg" width="57" height="18" border=0></a></div>
      </td>
      <td width="20%">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="5">&nbsp;</td>
    </tr>
  </table>


</form>
  <p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="331" border="0" align="center">
  <tr>
    <td><font size="2" color="003366">服務條款｜使用規則｜版權聲明｜隱私權聲明｜網站指南</font> <br>
      <font size="2" color="003366"><font face="Times New Roman, Times, serif">　　　Copyright
      2001 LINE. All Rights Reserved</font></font> </td>
  </tr>
</table>
</body>
</html>
