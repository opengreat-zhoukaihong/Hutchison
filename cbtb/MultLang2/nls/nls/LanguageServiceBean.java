package net.line.fortress.apps.system.nls;

import java.rmi.*;
import javax.ejb.*;
import javax.naming.*;
import java.sql.*;
import net.line.fortress.apps.system.utils.DefaultConnectionPool;
import net.line.fortress.apps.system.LogManager;

public class LanguageServiceBean implements SessionBean {
  private SessionContext sessionContext;
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
  public String getEncoding(String language) throws ObjectNotFoundException, FinderException, NamingException, RemoteException {
    LogManager.instance.logInfo("LanguageServiceBean.getEncoding: language[" + language + "]");
    String sql = "select encoding from language where code = ?";
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sql);
      pStmt.setString(1,language);
      rSet = pStmt.executeQuery();

      if (rSet.next())
        return rSet.getString("encoding");
      else
        return "UTF-8";
    } catch (SQLException e) {
      e.printStackTrace();
      return "UTF-8";
    } finally {
      try {
        if (rSet != null) rSet.close();
      } catch (SQLException e) {
          rSet = null;
      }
      try {
        if (pStmt != null)  pStmt.close();
      } catch (SQLException e) {
        pStmt = null;
      }
      try {
        if (connection != null)   connection.close();
      } catch (SQLException e) {
        connection = null;
      }
    }
  }

  public String getDescription(String language) throws ObjectNotFoundException, FinderException, NamingException, RemoteException {
    LogManager.instance.logInfo("LanguageServiceBean.getDescription: language[" + language + "]");
    String sql = "select description from language where code = ?";
    Connection connection = null;
    PreparedStatement pStmt = null;
    ResultSet rSet = null;
    try {
      connection = DefaultConnectionPool.getInstance().getConnection();
      pStmt = connection.prepareStatement(sql);
      pStmt.setString(1,language);
      rSet = pStmt.executeQuery();

      if (rSet.next())
        return rSet.getString("description");

      return "";
    } catch (SQLException e) {
      e.printStackTrace();
      return "";
    } finally {
      try {
        if (rSet != null) rSet.close();
      } catch (SQLException e) {
          rSet = null;
      }
      try {
        if (pStmt != null)  pStmt.close();
      } catch (SQLException e) {
        pStmt = null;
      }
      try {
        if (connection != null)   connection.close();
      } catch (SQLException e) {
        connection = null;
      }
    }
  }
}