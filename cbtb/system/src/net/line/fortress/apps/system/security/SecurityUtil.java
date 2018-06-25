package net.line.fortress.apps.system.security;

import java.net.*;
import java.util.*;
import net.line.fortress.apps.system.*;
import javax.servlet.http.*;

public class SecurityUtil {
  public static boolean checkLogon(HttpServletRequest request, HttpServletResponse response) {
    return checkLogon(request, response, true);
  }
  public static boolean checkLogon(HttpServletRequest request, HttpServletResponse response, boolean doLogin) {
    HttpSession session = request.getSession();
    if (session.getAttribute("net.line.system.user") != null) {
      return true;
    } else if (doLogin) {
      String queryString = request.getQueryString();
      String url = request.getServletPath() + ((queryString != null)? "?" + queryString: "");
      return checkLogon(request, response, url);
    }
    return false;
  }
  public static boolean checkLogon(HttpServletRequest request, HttpServletResponse response, String redirectURL) {
    HttpSession session = request.getSession();
    if (session.getAttribute("net.line.system.user") != null) {
      return true;
    }
    String logonPage = request.getContextPath() + ConfigManager.getInstance().getProperty("net.line.system.logonPage");
    try {
      if ("GET".equalsIgnoreCase(request.getMethod())) {
        LogManager.instance.logDebug("redirect: " + logonPage);
        response.sendRedirect(logonPage + "?gotoPage=" + java.net.URLEncoder.encode(redirectURL));
      } else {
        LogManager.instance.logDebug("redirect: " + logonPage);
        response.sendRedirect(logonPage + "?gotoPage=" + java.net.URLEncoder.encode(redirectURL));
      }
    } catch (java.io.IOException e) {
      LogManager.instance.logError("Unable to redirect.", e);
    }
    return false;
  }
  public static boolean implies(PermissionContext context, HttpSession session) throws SecurityException {
    try {
      SecurityManager secMgr = SecuritySystem.getSecurityManager();
      return secMgr.implies((Vector)session.getAttribute("net.line.system.user.permission"), context);
    } catch (Exception e) {
      throw new SecurityManagerNotFoundException(e);
    }
  }
  public static DocumentPermissionContext getDocumentPermissionContext(HttpSession session) {
    DocumentPermissionContext ctx = (DocumentPermissionContext)session.getAttribute("net.line.permission.context.document");
    ctx.clear();
    return ctx;
  }
  public static OrganizationPermissionContext getOrganizationPermissionContext(HttpSession session) {
    OrganizationPermissionContext ctx = (OrganizationPermissionContext)session.getAttribute("net.line.permission.context.organization");
    ctx.clear();
    return ctx;
  }
  public static SecurityPermissionContext getSecurityPermissionContext(HttpSession session) {
    SecurityPermissionContext ctx = (SecurityPermissionContext)session.getAttribute("net.line.permission.context.security");
    ctx.clear();
    return ctx;
  }
  public static SystemPermissionContext getSystemPermissionContext(HttpSession session) {
    SystemPermissionContext ctx = (SystemPermissionContext)session.getAttribute("net.line.permission.context.system");
    ctx.clear();
    return ctx;
  }
  public static ViewPermissionContext getViewPermissionContext(HttpSession session) {
    ViewPermissionContext ctx = (ViewPermissionContext)session.getAttribute("net.line.permission.context.view");
    ctx.clear();
    return ctx;
  }
  public static String encrypt(String password) {
    java.security.MessageDigest md5 = null;
    try {
      md5 = java.security.MessageDigest.getInstance("MD5");
    } catch (java.security.NoSuchAlgorithmException e) {
      LogManager.instance.logError("Unable to use MD5 algorithm for encryption.", e);
      throw new RuntimeException("Unable to use MD5 algorithm for encryption.");
    }
    byte[] digest = md5.digest(password.getBytes());
    char[] hex = new char[digest.length * 2];
    for (int i = 0; i < digest.length; i++) {
      char c;
      c = (char)((digest[i] >> 4) & 0xf);
      if (c > 9) {
        c = (char)((c - 10) + 'a');
      } else {
        c = (char)(c + '0');
      }
      hex[2 * i] = c;
      c = (char)(digest[i] & 0xf);
      if (c > 9) {
        c = (char)((c - 10) + 'a');
      } else {
        c = (char)(c + '0');
      }
      hex[2 * i + 1] = c;
    }
    return String.valueOf(hex);
  }
/*
  public void login(HttpSession session) {
    try {
      SecurityManager secMgr = SecuritySystem.getSecurityManager();
      String domainID = ((Domain)session.getAttribute("net.line.system.domain")).getDomainID();
      String userID = ((User)session.getAttribute("net.line.system.user")).getUserID();
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
      String personID = secMgr.getPersonID(domainID, userID);
      session.setAttribute("net.line.system.person.id", personID);
    } catch (SecurityDBAccessException e) {
      session.setAttribute("net.line.system.error.message", "Internal error");
      LogManager.instance.logError("Error in Login.", e);
    } catch (SecurityUserNotFoundException e) {
      session.setAttribute("net.line.system.error.message", "Internal error");
      LogManager.instance.logError("Error in Login.", e);
    } catch (java.rmi.RemoteException e) {
      session.setAttribute("net.line.system.error.message", "Internal error");
      LogManager.instance.logError("Error in Login.", e);
    }
  }

  public void logout(HttpSession session) {
    try {
      Vector groups = (Vector)session.getAttribute("net.line.system.user.group");
      if (groups != null) {
        groups.removeAllElements();
        session.removeAttribute("net.line.system.user.group");
      }
      Hashtable allGroups = (Hashtable)session.getAttribute("net.line.system.group.all");
      if (allGroups != null) {
        for (Iterator i = allGroups.values().iterator(); i.hasNext();) {
          ((Vector)i.next()).removeAllElements();
        }
        allGroups.clear();
        session.removeAttribute("net.line.system.group.all");
      }
      Hashtable allPermissions = (Hashtable)session.getAttribute("net.line.system.permission.all");
      if (allPermissions != null) {
        for (Iterator i = allPermissions.values().iterator(); i.hasNext();) {
          Vector currentPermissions = (Vector)i.next();
          for (Iterator j = currentPermissions.iterator(); j.hasNext();) {
            ((Permission)j.next()).cleanup();
          }
          currentPermissions.removeAllElements();
        }
        allPermissions.clear();
        session.removeAttribute("net.line.system.permission.all");
      }
      Vector permissions = (Vector)session.getAttribute("net.line.system.user.permission");
      if (permissions != null) {
        for (Iterator j = permissions.iterator(); j.hasNext();) {
          ((Permission)j.next()).cleanup();
        }
        permissions.removeAllElements();
        session.removeAttribute("net.line.system.user.permission");
      }
      session.removeAttribute("net.line.system.person.id");
    } catch (Exception e) {
      LogManager.instance.logError("Error in Logout.", e);
    }
  }
*/
}