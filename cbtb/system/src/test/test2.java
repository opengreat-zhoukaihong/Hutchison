package test;

import java.sql.*;
import java.util.*;
import java.rmi.*;
import javax.ejb.*;
import net.line.fortress.apps.system.security.*;
import com.arena.universe.security.operator.*;
import net.line.fortress.apps.system.utils.*;
import net.line.fortress.apps.system.*;
/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */

public class test2 {
  long noOfMillisInADay = 24 * 60 * 60 * 1000;
  public test2() {
  }

  public User authenticate(String domainID,
                           String userID,
                           String encryptedPassword,
                           boolean checkPassword,
                           Domain domain)
  {
  User user = null;
    Connection connection = null;


      //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); //加载驱动程序
      //String url = "jdbc:odbc:line";
      //Connection connection = DriverManager.getConnection(url, "weblogic", "weblogic");
      //Statement stm = connection.createStatement();
      //ResultSet rs = stm.executeQuery("select * from test");
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
     Class.forName("oracle.jdbc.driver.OracleDriver"); //加载驱动程序
      String url = "jdbc:oracle:thin:@khzhou:1521:cbt";
      connection = DriverManager.getConnection(url, "cbtb", "cbtb");
      //connection = DefaultConnectionPool.getInstance().getConnection();
      autoCommit = connection.getAutoCommit();
      connection.setAutoCommit(false);
      lStmt = connection.prepareStatement(sLock);
      lStmt.executeUpdate();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      pStmt.setString(2, userID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
        //throw new SecurityUserNotFoundException();
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
        //throw new SecurityUserSuspendedException();
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
        //updateUser(user, connection);
        commit = true;
       // throw new SecurityInvalidPasswordException();
      }
      user.setLastAttemptTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
      user.setNoOfFailedAttempt(0);
      if (System.currentTimeMillis() - user.getLastAccessTimestamp().getTime() >
        domain.getInactivePeriodInDays() * noOfMillisInADay) {
        user.setSuspended(true);
        //updateUser(user, connection);
        commit = true;
        //throw new SecurityUserSuspendedException();
      }
      if (user.isEverExpired() &&
          System.currentTimeMillis() - user.getLastModifyTimestamp().getTime() >
        domain.getPasswordExpiryPeriodInDays() * noOfMillisInADay) {
        if (user.getNoOfGraceLogon() >= domain.getMaxNoOfGraceLogon()) {
          user.setSuspended(true);
          user.setNoOfGraceLogon(0);
          //updateUser(user, connection);
          commit = true;
          //throw new SecurityUserSuspendedException();
        } else {
          user.setNoOfGraceLogon(user.getNoOfGraceLogon() + 1);
        }
      } else {
        user.setNoOfGraceLogon(0);
      }
      user.setLastAccessTimestamp(new java.sql.Timestamp(System.currentTimeMillis()));
      //updateUser(user, connection);
      commit = true;
      return user;
    } catch (SQLException e) {
      LogManager.instance.logError("Unable to authenticate() for " + domainID + "/" + userID, e);
      //throw new SecurityDBAccessException(e);
    } catch (Exception e) {
      //LogManager.instance.logError("Unable to authenticate() for " + domainID + "/" + userID, e);
      //throw new SecurityDBAccessException(e);
    }
     finally {
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
    return user;
  }

   public Domain getDomain(String domainID)
 {
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
      Class.forName("oracle.jdbc.driver.OracleDriver"); //加载驱动程序
      String url = "jdbc:oracle:thin:@khzhou:1521:cbt";
      connection = DriverManager.getConnection(url, "cbtb", "cbtb");
      //connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sQuery);
      pStmt.setString(1, domainID);
      rSet = pStmt.executeQuery();
      if (!rSet.next()) {
       // throw new SecurityDomainNotFoundException();
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
      //throw new SecurityDBAccessException(e);
    }
    catch (Exception e)
    {
    }
    finally {
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
    return domain;
  }
}



  public static void main(String[] args) {
    test2 t = new test2();
    User u = null;
    t.authenticate("HITSD","sdrequestor1","password",true,t.getDomain("HITSD"));
  }
}