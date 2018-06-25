package net.line.fortress.apps.system.ejb;

import java.sql.*;
import java.util.*;
import java.rmi.*;
import javax.ejb.*;
import net.line.fortress.apps.system.security.*;
import com.arena.universe.security.operator.*;
import net.line.fortress.apps.system.utils.*;
import net.line.fortress.apps.system.*;

public class BasicSecurityManagerImplBean implements SessionBean, net.line.fortress.apps.system.security.SecurityManager {
  private static final long noOfMillisInADay = 24 * 60 * 60 * 1000;
  private SessionContext sessionContext;
  private Hashtable operatorLookup = new Hashtable();
  public void ejbCreate() {
  }
  public void ejbRemove() {
  }
  public void ejbActivate() {
  }
  public void ejbPassivate() {
  }
  public void setSessionContext(SessionContext context) {
    sessionContext = context;
  }

  public Domain getDomain(String domainID)
    throws SecurityDomainNotFoundException,
           SecurityDBAccessException {
    Domain domain = null;
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sQuery = "SELECT domain_name, description, domain_type, " +
                    "       max_no_of_logon_attempt, max_no_of_grace_logon, consecutive_logon_interval, " +
                    "       inactive_period_in_days, password_expiry_period_in_days, countdown_enable_in_days " +
                    "FROM SEC_Domain " +
                    "WHERE domain_id = ? ";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
        throw new SecurityDomainNotFoundException();
      }
      domain = new Domain(domainID,
                          SQLUtil.getNullString(rSet, "domain_name", null),
                          SQLUtil.getNullString(rSet, "description", null),
                          rSet.getString("domain_type"),
                          rSet.getInt("max_no_of_logon_attempt"),
                          rSet.getInt("max_no_of_grace_logon"),
                          rSet.getInt("consecutive_logon_interval"),
                          rSet.getInt("inactive_period_in_days"),
                          rSet.getInt("password_expiry_period_in_days"),
                          rSet.getInt("countdown_enable_in_days"));
      return domain;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getDomain() for " + domainID, e);
      throw new SecurityDBAccessException(e);
    } finally {
    if (rSet != null) {
      try {
        rSet.close();
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to close the rSet.", e);
      }
    }
    if (pStmt != null) {
      try {
        pStmt.close();
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to close the pStmt.", e);
      }
    }
    if (connection != null) {
      try {
        connection.close();
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to close the connection.", e);
      }
    }
  }


  }
  public User findUser(String encryptedDomainID,
                       String encryptedUserID,
                       String encryptedPassword)
    throws SecurityDBAccessException,
           SecurityUserNotFoundException
  {
    User user =  null;
    String domainID = null,userID = null,password = null;
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sSql = " SELECT Domain_ID,User_ID,password " +
                  " FROM    SEC_USER_DETAILS " +
                  " WHERE   password = '" + encryptedPassword +"'";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sSql);
      rSet = pStmt.executeQuery();
      while (rSet.next()) {
        domainID = rSet.getString("Domain_ID");
        userID = rSet.getString("User_ID");
        password = rSet.getString("password");
        if(  net.line.fortress.apps.system.security.SecurityUtil.encrypt(domainID).equals(encryptedDomainID)
           && net.line.fortress.apps.system.security.SecurityUtil.encrypt(userID).equals(encryptedUserID)
           )
        {
            user = new User(domainID,userID,null,null,null,false,false,false,0,0,null,null,null,null,null);
            break;
        }
      }//end while
      if(user == null) throw new SecurityUserNotFoundException();
      return user;
    }catch (SQLException e) {
      LogManager.instance.logError("Unable to find for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }//end finally
  }

  public User authenticate(String domainID,
                           String userID,
                           String encryptedPassword,
                           boolean checkPassword,
                           Domain domain)
    throws SecurityUserNotFoundException,
           SecurityUserSuspendedException,
           SecurityInvalidPasswordException,
           SecurityDBAccessException {
    User user = null;
    Connection connection = null;
    PreparedStatement pStmt = null, lStmt = null;
    ResultSet rSet = null;
    String sLock = "LOCK TABLE Sec_User_details IN ROW EXCLUSIVE MODE";
    String sQuery = "SELECT password, user_name, description, " +
                    "       suspended, ever_expired, change_pwd_next_logon, " +
                    "       no_of_failed_attempt, no_of_grace_logon, " +
                    "       last_attempt_timestamp, last_access_timestamp, last_modify_timestamp, " +
                    "       created_by, creation_timestamp " +
                    "FROM SEC_User_Details " +
                    "WHERE domain_id = ? " +
                    "AND user_id = ? " +
                    "FOR UPDATE ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      lStmt = connection.prepareStatement(sLock);
      lStmt.executeUpdate();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      pStmt.setString(2, userID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
        throw new SecurityUserNotFoundException();
      }
      user = new User(domainID,
                      userID,
                      rSet.getString("password"),
                      SQLUtil.getNullString(rSet, "user_name", null),
                      SQLUtil.getNullString(rSet, "description", null),
                      rSet.getString("suspended").equals("Y") ? true : false,
                      rSet.getString("ever_expired").equals("Y") ? true : false,
                      rSet.getString("change_pwd_next_logon").equals("Y") ? true : false,
                      rSet.getInt("no_of_failed_attempt"),
                      rSet.getInt("no_of_grace_logon"),
                      rSet.getTimestamp("last_attempt_timestamp"),
                      rSet.getTimestamp("last_access_timestamp"),
                      rSet.getTimestamp("last_modify_timestamp"),
                      rSet.getString("created_by"),
                      rSet.getTimestamp("creation_timestamp"));
      if (user.isSuspended()) {
        throw new SecurityUserSuspendedException();
      }
      if (checkPassword == true && !user.getPassword().equals(encryptedPassword)) {
        if (System.currentTimeMillis() - user.getLastAttemptTimestamp().getTime() <=
            domain.getConsecutiveLogonInterval()) {
          user.setNoOfFailedAttempt(user.getNoOfFailedAttempt() + 1);
        } else {
          user.setNoOfFailedAttempt(1);
        }
        if (user.getNoOfFailedAttempt() >= domain.getMaxNoOfLogonAttempt()) {
          user.setSuspended(true);
          user.setNoOfFailedAttempt(0);
        }
        user.setLastAttemptTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
        updateUser(user, connection);
        commit = true;
        throw new SecurityInvalidPasswordException();
      }
      user.setLastAttemptTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
      user.setNoOfFailedAttempt(0);
      System.out.println("System.currentTimeMillis():"+System.currentTimeMillis());
      System.out.println("user.getLastAccessTimestamp().getTime():"+user.getLastAccessTimestamp().getTime());
      System.out.println("noOfMillisInADay:"+noOfMillisInADay);
      System.out.println("domain.getInactivePeriodInDays():"+domain.getInactivePeriodInDays());

      if (System.currentTimeMillis() - user.getLastAccessTimestamp().getTime() >
        domain.getInactivePeriodInDays() * noOfMillisInADay) {
        user.setSuspended(true);
        updateUser(user, connection);
        commit = true;
        throw new SecurityUserSuspendedException();
      }

      if (user.isEverExpired() &&
          System.currentTimeMillis() - user.getLastModifyTimestamp().getTime() >
        domain.getPasswordExpiryPeriodInDays() * noOfMillisInADay) {
        if (user.getNoOfGraceLogon() >= domain.getMaxNoOfGraceLogon()) {
          user.setSuspended(true);
          user.setNoOfGraceLogon(0);
          updateUser(user, connection);
          commit = true;
          throw new SecurityUserSuspendedException();
        } else {
          user.setNoOfGraceLogon(user.getNoOfGraceLogon() + 1);
        }
      } else {
        user.setNoOfGraceLogon(0);
      }
      user.setLastAccessTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
      updateUser(user, connection);
      commit = true;
      return user;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to authenticate() for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (lStmt != null) {
        try {
          lStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the lStmt.", e);
        }
      }
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }



  public java.util.Vector getQualifiedGroupIDs(String domainID,
                                               String userID)
    throws SecurityDBAccessException {
    Vector groups = new Vector();
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sQuery = "SELECT domain_id || '/' || group_id " +
                    "FROM SEC_Group_Membership " +
                    "WHERE domain_id = '" + domainID + "' " +
                    "AND user_or_group = 'U' " +
                    "AND principal = '" + userID + "' " +
                    "Union all " +
                    "SELECT domain_id || '/' || group_id " +
                    "FROM SEC_External_Group_Membership " +
                    "WHERE domain_id = 'PUBLIC' " +
                    "AND user_or_group = 'U' " +
                    "AND principal_domain_id = '" + domainID + "' " +
                    "AND principal = '" + userID + "' ";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      rSet = pStmt.executeQuery();
      while (rSet.next()) {
        groups.addElement(rSet.getString(1));
      }
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getGroups() for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
    return groups;
  }

  public java.util.Hashtable getAllGroupsWithMembers(String domainID)
    throws SecurityDBAccessException {
    Hashtable allGroups = new Hashtable();
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sQuery = "SELECT group_id, principal " +
                    "FROM SEC_Group_Membership " +
                    "WHERE domain_ID = ? " +
                    "AND user_or_group = 'U' " +
                    "ORDER BY group_id ";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      rSet = pStmt.executeQuery();
      String lastGroupID = null;
      String groupID = null;
      Vector currentGroup = null;
      while (rSet.next()) {
        groupID = rSet.getString(1);
        if (!groupID.equals(lastGroupID)) {
          currentGroup = new Vector();
          allGroups.put(groupID, currentGroup);
          lastGroupID = groupID;
        }
        currentGroup.addElement(rSet.getString(2));
      }
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getAllGroups() for " + domainID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
    return allGroups;
  }

  public java.util.Vector getPermissions(String domainID,
                                         String userID)
    throws SecurityDBAccessException {
    Vector permissions = new Vector();
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    Vector groupList = this.getQualifiedGroupIDs(domainID, userID);
    String sQuery = "SELECT (p.domain_id || p.permission_id) permission_id," +
                    "       p.permission_type, e.attribute, o.implement_class_name, e.value " +
                    "FROM SEC_Permission p, SEC_Expression e, SEC_Operator o " +
                    "WHERE p.domain_id = e.domain_id " +
                    "AND p.permission_id = e.permission_id " +
                    "AND e.attribute_type = o.attribute_type " +
                    "AND e.operator = o.operator " +

                    "AND ((    p.user_or_group = 'U' " +
                    "      AND p.principal = '" + userID + "' " +
                    "      AND p.domain_id = '" + domainID + "') OR " +
                    "     (    p.user_or_group = 'G' " +
                    "      AND p.principal in (SELECT group_id " +
                    "                          FROM SEC_Group_Membership m " +
                    "                          WHERE m.user_or_group = 'U' " +
                    "                          AND m.principal = '" + userID + "' " +
                    "                          AND m.domain_id = '" + domainID + "') " +
                    "      AND p.domain_id = '" + domainID + "') OR " +
                    "     (    p.user_or_group = 'G' " +
                    "      AND p.principal in (SELECT group_id " +
                    "                          FROM SEC_External_Group_Membership m " +
                    "                          WHERE m.user_or_group = 'U' " +
                    "                          AND m.domain_id = 'PUBLIC' " +
                    "                          AND m.principal_domain_id = '" + domainID + "' " +
                    "                          AND m.principal = '" + userID + "') " +
                    "      AND p.domain_id = 'PUBLIC') OR " +
                    "       (    p.user_or_group = 'G' " +
                    "        AND p.principal in (SELECT em.group_id " +
                    "                            FROM SEC_Group_Membership m, SEC_External_Group_Membership em " +
                    "                            WHERE em.user_or_group = 'G' " +
                    "                            AND em.domain_id = 'PUBLIC' " +
                    "                            AND em.principal_domain_id = m.domain_id " +
                    "                            AND em.principal = m.group_id " +
                    "                            AND m.user_or_group = 'U' " +
                    "                            AND m.principal = '" + userID + "' " +
                    "                            AND m.domain_id = '" + domainID + "') " +
                    "        AND p.domain_id = 'PUBLIC')) " +

                    "ORDER BY (p.domain_id || p.permission_id) ";
/*
    String sQuery = "SELECT (p.domain_id || p.permission_id) permission_id," +
                    "       p.permission_type, e.attribute, o.implement_class_name, e.value " +
                    "FROM SEC_Permission p, SEC_Expression e, SEC_Operator o " +
                    "WHERE p.domain_id = e.domain_id " +
                    "AND p.permission_id = e.permission_id " +
                    "AND e.attribute_type = o.attribute_type " +
                    "AND e.operator = o.operator " +
                    "AND (( p.domain_id = '" + domainID + "' " +
                    "       AND p.user_or_group = 'U' AND p.principal = '" + userID + "')";
    if (groupList.size() == 0) {
      sQuery += ") ";
    } else {
      sQuery += " OR (p.user_or_group = 'G' AND (p.domain_id || '/' || p.principal) IN (";
      String group = null;
      boolean firstEntry = true;
      for (Enumeration e = groupList.elements(); e.hasMoreElements(); ){
        group = (String)e.nextElement();
        if (firstEntry) {
          sQuery += "'" + group + "'";
          firstEntry = false;
        } else {
          sQuery += ", '" + group + "'";
        }
      }
      sQuery += "))) ";
    }
    sQuery += "ORDER BY (p.domain_id || p.permission_id)";
*/
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      rSet = pStmt.executeQuery();
      String lastPermissionID = null;
      String permissionID = null;
      Permission permission = null;
      Vector expression = null;
      while (rSet.next()) {
        permissionID = rSet.getString(1);
        if (!permissionID.equals(lastPermissionID)) {
          permission = new Permission(rSet.getString(2));
          expression = permission.getExpression();
          permissions.addElement(permission);
          lastPermissionID = permissionID;
        }
        expression.addElement(new Expression(rSet.getString(3),
  					     rSet.getString(4),
                                             rSet.getString(5)));
      }
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getPermissions() for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
    return permissions;
  }

  public java.util.Hashtable getAllUsersWithPermissions(String domainID)
    throws SecurityDBAccessException {
    Hashtable allPermissions = new Hashtable();
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sQuery = "SELECT u.user_id, (p.domain_id || p.permission_id) permission_id, p.permission_type, e.attribute, o.implement_class_name, e.value " +
                    "FROM SEC_User_Details u, SEC_Permission p, SEC_Expression e, SEC_Operator o " +
                    "WHERE ((    p.user_or_group = 'U' " +
                    "        AND p.principal = u.user_id " +
                    "        AND p.domain_id = u.domain_id) OR " +
                    "       (    p.user_or_group = 'G' " +
                    "        AND p.principal in (SELECT group_id " +
                    "                            FROM SEC_Group_Membership m " +
                    "                            WHERE m.user_or_group = 'U' " +
                    "                            AND m.principal = u.user_id " +
                    "                            AND m.domain_id = u.domain_id) " +
                    "        AND p.domain_id = u.domain_id) OR " +
                    "       (    p.user_or_group = 'G' " +
                    "        AND p.principal in (SELECT group_id " +
                    "                            FROM SEC_External_Group_Membership m " +
                    "                            WHERE m.user_or_group = 'U' " +
                    "                            AND m.domain_id = 'PUBLIC' " +
                    "                            AND m.principal_domain_id = u.domain_id " +
                    "                            AND m.principal = u.user_id) " +
                    "        AND p.domain_id = 'PUBLIC') OR " +
                    "       (    p.user_or_group = 'G' " +
                    "        AND p.principal in (SELECT em.group_id " +
                    "                            FROM SEC_Group_Membership m, SEC_External_Group_Membership em " +
                    "                            WHERE em.user_or_group = 'G' " +
                    "                            AND em.domain_id = 'PUBLIC' " +
                    "                            AND em.principal_domain_id = m.domain_id " +
                    "                            AND em.principal = m.group_id " +
                    "                            AND m.user_or_group = 'U' " +
                    "                            AND m.principal = u.user_id " +
                    "                            AND m.domain_id = u.domain_id) " +
                    "        AND p.domain_id = 'PUBLIC')) " +
                    "AND p.domain_id = e.domain_id " +
                    "AND p.permission_id = e.permission_id " +
                    "AND e.attribute_type = o.attribute_type " +
                    "AND e.operator = o.operator " +
                    "AND u.domain_id = ? " +
                    "ORDER BY u.user_id, (p.domain_id || p.permission_id) ";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      rSet = pStmt.executeQuery();
      String lastUserID = null;
      String userID = null;
      Vector currentPermissions = null;
      String lastPermissionID = null;
      String permissionID = null;
      Permission permission = null;
      Vector expression = null;
      while (rSet.next()) {
        userID = rSet.getString(1);
        if (!userID.equals(lastUserID)) {
          currentPermissions = new Vector();
          allPermissions.put(userID, currentPermissions);
          lastUserID = userID;
          lastPermissionID = null;
        }
        permissionID = rSet.getString(2);
        if (!permissionID.equals(lastPermissionID)) {
          permission = new Permission(rSet.getString(3));
          expression = permission.getExpression();
          currentPermissions.addElement(permission);
          lastPermissionID = permissionID;
        }
        expression.addElement(new Expression(rSet.getString(4),
                                             rSet.getString(5),
                                             rSet.getString(6)));
      }
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getAllPermissions() for " + domainID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
    return allPermissions;
  }

  public boolean implies(java.util.Vector permissions,
                         PermissionContext context) {
    Permission permission = null;
    Expression expression = null;
    BinaryOperator operator = null;
    Object actualValue = null;
    String comparedValue = null;
    Boolean result = null;
    boolean goOn;
    //LogManager.instance.logDebug("context permissionType: " + context.getPermissionType());
    if (permissions == null) {
      return false;
    }
    for (Enumeration e = permissions.elements(); e.hasMoreElements(); ) {
      permission = (Permission)e.nextElement();
      //LogManager.instance.logDebug("permission permissionType: " + permission.getPermissionType());
      if (permission.getPermissionType().equals(context.getPermissionType())) {
        goOn = true;
        for (Enumeration en = permission.getExpression().elements(); goOn && en.hasMoreElements(); ) {
          try {
            expression = (Expression)en.nextElement();
            actualValue = context.get(expression.getAttributeName());
            comparedValue = expression.getAttributeValue();
            //LogManager.instance.logDebug("evaluating: <" + actualValue + "> " +
            //                   expression.getOperatorClassName() + " <" + comparedValue + ">");
            operator = (BinaryOperator)operatorLookup.get(expression.getOperatorClassName());
            if (operator == null) {
              operator = (BinaryOperator)Class.forName(expression.getOperatorClassName()).newInstance();
              operatorLookup.put(expression.getOperatorClassName(), operator);
            }
            if (!operator.evaluate(actualValue, comparedValue, context)) {
              goOn = false;
            }
          } catch (Exception ex) {
            LogManager.instance.logError("Unable to evaluate: <" + actualValue + "> " +
                                         expression.getOperatorClassName() + " <" + comparedValue + ">", ex);
            goOn = false;
          }
        }
        if (goOn) {
          context.clear();
          return true;
        }
      }
    }
    context.clear();
    return false;
  }

  public void deleteUser(String domainID,
                         String userID)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException {
    Connection connection = null;
    PreparedStatement pStmt1 = null, pStmt2 = null, pStmt3 = null, pStmt4 = null, pStmt5 = null, pStmt6 = null;
    String sDelete1 = "DELETE FROM SEC_Group_Membership " +
                      "WHERE user_or_group = 'U' " +
                      "AND domain_id = ? " +
                      "AND principal = ? ";
    String sDelete2 = "DELETE FROM SEC_External_Group_Membership " +
                      "WHERE user_or_group = 'U' " +
                      "AND principal_domain_id = ? " +
                      "AND principal = ? ";
    String sDelete3 = "DELETE FROM SEC_Expression " +
                      "WHERE domain_id = ? " +
                      "AND permission_id in (SELECT permission_id " +
                      "                      FROM SEC_Permission " +
                      "                      WHERE domain_id = ? " +
                      "                      AND user_or_group = 'U' " +
                      "                      AND principal = ?) ";
    String sDelete4 = "DELETE FROM SEC_Permission " +
                      "WHERE domain_id = ? " +
                      "AND user_or_group = 'U' " +
                      "AND principal = ? ";
    String sDelete5 = "DELETE FROM SEC_User_Person_Relationship " +
                      "WHERE domain_id = ? " +
                      "AND user_id = ? ";
    String sDelete6 = "DELETE FROM SEC_User_Details " +
                      "WHERE domain_id = ? " +
                      "AND user_id = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt1 = connection.prepareStatement(sDelete1);
      pStmt1.setString(1, domainID);
      pStmt1.setString(2, userID);
      pStmt1.executeUpdate();
      pStmt2 = connection.prepareStatement(sDelete2);
      pStmt2.setString(1, domainID);
      pStmt2.setString(2, userID);
      pStmt2.executeUpdate();
      pStmt3 = connection.prepareStatement(sDelete3);
      pStmt3.setString(1, domainID);
      pStmt3.setString(2, domainID);
      pStmt3.setString(3, userID);
      pStmt3.executeUpdate();
      pStmt4 = connection.prepareStatement(sDelete4);
      pStmt4.setString(1, domainID);
      pStmt4.setString(2, userID);
      pStmt4.executeUpdate();
      pStmt5 = connection.prepareStatement(sDelete5);
      pStmt5.setString(1, domainID);
      pStmt5.setString(2, userID);
      pStmt5.executeUpdate();
      pStmt6 = connection.prepareStatement(sDelete6);
      pStmt6.setString(1, domainID);
      pStmt6.setString(2, userID);
      if (pStmt6.executeUpdate() == 0) {
        throw new SecurityUserNotFoundException();
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to deleteUser() for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt1 != null) {
        try {
          pStmt1.close();
        } catch (SQLException e) {
        LogManager.instance.logError("Unable to close the pStmt1.", e);
        }
      }
      if (pStmt2 != null) {
        try {
          pStmt2.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt2.", e);
        }
      }
      if (pStmt3 != null) {
        try {
          pStmt3.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt3.", e);
        }
      }
      if (pStmt4 != null) {
        try {
          pStmt4.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt4.", e);
        }
      }
      if (pStmt5 != null) {
        try {
          pStmt5.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt5.", e);
        }
      }
      if (pStmt6 != null) {
        try {
          pStmt6.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt6.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
        LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void deleteDomain(String domainID)
    throws SecurityDomainNotFoundException,
           SecurityDBAccessException {
    Connection connection = null;
    PreparedStatement pStmt1 = null, pStmt2 = null, pStmt3 = null, pStmt4 = null;
    PreparedStatement pStmt5 = null, pStmt6 = null, pStmt7 = null, pStmt8 = null;
    String sDelete1 = "DELETE FROM SEC_Expression WHERE domain_id = ? ";
    String sDelete2 = "DELETE FROM SEC_Permission WHERE domain_id = ? ";
    String sDelete3 = "DELETE FROM SEC_User_Person_Relationship WHERE domain_id = ? ";
    String sDelete4 = "DELETE FROM SEC_Group_Membership WHERE domain_id = ? ";
    String sDelete5 = "DELETE FROM SEC_External_Group_Membership WHERE principal_domain_id = ? ";
    String sDelete6 = "DELETE FROM SEC_Group_Details WHERE domain_id = ? ";
    String sDelete7 = "DELETE FROM SEC_User_Details WHERE domain_id = ? ";
    String sDelete8 = "DELETE FROM SEC_Domain WHERE domain_id = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt1 = connection.prepareStatement(sDelete1);
      pStmt1.setString(1, domainID);
      pStmt1.executeUpdate();
      pStmt2 = connection.prepareStatement(sDelete2);
      pStmt2.setString(1, domainID);
      pStmt2.executeUpdate();
      pStmt3 = connection.prepareStatement(sDelete3);
      pStmt3.setString(1, domainID);
      pStmt3.executeUpdate();
      pStmt4 = connection.prepareStatement(sDelete4);
      pStmt4.setString(1, domainID);
      pStmt4.executeUpdate();
      pStmt5 = connection.prepareStatement(sDelete5);
      pStmt5.setString(1, domainID);
      pStmt5.executeUpdate();
      pStmt6 = connection.prepareStatement(sDelete6);
      pStmt6.setString(1, domainID);
      pStmt6.executeUpdate();
      pStmt7 = connection.prepareStatement(sDelete7);
      pStmt7.setString(1, domainID);
      pStmt7.executeUpdate();
      pStmt8 = connection.prepareStatement(sDelete8);
      pStmt8.setString(1, domainID);
      if (pStmt8.executeUpdate() == 0) {
        throw new SecurityDomainNotFoundException();
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to deleteDomain() for " + domainID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt1 != null) {
        try {
          pStmt1.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt1.", e);
        }
      }
      if (pStmt2 != null) {
        try {
          pStmt2.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt2.", e);
        }
      }
      if (pStmt3 != null) {
        try {
          pStmt3.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt3.", e);
        }
      }
      if (pStmt4 != null) {
        try {
          pStmt4.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt4.", e);
        }
      }
      if (pStmt5 != null) {
        try {
          pStmt5.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt5.", e);
        }
      }
      if (pStmt6 != null) {
        try {
          pStmt6.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt6.", e);
        }
      }
      if (pStmt7 != null) {
        try {
          pStmt7.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt7.", e);
        }
      }
      if (pStmt8 != null) {
        try {
          pStmt8.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt8.", e);
        }
      }
      if (connection != null) {
      try {
        if (commit) {
          connection.commit();
        } else {
          connection.rollback();
        }
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to commit/rollback the connection.", e);
      }
      try {
        connection.setAutoCommit(autoCommit);
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
      }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }
/*
  public boolean checkLogon(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) {
    javax.servlet.http.HttpSession session = request.getSession();
    if (session.getAttribute("net.line.system.user") != null) {
      return true;
    }
    String logonPage = ConfigManager.getInstance().getProperty("net.line.system.logonPage");
    String queryString = request.getQueryString();
    String url = request.getRequestURI() + ((queryString != null)? "?" + queryString: "");
    try {
      if ("GET".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect(logonPage + "?gotoPage=" + java.net.URLEncoder.encode(url));
      } else {
        response.sendRedirect(logonPage);
      }
    } catch (java.io.IOException e) {
      LogManager.instance.logError("Unable to redirect.", e);
    }
    return false;
  }
*/
/*
  public java.util.Vector getAuthorizationList(java.util.Hashtable allPermissions,
                                               PermissionContext context) {
    Vector list = new Vector();
    String userID;
    Vector permissions;
    for (Enumeration e = allPermissions.keys(); e.hasMoreElements(); ) {
      userID = (String)e.nextElement();
      permissions = (Vector)allPermissions.get(userID);
      if (implies(permissions, context)) {
        list.addElement(userID);
      }
    }
    return list;
  }
*/
  public String getPersonID(String domainID,
                            String userID)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException {
    String personID = null;
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sQuery = "SELECT person_id " +
                    "FROM SEC_User_Person_Relationship " +
                    "WHERE domain_id = ? " +
                    "AND user_id = ? ";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      pStmt.setString(2, userID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
        throw new SecurityUserNotFoundException();
      }
      personID = rSet.getString("person_id");
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getPersonID() for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
    return personID;
  }

  public String getQualifiedUserID(String personID)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sQuery = "SELECT domain_id, user_id " +
                    "FROM SEC_User_Person_Relationship " +
                    "WHERE person_id = ? ";
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, personID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
        throw new SecurityUserNotFoundException();
      }
      return rSet.getString("domain_id") + "/" + rSet.getString("user_id");
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to getQualifiedUserID() for " + personID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  private void updateUser(User user, Connection connection)
    throws SecurityUserNotFoundException, SecurityDBAccessException {
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sUpdate = "UPDATE SEC_User_Details " +
                     "SET password = ? " +
                     ",   user_name = ? " +
                     ",   description = ? " +
                     ",   suspended = ? " +
                     ",   ever_expired = ? " +
                     ",   change_pwd_next_logon = ? " +
                     ",   no_of_failed_attempt = ? " +
                     ",   no_of_grace_logon = ? " +
                     ",   last_attempt_timestamp = ? " +
                     ",   last_access_timestamp = ? " +
                     ",   last_modify_timestamp = ? " +
                     ",   created_by = ? " +
                     ",   creation_timestamp = ? " +
                     "WHERE domain_id = ? " +
                     "AND user_id = ? ";
    try {
      pStmt = connection.prepareStatement(sUpdate);
      pStmt.setString(1, user.getPassword());
      SQLUtil.setNullString(pStmt, 2, user.getUserName());
      SQLUtil.setNullString(pStmt, 3, user.getDescription());
      pStmt.setString(4, user.isSuspended() ? "Y" : "N");
      pStmt.setString(5, user.isEverExpired() ? "Y" : "N");
      pStmt.setString(6, user.isChangePwdNextLogon() ? "Y" : "N");
      pStmt.setInt(7, user.getNoOfFailedAttempt());
      pStmt.setInt(8, user.getNoOfGraceLogon());
      pStmt.setTimestamp(9, user.getLastAttemptTimestamp());
      pStmt.setTimestamp(10, user.getLastAccessTimestamp());
      pStmt.setTimestamp(11, user.getLastModifyTimestamp());
      pStmt.setString(12, user.getCreatedBy());
      pStmt.setTimestamp(13, user.getCreationTimestamp());
      pStmt.setString(14, user.getDomainID());
      pStmt.setString(15, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityUserNotFoundException();
      }
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to updateUser() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
    }
  }

  public void changePassword(String domainID,
                             String userID,
                             String currentPassword,
                             String newPassword,
                             boolean checkPassword)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           SecurityInvalidPasswordException,
           java.rmi.RemoteException {
    User user = null;
    Connection connection = null;
    PreparedStatement pStmt = null, lStmt = null;
    ResultSet rSet = null;
    String sLock = "LOCK TABLE Sec_User_details IN ROW EXCLUSIVE MODE";
    String sQuery = "SELECT password, user_name, description, " +
                    "       suspended, ever_expired, change_pwd_next_logon, " +
                    "       no_of_failed_attempt, no_of_grace_logon, " +
                    "       last_attempt_timestamp, last_access_timestamp, last_modify_timestamp, " +
                    "       created_by, creation_timestamp " +
                    "FROM SEC_User_Details " +
                    "WHERE domain_id = ? " +
                    "AND user_id = ? " +
                    "FOR UPDATE ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      lStmt = connection.prepareStatement(sLock);
      lStmt.executeUpdate();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      pStmt.setString(2, userID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
        throw new SecurityUserNotFoundException();
      }
      user = new User(domainID,
                      userID,
                      rSet.getString("password"),
                      SQLUtil.getNullString(rSet, "user_name", null),
                      SQLUtil.getNullString(rSet, "description", null),
                      rSet.getString("suspended").equals("Y") ? true : false,
                      rSet.getString("ever_expired").equals("Y") ? true : false,
                      rSet.getString("change_pwd_next_logon").equals("Y") ? true : false,
                      rSet.getInt("no_of_failed_attempt"),
                      rSet.getInt("no_of_grace_logon"),
                      rSet.getTimestamp("last_attempt_timestamp"),
                      rSet.getTimestamp("last_access_timestamp"),
                      rSet.getTimestamp("last_modify_timestamp"),
                      rSet.getString("created_by"),
                      rSet.getTimestamp("creation_timestamp"));
      if (checkPassword == true && !user.getPassword().equals(currentPassword)) {
        throw new SecurityInvalidPasswordException();
      }
      user.setPassword(newPassword);
      updateUser(user, connection);
      commit = true;
      return;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to change password for " + domainID + "/" + userID, e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (lStmt != null) {
        try {
          lStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the lStmt.", e);
        }
      }
      if (rSet != null) {
        try {
          rSet.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the rSet.", e);
        }
      }
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void createDomain(Domain domain)
    throws SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sCreate = "INSERT INTO SEC_Domain (" +
                     "    domain_id" +
                     ",   domain_name" +
                     ",   description" +
                     ",   domain_type" +
                     ",   max_no_of_logon_attempt" +
                     ",   max_no_of_grace_logon" +
                     ",   consecutive_logon_interval" +
                     ",   inactive_period_in_days" +
                     ",   password_expiry_period_in_days" +
                     ",   countdown_enable_in_days" +
                     ") VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sCreate);
      pStmt.setString(1, domain.getDomainID());
      System.out.println(domain.getDomainName());
      SQLUtil.setNullString(pStmt, 2, domain.getDomainName());
      SQLUtil.setNullString(pStmt, 3, domain.getDescription());
      pStmt.setString(4, domain.getDomainType());
      pStmt.setInt(5, domain.getMaxNoOfLogonAttempt());
      pStmt.setInt(6, domain.getMaxNoOfGraceLogon());
      pStmt.setInt(7, domain.getConsecutiveLogonInterval());
      pStmt.setInt(8, domain.getInactivePeriodInDays());
      pStmt.setInt(9, domain.getPasswordExpiryPeriodInDays());
      pStmt.setInt(10, domain.getCountdownEnableInDays());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to createDomain() for " + domain.getDomainID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void updateDomain(Domain domain)
    throws SecurityDomainNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sUpdate = "UPDATE SEC_Domain " +
                     "SET domain_name = ? " +
                     ",   description = ? " +
                     ",   domain_type = ? " +
                     ",   max_no_of_logon_attempt = ? " +
                     ",   max_no_of_grace_logon = ? " +
                     ",   consecutive_logon_interval = ? " +
                     ",   inactive_period_in_days = ? " +
                     ",   password_expiry_period_in_days = ? " +
                     ",   countdown_enable_in_days = ? " +
                     "WHERE domain_id = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sUpdate);
      SQLUtil.setNullString(pStmt, 1, domain.getDomainName());
      SQLUtil.setNullString(pStmt, 2, domain.getDescription());
      pStmt.setString(3, domain.getDomainType());
      pStmt.setInt(4, domain.getMaxNoOfLogonAttempt());
      pStmt.setInt(5, domain.getMaxNoOfGraceLogon());
      pStmt.setInt(6, domain.getConsecutiveLogonInterval());
      pStmt.setInt(7, domain.getInactivePeriodInDays());
      pStmt.setInt(8, domain.getPasswordExpiryPeriodInDays());
      pStmt.setInt(9, domain.getCountdownEnableInDays());
      pStmt.setString(10, domain.getDomainID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDomainNotFoundException();
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to updateDomain() for " + domain.getDomainID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void createUser(User user, String personID)
    throws SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt1 = null, pStmt2 = null;
    String sCreate1 = "INSERT INTO SEC_User_Details (" +
                      "    domain_id" +
                      ",   user_id" +
                      ",   password" +
                      ",   user_name" +
                      ",   description" +
                      ",   suspended" +
                      ",   ever_expired" +
                      ",   change_pwd_next_logon" +
                      ",   no_of_failed_attempt" +
                      ",   no_of_grace_logon" +
                      ",   last_attempt_timestamp" +
                      ",   last_access_timestamp" +
                      ",   last_modify_timestamp" +
                      ",   created_by" +
                      ",   creation_timestamp" +
                      ") VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )";
    String sCreate2 = "INSERT INTO SEC_User_Person_Relationship (" +
                      "    domain_id" +
                      ",   user_id" +
                      ",   person_id" +
                      ") VALUES ( ? , ? , ? )";
     boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt1 = connection.prepareStatement(sCreate1);
      pStmt1.setString(1, user.getDomainID());
      pStmt1.setString(2, user.getUserID());
      pStmt1.setString(3, user.getPassword());
      SQLUtil.setNullString(pStmt1, 4, user.getUserName());
      SQLUtil.setNullString(pStmt1, 5, user.getDescription());
      pStmt1.setString(6, user.isSuspended() ? "Y" : "N");
      pStmt1.setString(7, user.isEverExpired() ? "Y" : "N");
      pStmt1.setString(8, user.isChangePwdNextLogon() ? "Y" : "N");
      pStmt1.setInt(9, user.getNoOfFailedAttempt());
      pStmt1.setInt(10, user.getNoOfGraceLogon());
      pStmt1.setTimestamp(11, user.getLastAttemptTimestamp());
      pStmt1.setTimestamp(12, user.getLastAccessTimestamp());
      pStmt1.setTimestamp(13, user.getLastModifyTimestamp());
      pStmt1.setString(14, user.getCreatedBy());
      pStmt1.setTimestamp(15, user.getCreationTimestamp());
      int nRows = pStmt1.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      pStmt2 = connection.prepareStatement(sCreate2);
      pStmt2.setString(1, user.getDomainID());
      pStmt2.setString(2, user.getUserID());
      pStmt2.setString(3, personID);
      nRows = pStmt2.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to createUser() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt1 != null) {
        try {
          pStmt1.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt1.", e);
        }
      }
      if (pStmt2 != null) {
        try {
          pStmt2.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt2.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void updateUser(User user)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sUpdate = "UPDATE SEC_User_Details " +
                     "SET user_name = ? " +
                     ",   description = ? " +
                     ",   suspended = ? " +
                     ",   ever_expired = ? " +
                     ",   change_pwd_next_logon = ? " +
                     ",   no_of_failed_attempt = ? " +
                     ",   no_of_grace_logon = ? " +
                     ",   last_attempt_timestamp = ? " +
                     ",   last_access_timestamp = ? " +
                     ",   last_modify_timestamp = ? " +
                     ",   created_by = ? " +
                     ",   creation_timestamp = ? " +
                     "WHERE domain_id = ? " +
                     "AND user_id = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sUpdate);
      SQLUtil.setNullString(pStmt, 1, user.getUserName());
      SQLUtil.setNullString(pStmt, 2, user.getDescription());
      pStmt.setString(3, user.isSuspended() ? "Y" : "N");
      pStmt.setString(4, user.isEverExpired() ? "Y" : "N");
      pStmt.setString(5, user.isChangePwdNextLogon() ? "Y" : "N");
      pStmt.setInt(6, user.getNoOfFailedAttempt());
      pStmt.setInt(7, user.getNoOfGraceLogon());
      pStmt.setTimestamp(8, user.getLastAttemptTimestamp());
      pStmt.setTimestamp(9, user.getLastAccessTimestamp());
      pStmt.setTimestamp(10, user.getLastModifyTimestamp());
      pStmt.setString(11, user.getCreatedBy());
      pStmt.setTimestamp(12, user.getCreationTimestamp());
      pStmt.setString(13, user.getDomainID());
      pStmt.setString(14, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityUserNotFoundException();
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to updateUser() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void addExternalGroupMembership(User user, String group)
    throws SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sCreate = "INSERT INTO SEC_External_Group_Membership (" +
                     "    domain_id" +
                     ",   group_id" +
                     ",   user_or_group" +
                     ",   principal_domain_id" +
                     ",   principal" +
                     ") VALUES ( 'PUBLIC' , ? , 'U' , ? , ? )";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sCreate);
      pStmt.setString(1, group);
      pStmt.setString(2, user.getDomainID());
      pStmt.setString(3, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to addExternalGroup() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }
  public void addCbtbGroupMembership(User user,String group)
  throws SecurityDBAccessException,
           java.rmi.RemoteException
  {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sCreate = "INSERT INTO SEC_Group_Membership (" +
                     "    domain_id" +
                     ",   group_id" +
                     ",   user_or_group" +
                     ",   principal" +
                     ") VALUES ( 'CBTB' , ? , 'U' , ?  )";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sCreate);
      pStmt.setString(1, group);
      pStmt.setString(2, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to addExternalGroup() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }
  public void removeExternalGroupMembership(User user, String group)
    throws SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sDelete = "DELETE SEC_External_Group_Membership " +
                     "WHERE domain_id = 'PUBLIC' " +
                     "AND   group_id = ? " +
                     "AND   user_or_group = 'U' " +
                     "AND   principal_domain_id = ? " +
                     "AND   principal = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sDelete);
      pStmt.setString(1, group);
      pStmt.setString(2, user.getDomainID());
      pStmt.setString(3, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to removeExternalGroup() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void removeCbtbGroupMembership(User user)
  throws SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sDelete = "DELETE SEC_Group_Membership " +
                     "WHERE domain_id = 'CBTB' " +
                     "AND   user_or_group = 'U' " +
                     "AND   principal = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sDelete);
      pStmt.setString(1, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to removeExternalGroup() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }

  public void removeCbtbGroupMembership(User user,String group)
  throws SecurityDBAccessException,
           java.rmi.RemoteException {
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    String sDelete = "DELETE SEC_Group_Membership " +
                     "WHERE domain_id = 'CBTB' " +
                     "AND   group_id = ? " +
                     "AND   user_or_group = 'U' " +
                     "AND   principal = ? ";
    boolean autoCommit = false;
    boolean commit = false;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      pStmt = connection.prepareStatement(sDelete);
      pStmt.setString(1, group);
      pStmt.setString(2, user.getUserID());
      int nRows = pStmt.executeUpdate();
      if (nRows == 0) {
        throw new SecurityDBAccessException(null);
      }
      commit = true;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to removeExternalGroup() for " + user.getDomainID() + "/" + user.getUserID(), e);
      throw new SecurityDBAccessException(e);
    } finally {
      if (pStmt != null) {
        try {
          pStmt.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the pStmt.", e);
        }
      }
      if (connection != null) {
        try {
          if (commit) {
            connection.commit();
          } else {
            connection.rollback();
          }
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to commit/rollback the connection.", e);
        }
        try {
          connection.setAutoCommit(autoCommit);
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to restore connection's autoCommit state.", e);
        }
        try {
          connection.close();
        } catch (SQLException e) {
          LogManager.instance.logError("Unable to close the connection.", e);
        }
      }
    }
  }
}