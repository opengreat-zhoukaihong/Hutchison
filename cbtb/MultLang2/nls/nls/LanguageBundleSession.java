package net.line.fortress.apps.system.nls;

import javax.servlet.http.*;
import java.util.*;
import net.line.fortress.apps.system.LogManager;

public class LanguageBundleSession extends Hashtable implements HttpSessionBindingListener {

  public LanguageBundleSession() {
  }

  public void valueBound(HttpSessionBindingEvent event) {
  }

  public void valueUnbound(HttpSessionBindingEvent event) {
      LogManager.instance.logInfo("LanguageBundleSession.valueUnbound: begin size = " + this.size());
      HttpSession session = event.getSession();
      if (this != null) {
          this.clear();
      }
  }
}