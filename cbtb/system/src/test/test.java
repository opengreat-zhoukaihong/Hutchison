package test;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */
import net.line.fortress.apps.system.security.*;
import net.line.fortress.apps.system.ejb.*;
import java.util.*;
import net.line.fortress.apps.system.*;
import java.sql.Timestamp;


public class test {

  public test() {
  }

  public static void main(String[] args) {
    String domainID = "Hutch";
    String userID = "Oper1";
    String password = SecurityUtil.encrypt("740114");
    Timestamp ts = new Timestamp(new Date().getTime());
    net.line.fortress.apps.system.security.SecurityManager secMgr = SecuritySystem.getSecurityManager();

    User user = new User(domainID,userID,null,"ALAN",null,false,false,false,0,0,ts,ts,ts,"SYSTEM",ts);
    try{
      //secMgr.createDomain(domain);
      //secMgr.createUser(user,"PersonID");
      //secMgr.addExternalGroupMembership(user,"admin");
      secMgr.removeExternalGroupMembership(user,"CBTShipperAdminGp");
    }catch(Exception e)
    {
      e.printStackTrace();
    }

  }
}