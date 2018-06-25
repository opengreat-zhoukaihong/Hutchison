package net.line.fortress.apps.system.init;

import weblogic.common.*;
import java.util.*;
import net.line.fortress.apps.system.*;

public class ServerInitialization implements T3StartupDef {
  private T3ServicesDef services;

  public ServerInitialization() {
  }

  public void setServices(T3ServicesDef services) {
    this.services = services;
  }

  public String startup(String name, Hashtable args) throws Exception {
    // Write your startup code here...
    LogManager.instance.logInfo("LogManager Initialization Finished");
    ConfigManager cfgMgr = ConfigManager.getInstance();
    for (int i = 1; true; i++) {
      String classname = cfgMgr.getProperty("net.line.system.serverStartup.class." + i);
      if (classname == null) break;
      try {
        Class.forName(classname).newInstance();
        LogManager.instance.logInfo(classname + " created");
      } catch (ClassNotFoundException e) {
        LogManager.instance.logError("Cannot create " + classname, e);
      }
    }
    return "ServerInitialization Finished";
  }
}