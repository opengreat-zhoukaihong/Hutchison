package com.cbtb.web;

import com.cbtb.util.*;
import com.cbtb.ejb.session.*;
import com.cbtb.model.*;
import net.line.fortress.apps.system.security.*;
import net.line.fortress.apps.system.ejb.*;
import net.line.fortress.apps.system.security.SecurityManager;
import java.util.*;
import com.cbtb.exception.*;

/**
 * Title:        Team Leader
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      hutchtech
 * @author Kevin_zhou
 * @version 1.0
 */

public class WebOperator {

  private EjbUtil ejbUtil = new EjbUtil();
  private SecurityManager secMgr;
  private Domain domain ;
  private User logonUser;
  private Vector groups ;
  private Hashtable allGroups ;
  private Hashtable allPermissions ;
  private Vector permissions ;
  private PermissionContext permissionContext ;
  private String personID ;
  private boolean isLogin = false;
  private boolean  isPass = false;
  private String domainID;
  private String userID;
  private String langCode;
  private String commChannel;




  public WebOperator() {
  }

  public CompanyManager getCompanyManager() {
    return ejbUtil.getCompanyManager();
  }

  public BillingManager getBillingManager()
  {
    return ejbUtil.getBillingManager();
  }

  public MatchManager getMatchManager()
  {
    return ejbUtil.getMatchManager();
  }

  public MasterManager getMasterManager()
  {
    return ejbUtil.getMasterManager();
  }

  //Kevin/////////////////////////////////////////////////

  public boolean login(String domainID, String userID, String password)
  { System.out.println("domainID:"+domainID + " userID:"+userID+" password:"+password);
    isLogin = false;
    try {
      secMgr = SecuritySystem.getSecurityManager();
      domain = secMgr.getDomain(domainID);
      System.out.println("domain:"+domain);
      logonUser = secMgr.authenticate(domainID, userID,
                  SecurityUtil.encrypt(password), true, domain);
      System.out.println("logonUser:"+logonUser);
      groups =  secMgr.getQualifiedGroupIDs(domainID, userID);
      System.out.println("groups:"+groups.toString());
      allGroups = secMgr.getAllGroupsWithMembers(domainID);
      System.out.println("allgroups:"+allGroups.toString());
      allPermissions = secMgr.getAllUsersWithPermissions(domainID);
      System.out.println("allPermissions:"+allPermissions.toString());
      permissions = secMgr.getPermissions(domainID, userID);
      System.out.println("permissions:"+permissions.toString());
      //Vector permissions = (Vector)allPermissions.get(userID);
      permissionContext = new DocumentPermissionContext(domainID, userID, groups, allGroups);
      System.out.println("permissionContext:"+permissionContext);
      //permissionContext.put("document_type", "DR");
      //permissionContext.put("action", "view");
      personID = secMgr.getPersonID(domainID, userID);
      System.out.println("personID:"+personID);
      secMgr = null;
      isLogin = true;
      this.domainID = domainID;
      this.userID = userID;

      //System.out.print(secMgr.implies(secMgr.getPermissions(domainID,userID),
                //   permissionContext));
    }
    catch (Exception e) {
      System.out.print(e.getMessage());
    }
    return isLogin;
  }

  public void clearPermissionContext()
  {
    if (permissionContext != null)
      permissionContext.clear();
  }

  public void putPermissionContext(String key, Object value)
  {
    if (permissionContext != null)
    {
      permissionContext.put(key, value);
    }
  }

  public boolean checkPermission()
  {
    isPass = false;
    try
    {
      if (isLogin)
      {
        secMgr = SecuritySystem.getSecurityManager();
        isPass = secMgr.implies(permissions, permissionContext);
        secMgr = null;
      }
    }
    catch (Exception e)
    {
      isPass = false;
    }
    return isPass;
  }

  public boolean checkLogin()
  {
    return isLogin;
  }

  public void logout()
  {
    isLogin = false;
    domain = null;
    logonUser= null;
    groups = null;
    allGroups = null;
    allPermissions = null;
    permissions = null;
    permissionContext = null ;
    personID = "" ;
  }

  public String getDomainID()
  {
    return domainID;
  }

  public String getUserID()
  {
    return userID;
  }

  public boolean changePassword(String currentPassword, String newPassword)
  {
    try
    {
      secMgr = SecuritySystem.getSecurityManager();
      secMgr.changePassword(domainID, userID, currentPassword, newPassword, true);
      secMgr = null;
      return true;
    }
    catch (Exception e)
    {
      return false;
    }
  }

  public static void main(String[] args)
  {
    WebOperator wo = new WebOperator();
    System.out.print(wo.login("HITSD","sdrequestor1","password"));
  }
}