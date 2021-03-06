package net.line.fortress.apps.system.security;

import net.line.fortress.apps.system.ejb.*;
import javax.naming.*;
import java.util.*;
import javax.ejb.*;
import net.line.fortress.apps.system.*;
import javax.rmi.PortableRemoteObject;
import java.io.*;
public class SecuritySystem {
  private static final int MAX_OUTPUT_LINE_LENGTH = 50;
  private static String url = null;
  private static String user = null;
  private static String password = null;
  private static net.line.fortress.apps.system.security.SecurityManager instance = null;
  private static Context getInitialContext() throws Exception
  {
    // add one line
   // setApplicationServer();
    System.out.println("*********:"+ConfigManager.getInstance().getProperty("net.line.applicationServer.url"));
    url = ConfigManager.getInstance().getProperty("net.line.applicationServer.url","t3://localhost:7001");
    System.out.println("*******************************"+url);
    Properties properties = null;
    try
    {
      properties = new Properties();
      properties.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
      properties.put(Context.PROVIDER_URL, url);
      if (user != null)
      {
        properties.put(Context.SECURITY_PRINCIPAL, user);
        properties.put(Context.SECURITY_CREDENTIALS, password == null ? "" : password);
      }
    }
    catch(Exception e)
    {
      throw e;
    }
    return new InitialContext(properties);
  }

  public static net.line.fortress.apps.system.security.SecurityManager getSecurityManager() {
    if (instance == null) {
      instance = initInstance();
    }
    return instance;
  }

  private static synchronized net.line.fortress.apps.system.security.SecurityManager initInstance() {
  Context ctx = null;
  try{
      ctx = getInitialContext();
      Object objref = ctx.lookup("ejb.BasicSecurityManagerImpl");
      BasicSecurityManagerImplHome beanHome = (BasicSecurityManagerImplHome) PortableRemoteObject.narrow(objref,BasicSecurityManagerImplHome.class);
      return beanHome.create();
    } catch (Exception e){
      LogManager.instance.logError("Unable get SecurityManager.", e);
      return null;
    } finally {
      try {
        ctx.close();
      }
      catch (Exception e) {
      }
    }
  }
}