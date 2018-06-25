<%@ page import="com.arena.universe.utility.StringUtil"%>
<%@ page import="com.arena.universe.crypto.client.*"%>
<%
    String plaintext = null, encryptedtext = null;
    try{
      ClientCipherManager ccm = ClientCipherSystem.getInstance();
      java.security.PublicKey arenaPubk = null;
      java.security.PrivateKey cbtbPrik = null;
      cbtbPrik = ccm.readPrivateKey(new FileInputStream("ABAPrivateKey_CBTB.key"));
      arenaPubk = ccm.readPublicKey(new FileInputStream("ABAPublicKey_ARENA.key"));

      //  decrypt
      encryptedtext = request.getParameter("RequestData");
      System.out.println("encryptedtext: "+encryptedtext);
      encryptedtext = ccm.decrypt(encryptedtext, arenaPubk);
      plaintext = ccm.decrypt(encryptedtext, cbtbPrik);
      System.out.println("plaintext: "+plaintext);

      //  encrypt
      plaintext = "organizationId=HITSD,userId=sdrequestor1,password=password,TimeStamp="+StringUtil.timestamp2Str(new Timestamp(System.currentTimeMillis()), "yyyy-MM-dd_HH:mm:ss.SSS");
      encryptedtext = ccm.encrypt(plaintext, arenaPubk);
      encryptedtext = ccm.encrypt(encryptedtext, cbtbPrik);
      System.out.println("encryptedtext: "+encryptedtext);

    } catch(Exception e){
      e.printStackTrace();
    }
    response.sendRedirect("http://192.168.0.149/dev_carmen/SingleLogon_TL?RequestData="+encryptedtext);

%>