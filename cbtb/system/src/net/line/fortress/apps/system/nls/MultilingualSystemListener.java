package net.line.fortress.apps.system.nls;
import javax.servlet.http.*;
import net.line.fortress.apps.system.LogManager;
import java.util.*;
import java.sql.*;
import net.line.fortress.apps.system.utils.*;

public class MultilingualSystemListener implements HttpSessionBindingListener {

  public MultilingualSystemListener() {
  }

  public void valueBound(HttpSessionBindingEvent event) {
      LogManager.instance.logInfo("MultilingualSystemListener.valueBound: begin");
      LogManager.instance.logInfo("LogManager MultilingualSystem.getInstance()");
      //Initialize LanguageBundlePool
      LanguageBundlePool.getInstance();
      //Initialize MultilingualSystem instance and the base name of the property file
      MultilingualSystem.getInstance().setBaseName("Translation");

      //Define the default language and encoding ACCORDING TO THE USER PROFILE
      LogManager.instance.logInfo("LogManager Setting line.current.language and line.current.encoding");
      HttpSession session = event.getSession();
      session.setAttribute("line.current.language", "zh_TW");
      session.setAttribute("line.current.encoding", "big5");
      LogManager.instance.logInfo("MultilingualSystemListener.valueBound: end");
  }

  public void valueUnbound(HttpSessionBindingEvent event) {
  }
}