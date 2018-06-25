package net.line.fortress.apps.system.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import net.line.fortress.apps.system.*;
import net.line.fortress.apps.system.security.*;
import net.line.fortress.apps.system.security.SecurityManager;

public class srvChangePassword extends HttpServlet {
  private static final String CONTENT_TYPE = "text/html";
  private static final String DOC_TYPE = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n" +
      "  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">";
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if (!SecurityUtil.checkLogon(request, response)) {
      return;
    }
    HttpSession session = request.getSession();
    String gotoPage = (String)request.getParameter("gotoPage");
    gotoPage = (gotoPage == null)? ConfigManager.getInstance().getProperty("net.line.system.indexPage"): gotoPage;
    String errorPage = ConfigManager.getInstance().getProperty("net.line.system.errorPage");
    User user = (User)session.getAttribute("net.line.system.user");
    String domainID = user.getDomainID();
    String userID = user.getUserID();
    String currentPassword = (String)request.getParameter("currentPwd");
    String newPassword = (String)request.getParameter("newPwd");
    String confirmPassword = (String)request.getParameter("confirmPwd");
    if (currentPassword == null || newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
      session.setAttribute("net.line.system.error.message", "Cannot change password");
      response.sendRedirect(errorPage);
      return;
    } else {
      try {
        SecurityManager secMgr = SecuritySystem.getSecurityManager();
        secMgr.changePassword(domainID, userID, SecurityUtil.encrypt(currentPassword), SecurityUtil.encrypt(newPassword), true);
        response.sendRedirect(gotoPage);
      } catch (Exception e) {
        session.setAttribute("net.line.system.error.message", "Cannot change password");
        response.sendRedirect(errorPage);
        return;
      }
    }
  }
  /**Clean up resources*/
  public void destroy() {
  }
}