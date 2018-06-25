package net.line.fortress.apps.system.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import net.line.fortress.apps.system.security.SecurityManager;
import net.line.fortress.apps.system.security.*;
import net.line.fortress.apps.system.*;
import weblogic.servlet.security.ServletAuthentication;

public class srvAuthentication extends HttpServlet {
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    LogManager.instance.logDebug("begin service");
    String userID = request.getParameter("userID");
    String password = request.getParameter("password");
    String domainID = request.getParameter("domainID");
    String gotoPage = request.getParameter("gotoPage");
    String errorPage = request.getParameter("errorPage");
    String changePasswordPage = request.getParameter("changePasswordPage");
    String exitPage = request.getParameter("exitPage");
    String indexPage = ConfigManager.getInstance().getProperty("net.line.system.indexPage");

    if (userID == null || password == null || domainID == null ||
        gotoPage == null || errorPage == null || changePasswordPage == null) {
      response.sendRedirect(indexPage);
      return;
    }
    HttpSession session = null;
    try {
      session = request.getSession();
      if (session.getAttribute("net.line.system.user") != null) {
        session.invalidate();
        response.sendRedirect(indexPage);
        return;
      }
      SecurityManager secMgr = SecuritySystem.getSecurityManager();
      Domain domain = secMgr.getDomain(domainID);
      User logonUser = secMgr.authenticate(domainID, userID, SecurityUtil.encrypt(password), true, domain);

      //WebLogic 6.0 only
      //ServletAuthentication.weak("_APP_USER", "USER", session);

      session.setAttribute("net.line.system.domain", domain);
      session.setAttribute("net.line.system.user", logonUser);

      Vector groups = secMgr.getQualifiedGroupIDs(domainID, userID);
      session.setAttribute("net.line.system.user.group", groups);
      Hashtable allGroups = secMgr.getAllGroupsWithMembers(domainID);
      session.setAttribute("net.line.system.group.all", allGroups);
      Hashtable allPermissions = secMgr.getAllUsersWithPermissions(domainID);
      session.setAttribute("net.line.system.permission.all", allPermissions);
      //Vector permissions = secMgr.getPermissions(domainID, userID);
      Vector permissions = (Vector)allPermissions.get(userID);
      if (permissions != null) {
        session.setAttribute("net.line.system.user.permission", permissions);
      }
      session.setAttribute("net.line.permission.context.document",
                       new DocumentPermissionContext(domainID, userID, groups, allGroups));
      session.setAttribute("net.line.permission.context.organization",
                       new OrganizationPermissionContext(domainID, userID, groups, allGroups));
      session.setAttribute("net.line.permission.context.security",
                       new SecurityPermissionContext(domainID, userID, groups, allGroups));
      session.setAttribute("net.line.permission.context.system",
                       new SystemPermissionContext(domainID, userID, groups, allGroups));
      session.setAttribute("net.line.permission.context.view",
                       new ViewPermissionContext(domainID, userID, groups, allGroups));

      String personID = secMgr.getPersonID(domainID, userID);
      session.setAttribute("net.line.system.person.id", personID);

      //  add session object
      for (int i = 1; true; i++) {
        String classname = ConfigManager.getInstance().getProperty("net.line.system.httpSession.listener." + i);
        if (classname == null) break;
        try {
          Object obj = Class.forName(classname).newInstance();
          session.setAttribute("net.line.system.httpSession.listener." + i, obj);
        } catch (ClassNotFoundException e) {
          LogManager.instance.logError("Cannot create " + classname);
        }
      }

      LogManager.instance.logInfo("user <" + domainID + "/" + userID + "> logged in");
//      session.setAttribute("net.line.system.page.all", new Vector());
      if (exitPage != null) {
        session.setAttribute("net.line.system.document.exitPage", exitPage);
      }

      response.setHeader("pragma", "no-cache");
      response.setIntHeader("expires", 0);
      if (logonUser.isChangePwdNextLogon()) {
        response.sendRedirect(changePasswordPage + "?gotoPage=" + response.encodeRedirectURL(gotoPage));
      } else {
        LogManager.instance.logDebug("redirect: " + response.encodeRedirectURL(gotoPage));
        response.sendRedirect(response.encodeRedirectURL(gotoPage));
      }
      return;
    } catch (SecurityDomainNotFoundException e) {
      session.setAttribute("net.line.system.error.message", "Invalid domain");
      LogManager.instance.logError("Error in Login.", e);
    } catch (SecurityDBAccessException e) {
      session.setAttribute("net.line.system.error.message", "Internal error");
      LogManager.instance.logError("Error in Login.", e);
    } catch (SecurityUserNotFoundException e) {
      session.setAttribute("net.line.system.error.message", "Invalid userid/password");
      LogManager.instance.logError("Error in Login.", e);
    } catch (SecurityInvalidPasswordException e) {
      session.setAttribute("net.line.system.error.message", "Invalid userid/password");
      LogManager.instance.logError("Error in Login.", e);
    } catch (SecurityUserSuspendedException e) {
      session.setAttribute("net.line.system.error.message", "User is suspended");
      LogManager.instance.logError("Error in Login.", e);
    } catch (Exception e) {
      LogManager.instance.logError("Error in Login.", e);
    }
    response.setHeader("pragma", "no-cache");
    response.setIntHeader("expires", 0);
    response.sendRedirect(errorPage);
    LogManager.instance.logDebug("end service");
  }
  /**Clean up resources*/
  public void destroy() {
  }
}